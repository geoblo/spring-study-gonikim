package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.zerock.service.HelloService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor // 생성자를 통한 의존성 주입을 할 수 있도록
public class HelloController {
	
	private final HelloService helloService;
	
//	@Autowired // 생성자가 하나만 있을 때는 생략 가능
//	public HelloController(HelloService helloService) {
//		this.helloService = helloService;
//	}
}
