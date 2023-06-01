package com.univ.fin.money.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Scholarship { //장학금
	private int schNo;
	private int studentNo;
	private int schCategoryNo;
	private int schAmount;
	private String classYear;
	private int classTerm;
	private Date proDate;
	private String status;
	private String etc;
}
