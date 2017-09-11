package com.vacomall.service.test;
/**
 * @author GaoJun.Zhou
 * @Time：2017年9月4日 下午2:04:34
 * @version 1.0
 */

import org.junit.Test;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

@ContextConfiguration(locations = { "classpath:spring-mq-consumer.xml" })
public class TestConsumer extends AbstractJUnit4SpringContextTests {

	@Test
	public void testHell() {
		while(true){}
	}

}
