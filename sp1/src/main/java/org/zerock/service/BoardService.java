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
	
	
	
	
	
	
	
}
