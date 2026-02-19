package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.zerock.service.HelloService;

import lombok.RequiredArgsConstructor;
import lombok.ToString;
import lombok.extern.log4j.Log4j2;

@Controller // 해당 클래스의 객체가 스프링에서 빈(Bean)으로 관리되는 대상임을 지정
@RequiredArgsConstructor // 생성자를 통한 의존성 주입을 할 수 있도록
@ToString
@Log4j2
@RequestMapping("/sample") // '/sample'로 시작하는 요청을 HelloController가 처리한다는 것을 의미
public class HelloController {
	
	private final HelloService helloService;
	
//	@Autowired // 생성자가 하나만 있을 때는 생략 가능
//	public HelloController(HelloService helloService) {
//		this.helloService = helloService;
//	}
	
//	@RequestMapping(value = "/ex1", method = RequestMethod.GET) // 옛날 방식
	// 스프링 4.3 이상에서는 @GetMapping, @PostMapping, @PutMapping, @DeleteMapping 등 지원
	@GetMapping("/ex1")
	public void ex1() {
		log.info("/sample/ex1");
	}
	// 메소드가 void이면 스프링이 요청 URL 기반으로 뷰 이름을 추론
	// 즉, 사용된 요청 경로 = 뷰 이름
	
	
	
	
	
	
	
	
	
	
}
