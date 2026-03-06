CREATE TABLE persistent_logins (
	username VARCHAR(64) NOT NULL, -- 사용자 ID
  series VARCHAR(64) PRIMARY KEY, -- 로그인 세션 식별자
  token VARCHAR(64) NOT NULL, -- 매번 변경되는 1회용 인증 토큰
  last_used DATETIME NOT NULL -- 마지막 사용 시간
);