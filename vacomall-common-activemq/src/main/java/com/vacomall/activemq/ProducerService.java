package com.vacomall.activemq;

import javax.jms.Destination;

/**
 * 消息生产者接口
 * Created by GaoJun.Zhou on 2017年9月11日.
 * @version 1.0  
 * Function: TODO
 */
public interface  ProducerService {

	 public void sendMessage(Destination destination, final String message);
	
}
