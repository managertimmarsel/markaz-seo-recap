# Markaz SEO · Rekap Nama 20/11/2026

Dashboard laporan SEO 15 aplikasi Markaz, ditambah **rekap nama 4 tahap per card** (awal → perubahan pertama → revisi → saran revisi 20/11/2026) untuk ditinjau tim Academy. Setiap card bisa diberi status **Dipakai / Revisi / Tidak dipakai** beserta catatan; tinjauan disimpan di Supabase.

## Struktur
- `template.html` — halaman dashboard (HTML, CSS, JS) dengan placeholder data.
- `data/` — data laporan, perubahan 19 Nov, rekap 4 tahap, rumus revisi 20/11, statistik meeting.
- `scripts/build.mjs` — build tanpa dependency: menghasilkan `public/index.html` dan `public/config.js`.
- `supabase/schema.sql` — tabel `review` (status & catatan Academy per card), `review_log` (riwayatnya), `seo_feedback` (feedback tim SEO per card) dan `seo_feedback_log`.

## Setup
- Supabase: project `markaz-seo-recap` (Singapore) sudah dibuat dan tabelnya sudah ada (`supabase/schema.sql`).
- Vercel: buka vercel.com/new → Import repo `markaz-seo-recap` → Deploy. Tidak perlu isi apa pun; build command dan output sudah diatur di `vercel.json`, dan alamat Supabase sudah ada di `scripts/build.mjs`. (Opsional: timpa lewat env `SUPABASE_URL` dan `SUPABASE_ANON_KEY`.)

## Membaca hasil tinjauan
- Di halaman: menu **Rekap Nama 20/11** → filter status, atau tombol "Salin yang dipakai" (format tabel untuk Sheets).
- Di Supabase: `select * from review order by updated_at desc;`

Catatan: halaman memakai anon key, jadi siapa pun yang memegang link bisa memberi tinjauan. Bagikan link hanya ke tim internal.
