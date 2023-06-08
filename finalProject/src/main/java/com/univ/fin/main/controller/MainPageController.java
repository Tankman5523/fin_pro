package com.univ.fin.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainPageController {

	@GetMapping("mainPage.mp")
	public String mainPage() {
		return "main/mainPage";
	}
	
	@GetMapping("universityIntro.mp")
	public String universityIntro() {
		return "main/universityIntoroduction";
	}
	
	@GetMapping("haksaInfo.mp")
	public String haksaInfo() {
		return "main/haksaInfo";
	}
	
	@GetMapping("haksaSchedule.mp")
	public String haksaSchedule() {
		return "main/haksaSchedule";
	}
	
	@GetMapping("noticeBoard.mp")
	public String noticeBoard() {
		return "main/noticeBoard";
	}
	
	@GetMapping("infoSystem.mp")
	public String infoSystemMain() {
		return "main/infoSystemMain";
	}
}
