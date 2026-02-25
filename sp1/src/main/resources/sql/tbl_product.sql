CREATE TABLE tbl_product (
	pno INT AUTO_INCREMENT PRIMARY KEY,  -- 상품 번호(고유식별자)
  pname VARCHAR(200) NOT NULL,         -- 상품 이름
  pdesc VARCHAR(1000) NOT NULL,        -- 상품 설명
  price INT NOT NULL,                  -- 상품 가격
  sale BOOLEAN DEFAULT FALSE,          -- 판매 여부(false)
  writer VARCHAR(100) NOT NULL,        -- 상품 등록자
  regdate DATETIME DEFAULT CURRENT_TIMESTAMP,
  moddate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE tbl_product_image (
	ino INT AUTO_INCREMENT PRIMARY KEY,  -- 이미지 번호(고유식별자)
  pno INT NOT NULL,                    -- 상품 번호(외래키)
  filename VARCHAR(300) NOT NULL,      -- 실제 파일명 또는 저장된 경로
  uuid CHAR(36) NOT NULL,              -- 파일명 중복 방지를 위한 UUID
  ord INT DEFAULT 0,                   -- 이미지 정렬 순서
  regdate DATETIME DEFAULT CURRENT_TIMESTAMP,  -- 등록일
  FOREIGN KEY (pno) REFERENCES tbl_product(pno) ON DELETE CASCADE,
  INDEX idx_product_image_pno (pno, ord)
);

CREATE INDEX idx_product_image_pno ON tbl_product_image(pno, ord);