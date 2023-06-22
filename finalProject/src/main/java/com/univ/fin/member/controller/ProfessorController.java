 package com.univ.fin.member.controller;



import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.univ.fin.common.model.vo.Attachment;
import com.univ.fin.common.model.vo.Classes;
import com.univ.fin.common.template.SaveFile;
import org.springframework.web.bind.annotation.ResponseBody;
import com.google.gson.Gson;
import com.univ.fin.common.model.vo.Grade;
import com.univ.fin.member.model.service.MemberService;
import com.univ.fin.member.model.vo.Professor;

@Controller
public class ProfessorController {
	
	
	@Autowired
	private MemberService memberService;
	
	//교수 학적정보 조회
	@RequestMapping("infoProfessor.pr")
	public String infoProfessor() {

			
		return "member/professor/infoProfessor";
	}
	
	//강의 개설 내역 페이지로 이동
	@RequestMapping(value="classCreateSelect.pr")
	public String selectClassCreateList(HttpSession session,Model model) {
		
		String professorNo = ((Professor)session.getAttribute("loginUser")).getProfessorNo();
		
		ArrayList<Classes> list = memberService.selectClassCreateList(professorNo);
		
		model.addAttribute("list",list);
		
		return "member/professor/pro_class_list";
	}
	
	//강의 개설 신청 페이지로 이동
	@RequestMapping("classCreateEnroll.pr")
	public String selectClassCreateEnroll() {
		
		return "member/professor/pro_class_enroll";
	}
	
	//강의 개설 신청 인서트
	@RequestMapping(value="classCreateInsert.pr")
	public ModelAndView insertClassCreate(Classes c
									,@RequestParam(value="upfile",required = false)MultipartFile upfile
									,HttpSession session
									,ModelAndView mv) {
		
		Attachment a = null;
		
		Professor p = (Professor)session.getAttribute("loginUser");
		
		c.setProfessorNo(p.getProfessorNo()); //교수 직번 담기
		c.setDepartmentNo(p.getDepartmentNo()); //학과명 담기
		
		if(!upfile.getOriginalFilename().equals("")) {//첨부파일이 있다면
			String subPath = "classes/";//강의관련 폴더
			String changeName = new SaveFile().saveFile(reUpfile, session, subPath); //파일 이름 바꾸고, 저장하고 옴
			String filePath = "resources/uploadFiles/"; 
			a = new Attachment();
			
			//첨부파일에 담기
			a.setOriginName(upfile.getOriginalFilename()); //파일 원래 이름
			a.setChangeName(changeName); //파일 변경명
			a.setFilePath(filePath); //파일 저장 경로
			
			int result = memberService.insertClassCreate(c,a);
			
			if(result>0) {//작성 성공
				mv.addObject("alertMsg","개설 신청 성공");
				mv.setViewName("redirect:classCreateSelect.pr");
			}else {//작성 실패
				new File(filePath+changeName).delete(); //작성실패하면 첨부파일 삭제
				mv.addObject("errorMsg","개설 신청 실패");
				mv.setViewName("common/errorPage");
			}
		}else {//어떤 오류로 강의계획서를 안올렸는데 메소드를 들어왔다면
			mv.addObject("errorMsg","강의 계획서 미첨부");
			mv.setViewName("common/errorPage");
		}
		
		return  mv;
	}
	
	//강의 개설 반려일때 수정 페이지 이동
	@RequestMapping("updateClassCreate.pr")
	public String selectRejectedClass(int classNo,Model model) {
		
		//수정할 강의 정보 가져오기
		Classes c = memberService.selectRejectedClass(classNo);
		Attachment a= null;
		if(c.getFileNo()!=null) {//강의계획서가 없는게 아니면
			//수정할 강의 첨부파일 가져오기
			a = memberService.selectRejectedClassAtt(c.getFileNo());
			
		}
		//모델에 담아 보내기
		model.addAttribute("c",c);
		model.addAttribute("a",a);
		
		return "member/professor/pro_class_update";
	}
	
	//강의 개설 수정 업데이트
	@RequestMapping(value="classCreateUpdate.pr")
	public String classCreateUpdate(Classes c,String originFileName
			,@RequestParam(value="reUpfile",required = false)MultipartFile reUpfile,HttpSession session) {
		
		Attachment a = null;
	
		if(!reUpfile.getOriginalFilename().equals("")) {//새로운 첨부파일이 있다면
			String subPath = "classes/";//강의관련 폴더
			String changeName = new SaveFile().saveFile(reUpfile, session, subPath); //파일 이름 바꾸고, 저장하고 옴
			String filePath = "resources/uploadFiles/"; //저장경로
			
			a = new Attachment();
			
			//첨부파일에 담기
			a.setOriginName(reUpfile.getOriginalFilename()); //파일 원래 이름
			a.setChangeName(changeName); //파일 변경명
			a.setFilePath(filePath); //파일 저장 경로
			
			
			if(c.getFileNo()!=null) {//기존 첨부파일이 있다면
				
				a.setFileNo(Integer.parseInt(c.getFileNo()));//첨부파일에 기존 파일번호 담고
				
				new File(filePath+originFileName).delete(); //기존 첨부파일 삭제
			}else {//기존 첨부파일이 없다면
				
				//사실 강의계획서는 필수라 이런 경우는 없지만 혹시 모르니까
			}
		}
		
		int result = memberService.updateClassCreate(c,a);		
		
		return "redirect:classCreateSelect.pr";
	}
	

	//학적 정보수정 - 교수
	@RequestMapping(value="updateProfessor.pr", method = RequestMethod.POST)
	public String updateProfessor(Professor pr,
									Model model,
									HttpSession session) {
		int result = memberService.updateProfessor(pr);
		
		
		if(result>0) {
			//유저 정보갱신
			Professor updateProfessor = memberService.loginProfessor(pr);
			session.setAttribute("loginUser", updateProfessor);
			model.addAttribute("msg", "수정 완료");
		}else { //정보변경실패
			model.addAttribute("msg","수정 실패");
		}
		
	return "member/professor/infoProfessor";
		
	}
	
	// 학사관리 - 개인시간표
	@RequestMapping("personalTimetable.pr")
	public ModelAndView personalTimetable(ModelAndView mv, HttpSession session) {
		Professor st = (Professor)session.getAttribute("loginUser");
		String professorNo = st.getProfessorNo();
		ArrayList<String> classTerm = memberService.selectProfessorClassTerm(professorNo); // 강의한 학년도, 학기
		
		mv.addObject("classTerm", classTerm).setViewName("member/professor/personalTimetableView");
		return mv;
	}
	
	// 개인시간표 -> 학기 선택 후 시간표 조회
	@ResponseBody
	@RequestMapping(value = "selectProfessorTimetable.pr", produces = "application/json; charset=UTF-8;")
	public String selectStudentTimetable(@RequestParam HashMap<String,String> map, HttpSession session) {
		Professor st = (Professor)session.getAttribute("loginUser");
		String professorNo = st.getProfessorNo();
		map.put("professorNo", professorNo);
		
		ArrayList<Classes> cList = memberService.selectProfessorTimetable(map);
		return new Gson().toJson(cList);
	}
	
	// 수업관리 - 성적관리
	@GetMapping("gradeInsert.pr")
	public ModelAndView gradeInsertView(ModelAndView mv, HttpSession session) {
		Professor st = (Professor)session.getAttribute("loginUser");
		String professorNo = st.getProfessorNo();
		ArrayList<String> classTerm = memberService.selectProfessorClassTerm(professorNo); // 강의한 학년도, 학기
		
		mv.addObject("classTerm", classTerm).setViewName("member/professor/gradeInsertView");
		return mv;
	}
	
	// 성적관리 -> 수강중인 학생 조회
	@ResponseBody
	@RequestMapping(value = "selectStudentGradeList.pr", produces = "application/json; charset=UTF-8;")
	public String selectStudentGradeList(String cn) {
		int classNo = Integer.parseInt(cn);
		ArrayList<HashMap<String, String>> sList = new ArrayList<>();
		sList.add(memberService.countStudentGrade(classNo)); // 학점별로 몇명이 해당되는지
		sList.addAll(memberService.selectStudentGradeList(classNo));
		
		return new Gson().toJson(sList);
	}
	
	// 성적관리 -> 성적 입력
	@ResponseBody
	@PostMapping("gradeInsert.pr")
	public String gradeInsert(Grade g) {
		HashMap<String, String> map = new HashMap<>();
		map.put("classNo", g.getClassNo());
		map.put("gradeLevel", g.getGradeLevel().substring(0, 1));
		
		// A: 30%, A+B: 70% 이내
		if(map.get("gradeLevel").equals("A") || map.get("gradeLevel").equals("B")) {
			int check = memberService.checkGradeNos(map); // 수강인원*비율에 따른 가능 인원 수
			int count = memberService.countGradeNos(map); // 실제 몇명이 해당되는지
			if(count < check) {
				int result = memberService.gradeInsert(g);
				return (result>0)? "Y": "N";
			}
			else {
				return "B";
			}
		}
		else {
			int result = memberService.gradeInsert(g);
			return (result>0)? "Y": "N";
		}
	}
	
	// 성적관리 -> 성적 수정
	@ResponseBody
	@PostMapping("gradeUpdate.pr")
	public String gradeUpdate(Grade g) {
		HashMap<String, String> map = new HashMap<>();
		map.put("classNo", g.getClassNo());
		map.put("gradeLevel", g.getGradeLevel().substring(0, 1));
		
		// A: 30%, A+B: 70% 이내
		if(map.get("gradeLevel").equals("A") || map.get("gradeLevel").equals("B")) {
			int check = memberService.checkGradeNos(map); // 수강인원*비율에 따른 가능 인원 수
			int count = memberService.countGradeNos(map); // 실제 몇명이 해당되는지
			if(count < check) { // 성적 입력 가능
				int result = memberService.gradeUpdate(g);
				return (result>0)? "Y": "N";
			}
			else { // 불가능
				return "B";
			}
		}
		else {
			int result = memberService.gradeUpdate(g);
			return (result>0)? "Y": "N";
		}
	}
	
	//상담관리 페이지 이동
	@RequestMapping("counselHistory.pr")
	public String counselHistory() {
		
		return "member/professor/counselHistory";
	}
	
	// 학사관리 - 강의시간표
	@RequestMapping("classListView.pr")
	public ModelAndView classListView(ModelAndView mv) {
		ArrayList<String> classTerm = memberService.selectClassTerm();
		
		mv.addObject("classTerm", classTerm).setViewName("member/professor/classListView");
		return mv;
	}
	
	//상담관리 조건 검색
	@PostMapping("selectCounsel.pr")
	public String selectCounselList(Model model) {
		
		
		
		return null;
	}

}
