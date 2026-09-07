-- SkillBridge AI PostgreSQL foundation
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY,
  full_name VARCHAR(160) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  role VARCHAR(40) NOT NULL CHECK (role IN ('student','industry','academician','institution')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS skills (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(120) UNIQUE NOT NULL,
  category VARCHAR(80) NOT NULL
);
CREATE TABLE IF NOT EXISTS student_skills (
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  skill_id BIGINT REFERENCES skills(id) ON DELETE CASCADE,
  proficiency SMALLINT CHECK (proficiency BETWEEN 0 AND 100),
  verified BOOLEAN DEFAULT FALSE,
  PRIMARY KEY(user_id, skill_id)
);
CREATE TABLE IF NOT EXISTS opportunities (
  id BIGSERIAL PRIMARY KEY,
  posted_by UUID REFERENCES users(id),
  title VARCHAR(220) NOT NULL,
  company VARCHAR(180) NOT NULL,
  opportunity_type VARCHAR(60) NOT NULL,
  location VARCHAR(160),
  description TEXT,
  status VARCHAR(40) DEFAULT 'Open',
  created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS opportunity_skills (
  opportunity_id BIGINT REFERENCES opportunities(id) ON DELETE CASCADE,
  skill_id BIGINT REFERENCES skills(id) ON DELETE CASCADE,
  weight NUMERIC(5,2) DEFAULT 0,
  PRIMARY KEY(opportunity_id, skill_id)
);
CREATE TABLE IF NOT EXISTS applications (
  id BIGSERIAL PRIMARY KEY,
  opportunity_id BIGINT REFERENCES opportunities(id) ON DELETE CASCADE,
  student_id UUID REFERENCES users(id) ON DELETE CASCADE,
  status VARCHAR(50) DEFAULT 'Applied',
  applied_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS assessments (
  id BIGSERIAL PRIMARY KEY,
  student_id UUID REFERENCES users(id) ON DELETE CASCADE,
  role_target VARCHAR(160) NOT NULL,
  score NUMERIC(5,2) NOT NULL,
  assessment_json JSONB NOT NULL,
  completed_at TIMESTAMPTZ DEFAULT NOW()
);
