-- Supabase SQL schema for GloveCom

create table if not exists users (
  id uuid primary key default uuid_generate_v4(),
  name text,
  email text unique,
  created_at timestamptz default now()
);

create table if not exists gestures (
  id uuid primary key default uuid_generate_v4(),
  gesture_name text not null,
  esp32_pattern jsonb not null,
  message text,
  user_id uuid references users(id),
  created_at timestamptz default now()
);

create table if not exists history (
  id uuid primary key default uuid_generate_v4(),
  gesture_name text,
  translated_text text,
  user_id uuid references users(id),
  timestamp timestamptz default now()
);
