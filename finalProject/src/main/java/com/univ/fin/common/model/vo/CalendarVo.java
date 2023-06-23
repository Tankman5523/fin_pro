package com.univ.fin.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CalendarVo {
	private int calendarNo; 	//일정번호
	private String content; 	//일정내용
	private String startDate;	//시작날짜
	private String endDate;		//마지막날짜
}
