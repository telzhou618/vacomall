package com.vacomall.system;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

import com.vacomall.system.i.ISysLogService;

/**
 * @author GaoJun.Zhou
 * @Time：2017年9月4日 下午5:44:11
 * @version 1.0
 */
@ContextConfiguration(locations = { "classpath:spring/spring-context.xml" })
public class SystemTest extends AbstractJUnit4SpringContextTests {

	@Autowired ISysLogService sysLogService ;
	
	@Test
	public void test(){
		assertNotNull(sysLogService);
	}
	
}
