-- RARA Wellness Club: shared workspace table
-- Execute in Supabase > SQL Editor as project owner.
create table if not exists public.rara_workspace (
  id text primary key check (id = 'main'),
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.rara_workspace enable row level security;

drop policy if exists "RARA admin can read workspace" on public.rara_workspace;
drop policy if exists "RARA admin can insert workspace" on public.rara_workspace;
drop policy if exists "RARA admin can update workspace" on public.rara_workspace;

create policy "RARA admin can read workspace"
on public.rara_workspace for select to authenticated
using (lower(coalesce(auth.jwt() ->> 'email','')) = 'rarawellnessclub@gmail.com');

create policy "RARA admin can insert workspace"
on public.rara_workspace for insert to authenticated
with check (lower(coalesce(auth.jwt() ->> 'email','')) = 'rarawellnessclub@gmail.com');

create policy "RARA admin can update workspace"
on public.rara_workspace for update to authenticated
using (lower(coalesce(auth.jwt() ->> 'email','')) = 'rarawellnessclub@gmail.com')
with check (lower(coalesce(auth.jwt() ->> 'email','')) = 'rarawellnessclub@gmail.com');

grant select, insert, update on public.rara_workspace to authenticated;

-- Enable realtime notifications for shared changes.
do $$
begin
  alter publication supabase_realtime add table public.rara_workspace;
exception when duplicate_object then
  null;
when undefined_object then
  null;
end $$;
