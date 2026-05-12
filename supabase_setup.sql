-- =============================================
-- DeenApp Database Setup
-- Run this in Supabase SQL Editor
-- =============================================

-- Zikir progress logs
CREATE TABLE IF NOT EXISTS zikir_logs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('post_salat', 'morning', 'evening')),
  zikir_name TEXT NOT NULL,
  count INTEGER NOT NULL DEFAULT 0,
  target INTEGER NOT NULL,
  completed BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Prayer tracking logs
CREATE TABLE IF NOT EXISTS prayer_logs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  prayer_name TEXT NOT NULL CHECK (prayer_name IN ('fajr', 'dhuhr', 'asr', 'maghrib', 'isha')),
  prayed_at TIMESTAMPTZ,
  on_time BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for performance
CREATE INDEX idx_zikir_logs_user_date ON zikir_logs (user_id, created_at);
CREATE INDEX idx_prayer_logs_user_date ON prayer_logs (user_id, created_at);

-- =============================================
-- Row Level Security (RLS)
-- Users can only access their own data
-- =============================================

ALTER TABLE zikir_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE prayer_logs ENABLE ROW LEVEL SECURITY;

-- Zikir: users can read/write their own logs
CREATE POLICY "Users can view own zikir logs"
  ON zikir_logs FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own zikir logs"
  ON zikir_logs FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own zikir logs"
  ON zikir_logs FOR UPDATE
  USING (auth.uid() = user_id);

-- Prayer: users can read/write their own logs
CREATE POLICY "Users can view own prayer logs"
  ON prayer_logs FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own prayer logs"
  ON prayer_logs FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own prayer logs"
  ON prayer_logs FOR UPDATE
  USING (auth.uid() = user_id);
