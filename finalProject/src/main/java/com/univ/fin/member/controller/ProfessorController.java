 package com.univ.fin.member.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.univ.fin.common.model.vo.Attachment;
import com.univ.fin.common.model.vo.Classes;
import com.univ.fin.common.model.vo.Counseling;
import com.univ.fin.common.template.SaveFile;
import com.univ.fin.main.model.vo.Notice;
import com.univ.fin.common.model.vo.Grade;
import com.univ.fin.common.model.vo.ProfessorRest;
import com.univ.fin.member.model.service.MemberService;
import com.univ.fin.member.model.vo.Professor;

@Controller
public class ProfessorController {
	
	@Autowired
	private MemberService memberService;
	
	// 메인페이지
	@RequestMapping("main.pr")
	public ModelAndView mainPage(ModelAndView mv, HttpSession session) {
		Professor pr = (Professor)session.getAttribute("loginUser");
		String professorNo = pr.getProfessorNo();
		
		ArrayList<Counseling> counList = memberService.selectCounceling(professorNo); // 상담신청 조회
		ArrayList<HashMap<String, String>> calList = memberService.yearCalendarList(); // 학사일정 조회
		ArrayList<Notice> nList = memberService.selectMainNotice(); // 공지사항 목록
		HashMap<String, String> map = new HashMap<>();
		map.put("person", "professor");
		map.put("personNo", professorNo);
		String filePath = memberService.selectProfile(map);
		
		mv.addObject("filePath", filePath).addObject("counList", counList).addObject("calList", calList)
		  .addObject("nList", nList).setViewName("member/professor/mainPage");
		return mv;
	}
	
	// 메인 -> 강의 조회
	@ResponseBody
	@RequestMapping(value = "getClasses.pr", produces = "application/json; charset=UTF-8")
	public String getClasses(String day, HttpSession session) {
		Professor pr = (Professor)session.getAttribute("loginUser");
		String professorNo = pr.getProfessorNo();
		
		Calendar calendar = Calendar.getInstance();
		String year = String.valueOf(calendar.get(calendar.YEAR)); // 년도
		int month = calendar.get(calendar.MONTH)+1; // 월
		String term = "";
		if(3<=month && month<=6) { // 1학기
			term = "1";
		}
		else if(9<=month && month<=12) { // 2학기
			term = "2";
		}
		else {
			term = "0";
		}
		
		HashMap<String, String> map = new HashMap<>();
		map.put("year", year);
		map.put("term", term);
		map.put("professorNo", professorNo);
		ArrayList<Classes> cList = memberService.selectProfessorTimetable(map); // 해당 학기 모든 개인시간표 추출
		Collections.sort(cList, new Comparator<Classes>() { // 요일별로 정렬
			public int compare(Classes c1, Classes c2) {
				int dayCompare = Integer.parseInt(c1.getDay()) - Integer.parseInt(c2.getDay());
				
				if(dayCompare == 0) { // 요일같으면 교시별로 정렬
					return Integer.parseInt(c1.getPeriod()) - Integer.parseInt(c2.getPeriod());
				}
				else {
					return dayCompare;
				}
			}
		});
		
		return new Gson().toJson(cList);
	}
	
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
			String subPath = "classes/"; //강의관련 세부경로
			String changeName = new SaveFile().saveFile(upfile, session, subPath); //파일 이름 바꾸고, 저장하고 옴
			String filePath = "resources/uploadFiles/"; 
			a = new Attachment();
			
			//첨부파일에 담기
			a.setOriginName(upfile.getOriginalFilename()); //파일 원래 이름
			a.setChangeName(changeName); //파일 변경명
			a.setFilePath(filePath+subPath); //파일 저장 경로
			
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
			String subPath = "classes/"; //강의관련 세부경로
			String changeName = new SaveFile().saveFile(reUpfile, session, subPath); //파일 이름 바꾸고, 저장하고 옴
			String filePath = "resources/uploadFiles/"+subPath; //저장경로
			
			a = new Attachment();
			
			//첨부파일에 담기
			a.setOriginName(reUpfile.getOriginalFilename()); //파일 원래 이름
			a.setChangeName(changeName); //파일 변경명
			a.setFilePath(filePath+subPath); //파일 저장 경로
			
			
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
		if(memberService.checkPeriod("성적") > 0) { // 성적입력 가능한 기간인지 확인
			session.setAttribute("check", "possible");
		}
		else {
			session.setAttribute("check", "impossible");
			
		}
		
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
	public String gradeInsert(Grade g, HttpSession session) {
		Professor p = (Professor)session.getAttribute("loginUser");
		
		HashMap<String, String> map = new HashMap<>();
		map.put("classNo", g.getClassNo());
		map.put("gradeLevel", g.getGradeLevel().substring(0, 1));
		
		HashMap<String, String> alarm = new HashMap<>();
		alarm.put("cmd", "gradeInsert");
		alarm.put("studentNo", g.getStudentNo());
		alarm.put("professorName", p.getProfessorName());
		
		// A: 30%, A+B: 70% 이내
		if(map.get("gradeLevel").equals("A") || map.get("gradeLevel").equals("B")) {
			int check = memberService.checkGradeNos(map); // 수강인원*비율에 따른 가능 인원 수
			int count = memberService.countGradeNos(map); // 실제 몇명이 해당되는지
			if(count < check) {
				int result = memberService.gradeInsert(g, alarm);
				return (result>0)? "Y": "N";
			}
			else {
				return "B";
			}
		}
		else {
			int result = memberService.gradeInsert(g, alarm);
			return (result>0)? "Y": "N";
		}
	}
	
	// 성적관리 -> 성적 수정
	@ResponseBody
	@PostMapping("gradeUpdate.pr")
	public String gradeUpdate(Grade g, HttpSession session) {
		Professor p = (Professor)session.getAttribute("loginUser");
		
		HashMap<String, String> map = new HashMap<>();
		map.put("classNo", g.getClassNo());
		map.put("gradeLevel", g.getGradeLevel().substring(0, 1));
		
		HashMap<String, String> alarm = new HashMap<>();
		alarm.put("cmd", "gradeUpdate");
		alarm.put("studentNo", g.getStudentNo());
		alarm.put("professorName", p.getProfessorName());
		
		// A: 30%, A+B: 70% 이내
		if(map.get("gradeLevel").equals("A") || map.get("gradeLevel").equals("B")) {
			int check = memberService.checkGradeNos(map); // 수강인원*비율에 따른 가능 인원 수
			int count = memberService.countGradeNos(map); // 실제 몇명이 해당되는지
			if(count < check) { // 성적 입력 가능
				int result = memberService.gradeUpdate(g, alarm);
				return (result>0)? "Y": "N";
			}
			else { // 불가능
				return "B";
			}
		}
		else {
			int result = memberService.gradeUpdate(g, alarm);
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
	
	//안식,퇴직 신청 조회 페이지 이동
	@RequestMapping("professorRestList.pr")
	public String selectProRestList(HttpSession session,Model model) {
		
		String professorNo = ((Professor)session.getAttribute("loginUser")).getProfessorNo();
		
		ArrayList<ProfessorRest> list = memberService.selectRestListPro(professorNo);
		
		model.addAttribute("list",list);
		
		return "member/professor/pro_rest_list";
	}
	
	//안식 신청 페이지로 이동
	@RequestMapping("professorRestEnroll.pr")
	public String enrollRestForm() {
		
		return "member/professor/pro_rest_enroll";
	}
	
	//퇴직 신청 페이지로 이동
	@RequestMapping("professorRetireEnroll.pr")
	public String enrollRetireForm() {
		
		return "member/professor/pro_retire_enroll";
	}
	
	//안식,퇴직 신청 인서트
	@RequestMapping("professorRestRetire.pr")
	public String insertProRest(ProfessorRest pr) {
		
		if(pr.getEndDate()!=null) {//퇴직은 종료일을 안받기 때문에 안식이라는 뜻
			pr.setCategory(1);//카테고리 안식(1) 담음
		}else {//퇴직일떄
			pr.setCategory(0);//카테고리에 퇴직(0) 담음
		}
		
		int result = memberService.insertProRest(pr);
		
		return "redirect:professorRestList.pr";
	}
	
	// (교수) 상담조회
	@ResponseBody
	@PostMapping(value = "selectCounsel.pr", produces = "application/json; charset=UTF-8;")
	public String selectCounselList(String counselType, String professorNo, String startDate, String endDate, ModelAndView mv) {
	
		HashMap<String, String> counselMap = new HashMap<String, String>();
		counselMap.put("counselType", counselType);
		counselMap.put("startDate", startDate);
		counselMap.put("endDate", endDate);
		counselMap.put("professorNo", professorNo);
		
		ArrayList<Counseling> list = memberService.professorSelectCounseling(counselMap);

		return new Gson().toJson(list);			
	}
	
	// (교수) 상담 상세 조회
	@RequestMapping("counselDetail.pr")
	public ModelAndView selectCounselDetail(@RequestParam("cno") String counselNo, ModelAndView mv) {
		
		Counseling counsel = memberService.selectCounselDetail(counselNo);
	
		mv.addObject("c", counsel).setViewName("member/professor/counselHistoryDetail");
		return mv;
	}
	
	@RequestMapping("updateCounselStatus")
	public ModelAndView updateCounselStatus(@RequestParam("counsel-status") String counselStatus
											,String cancelResult, String counselNo, ModelAndView mv, HttpSession session) {
		Professor p = (Professor)session.getAttribute("loginUser");
		
		if(cancelResult.isEmpty()) {
			cancelResult = "null";
		}
		
		System.out.println(counselStatus);
		System.out.println(cancelResult);
		System.out.println(counselNo);
		
		HashMap<String, String> statusMap = new HashMap<String, String>();
		statusMap.put("counselStatus", counselStatus);
		statusMap.put("cancelResult", cancelResult);
		statusMap.put("counselNo", counselNo);
		
		HashMap<String, String> alarm = new HashMap<>();
		if(statusMap.get("counselStatus").equals("C")) {
			alarm.put("cmd", "counselUpdate");
		} else {
			alarm.put("cmd", "nothing");
		}
		Counseling c = memberService.selectCounselDetail(counselNo);
		alarm.put("studentNo", c.getStudentNo());
		alarm.put("professorName", p.getProfessorName());
		
		int result = memberService.updateCounselStatus(statusMap, alarm);
		
		String msg = "";
		
		if(result < 0) {
			msg = "업데이트 실패";
			mv.addObject("msg", msg).setViewName("member/professor/counselHistory");
		}else {
			Counseling counsel = memberService.selectCounselDetail(counselNo);
			msg = "상담 정보가 변경 되었습니다.";
			mv.addObject("c", counsel);
			mv.addObject("msg", msg);
			mv.setViewName("member/professor/counselHistoryDetail");
		}
		
		return mv;
	}

}
