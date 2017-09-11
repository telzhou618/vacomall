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

/**
 * 邮件发送测试
 * Created by GaoJun.Zhou on 2017年9月11日.
 * @version 1.0  
 * Function: TODO
 */
@ContextConfiguration(locations = { "classpath:spring-context.xml","classpath:spring-mail.xml" })
public class TestEmail extends AbstractJUnit4SpringContextTests {

	@Autowired
	private EMailService emailService;

	@Test
	public void testEmail() {
		MailParam mailParam = new MailParam("274410087@qq.com", "测试邮件标题", "测试邮件内容");
		Assert.notNull(emailService);
		emailService.send(mailParam);
		System.out.println("#### email server test ok .");
	}
}
