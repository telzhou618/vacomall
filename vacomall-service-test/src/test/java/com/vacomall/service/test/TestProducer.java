package com.vacomall.service.test;
/**
 * @author GaoJun.Zhou
 * @Time：2017年9月4日 下午2:04:34
 * @version 1.0
 */

import javax.jms.Destination;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

import com.vacomall.activemq.ProducerService;

/**
 * 生产者测试
 * Created by GaoJun.Zhou on 2017年9月11日.
 * @version 1.0  
 * Function: TODO
 */
@ContextConfiguration(locations = {"classpath:spring-context.xml","classpath:spring-mq-producer.xml" })
public class TestProducer extends AbstractJUnit4SpringContextTests {

	@Autowired
	ProducerService producerService;

	@Autowired
	Destination queueDestination;

	@Test
	public void testProducer() {
		producerService.sendMessage(queueDestination, "Hello World");
	}

}
