-- Add soft-delete support to studies table (idempotent)
-- This migration adds a deleted_at column used by the app to move items to the trash

BEGIN;

-- Add deleted_at column if it doesn't exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM information_schema.columns
    WHERE table_schema = 'public'
      AND table_name = 'studies'
      AND column_name = 'deleted_at'
  ) THEN
    ALTER TABLE public.studies
      ADD COLUMN deleted_at TIMESTAMPTZ NULL;
  END IF;
END $$;

-- Helpful index for common queries (user_id + deleted_at)
CREATE INDEX IF NOT EXISTS idx_studies_user_deleted
  ON public.studies (user_id, deleted_at);

COMMIT;
-- Add deleted_at column for soft delete and index it
ALTER TABLE public.studies
ADD COLUMN IF NOT EXISTS deleted_at timestamptz NULL;

CREATE INDEX IF NOT EXISTS idx_studies_deleted_at ON public.studies (deleted_at);
