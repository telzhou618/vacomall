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

import com.vacomall.email.EMailService;
import com.vacomall.email.MailParam;
import com.vacomall.redis.JedisClient;

@ContextConfiguration(locations = { "classpath*:*.xml" })
public class BaseTest extends AbstractJUnit4SpringContextTests {

	@Autowired
	private JedisClient jedisClient;

	@Autowired
	private EMailService emailService;
	
	/**
	 * 测试Redis
	 */
	@Test
	public void testRedis() {
		jedisClient.set("test_key", "hello world");
		Assert.notNull(jedisClient.get("test_key"));
		System.out.println("#### redis server test ok .");
	}
	
	/**
	 * 测试Email
	 */
	@Test
	public void testEmail() {
		MailParam mailParam = new MailParam("274410087@qq.com", "测试邮件标题", "测试邮件内容");
		Assert.notNull(emailService);
		//emailService.send(mailParam);
		System.out.println("#### email server test ok .");
	}
}
