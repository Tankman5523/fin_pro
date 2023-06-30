package com.univ.fin.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class WeatherVo {

	private String baseDate; //발표일자
	private String baseTime; //발표시각
	private String category; //자료구분문자
	private String obsrValue; //초단기 실황 값
	private String fcstValue; //초단기,단기 예보 값
	private String fcstDate; //예보일자
	private String fcstTime; //예보시각
}
