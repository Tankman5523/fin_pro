package com.univ.fin.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AlarmVo {
	private int alarmNo;
	private String cmd;
	private String studentNo;
	private String professorName;
	private String status;
}
