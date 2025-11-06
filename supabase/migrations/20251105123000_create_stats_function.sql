-- Create helper function to return app statistics (counts)
-- Returns a jsonb with counts for auth.users, public.profiles and public.studies

CREATE OR REPLACE FUNCTION public.get_app_counts()
RETURNS jsonb
LANGUAGE sql
STABLE
AS $$
SELECT jsonb_build_object(
  'auth_users', (SELECT COUNT(*) FROM auth.users),
  'profiles', (SELECT COUNT(*) FROM public.profiles),
  'studies', (SELECT COUNT(*) FROM public.studies WHERE deleted_at IS NULL),
  'deleted_studies', (SELECT COUNT(*) FROM public.studies WHERE deleted_at IS NOT NULL)
);
$$;

-- Optionally grant execute to anon if you want the client (unauthenticated) to call it
-- GRANT EXECUTE ON FUNCTION public.get_app_counts() TO anon;
