package com.univ.fin.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FineDustVo {
	
	private String sidoName;	//시도명
	private String dataTime;	//측정일시
	private String pm10Grade1h; //미세먼지 1시간 등급
	private String pm25Grade1h; //초미세먼지 1시간 등급
	
}
