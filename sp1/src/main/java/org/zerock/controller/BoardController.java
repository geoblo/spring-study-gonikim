package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/board")
@Log4j2
@RequiredArgsConstructor
public class BoardController {
	
	private final BoardService boardService;
	
	// Quiz1: 게시물 목록은 '/board/list'라는 경로를 GET 방식으로 호출해서 동작하도록 설계
	// Quiz2: BoardService를 이용해서 호출한 반환된 결과를 담아 화면으로 전달
	@GetMapping("/list")
	public void list(Model model) {
		log.info("---------------------------------");
		log.info("board list");
		
		model.addAttribute("list", boardService.getList());
	}
	
	// 게시물 등록은 GET 방식과 POST 방식 모두를 이용해서 처리
	// GET: 게시물 등록에 필요한 입력 화면
	// POST: 게시물 등록 처리 후 게시물 목록으로 리다이렉트
	@GetMapping("/register")
	public void register() {
		log.info("---------------------------------");
		log.info("board register");
	}
	
	// Quiz: registerPost()는 POST 방식의 요청을 처리하고 
	// 브라우저에게 '/board/list'로 이동하도록 유도(리다이렉트)
	@PostMapping("/register")
	public String registerPost() {
		log.info("---------------------------------");
		log.info("board register post");
		
		return "redirect:/board/list";
	}
	
	// 게시물 조회는 GET 방식으로 게시물의 번호로 해당 게시물을 Model에 담아서 전달하는 방식으로 구성
	// 경로의 마지막 값을 게시물의 번호로 활용
	@GetMapping("/read/{bno}")
	public String read(@PathVariable("bno") Long bno) {
		log.info("---------------------------------");
		log.info("board read");
		
		return "/board/read";
	}
	
	// GET 방식으로 수정하려고 하는 게시물을 확인하고, POST 방식으로 수정이나 삭제를 처리
	@GetMapping("/modify/{bno}")
	public String modifyGet(@PathVariable("bno") Long bno) {
		log.info("---------------------------------");
		log.info("board modify get");
		
		return "/board/modify";
	}
	
	@PostMapping("/modify")
	public String modifyPost() {
		log.info("---------------------------------");
		log.info("board modify post");
		
		return "redirect:/board/read/123";
	}
	
	@PostMapping("/remove")
	public String remove() {
		log.info("---------------------------------");
		log.info("board remove post");
		
		return "redirect:/board/list";
	}
	
	
	
	
	
	
	
	
}
