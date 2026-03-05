package org.zerock.mapper;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import lombok.extern.log4j.Log4j2;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
public class AccountMapperTests {
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Test
	public void testEncoding() {
		String pw = "1111";
		
		String enPw = encoder.encode(pw);
		log.info(enPw); // salt에 의해 매번 다른 값으로 해시화
		log.info("---------");
		
		boolean match = encoder.matches(pw, enPw);
		log.info(match);
	}
	
	
	
	
	
	
	
	
	
	
}
