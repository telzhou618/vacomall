package com.vacomall.service.test;
/**
 * @author GaoJun.Zhou
 * @Time：2017年9月4日 下午2:04:34
 * @version 1.0
 */

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.util.Assert;

import com.vacomall.redis.JedisClient;
/**
 * Redis测试
 * Created by GaoJun.Zhou on 2017年9月11日.
 * @version 1.0  
 * Function: TODO
 */
@ContextConfiguration(locations = { "classpath:spring-context.xml","classpath:spring-jedis.xml" })
public class TestRedis extends AbstractJUnit4SpringContextTests {

	@Autowired
	private JedisClient jedisClient;

	@Test
	public void testRedis() {
		jedisClient.set("test_key", "hello world");
		Assert.notNull(jedisClient.get("test_key"));
		System.out.println("#### redis server test ok .");
	}
}
