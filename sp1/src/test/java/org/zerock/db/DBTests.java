package org.zerock.db;

import javax.sql.DataSource;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import lombok.extern.log4j.Log4j2;

@ExtendWith(SpringExtension.class) // Junit(Jupiter)에 스프링 테스트 프레임워크를 사용하도록 확장으로 등록하는 것
// 이게 없으면? 그냥 순수 JUnit 테스트일 뿐, 스프링 환경에서 DI 등이 실행이 안됨
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml") // 테스트에 필요한 설정을 로딩하기 위해 설정
@Log4j2
public class DBTests {
	
	@Autowired // HikariCP에서 만들어진 DataSource 타입의 빈을 주입하도록 설정
	private DataSource dataSource;
	
	@Test
	public void testConnection() {
		log.info("---------------");
		log.info(dataSource); // 빈으로 주입된 객체가 정상적으로 만들어졌는지 log로 확인		
		log.info("---------------");
	}
	
}
