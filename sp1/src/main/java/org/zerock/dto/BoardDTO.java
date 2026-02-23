package org.zerock.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder // 필요한 데이터만을 추가해서 객체를 생성할 수 있는 방법을 제공
@AllArgsConstructor
@NoArgsConstructor // 요청 파라미터 자동 수집 및 MyBatis에서 SELECT문의 결과를 처리할 때 필요(기본 생성자 + Setter 방식)
public class BoardDTO {
	// 게시물 번호(bno)와 같은 식별자(PK) 데이터는 "값이 없음(null)"을 표현해야 하는 경우가 많으므로
	// Long을 사용하는 것이 훨씬 안전하고 좋은 습관(long을 쓰면 0으로 초기화 -> 이게 0번 게시물인지, 번호가 없는 건지 모호함)
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
	private boolean delFlag;
	
	
	
	
	
	
}
