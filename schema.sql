create extension if not exists pgcrypto;

create table if not exists public.cards (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  set_name text,
  sport_or_game text,
  year int,
  card_number text,
  grade text,
  estimated_low numeric,
  estimated_high numeric,
  deal_score int check (deal_score between 0 and 100),
  image_url text,
  passport_code text unique not null,
  notes text,
  created_at timestamptz default now()
);

create table if not exists public.watchlist (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  card_name text not null,
  target_price numeric,
  created_at timestamptz default now()
);

alter table public.cards enable row level security;
alter table public.watchlist enable row level security;

drop policy if exists "cards_select_own" on public.cards;
create policy "cards_select_own" on public.cards for select using (auth.uid() = user_id);
drop policy if exists "cards_insert_own" on public.cards;
create policy "cards_insert_own" on public.cards for insert with check (auth.uid() = user_id);
drop policy if exists "cards_update_own" on public.cards;
create policy "cards_update_own" on public.cards for update using (auth.uid() = user_id);
drop policy if exists "cards_delete_own" on public.cards;
create policy "cards_delete_own" on public.cards for delete using (auth.uid() = user_id);

drop policy if exists "watchlist_select_own" on public.watchlist;
create policy "watchlist_select_own" on public.watchlist for select using (auth.uid() = user_id);
drop policy if exists "watchlist_insert_own" on public.watchlist;
create policy "watchlist_insert_own" on public.watchlist for insert with check (auth.uid() = user_id);
drop policy if exists "watchlist_delete_own" on public.watchlist;
create policy "watchlist_delete_own" on public.watchlist for delete using (auth.uid() = user_id);

-- Storage bucket for card photos
insert into storage.buckets (id, name, public)
values ('card-images', 'card-images', false)
on conflict (id) do nothing;

drop policy if exists "card_images_select_own" on storage.objects;
create policy "card_images_select_own" on storage.objects for select
using (bucket_id = 'card-images' and auth.uid()::text = (storage.foldername(name))[1]);

drop policy if exists "card_images_insert_own" on storage.objects;
create policy "card_images_insert_own" on storage.objects for insert
with check (bucket_id = 'card-images' and auth.uid()::text = (storage.foldername(name))[1]);

drop policy if exists "card_images_delete_own" on storage.objects;
create policy "card_images_delete_own" on storage.objects for delete
using (bucket_id = 'card-images' and auth.uid()::text = (storage.foldername(name))[1]);
