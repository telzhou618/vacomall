package com.vacomall.controller;

/**
 * @author GaoJun.Zhou
 * @Time：2017年9月6日 下午12:27:26
 * @version 1.0
 */
public class AdminController {
	/**
	 * 重定向
	 * @param view
	 * @return
	 */
	public String redirectTo(String view){
		return "redirect:" + view;
	}	
}
