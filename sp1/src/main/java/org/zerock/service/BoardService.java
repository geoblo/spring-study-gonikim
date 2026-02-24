package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.dto.BoardDTO;
import org.zerock.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@RequiredArgsConstructor
@Log4j2
@Transactional
public class BoardService {
	
	private final BoardMapper boardMapper;
	
	// 게시물 목록 처리: BoardMapper에서 나온 BoardDTO 목록을 반환하도록 작성
	public List<BoardDTO> getList() {
		return boardMapper.list();
	}
	
	// 게시글 등록 처리: 등록 기능을 작성하고 새로 추가된 게시물의 번호를 반환하도록 구성
	public Long register(BoardDTO dto) {
		int insertCount = boardMapper.insert(dto);
		
		log.info("insertCount: " + insertCount);
		
		return dto.getBno();
	}
	
	// 게시물 조회 처리: 파라미터는 게시물의 번호(bno)이고 리턴 타입은 BoardDTO를 사용
	public BoardDTO read(Long bno) {
		BoardDTO boardDTO = boardMapper.selectOne(bno);
		
		return boardDTO;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
