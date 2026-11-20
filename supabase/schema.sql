-- Tabel tinjauan tim Academy untuk rekap nama card Markaz.
-- Sudah diterapkan di project Supabase "markaz-seo-recap" (ref zpmgxjvxslhvufmsgpav, Singapore).
-- Untuk project baru: SQL Editor > New query > tempel > Run.

create table if not exists public.review (
  key          text primary key,          -- app~tab~id, mis. jadiojk~Latsol~129
  app          text not null,
  tab          text not null,
  card_id      text not null,
  nama_saran   text,                      -- nama tahap 4 (saran revisi 20/11/2026)
  status       text not null default 'menunggu'
               check (status in ('menunggu','setuju','revisi','tolak')),  -- setuju = Dipakai, tolak = Tidak dipakai
  catatan      text default '' check (char_length(catatan) <= 4000),
  nama_revisi  text default '' check (char_length(nama_revisi) <= 300),  -- diisi bila tim minta nama lain
  reviewer     text not null check (char_length(reviewer) between 1 and 120),
  updated_at   timestamptz not null default now()
);

create table if not exists public.review_log (
  id          bigint generated always as identity primary key,
  key         text not null,
  status      text,
  catatan     text,
  nama_revisi text,
  reviewer    text,
  created_at  timestamptz not null default now()
);
create index if not exists review_log_key_idx on public.review_log (key);

alter table public.review     enable row level security;
alter table public.review_log enable row level security;

-- Halaman memakai anon key: siapa pun yang punya link bisa membaca dan memberi tinjauan.
drop policy if exists "review read"   on public.review;
drop policy if exists "review insert" on public.review;
drop policy if exists "review update" on public.review;
create policy "review read"   on public.review for select to anon, authenticated using (true);
create policy "review insert" on public.review for insert to anon, authenticated with check (true);
create policy "review update" on public.review for update to anon, authenticated using (true) with check (true);

drop policy if exists "log read"   on public.review_log;
drop policy if exists "log insert" on public.review_log;
create policy "log read"   on public.review_log for select to anon, authenticated using (true);
create policy "log insert" on public.review_log for insert to anon, authenticated with check (true);

-- Realtime: status yang diubah satu orang langsung muncul di layar orang lain.
do $$ begin
  alter publication supabase_realtime add table public.review;
exception when duplicate_object then null; end $$;
