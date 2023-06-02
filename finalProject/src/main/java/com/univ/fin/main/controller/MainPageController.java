package com.univ.fin.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainPageController {

	@GetMapping("mainPage.mp")
	public String mainPage() {
		return "main/mainPage";
	}
	
	@GetMapping("infoSystem.mp")
	public String infoSystemMain() {
		
		return "main/infoSystemMain";
	}
	
	@GetMapping("universityIntro.mp")
	public String universityIntro() {
		return "main/universityIntoroduction";
	}
	
	
}
