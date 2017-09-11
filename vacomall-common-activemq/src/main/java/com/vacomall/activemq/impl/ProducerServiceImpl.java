package com.vacomall.activemq.impl;


import javax.annotation.Resource;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.Session;

import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;
import org.springframework.stereotype.Service;

import com.vacomall.activemq.ProducerService;

/**
 * 消息生产者实现
 * @author GaoJun.Zhou
 * @Time：2017年9月11日 下午12:33:57
 * @version 1.0
 */
@Service
public class ProducerServiceImpl implements ProducerService {
	 
    @Resource
    private JmsTemplate jmsTemplate;
    
    public void sendMessage(Destination destination, final String message) {
        jmsTemplate.send(destination, new MessageCreator() {
            public Message createMessage(Session session) throws JMSException {
                return session.createTextMessage(message);
            }
        });
    } 
}
