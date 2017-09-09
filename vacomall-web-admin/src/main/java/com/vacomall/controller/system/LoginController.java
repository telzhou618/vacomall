package com.vacomall.controller.system;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/login")
public class LoginController {
	
	
	@RequestMapping
	public String login(Model model){
		return "login";
	}
}
