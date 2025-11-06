-- Add soft-delete support to studies table (idempotent)
-- This migration adds a deleted_at column used by the app to move items to the trash
BEGIN;

-- Ensure the deleted_at column exists (idempotent)
ALTER TABLE public.studies ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMPTZ NULL;

-- Indexes to speed up trash queries
CREATE INDEX IF NOT EXISTS idx_studies_user_deleted ON public.studies (user_id, deleted_at);
CREATE INDEX IF NOT EXISTS idx_studies_deleted_at ON public.studies (deleted_at);

COMMIT;
