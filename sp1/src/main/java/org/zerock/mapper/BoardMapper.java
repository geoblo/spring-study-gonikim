package org.zerock.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.zerock.dto.BoardDTO;

public interface BoardMapper {

	int insert(BoardDTO dto);
	
	BoardDTO selectOne(Long bno);
	
	int remove(Long bno);
	
	int update(BoardDTO dto);
	
	List<BoardDTO> list();
	
	// MyBatis에서 여러 값을 전달하려면 @Param, Map 타입, 또는 객체(DTO) 타입을 사용
	// 잘못된 코드
	// List<BoardDTO> list2(int skip, int count);
	// 매퍼 XML에서 
	// LIMIT #{skip}, #{count} -- MyBatis는 skip, count라는 이름을 모름
	// 1. @Param 사용(권장)
	// SQL에서 사용할 파라미터 이름을 명시적으로 지정하는 역할, 예: @Param("skip") -> SQL에서 #{skip}
	List<BoardDTO> list2(@Param("skip") int skip, @Param("count") int count);
	// 2. Map 사용
//	List<BoardDTO> list2(Map<String, Integer> param);
	// 3. DTO 객체 사용(권장)
//	List<BoardDTO> list2(PageRequestDTO dto);
	
	int listCount();
	
	
	
	
	
	
	
	
	
	
	
	
}
