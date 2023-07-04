package com.univ.fin.common.template;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

@EnableCaching
@Controller
public class FineDust {
	
	@Autowired
	private CacheManager cacheManager;
	
	@Cacheable("dust")
	@ResponseBody
	@RequestMapping(value="dust.api", produces="application/json; charset=UTF-8")
	public String fineDust() throws UnsupportedEncodingException, MalformedURLException, ParseException{
	
		String url = "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty";
		url += "?serviceKey=JgXo3POe0a3b4pTvBw8rueVqJHCR9e88WngrWVqtFnFyJLCgxTMU7sHDmeMFiWmVEFsKZXxapPzBPgf8FVTeOA%3D%3D";
		url += "&returnType=JSON";
		url += "&numOfRows=100";
		url += "&pageNo=1";
		url += "&sidoName=" + URLEncoder.encode("서울", "UTF-8");
		url += "&ver=1.3";
		
		String responseText = "";
		boolean success = false;
		while(success != true) {
			URL requestUrl = new URL(url);
			
			HttpURLConnection urlCon;
			try {
				urlCon = (HttpURLConnection)requestUrl.openConnection();
			
				urlCon.setRequestMethod("GET");
				urlCon.setRequestProperty("Content-type", "application/json");
				urlCon.setRequestProperty("Accept", "application/json");
				urlCon.setConnectTimeout(1500);
				urlCon.setReadTimeout(1500);
				
				if(urlCon.getResponseCode() >= 200 && urlCon.getResponseCode() <= 300) {
					success = true;
				}
				
				BufferedReader br = new BufferedReader(new InputStreamReader(urlCon.getInputStream()));
				
				String line;
				
				while((line = br.readLine()) != null) {
					responseText += line;
				}
				
				System.out.println("FineDust : " + responseText);
				
				br.close();
				urlCon.disconnect();
			} catch (SocketTimeoutException e) {
				System.out.println("미세먼지 타임아웃 발생");
				success = false;
				responseText = "";
			} catch (IOException e) {
			}
		}
		
		JSONObject totalObj = (JSONObject) new JSONParser().parse(responseText);
		JSONObject bodyObj = (JSONObject) totalObj.get("response");
		JSONObject body = (JSONObject) bodyObj.get("body");
		JSONArray arr = (JSONArray) body.get("items");
		
		String setPm10 = "";
		String setPm25 = "";
		for(int i=0; i<arr.size(); i++) {
			JSONObject item = (JSONObject)arr.get(i);
			if(item.get("stationName").equals("영등포구")) {
				setPm10 = (String)item.get("pm10Grade1h"); //미세먼지 1시간 등급
				setPm25 = (String)item.get("pm25Grade1h"); //초미세먼지 1시간 등급
			}
		}
		
		/* 통신관련 상태 이상일때 */
		String pm10 = "";
		String pm25 = "";
		String chkError = "YYYY";
		if(setPm10 == null || setPm25 == null) { //비정상처리
			pm10 = chkGrade("0");
			pm25 = chkGrade("0");
			chkError = "NNNN";
		}else { //정상처리
			pm10 = chkGrade(setPm10); //미세먼지 등급 변환
			pm25 = chkGrade(setPm25); //초미세먼지 등급 변환
		}
		
		HashMap<String, String> h = new HashMap<>();
		h.put("pm10Grade1h", pm10);
		h.put("pm25Grade1h", pm25);
		h.put("chkError", chkError);
		
		return new Gson().toJson(h);
	}
	
	/* 등급변환 */
	public String chkGrade(String pm) {
		
		int pm2 = Integer.parseInt(pm);
		
		String setPm = "";
		
		/* 좋음 : 1, 보통 : 2, 나쁨 : 3, 매우나쁨 : 4 */
		switch(pm2) {
			case 0 : setPm = "<span><img id='dustErrorGif' src='resources/icon/dust_error.gif' data-animated='resources/icon/dust_error.gif'></span>";
				break;
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
	
	/* 통신관련 상태이상일 경우 캐시 삭제 */
	@ResponseBody
	@RequestMapping(value="dustCache.api",produces = "application/json; charset=UTF-8")
	public void dustCache() {
		cacheManager.getCache("dust").clear();
	}
	
}
