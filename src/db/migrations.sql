CREATE TABLE IF NOT EXISTS payment_intents (
    id BIGSERIAL PRIMARY KEY,
    reference TEXT NOT NULL UNIQUE,
    customer_id TEXT,
    customer_email TEXT NOT NULL,
    amount_minor INTEGER NOT NULL,
    currency TEXT NOT NULL CHECK (currency IN ('GHS')),
    status TEXT NOT NULL CHECK (status IN ('pending', 'paid', 'failed', 'canceled', 'refunded')),
    gateway_meta JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Index for fast lookup
CREATE INDEX IF NOT EXISTS idx_payment_intents_reference ON payment_intents(reference);

-- Trigger to auto-update updated_at
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END; $$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_payment_intents_updated ON payment_intents;
CREATE TRIGGER trg_payment_intents_updated
BEFORE UPDATE ON payment_intents
FOR EACH ROW EXECUTE FUNCTION set_updated_at();