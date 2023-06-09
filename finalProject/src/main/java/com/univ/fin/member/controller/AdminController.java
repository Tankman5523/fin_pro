package com.univ.fin.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.univ.fin.common.model.vo.Attachment;
import com.univ.fin.common.model.vo.CalendarVo;
import com.univ.fin.common.model.vo.ClassRating;
import com.univ.fin.common.model.vo.Classes;
import com.univ.fin.common.model.vo.Counseling;
import com.univ.fin.common.model.vo.ProfessorRest;
import com.univ.fin.common.model.vo.StudentRest;
import com.univ.fin.common.template.SaveFile;
import com.univ.fin.main.model.vo.Notice;
import com.univ.fin.main.model.vo.NoticeAttachment;
import com.univ.fin.member.model.service.MemberService;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;
import com.univ.fin.money.model.vo.RegistPay;

import lombok.extern.slf4j.Slf4j;

@Controller
public class AdminController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	//학생등록 페이지
	@RequestMapping("enrollStudent.ad")
	public String enrollStudent() {		
		
		return "member/admin/enrollStudent";
	}
	
	//학생등록 페이지 등록
	@RequestMapping(value="insertStudent.ad" ,method=RequestMethod.POST)
	public String insertStudent(Student st,
								@RequestParam(value="upfile",required = false)MultipartFile upfile,
								Model model,
								HttpSession session) {
		
		st.setStudentPwd("$2a$10$chsqqg6wWHMHhAlO2twsSOUhvFzX1zGWtPuMY/s4EbCEEOInlEUvS");
		
		if(!upfile.getOriginalFilename().equals("")) {//첨부파일이 있다면
			String subPath = "student/"; //학생관련 세부경로
			String changeName = new SaveFile().saveFile(upfile, session, subPath); //파일 이름 바꾸고, 저장하고 옴
			String filePath = "resources/uploadFiles/"; 
			
			//첨부파일에 담기
			Attachment a = Attachment.builder()
									.originName(upfile.getOriginalFilename()) //파일 원래 이름
									.changeName(changeName) //파일 변경명
									.filePath(filePath+subPath) //파일 저장 경로
									.build();
		
		
			int result = memberService.insertStudent(st,a);
			
			if(result>0) {
				model.addAttribute("msg", "회원 생성 완료");
			}else {
				model.addAttribute("msg","회원 생성 실패");
				
			}
		
		}
		return "member/admin/enrollStudent";
	}
	
	//강의개설 승인 페이지 이동
	@RequestMapping("classManagePage.ad")
	public String classManageSelect(Model model) {
		
		ArrayList<Classes> list = memberService.selectClassList();
		
		//ArrayList<Attachment> alist = memberService.selectClassAttachment();
		
		ArrayList<String> ylist= new ArrayList<>(); //학년도 담아갈 리스트
		String year; //학년도 담을 변수
		
		for(Classes b : list) {
			year = b.getClassYear();
			if(!ylist.contains(year)) { //학년도가 중복되지 않는다면
				ylist.add(year); //학년도 리스트에 넣기
			}
		}
		
		model.addAttribute("list",list);
		model.addAttribute("ylist",ylist);
		//model.addAttribute("alist",alist);
		
		return "member/admin/ad_class_list";
	}
	
	//교수 관리자 등록 페이지 이동
	@RequestMapping("enrollProfessor.ad")
	public String enrollProfessor() {
		
		return "member/admin/enrollProfessor";
	}
	
	@RequestMapping(value="insertProfessor.ad", method=RequestMethod.POST)
	public String insertProfessor(Professor pr,
								  @RequestParam(value="upfile",required = false)MultipartFile upfile,
	                              Model model,
	                              HttpSession session) {
		
		pr.setProfessorPwd("$2a$10$chsqqg6wWHMHhAlO2twsSOUhvFzX1zGWtPuMY/s4EbCEEOInlEUvS");
		
		if(!upfile.getOriginalFilename().equals("")) {//첨부파일이 있다면
			String subPath = "student/"; //학생관련 세부경로
			String changeName = new SaveFile().saveFile(upfile, session, subPath); //파일 이름 바꾸고, 저장하고 옴
			String filePath = "resources/uploadFiles/"; 
			
			//첨부파일에 담기
			Attachment a = Attachment.builder()
									.originName(upfile.getOriginalFilename()) //파일 원래 이름
									.changeName(changeName) //파일 변경명
									.filePath(filePath+subPath) //파일 저장 경로
									.build();
		
		    if (pr.getDepartmentNo().equals("-선택-")) {
		        if (pr.getPosition().equals("관리자")) {
		            pr.setDepartmentNo("");
		            pr.setCollegeNo("");
		        } else {
		            if (pr.getCollegeNo().equals("-선택-") || pr.getCollegeNo() == null) {
		                // 관리자가 아니면서 부서 선택을 하지 않은 경우
		            	model.addAttribute("msg","빈 입력란이 있습니다.");
		            }
		        }
		    }	        

		    int result = memberService.insertProfessor(pr,a);
	
		    if (result > 0) {
		        model.addAttribute("msg", "직원 생성 완료");
		    } else {
		        model.addAttribute("msg", "직원 생성 실패");
		    }
	    
		}
	    return "redirect:enrollProfessor.ad";
	}

	
	//강의 개설 일괄 승인
	@RequestMapping("permitAllClassCreate.ad")
	public String updateClassPermitAll(int cArr[],Model model) {
			
		int result = memberService.updateClassPermitAll(cArr);
			
		if(result>0) {//업데이트(개설승인) 성공
			model.addAttribute("alertMsg","일괄 개설을 성공 했습니다.");
		}else {//업데이트(개설승인) 실패
			model.addAttribute("alertMsg","일괄 개설 오류");
		}
			
		return "redirect:classManagePage.ad";
	}
		
	//강의 개설 개별 승인
	@RequestMapping("permitClassCreate.ad")
	public String updateClassPermit(int cno,Model model) {
		
		int result = memberService.updateClassPermit(cno);
		
		if(result>0) {
			model.addAttribute("alertMsg","개설 성공 했습니다.");
		}else {
			model.addAttribute("alertMsg","개설 오류");	
		}
		
		return "redirect:classManagePage.ad";
	}
		
	//강의 개설 반려
	@RequestMapping("rejectClassCreate.ad")
	public String updateClassReject(Classes c,Model model) {
			
		int result = memberService.updateClassReject(c);
		
		if(result>0) {
			model.addAttribute("alertMsg","반려 했습니다.");
		}else {
			model.addAttribute("alertMsg","반려 오류");	
		}
			
		return "redirect:classManagePage.ad";
	}
	
	//강의 일괄 학기종료
	@RequestMapping("classTermFinish.ad")
	public String updateClassTermFinish(int cArr[],Model model) {
		int result = memberService.updateClassTermFinish(cArr);
		
		if(result>0) {//업데이트(학기종료) 성공
			model.addAttribute("alertMsg","일괄 개설을 성공 했습니다.");
		}else {//업데이트(학기종료) 실패
			model.addAttribute("alertMsg","일괄 개설 오류");
		}
			
		return "redirect:classManagePage.ad";
	}
	
	//강의 관리 검색
	@ResponseBody
	@RequestMapping(value="classSearchList.ad",produces="application/json; charset = UTF-8")
	public String selectSearchClassList(Classes c,String category,String keyword) {
		
		if(!keyword.equals("")) {
			switch(category) {//검색 카테고리에 따라 키워드 담기
			case "professor": c.setProfessorNo(keyword);
			break;
			case "class": c.setClassName(keyword);
			break;
			case "department": c.setDepartmentNo(keyword);
			break;
			}
		}
		
		ArrayList<Classes> list = memberService.selectClassListSearch(c);
		
		return new Gson().toJson(list);
	}

	// 강의관리 - 강의시간표
	@RequestMapping("classListView.ad")
	public ModelAndView classListView(ModelAndView mv) {
		ArrayList<String> classTerm = memberService.selectClassTerm();
		
		mv.addObject("classTerm", classTerm).setViewName("member/admin/classListView");
		return mv;
	}
	
	//강의평가조회 페이지
	@RequestMapping("classRatingPage.ad")
	public String classRatingPage() {
		return "member/admin/ad_classRating_list";
	}
	
	//강의평가 조회(검색)
	@ResponseBody
	@GetMapping(value="classRatingList.ad",produces = "application/json;charset=utf-8")
	public String classRatingList(ClassRating cr) {
		ArrayList<ClassRating> list = memberService.classRatingList(cr);
		return new Gson().toJson(list);
	}
	
	//강의평가 기타건의사항 조회
	@ResponseBody
	@GetMapping(value="classRatingEtc.ad",produces = "application/json;charset=utf-8")
	public String classRatingEtcList(ClassRating cr) {
		ArrayList<ClassRating> list = memberService.classRatingEtcList(cr);
		return new Gson().toJson(list);
	}
	
	//강의평가 문항별 평균 점수
	@ResponseBody
	@GetMapping(value="classRatingAverage.ad",produces = "application/json;charset=utf-8")
	public String classRatingAverage(ClassRating cr) {
		ClassRating result = memberService.classRatingAverage(cr);
		return new Gson().toJson(result);
	}
	
	// 학사관리 - 학사일정 관리
	@GetMapping("calendarView.ad")
	public String calendarView() {
		return "member/admin/calendarView";
	}
	
	// 학사일정 관리 -> 학사일정 조회
	@ResponseBody
	@PostMapping(value="calendarView.ad",produces = "application/json;charset=utf-8")
	public String calendarList() {
		ArrayList<HashMap<String, String>> calList = memberService.calendarList();
		return new Gson().toJson(calList);
	}
	
	// 학사일정 관리 -> 학사일정 추가/수정/삭
	@PostMapping("manageCalendar.ad")
	public String manageCalendar(CalendarVo c, String check, HttpSession session) {
		int result = 0;
		
		if(check.equals("insert")) { // 추가
			result = memberService.insertCalendar(c);
			
			if(result > 0) {
				session.setAttribute("alertMsg", "학사일정이 추가되었습니다.");
			}
			else {
				session.setAttribute("alertMsg", "학사일정 추가에 실패하셨습니다.");
			}
		}
		else if(check.equals("update")) { // 수정
			result = memberService.updateCalendar(c);
			
			if(result > 0) {
				session.setAttribute("alertMsg", "학사일정이 수정되었습니다.");
			}
			else {
				session.setAttribute("alertMsg", "학사일정 수정에 실패하셨습니다.");
			}
		}
		else { // 삭제
			result = memberService.deleteCalendar(c);
			
			if(result > 0) {
				session.setAttribute("alertMsg", "학사일정이 삭제되었습니다.");
			}
			else {
				session.setAttribute("alertMsg", "학사일정 삭제에 실패하셨습니다.");
			}
		}
		
		return "redirect:calendarView.ad";
	}
	
	//학생 휴,복학 신청 관리 페이지 이동
	@RequestMapping("stuRestList.ad")
	public String selectStuRestList(Model model) {
		
		ArrayList<Counseling> list = memberService.selectCounAllStuList();
		
		model.addAttribute("list",list);
		
		return "member/admin/ad_st_rest_list";
	}
	
	//학생 휴,복학 신청 상세보기 페이지 이동
	@RequestMapping("stuRestDetailView.ad")
	public String selectStuRestDetail(int rno,Model model) throws ParseException {
		
		//휴,복학 신청 정보 조회
		StudentRest sr =memberService.selectStuRestDetail(rno);
		
		String studentNo = sr.getStudentNo(); //신청 학생 학번
		
		//학생 정보 조회
		Student s = memberService.selectStudentInfo(studentNo);
		
		//휴학 횟수
		int restCount = memberService.selectRestCount(studentNo);
		
		if(sr.getCategory().contains("휴학")) {//학생이 휴학 상태가 아니면
			Date startDate = sr.getStartDate(); //휴,복학 시작날짜
			
			if(sr.getCategory().equals("휴학연장")) {//휴학연장이면 그전 상담 정보도 가져와야함
				StudentRest sr2 = memberService.selectRestInfo(studentNo);
				startDate = sr2.getStartDate();//휴학 연장 전에 시작 날짜를 알아야함
				
				model.addAttribute("sr2",sr2); //연장 전 휴학 정보
			}
			
			String classYear =startDate.toString().substring(0, startDate.toString().indexOf("-")); //해당 년도만 뽑기
			int classTerm ; //해당 학기
			
			//학기를 나누는 기준 (학사일정 생기면 아마 거기서 가져올 예정)
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); //String Date로 바꿈
			Date termChange = formatter.parse("2023-06-30");
			
			if(startDate.after(termChange)) {//6월30일이 넘으면 2학기 6월30일도 1학기임
				classTerm = 2;
			}else {
				classTerm = 1;
			}
			//학번,해당년도,학기 담기
			RegistPay rp = RegistPay.builder().studentNo(studentNo).classYear(classYear).classTerm(classTerm).build();
			//등록금 정보 조회
			RegistPay checkRp = memberService.checkRegPay(rp);
			
			model.addAttribute("rp",checkRp); //등록금 정보
			
		}
		
		//담아 가기
		model.addAttribute("sr",sr); //휴,복학 신청 정보
		model.addAttribute("s",s); //학생 정보
		model.addAttribute("rcount",restCount); //휴학횟수
		
		return "member/admin/ad_st_rest_detail";
	}
	
	//학생 휴,복학 승인
	@RequestMapping("updateRestPermit.ad")
	public String updateStuRestPermit(StudentRest sr,Model model) {
		
		int result = memberService.updateStuRestPermit(sr);
		
		if(result>0) {
			model.addAttribute("alertMsg","신청 승인 했습니다.");
		}else {
			model.addAttribute("alertMsg","승인 오류 발생");
		}
		
		return "redirect:stuRestList.ad";
	}
	
	//학생 휴,복학 반려
	@RequestMapping("updateRestRetire.ad")
	public String updateStuRestRetire(int restNo,Model model) {
		
		int result = memberService.updateStuRestRetire(restNo);
			
		if(result>0) {
			model.addAttribute("alertMsg","반려 했습니다.");
		}else {
			model.addAttribute("alertMsg","반려 오류 발생");
		}
		return "redirect:stuRestList.ad";
	}
	
	//학생 휴,복학 리스트 검색 조회
	@ResponseBody
	@RequestMapping(value="searchStuRestList.ad",produces="application/json; charset=UTF-8")
	public String selectSearchStuRestList(String status, String category 
										, @RequestParam(value = "start",defaultValue = "1900-01-01")String start
										, @RequestParam(value = "end",defaultValue = "2999-12-31")String end
										, String searchType, String keyword) {
		
		HashMap<String, String> set = new HashMap<String, String>();
		set.put("status", status);
		set.put("category",category);
		set.put("start",start);
		set.put("end",end);
		set.put(searchType,keyword);
		
		ArrayList<StudentRest> list = memberService.selectSearchStuRestList(set);
		
		//Gson Date format 설정
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		
		return gson.toJson(list);
	}
	
	//임직원 안식,퇴직 신청 관리 페이지 이동
	@RequestMapping("proRestList.ad")
	public String selectProRestList(Model model) {
		
		ArrayList<ProfessorRest> list = memberService.selectCounAllProList();
		
		model.addAttribute("list",list);
		
		return "member/admin/ad_pro_rest_list";
	}
	
	//임직원 안식,퇴직 신청 상세보기
	@RequestMapping("proRestDetail.ad")
	public String selectProRestDetail(int restNo,Model model) {
		
		//안식,퇴직 신청 정보 가져오기
		ProfessorRest pr = memberService.selectProRestDetail(restNo);
		
		//임직원 정보 가져오기
		Professor p = memberService.selectProfessorForNo(pr.getProfessorNo());
		
		model.addAttribute("pr",pr);
		model.addAttribute("p",p);
		
		return "member/admin/ad_pro_rest_detail";
	}
	
	//임직원 안식,퇴직 업데이트
	@RequestMapping("updateProRest.ad")
	public String updateProfessorRest(ProfessorRest pr,Model model) {
		int result = memberService.updateProfessorRest(pr);//
		
		if(result>0) {
			model.addAttribute("alertMsg","반려 했습니다.");
		}else {
			model.addAttribute("alertMsg","반려 오류");
		}
		
		return "redirect:proRestList.ad";
	}
	
	//임직원 자동 퇴직 처리
	@Scheduled(cron = "0 0 12 * * *")
	public void autoUpdateProfessorRetire() {
		memberService.updateAutoRetire();
	}
	
	
	//임직원 안식,퇴직 신청 검색 리스트 조회
	@ResponseBody
	@RequestMapping(value="searchProRestList.ad",produces="application/json; charset=UTF-8;")
	public String searchProRestList(String status, String category 
									, @RequestParam(value = "start",defaultValue = "1900-01-01")String start
									, @RequestParam(value = "end",defaultValue = "2999-12-31")String end
									, String searchType, String keyword) {

		HashMap<String, String> set = new HashMap<String, String>();
		set.put("status", status);
		set.put("category",category);
		set.put("start",start);
		set.put("end",end);
		set.put(searchType,keyword);
		
		ArrayList<ProfessorRest> list = memberService.selectSearchProRestList(set);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		
		return gson.toJson(list);
	}
	
	// (관리자) 공지사항 관리 이동
	@RequestMapping("selectNotice.ad")
	public String selectNoticeList() {

		return "member/admin/ad_selectNotice";
	}

	// (관리자) 공지사항 관리 - 전체 공지사항 조회
	@ResponseBody
	@PostMapping(value = "selectNoticeList.ad", produces = "application/json; charset=UTF-8;")
	public String selectNoticeAllList() {

		ArrayList<Notice> list = memberService.selectNoticeAllList();

		return new Gson().toJson(list);
	}
	
	
	//(관리자) 공지사항 관리 - 공지사항 검색
	@ResponseBody
	@PostMapping(value = "searchNotice.ad", produces = "application/json; charset=UTF-8;")
	public String searchNotice(String field, String category, String type, String keyword) {
		
		HashMap<String, String> noticeMap = new HashMap<String, String>();
		noticeMap.put("field", field);
		noticeMap.put("category", category);
		noticeMap.put("type", type);
		noticeMap.put("keyword", keyword);
		
		ArrayList<Notice> list = memberService.searchNotice(noticeMap);
		
		return new Gson().toJson(list);
	}
	
	// (관리자)메인페이지
	@RequestMapping(value="main.ad")
	public ModelAndView mainPage(ModelAndView mv) {
		
		ArrayList<Classes> classList = memberService.selectAdMainClasses();
		ArrayList<StudentRest> srList = memberService.selectMainStudentRest();
		ArrayList<ProfessorRest> prList = memberService.selectMainProfessorRest();
		ArrayList<HashMap<String, String>> calList = memberService.yearCalendarList(); // 학사일정 조회
		ArrayList<Notice> nList = memberService.selectMainNotice(); // 공지사항 목록
		
		mv.addObject("classList", classList).addObject("srList", srList).addObject("prList",prList).addObject("calList", calList)
		  .addObject("nList", nList).setViewName("member/admin/mainPage");
		return mv;
	}

	//(관리자) 공지사항 관리 - 공지사항 선택 삭제
	@ResponseBody
	@PostMapping(value = "deleteNotice.ad", produces = "application/json; charset=UTF-8;")
	public String deleteNotice(String[] noticeNo) {
		
		int result = 0;
		String msg = "";
		
		if(noticeNo == null) {			
			result = memberService.allDeleteNotice();	
		}else {
			result = memberService.selectDeleteNotice(noticeNo);
		}
		
		if(result > 0) {
			msg = "선택한 게시글이 삭제되었습니다.";
		}else {
			msg = "게시글 삭제 실패";
		}
		
		
		return new Gson().toJson(msg);
	}
	
	//(관리자) 공지사항 관리 - 공지사항 수정 페이지 이동
	@RequestMapping(value = "updateNotice.ad")
	public String selectUpdateNotice(String noticeNo, Model model) {
		
		Notice n = memberService.selectUpdateNotice(noticeNo);
		ArrayList<NoticeAttachment> list = memberService.selectUpdateNoticeFile(noticeNo);
		
		model.addAttribute("n", n);
		model.addAttribute("list", list);
		
		return "member/admin/updateNoticeForm";
	}
	
	//(관리자) 공지사항 관리 - 공지사항 등록 페이지 이동
	@RequestMapping(value = "insertNotice.ad")
	public String insertNotice(String user) {
		
		return "member/admin/insertNoticeForm";
	}
	
	///(관리자) 공지사항 관리 - 공지사항 등록
	@PostMapping("insertNoticeForm.ad")
	public ModelAndView insertNoticeFrom(Notice n
			, @RequestParam("upfile") List<MultipartFile> upfile
			, HttpSession session, ModelAndView mv) {

		String alertMsg = "";		
		String originName = "";
		String changeName = "";
		String savePath = "";
		
		NoticeAttachment na = new NoticeAttachment();
		ArrayList<NoticeAttachment> list = new ArrayList<NoticeAttachment>();

		int result = memberService.insertNoticeForm(n);
		
		if(!(upfile.size() == 1 && upfile.get(0).getOriginalFilename().equals("")) && result>0) {

			List<Map<String, String>> fileList = new ArrayList<>();
			
			for(int i = 0; i < upfile.size(); i++) {
				originName = upfile.get(i).getOriginalFilename();
				String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
				int ranNum = (int)(Math.random()*90000+10000);
				String ext = originName.substring(originName.lastIndexOf("."));

				changeName = currentTime+ranNum+ext;

				String subPath = "notice/";
				String filePath = "resources/uploadFiles/";
				
				savePath = session.getServletContext().getRealPath("/resources/uploadFiles/notice/");

				Map<String, String> map = new HashMap<>();
				map.put("originName", originName);
				map.put("changeName", changeName);
				
				fileList.add(map);
				
				try {
					File uploadFile = new File(savePath+fileList.get(i).get("changeName"));
					upfile.get(i).transferTo(uploadFile);
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				na = NoticeAttachment.builder().noticeNo(result).originName(originName).changeName(changeName).filePath(filePath+subPath).build();
				list.add(na);

			}
			
			int result1 = memberService.insertNoticeFile(list);
			
			if(result1 > 0) {
				alertMsg = "게시글이 등록되었습니다.";
				session.setAttribute("alertMsg", alertMsg);
				mv.setViewName("member/admin/ad_selectNotice");
			}else {
				alertMsg = "게시글 등록을 실패했습니다.";
				session.setAttribute("msg", alertMsg);
				mv.setViewName("member/admin/ad_selectNotice");
			}
		}else {
			if(result > 0) {
				alertMsg = "게시글이 등록되었습니다.";
				session.setAttribute("alertMsg", alertMsg);
				mv.setViewName("member/admin/ad_selectNotice");
			}else {
				alertMsg = "게시글 등록을 실패했습니다.";
				session.setAttribute("alertMsg", alertMsg);
				mv.setViewName("member/admin/ad_selectNotice");
			}
		}
		return mv;
	}
	
	///(관리자) 공지사항 관리 - 공지사항 수정
	@PostMapping("updateNoticeForm.ad")
	public ModelAndView updateNoticeFrom(Notice n, String delFileNo, int noticeNo
			, @RequestParam("upfile") List<MultipartFile> upfile
			, HttpSession session, ModelAndView mv) {

		String alertMsg = "";
		
		int result = memberService.updateNoticeForm(n, delFileNo);
		
		String originName = "";
		String changeName = "";
		String savePath = "";
		
		NoticeAttachment na = new NoticeAttachment();
		ArrayList<NoticeAttachment> list = new ArrayList<NoticeAttachment>();

		if(!(upfile.size() == 1 && upfile.get(0).getOriginalFilename().equals("")) && result>0) {

			List<Map<String, String>> fileList = new ArrayList<>();
			
			for(int i = 0; i < upfile.size(); i++) {
				originName = upfile.get(i).getOriginalFilename();
				String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
				int ranNum = (int)(Math.random()*90000+10000);
				String ext = originName.substring(originName.lastIndexOf("."));

				changeName = currentTime+ranNum+ext;

				String subPath = "notice/";
				String filePath = "resources/uploadFiles/";
				
				savePath = session.getServletContext().getRealPath("/resources/uploadFiles/notice/");

				Map<String, String> map = new HashMap<>();
				map.put("originName", originName);
				map.put("changeName", changeName);
				
				fileList.add(map);
				
				try {
					File uploadFile = new File(savePath+fileList.get(i).get("changeName"));
					upfile.get(i).transferTo(uploadFile);
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				na = NoticeAttachment.builder().noticeNo(noticeNo).originName(originName).changeName(changeName).filePath(filePath+subPath).build();
				list.add(na);
				System.out.println(list);
			}
			
			int result1 = memberService.insertNoticeFile(list);
			
			if(result1 > 0) {
				alertMsg = "게시글이 수정되었습니다.";
				session.setAttribute("alertMsg", alertMsg);
				mv.setViewName("member/admin/ad_selectNotice");
			}else {
				alertMsg = "게시글 수정을 실패했습니다.";
				session.setAttribute("alertMsg", alertMsg);
				mv.setViewName("member/admin/ad_selectNotice");
			}
		}else {
			if(result > 0) {
				alertMsg = "게시글이 수정되었습니다.";
				session.setAttribute("alertMsg", alertMsg);
				mv.setViewName("member/admin/ad_selectNotice");
			}else {
				String msg = "게시글 수정을 실패했습니다.";
				session.setAttribute("alertMsg", alertMsg);
				mv.setViewName("member/admin/ad_selectNotice");
			}
		}
		return mv;
	}
	
	// (관리자) 공지사항 상세 보기
	@RequestMapping(value = "detailNoticeView.ad")
	public String detailNoticeView(String noticeNo, Model model) {
		
		Notice n = memberService.detailNoticeView(noticeNo);
		ArrayList<NoticeAttachment> na = memberService.detailNoticeFile(noticeNo);
		model.addAttribute("n", n);
		model.addAttribute("na", na);
		
		return "member/admin/detailNoticeView";
	}

}

