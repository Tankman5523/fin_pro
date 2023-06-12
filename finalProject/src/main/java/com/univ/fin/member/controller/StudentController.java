package com.univ.fin.member.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.univ.fin.common.model.vo.Bucket;
import com.univ.fin.common.model.vo.Counseling;
import com.univ.fin.common.model.vo.RegisterClass;
import com.univ.fin.common.template.DepartmentCategory;
import com.univ.fin.member.model.service.MemberService;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;

@Controller
public class StudentController {

	@Autowired
	private MemberService memberService;
	
	//수강신청 폼
	@RequestMapping("registerClassForm.st")
	public String registerClassForm() {
		return "member/student/registerClass";
	}
	
	//예비수강신청 폼
	@GetMapping("preRegisterClass.st")
	public String preRegisterClassForm() {
		return "member/student/preRegisterClass";
	}
	
	//예비수강신청 - 수강담기
	@ResponseBody
	@PostMapping("preRegisterClass.st")
	public String preRegisterClass(Bucket b) {
		
		int result = 0;
		
		int chkClass = memberService.checkPre(b); //예비수강 중복체크
		
		if(chkClass == 0) {
			result = memberService.preRegisterClass(b);
		}
		
		return new Gson().toJson(result);
	}
	
	//예비수강신청 - 수강조회
	@ResponseBody
	@RequestMapping(value="majorClass.st",produces = "application/json; charset=UTF-8")
	public String majorClassList(@RequestParam(value="departmentName",defaultValue = "교양")String departmentName,RegisterClass rc) {
		
		String term = String.valueOf(rc.getClassTerm().charAt(0)); //학기 추출
		
		RegisterClass rc2 = RegisterClass.builder()
										 .classYear(rc.getClassYear()) //학년도
										 .classTerm(term) //학기
										 .departmentName(departmentName) //전공
										 .professorName(rc.getProfessorName()) //교수명
										 .className(rc.getClassName()) //과목명
										 .studentNo(rc.getStudentNo()) //학번 
										 .studentLevel(rc.getStudentLevel()) //학생 학년
										 .build();
		
		ArrayList<RegisterClass> list = memberService.preClass(rc2);
//		ArrayList<RegisterClass> list = memberService.majorClass(rc2);
		
		return new Gson().toJson(list);
	}
	
	//예비수강신청 - 장바구니 조회
	@ResponseBody
	@RequestMapping(value="preRegList.st", produces = "application/json; charset=UTF-8")
	public String preRegList(String studentNo) {
		
		ArrayList<RegisterClass> list = memberService.preRegList(studentNo);
		
		return new Gson().toJson(list);
	}
	
	//예비수강신청 - 장바구니 수강취소
	@ResponseBody
	@RequestMapping(value="delPreRegList.st", produces = "application/json; charset=UTF-8")
	public String delPreRegList(RegisterClass rc) {
		
		int result = memberService.delPreRegList(rc); 
		
		return new Gson().toJson(result);
	}
	
	//수강신청 - 수강신청(전공 카테고리조회)
	@ResponseBody
	@RequestMapping(value="selectCollegeNo.st",produces = "application/json; charset=UTF-8")
	public String selectCollegeNo(int cno) {
		
		DepartmentCategory d = new DepartmentCategory();
		
		ArrayList<String> list = d.departmentCategory(cno);
		
		return new Gson().toJson(list);
	}
	
	// 수강신청 - 학기별 성적 조회
	@RequestMapping("classManagement.st")
	public String student_classManagement() {
		return "member/student/gradeListView";
	}
	
	// 수강신청 - 강의시간표
	@RequestMapping("classListView.st")
	public ModelAndView classListView(ModelAndView mv) {
		ArrayList<String> classTerm = memberService.selectClassTerm();
		System.out.println(classTerm);
		
		mv.addObject("classTerm", classTerm).setViewName("member/student/classListView");
		return mv;
	}

	
	//상담관리 - 상담조회페이지 이동
	@RequestMapping("counselingList.st")
	public String counselingList(HttpSession session,Model m) {
		
		String studentNo =((Student)session.getAttribute("loginUser")).getStudentNo();
		
		ArrayList<Counseling> list = memberService.selectCounStuList(studentNo);
		
		m.addAttribute("list",list);
		
		return "member/student/st_counseling_list";
	}
	
	//상담관리 - 상담신청 페이지 이동
	@RequestMapping("counselingEnroll.st")
	public String counselingEnroll(String departmentNo) {
		return "member/student/st_counseling_enrollForm";
	}
	
	//상담관리 - 상담신청 페이지 학생 학과 교수 리스트 조회
	@ResponseBody
	@RequestMapping(value="departmentProList.st",produces = "application/json; charset = UTF-8")
	public String selectDepartProList(String departmentNo) {
		
		//학과별 교수 조회해서 가져가기
		ArrayList<Professor> list = memberService.selectDepartProList(departmentNo);
		
		return new Gson().toJson(list);
	} 
	
	//상담신청 - 상담신청 작성
	@RequestMapping(value="insertCounseling.st",method =RequestMethod.POST)
	public ModelAndView insertCounseling(Counseling c,ModelAndView mv) {
		
		int result = memberService.insertCounseling(c);
		
		if(result>0) {
			mv.addObject("alertMsg", "상담신청 성공");
			mv.setViewName("redirect:counselingList.st");
		}else {
			mv.addObject("errorMsg", "상담신청 실패");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
	
	//상담관리 - 상담 상세보기
	@RequestMapping("stuCounDetail.st")
	public String StudentcounDetail(int counselNo,Model m) {
		
		Counseling c = memberService.selectCounseling(counselNo);
		
		Professor p = memberService.selectProfessorForNo(c.getProfessorNo());
		
		m.addAttribute("c",c);
		m.addAttribute("p",p);
		
		return "member/student/st_counseling_detail";
	}
	
	
	@RequestMapping(value="counselingUpdate.st",method =RequestMethod.POST)
	public ModelAndView StuCounUpdate(Counseling c,ModelAndView mv) {
		
		
		
		int result = memberService.updateCounContent(c);
		
		if(result>0) {
			mv.addObject("counselNo",c.getCounselNo());
			mv.setViewName("redirect:stuCounDetail.st");
		}else {
			mv.addObject("errorMsg", "상담신청 실패");
			mv.setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	
		//학적 정보조회 - 학생
			@RequestMapping("infoStudent.st")
			public String infoStudent() {		
				
				return "member/student/infoStudent";
			}
			
			
			//학적 정보수정 - 학생
			
			@RequestMapping(value="updateStudent.st" , method = RequestMethod.POST)
			public String updateStudent(Student st,
											Model model,
											HttpSession session) {
				int result = memberService.updateStudent(st);
				
				System.out.println("확인 : "+result);
				
				if(result>0) {
					//유저 정보갱신
					Student loginUser = memberService.loginStudent(st);
					session.setAttribute("loginUser", loginUser);
					model.addAttribute("msg", "수정 완료");
				}else { //정보변경실패
					model.addAttribute("msg", "수정 실패");
				}
				
			return "member/student/infoStudent";
				
			}
	
	// 학사관리 - 개인시간표
	@RequestMapping("personalTimetable.st")
	public ModelAndView personalTimetable(ModelAndView mv, HttpSession session) {
		Student st = (Student)session.getAttribute("loginUser");
		String studentNo = st.getStudentNo();
		ArrayList<String> classTerm = memberService.selectClassTerm(studentNo);
		
		mv.addObject("classTerm", classTerm).setViewName("member/student/personalTimetableView");
		return mv;
	}
}
