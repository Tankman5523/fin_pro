package com.univ.fin.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BusTimeVO {
	//request
	private String busNum; //버스노선번호
	private String stId; //정류장 ID
	private String busRouteId; //버스노선 ID
	private String ord; // 버스노선에서 해당 정류장의 순번
	
	//response
	private int isLast1; //첫번째 도착예정버스의 막차여부 (0:막차아님, 1:막차)
	private int arrmsg1; //첫번째 도착예정 버스의 도착정보메시지 ex)5분57초후[2번째 전]
	
	private int isLast2; //두번째 도착예정버스의 막차여부 (0:막차아님, 1:막차)
	private int arrmsg2; //두번째 도착예정 버스의 도착정보메시지 ex)5분57초후[2번째 전]
}
