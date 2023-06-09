package com.univ.fin.common.template;

import java.util.ArrayList;

public class DepartmentCategory{
	
	//학과 카테고리 모듈
	public ArrayList<String> departmentCategory(int cno) {
		
		ArrayList<String> list = new ArrayList<>();
		
		switch(cno) {
			case 0 : list.add("===전공===");
				break;
			case 1 : list.add("국어국문학과");
					 list.add("영어영문학과");
					 list.add("일어일문학과");
					 list.add("사학과");
				break;
			case 2 : list.add("경제경영학과");
					 list.add("회계학과");
					 list.add("법학과");
					 list.add("행정학과");
				break;
			case 3 : list.add("초등교육과");
					 list.add("유아교육과");
				break;
			case 4 : list.add("생명공학과");
					 list.add("수학과");
					 list.add("물리학과");
					 list.add("통계학과");
				break;
			case 5 : list.add("건축학과");
					 list.add("기계학과");
					 list.add("컴퓨터공학과");
					 list.add("전자전기과");
					 list.add("화학공학과");
				break;
			case 6 : list.add("시각디자인학과");
					 list.add("패션디자인학과");
				break;
			case 7 : list.add("연극영화과");
					 list.add("실용음악과");
				break;
		}
		return list;
	}
	
}
