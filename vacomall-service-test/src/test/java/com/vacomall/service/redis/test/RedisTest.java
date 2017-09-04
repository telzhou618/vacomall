package com.vacomall.service.redis.test;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.util.Assert;

import com.vacomall.redis.JedisClient;

/**
 * @author GaoJun.Zhou
 * @Time：2017年9月4日 下午12:16:23
 * @version 1.0
 */
@ContextConfiguration(locations = { "classpath*:*.xml" })
public class RedisTest extends AbstractJUnit4SpringContextTests {
	@Autowired
	private JedisClient jedisClient;
	
	@Test
	public void test(){
		System.out.println("------------start redis test---------------");
		jedisClient.set("test_key", "hello world");
		Assert.notNull(jedisClient.get("test_key"));
		System.out.println("redis test ok .");
		System.out.println("------------end redis test-----------------");
	}
}
