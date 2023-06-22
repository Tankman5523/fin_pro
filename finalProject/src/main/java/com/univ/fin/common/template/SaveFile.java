package com.univ.fin.common.template;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

public class SaveFile {
	
	//
	public String saveFile(MultipartFile upfile,HttpSession session,String subPath) {
		//1.원본 파일명 뽑기 
		String originName = upfile.getOriginalFilename(); 
		
		//2.시간형식 문자열로 뽑아내기
		//202305163033
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		//3.뒤에 붙을 5자리 랜덤값 뽑아주기
		int ranNum = (int)(Math.random()*90000+10000); //5자리 랜덤값
		
		//4.확장자명 추출하기
		String ext = originName.substring(originName.lastIndexOf("."));
		
		//5.추출한 문자열들 다 합쳐서 changeName 만들기
		String changeName = currentTime+ranNum+ext;
		
		//6.업로드하고자 하는 물리적인 경로 알아내기
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/"+subPath);
		
		//7.경로와 수정파일명을 합쳐 파일 업로드 하기
		
		try {
			//파일업로드 구문
			upfile.transferTo(new File(savePath+changeName));
			
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return changeName;
	}
	
}
