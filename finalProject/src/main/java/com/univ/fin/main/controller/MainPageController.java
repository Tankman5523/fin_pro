package com.univ.fin.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainPageController {

	@GetMapping("infoSystem.mp")
	public String infoSystemMain() {
		
		return "main/infoSystemMain";
	}
	
	
}
