ALTER TABLE products ADD COLUMN login_type TEXT NOT NULL DEFAULT 'gmail';
CREATE TABLE IF NOT EXISTS transaction_groups (id TEXT PRIMARY KEY, transaction_id TEXT UNIQUE NOT NULL, created_at INTEGER NOT NULL);
CREATE TABLE IF NOT EXISTS group_members (group_id TEXT NOT NULL, user_id TEXT NOT NULL, role TEXT NOT NULL, PRIMARY KEY(group_id,user_id));
CREATE TABLE IF NOT EXISTS payments (id TEXT PRIMARY KEY, transaction_id TEXT UNIQUE NOT NULL, method TEXT NOT NULL, reference TEXT DEFAULT '', proof_url TEXT DEFAULT '', status TEXT NOT NULL DEFAULT 'pending', created_at INTEGER NOT NULL, verified_at INTEGER);
CREATE TABLE IF NOT EXISTS notifications (id TEXT PRIMARY KEY, user_id TEXT NOT NULL, title TEXT NOT NULL, body TEXT NOT NULL, type TEXT NOT NULL, ref_id TEXT DEFAULT '', read_at INTEGER, created_at INTEGER NOT NULL);
CREATE INDEX IF NOT EXISTS idx_notifications_user ON notifications(user_id,created_at);
