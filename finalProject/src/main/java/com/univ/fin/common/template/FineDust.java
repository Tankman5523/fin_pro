package com.univ.fin.common.template;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

@EnableCaching
@Controller
public class FineDust {
	
	@Autowired
	CacheManager cacheManager;
	
	@Scheduled(cron = "0 0/30 * * * *")
	public void updateDust() throws Exception {
		cacheManager.getCache("dust").clear();
		fineDust();
	}
	
	@Cacheable("dust")
	@ResponseBody
	@RequestMapping(value="dust.api", produces="application/json; charset=UTF-8")
	public String fineDust() throws Exception {
	
		String url = "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty";
		url += "?serviceKey=JgXo3POe0a3b4pTvBw8rueVqJHCR9e88WngrWVqtFnFyJLCgxTMU7sHDmeMFiWmVEFsKZXxapPzBPgf8FVTeOA%3D%3D";
		url += "&returnType=JSON";
		url += "&numOfRows=1";
		url += "&pageNo=1";
		url += "&sidoName=" + URLEncoder.encode("서울", "UTF-8");
		url += "&ver=1.3";
		
		URL requestUrl = new URL(url);
		
		HttpURLConnection urlCon = (HttpURLConnection)requestUrl.openConnection();
		
		urlCon.setRequestMethod("GET");
		urlCon.setRequestProperty("Accept", "application/json");
		
		BufferedReader br = new BufferedReader(new InputStreamReader(urlCon.getInputStream()));
		
		String responseText = "";
		String line;
		
		while((line = br.readLine()) != null) {
			responseText += line;
		}
		
		br.close();
		urlCon.disconnect();
		
		JSONObject totalObj = (JSONObject) new JSONParser().parse(responseText);
		JSONObject bodyObj = (JSONObject) totalObj.get("response");
		JSONObject body = (JSONObject) bodyObj.get("body");
		JSONArray arr = (JSONArray) body.get("items");
		JSONObject item = (JSONObject)arr.get(0);
		
		String setPm10 = (String)item.get("pm10Grade1h"); //미세먼지 1시간 등급
		String setPm25 = (String)item.get("pm25Grade1h"); //초미세먼지 1시간 등급
		
		String pm10 = chkGrade(setPm10); //미세먼지 등급 변환
		String pm25 = chkGrade(setPm25); //초미세먼지 등급 변환
		
		HashMap<String, String> h = new HashMap<>();
		h.put("pm10Grade1h", pm10);
		h.put("pm25Grade1h", pm25);
		
		return new Gson().toJson(h);
	}
	
	/* 등급변환 */
	public String chkGrade(String pm) {
		
		int pm2 = Integer.parseInt(pm);
		
		String setPm = "";
		
		/* 좋음 : 1, 보통 : 2, 나쁨 : 3, 매우나쁨 : 4 */
		switch(pm2) {
			case 1 : setPm = "<span style='color : #32a1ff;'>좋음</span>";
				break;
			case 2 : setPm = "<span style='color : #00c73c;'>보통</span>";
				break;
			case 3 : setPm = "<span style='color : #fda60e;'>나쁨</span>";
				break;
			case 4 : setPm = "<span style='color : #e64746;'>매우나쁨</span>";
				break;
		}
		
		return setPm;
	}
	
}
