package com.univ.fin.main.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Notice {
	private int noticeNo;//	NOTICE_NO	NUMBER
	private String professorNo;//	PROFESSOR_NO	VARCHAR2(30 BYTE)
	private int noticeCategory;//	NOTICE_CATEGORY	NUMBER
	private String noticeTitle;//	NOTICE_TITLE	VARCHAR2(100 BYTE)
	private String noticeContent;//	NOTICE_CONTENT	VARCHAR2(600 BYTE)
	private int count;//	COUNT	NUMBER
	private String createDate;//	CREATE_DATE	DATE
	private String field;//	FIELD	VARCHAR2(2 BYTE)
	private String status;//	STATUS	VARCHAR2(2 BYTE)
	private String originName;
	private String changeName;
	private String categoryName;
	private int rank;
}
