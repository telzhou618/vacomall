package com.vacomall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author GaoJun.Zhou
 * @Time：2017年9月5日 上午11:52:49
 * @version 1.0
 */
@Controller
public class IndexController {

	@RequestMapping("/")
	public String index(Model model){
		model.addAttribute("systemName","VACOMALL" );
		return "index";
	}
	
}
