package com.vacomall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.vacomall.system.i.ISysLogService;

/**
 * @author GaoJun.Zhou
 * @Time：2017年9月5日 上午10:37:54
 * @version 1.0
 */
@Controller
@RequestMapping("/log")
public class LogController {

	@Autowired private ISysLogService sysLogService;
	
	@RequestMapping("/list")
	public String list(Model model){
		
		model.addAttribute("list",sysLogService.selectList(null));
		model.addAttribute("name", "zhangsan");
		return "log/list";
	}
	
}
