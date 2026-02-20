package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.dto.SampleDTO;
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
		
		helloService.hello1();
	}
	// 메소드가 void이면 스프링이 요청 URL 기반으로 뷰 이름을 추론
	// 즉, 사용된 요청 경로 = 뷰 이름
	
	@GetMapping("/ex2")
	public String ex2() {
		log.info("/sample/ex2");
		
		helloService.hello2("Hong Gil Dong");
		
		return "sample/success";
	}
	
	@GetMapping("/ex3")
	public String ex3() {
		log.info("/sample/ex3");
		
		return "redirect:/sample/ex3re";
		// 브라우저에게 /sample/ex3re 로 이동하라는 메시지를 전송
	}
	
	@GetMapping("/ex3re")
	public String ex3Re() {
		log.info("/sample/ex3re");
		
		return "sample/ex3re";
	}
	
	@GetMapping("/ex4")
	public void ex4(
			@RequestParam(name = "n1", defaultValue = "1") int num, // 파라미터가 없는 경우 기본값을 사용
//			@RequestParam(name = "name", required = false) String name) { // 필수 여부 지정, 파라미터가 없어도 에러없이 받고 싶을 때
			@RequestParam("name") String name) { // 속성이 하나인 경우 그냥 문자열로 작성 가능
//			@RequestParam String name) { // 자바 컴파일 옵션 추가 필요(권장X)
		log.info("/sample/ex4");
		log.info("num: " + num);
		log.info("name: " + name);
	}
	
	@GetMapping("/ex5")
	public void ex5(SampleDTO dto) { // 객체형은 별도의 어노테이션 없이 선언
		log.info("/sample/ex5");
		log.info(dto);		
	}
	
	@GetMapping("/ex6")
	public void ex6(Model model) {
		model.addAttribute("name", "Hong Gil Dong");
		model.addAttribute("age", 16);
		// 참고: 뷰 렌더링 직전에 request attribute로 복사됨
	}
	
	@GetMapping("/ex7")
	public String ex7(RedirectAttributes rttr) {
		// 리다이렉트 시 새로운 요청으로 데이터를 전달하는 2가지 방법
		rttr.addAttribute("name", "Hong"); // 쿼리스트링으로 만들어 데이터 전달
		rttr.addFlashAttribute("age", 16); // 1회성 데이터 전달용
		// 참고: 내부적으로 세션에 임시 저장 후, 다음 요청에서 Model에 자동 주입되고 즉시 제거됨
		
		return "redirect:/sample/ex8";
	}
	
	@GetMapping("/ex8")
	public void ex8() {
		log.info("/sample/ex8");
	}
	
	
	
	
	
	
	
	
}
