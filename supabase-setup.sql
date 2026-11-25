create table records (
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  day date not null,
  session text not null check (session in ('morning','evening')),
  tea int not null default 0,
  coffee int not null default 0,
  tea_price numeric not null default 0,
  coffee_price numeric not null default 0,
  primary key (user_id, day, session)
);
create table notes (
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  day date not null,
  note text not null,
  primary key (user_id, day)
);
create table prices (
  user_id uuid primary key default auth.uid() references auth.users on delete cascade,
  tea numeric not null default 10,
  coffee numeric not null default 15
);
alter table records enable row level security;
alter table notes enable row level security;
alter table prices enable row level security;
create policy "own records" on records for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "own notes" on notes for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "own prices" on prices for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
