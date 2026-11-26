-- Trackr cloud sync. Paste all of this into the Supabase SQL editor of the Trackr project and click Run, once.
-- There is no sign-in: the app's publishable key ships in index.html (a public repo), so ANYONE with that key
-- can read and change these tables. Deletes are soft (deleted = true), so a deleted run can still be recovered here.

-- Safe to run again: it never drops tables that hold synced data. It only removes the empty tables
-- from an earlier draft of this file (the sign-in version, which had a user_id column).
do $$ begin
  if exists (select 1 from information_schema.columns where table_schema = 'public' and table_name = 'trackr_activities' and column_name = 'user_id') then
    drop table public.trackr_activities;
    drop table if exists public.trackr_settings;
  end if;
end $$;

create table if not exists public.trackr_activities (
  id text primary key,                   -- the activity id the app made (Date.now() or a Strava id)
  data jsonb,                            -- the whole activity, as stored on the phone; null once deleted
  deleted boolean not null default false,
  updated_at timestamptz not null default clock_timestamp()
);

create table if not exists public.trackr_settings (
  key text primary key check (key in ('vo2', 'coach', 'profile', 'ref', 'skip', 'gym')),
  value jsonb,
  updated_at timestamptz not null default clock_timestamp()
);

-- Widen the allowed keys on a database made before the Gym tab (gym = workout templates).
alter table public.trackr_settings drop constraint if exists trackr_settings_key_check;
alter table public.trackr_settings add constraint trackr_settings_key_check check (key in ('vo2', 'coach', 'profile', 'ref', 'skip', 'gym'));

create index if not exists trackr_activities_changed on public.trackr_activities (updated_at);
create index if not exists trackr_settings_changed on public.trackr_settings (updated_at);

-- The server stamps every write, so a device can ask for "everything changed since my last sync".
-- clock_timestamp() rather than now() gives each row of a batch its own time.
create or replace function public.trackr_touch() returns trigger
language plpgsql set search_path = '' as $$
begin
  new.updated_at := clock_timestamp();
  return new;
end;
$$;
drop trigger if exists trackr_activities_touch on public.trackr_activities;
create trigger trackr_activities_touch before insert or update on public.trackr_activities
  for each row execute function public.trackr_touch();
drop trigger if exists trackr_settings_touch on public.trackr_settings;
create trigger trackr_settings_touch before insert or update on public.trackr_settings
  for each row execute function public.trackr_touch();

alter table public.trackr_activities enable row level security;
alter table public.trackr_settings enable row level security;
drop policy if exists "open" on public.trackr_activities;
create policy "open" on public.trackr_activities for all to anon, authenticated using (true) with check (true);
drop policy if exists "open" on public.trackr_settings;
create policy "open" on public.trackr_settings for all to anon, authenticated using (true) with check (true);
grant select, insert, update on public.trackr_activities, public.trackr_settings to anon, authenticated;
