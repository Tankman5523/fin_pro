package com.univ.fin.common.template;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class WeatherScheduled {

	@Autowired
	private CacheManager cacheManager;
	
	@Autowired
	private Weather weatherIoc;
	
	@Autowired
	private FineDust fineDustIoc;
	
	/* ========== (캐시 삭제후 데이터 갱신 - 온도)========== */
	@Scheduled(cron = "0 0/10 * * * *") // 매 10분마다 갱신
	public void updateUltraShortTerm() throws Exception {
		cacheManager.getCache("weather").clear(); //전 캐쉬 삭제
		weatherIoc.weather();
	}
	
	/* ========== (캐시 삭제후 데이터 갱신 - 강수형태,하늘상태)========== */
	@Scheduled(cron = "0 0/10 * * * *") // 매 10분마다 갱신
	public void updateUltraShortTerm2() throws Exception {
		cacheManager.getCache("skyPty").clear(); //전 캐쉬 삭제
		weatherIoc.skyPty();
	}
	
	/* ========== (캐시 삭제후 데이터 갱신 - 최저,최고온도)========== */
	@Scheduled(cron = "0 0 23 * * *") //매일 23시마다 갱신
	public void updateShortTerm() throws Exception {
		cacheManager.getCache("tmnTmx").clear(); //전 캐쉬 삭제
		weatherIoc.tmnTmx();
	}
	
	/* ========== (캐시 삭제후 데이터 갱신 - 미세,초미세먼지)========== */
	@Scheduled(cron = "0 0/30 * * * *")
	public void updateDust() throws Exception {
		cacheManager.getCache("dust").clear();
		fineDustIoc.fineDust();
	}
	
}
