package com.univ.fin.common.template;

import com.univ.fin.common.model.vo.PageInfo;

public class Pagination {
	
	public static PageInfo getPageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {
		int maxPage = (int)Math.ceil((double)listCount/boardLimit);
		int startPage = (currentPage-1)/pageLimit * pageLimit +1;
		int endPage = startPage+pageLimit-1;
		
		if(endPage > maxPage) { // 끝 수가 페이지 수보다 크다면 해당 수를 총 페이지 수로 바꿔주기
			endPage = maxPage;
		}
		
		return new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);
	}
	
}
