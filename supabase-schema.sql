-- 진행기록 트래커 - Supabase 스키마
-- Supabase 대시보드 > SQL Editor 에서 이 파일 전체를 붙여넣고 실행하세요.

create table if not exists categories (
  id text primary key,
  name text not null,
  color text not null,
  created_at timestamptz default now()
);

create table if not exists items (
  id text primary key,
  category_id text references categories(id),
  title text not null,
  status text default '진행중',
  assignees jsonb default '[]'::jsonb,
  date date,
  all_day boolean default true,
  time text default '',
  location text default '',
  linked_case_id text,
  converted_from text,
  reminder_time text default '',
  logs jsonb default '[]'::jsonb,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table categories enable row level security;
alter table items enable row level security;

-- 앱 화면 자체 비밀번호로 보호되므로, anon key로 자유롭게 읽고 쓸 수 있도록 허용합니다.
drop policy if exists "public categories access" on categories;
create policy "public categories access" on categories
  for all using (true) with check (true);

drop policy if exists "public items access" on items;
create policy "public items access" on items
  for all using (true) with check (true);

insert into categories (id, name, color) values
  ('cat-schedule', '일정', '#2F5233'),
  ('cat-todo', '할일', '#C9A227'),
  ('cat-sales', '미팅일정', '#8A4B2E'),
  ('cat-progress', '진행사항', '#4A5B6A')
on conflict (id) do nothing;
