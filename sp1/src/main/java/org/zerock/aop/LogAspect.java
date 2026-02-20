package org.zerock.aop;

import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j2;

@Aspect
@Log4j2
@Component
public class LogAspect {
	
	// 특정 객체의 메소드가 실행될 때 전달되는 파라미터를 자동으로 로깅
	// @Before: 타겟 메소드의 실행 전에 동작할 것을 명시
	// "execution()": 포인트컷 표현식 중 하나로 문자열로 포인트컷 설정을 지정
	// * org.zerock.service.*.*(..):
	// org.zerock.service 패키지 내에 모든 클래스(*)의 모든 메소드(*)가 실행 전에 logParam()가 동작하도록 지정
	// 리턴 타입(맨 앞 *)이나 매개변수(..) 상관없이 모든 메소드
	@Before("execution(* org.zerock.service.*.*(..))")
	public void logParam(JoinPoint jp) { // JoinPoint: 현재 실행 중인 메소드 정보, 전달된 파라미터, 타겟 객체 등
		log.info("-------------------------");
		log.info("logParam()");
		
		Object[] params = jp.getArgs();
		log.info(Arrays.toString(params)); // 배열을 문자열로 변환할 때 사용하는 유틸 메소드
		
		Object target = jp.getTarget();
		log.info(target);
		
		log.info("-------------------------");
	}
	
	// 시간 성능 측정
	@Around("execution(* org.zerock.service.*.*(..))")
	public Object logTime(ProceedingJoinPoint pjp) throws Throwable {
		log.info("-------------------------");
		log.info("logTime()");
		
		long start = System.currentTimeMillis();
		
		Object result = pjp.proceed(); // @Around는 이 코드를 직접 호출해야 타겟 메소드가 실제로 실행됨
		
		long end = System.currentTimeMillis();
		
		log.info("-------------------------");
		log.info("TIME: " + (end - start));		
		
		return result;
	}
	
	
	
	
	

}
