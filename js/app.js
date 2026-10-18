// js/app.js
import { api } from "./api.js";
import { renderRows, showArtistDetail, showAlbumDetail, showPersonDetail, escapeHtml } from "./render.js";

const state = { mode: "artists", loading: false };

const els = {
  toggle: document.getElementById("toggle"),
  pill: document.getElementById("pill"),
  modeLbl: document.getElementById("modeLabel"),
  form: document.getElementById("searchForm"),
  q: document.getElementById("q"),
  genre: document.getElementById("genre"),
  year: document.getElementById("year"),
  go: document.getElementById("go"),
  body: document.getElementById("body"),
  headL: document.getElementById("headLeft"),
  headR: document.getElementById("headRight"),
  drawer: document.getElementById("drawer"),
  drawerBody: document.getElementById("drawerBody"),
  drawerClose: document.getElementById("drawerClose"),
};

/* ── Pill ─────────────────────────────────────── */
function positionPill() {
  const a = els.toggle.querySelector("button.active");
  if (!a) return;
  const t = els.toggle.getBoundingClientRect();
  const r = a.getBoundingClientRect();
  els.pill.style.width = r.width + "px";
  els.pill.style.transform = `translateX(${r.left - t.left - 3}px)`;
}
window.addEventListener("resize", positionPill);

/* ── Mode switch ─────────────────────────────── */
function setMode(mode) {
  state.mode = mode;
  els.toggle.querySelectorAll("button").forEach(b =>
    b.classList.toggle("active", b.dataset.mode === mode));
  els.modeLbl.textContent = mode === "artists" ? "Artists & People" : "Music & Albums";
  els.q.placeholder = mode === "artists"
    ? "Search artists or people…"
    : "Search albums or tracks…";
  // Only "year" filter makes sense in albums mode.
  els.year.style.display = mode === "albums" ? "" : "none";
  positionPill();
  resetResults();
}

function resetResults() {
  els.body.innerHTML = '<div class="state">Type something and hit <strong>Search</strong>.</div>';
  els.headL.textContent = "Results";
  els.headR.innerHTML = "&nbsp;";
}

els.toggle.addEventListener("click", e => {
  const b = e.target.closest("button[data-mode]");
  if (!b || b.dataset.mode === state.mode) return;
  setMode(b.dataset.mode);
});

/* ── Search ──────────────────────────────────── */
els.form.addEventListener("submit", e => { e.preventDefault(); search(); });
els.q.addEventListener("keydown", e => { if (e.key === "Enter") { e.preventDefault(); search(); } });

async function search() {
  if (state.loading) return;
  state.loading = true;
  els.go.disabled = true;

  els.headL.textContent = state.mode === "artists" ? "Artists" : "Music";
  els.headR.innerHTML = "&nbsp;";
  els.body.innerHTML = '<div class="state"><div class="spinner"></div><br>Searching…</div>';

  const q = els.q.value.trim();
  const genre = els.genre.value || undefined;
  const year = els.year.value ? Number(els.year.value) : undefined;

  try {
    let rows = [];
    if (state.mode === "artists") {
      const [artists, people] = await Promise.all([
        api.searchArtists({ q, genre }),
        api.searchPeople({ q }),
      ]);
      rows = [
        ...artists.map(d => ({ kind: "artist", data: d })),
        ...people.map(d => ({ kind: "person", data: d })),
      ];
    } else {
      const [albums, tracks] = await Promise.all([
        api.searchAlbums({ name: q, genre, year }),
        api.searchTracks({ name: q, genre, year }),
      ]);
      rows = [
        ...albums.map(d => ({ kind: "album", data: d })),
        ...tracks.map(d => ({ kind: "track", data: d })),
      ];
    }
    els.headR.textContent = `${rows.length} result${rows.length === 1 ? "" : "s"}`;
    renderRows(els.body, rows);
  } catch (err) {
    els.headR.innerHTML = "&nbsp;";
    els.body.innerHTML = `<div class="state err">Error: ${escapeHtml(err.message)}</div>`;
  } finally {
    state.loading = false;
    els.go.disabled = false;
  }
}

/* ── Row clicks → drawer ─────────────────────── */
els.body.addEventListener("click", e => {
  const row = e.target.closest(".row.clickable");
  if (!row) return;
  const kind = row.dataset.kind;
  const id = row.dataset.id;
  if (kind === "artist") return openDrawer(() => showArtistDetail(id));
  if (kind === "person") return openDrawer(() => showPersonDetail(id));
  if (kind === "album") return openDrawer(() => showAlbumDetail(id));
  if (kind === "track" && row.dataset.albumId)
    return openDrawer(() => showAlbumDetail(row.dataset.albumId));
});

/* ── Drawer helpers ──────────────────────────── */
async function openDrawer(builder) {
  els.drawer.hidden = false;
  els.drawerBody.innerHTML = '<div class="state"><div class="spinner"></div></div>';
  try {
    els.drawerBody.innerHTML = await builder();
  } catch (err) {
    els.drawerBody.innerHTML = `<p class="err">${escapeHtml(err.message)}</p>`;
  }
}
function closeDrawer() { els.drawer.hidden = true; els.drawerBody.innerHTML = ""; }
els.drawerClose.addEventListener("click", closeDrawer);
els.drawer.addEventListener("click", e => { if (e.target === els.drawer) closeDrawer(); });
document.addEventListener("keydown", e => { if (e.key === "Escape") closeDrawer(); });

// Links inside the drawer:
els.drawerBody.addEventListener("click", e => {
  const albumsBtn = e.target.closest("[data-albums-by-artist]");
  if (albumsBtn) {
    const name = albumsBtn.dataset.artistName || "";
    if (!name) return;
    closeDrawer();
    setMode("albums");
    els.q.value = name;
    runAlbumsByArtist(name);
    return;
  }
  const artistBtn = e.target.closest("[data-artist-id]");
  if (artistBtn) return openDrawer(() => showArtistDetail(artistBtn.dataset.artistId));
  const personBtn = e.target.closest("[data-person-id]");
  if (personBtn) return openDrawer(() => showPersonDetail(personBtn.dataset.personId));
});

/**
 * The "Show all albums by X" action. This is the specific case you called out:
 * an album search filtered by artist, without also filtering by album title.
 */
async function runAlbumsByArtist(artistName) {
  // Switch tab first (visual), but do NOT go through setMode()'s reset path —
  // just flip the classes and labels, then drive the results directly.
  state.mode = "albums";
  els.toggle.querySelectorAll("button").forEach(b =>
    b.classList.toggle("active", b.dataset.mode === "albums"));
  els.modeLbl.textContent = "Music & Albums";
  els.q.placeholder = "Search albums or tracks…";
  els.year.style.display = "";
  positionPill();

  try {
    const albums = await api.searchAlbums({ artist: artistName });
    els.headR.textContent = `${albums.length} album${albums.length === 1 ? "" : "s"}`;
    renderRows(els.body, albums.map(d => ({ kind: "album", data: d })));
  } catch (err) {
    els.body.innerHTML = `<div class="state err">Error: ${escapeHtml(err.message)}</div>`;
  } finally {
    els.go.disabled = false;
  }
}

/* ── Boot ────────────────────────────────────── */
async function loadGenres() {
  // There's no dedicated /genres endpoint, so derive the list from a broad
  // artist search. Cheap and cacheable; swap for a real endpoint later.
  try {
    const artists = await api.searchArtists({});
    const set = new Set();
    for (const a of artists) {
      if (a.genres) a.genres.split(",").forEach(g => set.add(g.trim()));
    }
    const opts = [...set].sort().map(g => `<option value="${escapeHtml(g)}">${escapeHtml(g)}</option>`).join("");
    els.genre.innerHTML = `<option value="">All genres</option>${opts}`;
  } catch { /* non-fatal */ }
}

setMode("artists");
requestAnimationFrame(positionPill);
loadGenres();