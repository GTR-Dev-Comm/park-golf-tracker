-- items 테이블에 "소제목" 컬럼을 추가합니다.
-- Supabase SQL Editor에서 실행하세요. (기존 데이터는 그대로 유지됩니다)

alter table items add column if not exists subtitle text default '';
