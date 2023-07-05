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
		
		Object loginUser = session.getAttributes().get("loginUser");
		if(loginUser instanceof Student) { // 학생 로그인
			Student s = (Student)loginUser;
			String studentNo = s.getStudentNo();
			userSessionsMap.put(studentNo, session);
		}
		else if(loginUser instanceof Professor) { // 교수 로그인
			Professor p = (Professor)loginUser;
			String professorNo = p.getProfessorNo();
			userSessionsMap.put(professorNo, session);
		}
		else {
			userSessionsMap.put(session.getId(), session);
		}
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String msg = message.getPayload();
		String[] strs = msg.split(",");
		if(strs != null && strs.length==3) { // 메세지 보냈을 때
			String cmd = strs[0]; // 어떤 종류의 알람인지
			String rNo = strs[1]; // 받는 사람
			String sName = strs[2]; // 보내는 사람
			
			WebSocketSession person = userSessionsMap.get(rNo); // 메세지 받는 사람이 접속중인지 확인
			
			if(person != null) { // 접속중이면
				if("gradeInsert".equals(cmd)) { // 성적 입력
					AlarmVo alarm = AlarmVo.builder().cmd(cmd).senderName(sName).build();
					String text = new Gson().toJson(alarm);
					TextMessage newMessage = new TextMessage(text);
					
					person.sendMessage(newMessage);
				}
				else if("gradeUpdate".equals(cmd)) { // 성적 수정
					AlarmVo alarm = AlarmVo.builder().cmd(cmd).senderName(sName).build();
					String text = new Gson().toJson(alarm);
					TextMessage newMessage = new TextMessage(text);
					
					person.sendMessage(newMessage);
				}
				else if("counselUpdate".equals(cmd)) { // 상담 변동
					AlarmVo alarm = AlarmVo.builder().cmd(cmd).senderName(sName).build();
					String text = new Gson().toJson(alarm);
					TextMessage newMessage = new TextMessage(text);
					
					person.sendMessage(newMessage);
				}
				else if("counselRequest".equals(cmd)) { // 상담 신청
					AlarmVo alarm = AlarmVo.builder().cmd(cmd).senderName(sName).build();
					String text = new Gson().toJson(alarm);
					TextMessage newMessage = new TextMessage(text);
					
					person.sendMessage(newMessage);
				}
				else if("reportUpdate".equals(cmd)) { // 성적이의신청 변동
					AlarmVo alarm = AlarmVo.builder().cmd(cmd).senderName(sName).build();
					String text = new Gson().toJson(alarm);
					TextMessage newMessage = new TextMessage(text);
					
					person.sendMessage(newMessage);
				}
				else if("reportRequest".equals(cmd)) { // 성적이의신청
					AlarmVo alarm = AlarmVo.builder().cmd(cmd).senderName(sName).build();
					String text = new Gson().toJson(alarm);
					TextMessage newMessage = new TextMessage(text);
					
					person.sendMessage(newMessage);
				}
				else if("reportUpdate".equals(cmd)) {
					AlarmVo alarm = AlarmVo.builder().cmd(cmd).professorName(pName).build();
					String text = new Gson().toJson(alarm);
					TextMessage newMessage = new TextMessage(text);
					
					student.sendMessage(newMessage);
				}
			}
			
		}
		else if(strs != null && strs.length==1) { // 뒤늦게 로그인한 사람이 확인할 때
			WebSocketSession person = userSessionsMap.get(msg);
			
			ArrayList<AlarmVo> aList = memberService.alarmReceive(msg);
			String text = new Gson().toJson(aList);
			TextMessage newMessage = new TextMessage(text);
			
			person.sendMessage(newMessage);
		}
		
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		userSessionsMap.remove(session.getId());
		users.remove(session);
	}
}
