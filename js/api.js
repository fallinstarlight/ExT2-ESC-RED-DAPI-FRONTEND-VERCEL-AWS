// js/api.js — thin fetch wrappers for both APIs.
export const API_ARTISTS = "http://localhost:8000";
export const API_ALBUMS  = "http://localhost:8001";

async function get(base, path, params = {}) {
  const url = new URL(base + path);
  for (const [k, v] of Object.entries(params)) {
    if (v !== undefined && v !== null && v !== "") url.searchParams.set(k, v);
  }
  const res = await fetch(url, { headers: { Accept: "application/json" } });
  if (!res.ok) {
    let msg = `HTTP ${res.status}`;
    try { const j = await res.json(); if (j.error) msg = j.error; } catch {}
    throw new Error(msg);
  }
  return res.json();
}

export const api = {
  // Artists API
  searchArtists: (p) => get(API_ARTISTS, "/artists", p),
  artist:        (id) => get(API_ARTISTS, `/artists/${id}`),
  bandMembers:   (id) => get(API_ARTISTS, `/artists/${id}/members`),
  searchPeople:  (p) => get(API_ARTISTS, "/people", p),
  person:        (id) => get(API_ARTISTS, `/people/${id}`),

  // Albums API
  searchAlbums: (p) => get(API_ALBUMS, "/albums", p),
  album:        (id) => get(API_ALBUMS, `/albums/${id}`),
  albumTracks:  (id) => get(API_ALBUMS, `/albums/${id}/tracks`),
  searchTracks: (p) => get(API_ALBUMS, "/tracks", p),
};