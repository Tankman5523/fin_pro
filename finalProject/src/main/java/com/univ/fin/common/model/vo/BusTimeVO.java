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
	private int sectOrd1; //첫번째도착예정버스의 현재구간 순번
	private int kals1; //첫번째 도착예정 버스의 기타1 도착예정시간(초)
	private int neus1; //첫번째 도착예정 버스의 기타2 도착예정시간(초)
	private int isLast1; //첫번째도착예정버스의 막차여부 (0:막차아님, 1:막차)
	private int arrmsg1; //첫번째 도착예정 버스의 도착정보메시지 ex)5분57초후[2번째 전]
}
