// Build tanpa dependency: gabungkan template + data JSON menjadi public/index.html,
// dan tulis public/config.js dari environment variable Vercel (SUPABASE_URL, SUPABASE_ANON_KEY).
import { readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = join(dirname(fileURLToPath(import.meta.url)), '..');
const rd = (p) => readFileSync(join(root, p), 'utf8');
const js = (p) => rd(p).replace(/<\//g, '<\\/');

let body = rd('template.html')
  .replace('__DATA__', () => js('data/data.json'))
  .replace('__CHANGES__', () => js('data/changes.json'))
  .replace('__PROPOSALS__', () => js('data/rekap.json'))
  .replace('__RUMUS__', () => js('data/rumus20.json'))
  .replace('__MEETING__', () => js('data/meeting_stats.json'));

const html = `<!doctype html><html lang="id"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover"><meta name="robots" content="noindex,nofollow"></head><body>${body}</body></html>`;
mkdirSync(join(root, 'public'), { recursive: true });
writeFileSync(join(root, 'public/index.html'), html);

const cfg = {
  supabaseUrl: process.env.SUPABASE_URL || '',
  supabaseAnonKey: process.env.SUPABASE_ANON_KEY || '',
};
writeFileSync(join(root, 'public/config.js'), `window.MARKAZ_CONFIG=${JSON.stringify(cfg)};\n`);
console.log(`index.html ${(html.length / 1024).toFixed(0)} KB · Supabase ${cfg.supabaseUrl ? 'terisi' : 'BELUM diisi'}`);
