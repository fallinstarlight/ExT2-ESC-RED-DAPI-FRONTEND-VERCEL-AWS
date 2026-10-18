// js/render.js
import { api } from "./api.js";

export function escapeHtml(str) {
  return String(str ?? "")
    .replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;").replace(/'/g, "&#39;");
}
export function cssUrl(url) {
  return String(url).replace(/'/g, "%27").replace(/\)/g, "%29");
}
export function fmtDuration(sec) {
  sec = Number(sec);
  return `${Math.floor(sec / 60)}:${String(sec % 60).padStart(2, "0")}`;
}
function iconFor(kind) {
  return { artist: "♪", person: "☺", album: "◈", track: "♫" }[kind] || "•";
}

export function describe(r) {
  const d = r.data;
  if (r.kind === "artist") {
    const chips = [];
    if (d.artist_type) chips.push({ label: d.artist_type });
    if (d.is_active) chips.push({ label: "active", accent: true });
    if (d.genres) chips.push({ label: d.genres });
    if (d.album_count != null)
      chips.push({ label: `${d.album_count} album${d.album_count == 1 ? "" : "s"}` });
    return {
      thumbUrl: d.photo_url || null,
      title: d.artistic_name || "(unnamed artist)",
      subtitle: d.description || "",
      chips,
    };
  }
  if (r.kind === "person") {
    const chips = [];
    if (d.stage_name) chips.push({ label: d.stage_name });
    if (d.bands) chips.push({ label: d.bands });
    return {
      thumbUrl: d.photo_url || null,
      title: d.full_name || "(unnamed person)",
      subtitle: d.biography || "",
      chips,
    };
  }
  if (r.kind === "album") {
    const chips = [{ label: "album", kind: true }];
    if (d.release_year) chips.push({ label: String(d.release_year) });
    if (d.rating != null)
      chips.push({ label: `★ ${Number(d.rating).toFixed(1)}`, accent: true });
    if (d.genres) chips.push({ label: d.genres });
    if (d.track_count != null)
      chips.push({ label: `${d.track_count} track${d.track_count == 1 ? "" : "s"}` });
    return {
      thumbUrl: d.cover_url || null,
      title: d.album_name || "(untitled album)",
      subtitle: d.artist_name || "",
      chips,
    };
  }
  // track
  const chips = [{ label: "track", kind: true }];
  if (d.album_name) chips.push({ label: d.album_name });
  if (d.artist_name) chips.push({ label: d.artist_name });
  if (d.track_number != null) chips.push({ label: `#${d.track_number}` });
  if (d.duration_seconds != null) chips.push({ label: fmtDuration(d.duration_seconds) });
  return {
    thumbUrl: d.cover_url || null,
    title: d.track_name || "(untitled track)",
    subtitle: d.album_name ? `${d.album_name} — ${d.artist_name || ""}` : "",
    chips,
  };
}

/**
 * Render the result list. Each row gets a data-* kind/id pair; app.js
 * binds a click handler that opens the appropriate detail drawer.
 */
export function renderRows(bodyEl, rows) {
  if (rows.length === 0) {
    bodyEl.innerHTML = '<div class="state">No results found.</div>';
    return;
  }
  const frag = document.createDocumentFragment();
  for (const r of rows) {
    const el = document.createElement("div");
    el.className = "row clickable";
    el.dataset.kind = r.kind;

    // Pick the id that matches the row kind — never fall through to
    // artist_id on an album/track row.
    const idByKind = {
      artist: r.data.artist_id,
      person: r.data.person_id,
      album: r.data.album_id,
      track: r.data.track_id,
    };
    const id = idByKind[r.kind];
    if (id != null) el.dataset.id = id;

    if (r.kind === "track" && r.data.album_id != null) {
      el.dataset.albumId = r.data.album_id;
    }

    const { thumbUrl, title, subtitle, chips } = describe(r);
    // …rest unchanged
    el.innerHTML = `
      <div class="thumb" style="${thumbUrl ? `background-image:url('${cssUrl(thumbUrl)}')` : ""}">
        ${thumbUrl ? "" : iconFor(r.kind)}
      </div>
      <div class="info">
        <p class="title">${escapeHtml(title)}</p>
        <p class="subtitle">${escapeHtml(subtitle || "")}</p>
        <div class="meta">${chips.map(c =>
      `<span class="chip ${c.accent ? "accent" : ""} ${c.kind ? "kind" : ""}">${escapeHtml(c.label)}</span>`
    ).join("")}</div>
      </div>`;
    frag.appendChild(el);
  }
  bodyEl.replaceChildren(frag);
}

/* ─── Detail drawers ─────────────────────────────── */

export async function showArtistDetail(id) {
  const [artist, members] = await Promise.all([
    api.artist(id),
    api.bandMembers(id).catch(() => []),
  ]);
  const img = artist.photo_url
    ? `<img class="detail-img" src="${escapeHtml(artist.photo_url)}" alt="">` : "";
  const memberList = members.length
    ? `<ul class="clean">${members.map(m => `
        <li>
          <span>
            <button class="linklike" data-person-id="${m.person_id}">
              ${escapeHtml(m.full_name)}
            </button>
            ${m.member_role ? `<span class="badge">${escapeHtml(m.member_role)}</span>` : ""}
          </span>
          <span>${m.joined_year ?? ""}${m.left_year ? `–${m.left_year}` : ""}</span>
        </li>`).join("")}</ul>`
    : `<p class="sub">No band members recorded.</p>`;

  return `
    ${img}
    <h2>${escapeHtml(artist.artistic_name)}</h2>
    <p class="sub">
      ${escapeHtml(artist.artist_type || "")}
      ${artist.is_active ? " · active" : ""}
      ${artist.genres ? " · " + escapeHtml(artist.genres) : ""}
    </p>
    <p>${escapeHtml(artist.description || "")}</p>

    <p>
      <button class="linklike" data-albums-by-artist="${artist.artist_id}"
        data-artist-name="${escapeHtml(artist.artistic_name)}">
        Show all albums by ${escapeHtml(artist.artistic_name)} →
      </button>
    </p>

    ${artist.artist_type === "band" ? `<h3 style="margin-top:22px;font-weight:400;letter-spacing:1px;">Members</h3>${memberList}` : ""}
  `;
}

export async function showAlbumDetail(id) {
  const [album, tracks] = await Promise.all([
    api.album(id),
    api.albumTracks(id),
  ]);
  const img = album.cover_url
    ? `<img class="detail-img" src="${escapeHtml(album.cover_url)}" alt="">` : "";
  const trackList = tracks.length
    ? `<ul class="clean">${tracks.map(t => `
        <li>
          <span>${t.track_number ? `${t.track_number}. ` : ""}${escapeHtml(t.track_name)}</span>
          <span>${t.duration_seconds ? fmtDuration(t.duration_seconds) : ""}</span>
        </li>`).join("")}</ul>`
    : `<p class="sub">No tracks listed.</p>`;

  return `
    ${img}
    <h2>${escapeHtml(album.album_name)}</h2>
    <p class="sub">
      ${escapeHtml(album.artist_name || "")}
      ${album.release_year ? ` · ${album.release_year}` : ""}
      ${album.rating != null ? ` · ★ ${Number(album.rating).toFixed(1)}` : ""}
      ${album.genres ? ` · ${escapeHtml(album.genres)}` : ""}
    </p>
    ${trackList}
  `;
}

export async function showPersonDetail(id) {
  const rows = await api.person(id);
  const head = rows[0] || {};
  const img = head.photo_url
    ? `<img class="detail-img" src="${escapeHtml(head.photo_url)}" alt="">` : "";
  const bands = rows
    .filter(r => r.band_artist_id)
    .map(r => `
      <li>
        <button class="linklike" data-artist-id="${r.band_artist_id}">
          ${escapeHtml(r.band_name)}
        </button>
        <span>
          ${r.member_role ? `<span class="badge">${escapeHtml(r.member_role)}</span>` : ""}
          ${r.joined_year ?? ""}${r.left_year ? `–${r.left_year}` : ""}
        </span>
      </li>`).join("");

  return `
    ${img}
    <h2>${escapeHtml(head.full_name || "(unnamed person)")}</h2>
    <p class="sub">${escapeHtml(head.stage_name || "")}</p>
    <p>${escapeHtml(head.biography || "")}</p>
    <h3 style="margin-top:22px;font-weight:400;letter-spacing:1px;">Bands</h3>
    ${bands ? `<ul class="clean">${bands}</ul>` : `<p class="sub">No band memberships.</p>`}
  `;
}