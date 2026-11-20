# Markaz SEO · Rekap Nama 20/11/2026

Dashboard laporan SEO 15 aplikasi Markaz, ditambah **rekap nama 4 tahap per card** (awal → perubahan pertama → revisi → saran revisi 20/11/2026) untuk ditinjau tim Academy. Setiap card bisa diberi status **Dipakai / Revisi / Tidak dipakai** beserta catatan; tinjauan disimpan di Supabase.

## Struktur
- `template.html` — halaman dashboard (HTML, CSS, JS) dengan placeholder data.
- `data/` — data laporan, perubahan 19 Nov, rekap 4 tahap, rumus revisi 20/11, statistik meeting.
- `scripts/build.mjs` — build tanpa dependency: menghasilkan `public/index.html` dan `public/config.js`.
- `supabase/schema.sql` — tabel `review` (status terakhir per card) dan `review_log` (riwayat setiap perubahan).

## Setup
1. Supabase: jalankan `supabase/schema.sql` di SQL Editor.
2. Vercel: isi Environment Variables `SUPABASE_URL` dan `SUPABASE_ANON_KEY` (Settings → API di Supabase), lalu deploy. Build command `node scripts/build.mjs`, output `public` (sudah diatur di `vercel.json`).

## Membaca hasil tinjauan
- Di halaman: menu **Rekap Nama 20/11** → filter status, atau tombol "Salin yang dipakai" (format tabel untuk Sheets).
- Di Supabase: `select * from review order by updated_at desc;`

Catatan: halaman memakai anon key, jadi siapa pun yang memegang link bisa memberi tinjauan. Bagikan link hanya ke tim internal.
