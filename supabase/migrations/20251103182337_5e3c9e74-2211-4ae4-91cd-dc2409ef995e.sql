-- Add deleted_at column to studies table for soft deletes
-- Ensure deleted_at exists (idempotent)
ALTER TABLE public.studies ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMP WITH TIME ZONE NULL;

-- Add index for better query performance on trash queries (only for non-null values)
CREATE INDEX IF NOT EXISTS idx_studies_deleted_at ON public.studies(deleted_at) WHERE deleted_at IS NOT NULL;