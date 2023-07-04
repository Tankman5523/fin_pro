package com.univ.fin.main.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class NoticeAttachment {
	private int fileNo;//	FILE_NO	NUMBER
	private int noticeNo;//	NOTICE_NO	NUMBER
	private String originName;//	ORIGIN_NAME	VARCHAR2(255 BYTE)
	private String changeName;//	CHANGE_NAME	VARCHAR2(255 BYTE)
	private String filePath;//	FILE_PATH	VARCHAR2(1000 BYTE)
	private Date uploadDate;//	UPLOAD_DATE	DATE
	private String status;//	STATUS	VARCHAR2(2 BYTE)
}
