-- Add deleted_at column to studies table for soft deletes
ALTER TABLE public.studies 
ADD COLUMN deleted_at TIMESTAMP WITH TIME ZONE DEFAULT NULL;

-- Add index for better query performance on trash queries
CREATE INDEX idx_studies_deleted_at ON public.studies(deleted_at) 
WHERE deleted_at IS NOT NULL;