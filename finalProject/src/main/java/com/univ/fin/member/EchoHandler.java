package com.univ.fin.member;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.univ.fin.common.model.vo.AlarmVo;
import com.univ.fin.member.model.service.MemberService;
import com.univ.fin.member.model.vo.Professor;
import com.univ.fin.member.model.vo.Student;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class EchoHandler extends TextWebSocketHandler  {
	
	@Autowired
	private MemberService memberService;

	private Set<WebSocketSession> users = new CopyOnWriteArraySet<>();
	private HashMap<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) {
		users.add(session);
		log.info("접속");
		log.info("session: {}", session);
		
		Object loginUser = session.getAttributes().get("loginUser");
		if(loginUser instanceof Student) {
			Student s = (Student)loginUser;
			String studentNo = s.getStudentNo();
			userSessionsMap.put(studentNo, session);
		}
		else {
			userSessionsMap.put(session.getId(), session);
		}
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("수신");
		log.info("session: {}", session);
		log.info("textMessage: {}", message);
		
		String msg = message.getPayload();
		String[] strs = msg.split(",");
		if(strs != null && strs.length==3) { // 교수가 보냈을 때
			String cmd = strs[0]; // 어떤 종류의 알람인지
			String sNo = strs[1]; // 받는 사람
			String pName = strs[2]; // 보내는 사람
			
			WebSocketSession student = userSessionsMap.get(sNo); // 메세지 받는 사람이 접속중인지 확인
			
			if(student!= null) { // 접속중이면
				if("gradeInsert".equals(cmd)) {
					AlarmVo alarm = AlarmVo.builder().cmd(cmd).professorName(pName).build();
					String text = new Gson().toJson(alarm);
					TextMessage newMessage = new TextMessage(text);
					
					student.sendMessage(newMessage);
				}
				else if("gradeUpdate".equals(cmd)) {
					AlarmVo alarm = AlarmVo.builder().cmd(cmd).professorName(pName).build();
					String text = new Gson().toJson(alarm);
					TextMessage newMessage = new TextMessage(text);
					
					student.sendMessage(newMessage);
				}
			}
			
		}
		else if(strs != null && strs.length==1) { // 뒤늦게 로그인한 학생이 확인할 때
			WebSocketSession student = userSessionsMap.get(msg);
			
			ArrayList<AlarmVo> aList = memberService.alarmReceive(msg);
			String text = new Gson().toJson(aList);
			TextMessage newMessage = new TextMessage(text);
			
			student.sendMessage(newMessage);
		}
		
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("종료");
		log.info("session: {}", session);
		log.info("CloseStatus: {}", status);
//		Object loginUser = session.getAttributes().get("loginUser");
//		if(loginUser instanceof Student) {
//			Student s = (Student)loginUser;
//			String studentNo = s.getStudentNo();
//			userSessionsMap.remove(studentNo, session);
//		}
		userSessionsMap.remove(session.getId());
		users.remove(session);
	}
}
