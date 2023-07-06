package com.univ.fin.common.template;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Locale;
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
import com.univ.fin.common.model.vo.WeatherVo;

import lombok.Synchronized;

@EnableCaching
@Controller
public class Weather {
	
	@Autowired
	private CacheManager cacheManager;
	
	/* ========== 실시간 온도 ========== */
	@Cacheable("weather")
	@Synchronized
	@ResponseBody
	@RequestMapping(value="weather.api",produces="application/json; charset=UTF-8")
	public String weather() throws Exception{

		//기온
		HashMap<String, String> h = ultraShortTerm();
		
		return new Gson().toJson(h);
	}
	
	/* ========== 하늘상태, 강수형태  ========== */
	@Cacheable("skyPty")
	@Synchronized
	@ResponseBody
	@RequestMapping(value="skyPty.api",produces="application/json; charset=UTF-8")
	public String skyPty() throws Exception{

		//하늘 상태, 강수형태
		HashMap<String, String> h = ultraShortforecast();
		
		if(h == null) {
			return new Gson().toJson(h);
		}else {
			
			//강수, 하늘 가공처리
			/* IMG - 아이콘, SKY - 하늘상태 */
			HashMap<String, String> icon = new HashMap<>();
			icon.put("sky", h.get("SKY"));
			icon.put("pty", h.get("PTY"));
			
			HashMap<String,String> setIcon = weatherIcon(icon);
			setIcon.put("chkError", h.get("chkError"));
			
			return new Gson().toJson(setIcon);
		}
	}
	
	/* ========== 최저,최고 온도 ========== */
	@Cacheable("tmnTmx")
	@Synchronized
	@ResponseBody
	@RequestMapping(value="tmnTmx.api",produces="application/json; charset=UTF-8")
	public String tmnTmx() throws Exception{
		
		//최저온도, 최고온도
		HashMap<String, String> h = shortTerm();
		
		return new Gson().toJson(h);
	}
	
	/* ========== 전날 추출 ========== */
	public String yesterday() throws Exception {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date today = new Date();
		String date = sdf.format(today);
		Date setDate = sdf.parse(date);
		Calendar cal = new GregorianCalendar(Locale.KOREA);
		cal.setTime(setDate);
		cal.add(Calendar.DATE, -1);
		String yesterday = sdf.format(cal.getTime());
		
		return yesterday;
	}
	
	/* ========== 단기 예보 ========== */
	public HashMap<String, String> shortTerm() throws ParseException, MalformedURLException, InterruptedException{
		
		String yesterday = null;
		try {
			yesterday = yesterday();
		} catch (Exception e) {
		}
		
		HashMap<String, String> h = new HashMap<>();
		String chkError = "YYYY"; //비정상 처리 판별
		
		String url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst";
		url += "?serviceKey=LV1haHMzhSQa4G%2Fy3Z9xbZ9hC9LKdHt3g2Z4M5SQwQVcGxx6M7HRJqVs30pL9H4MdL7POcjH78%2FBspjr%2FNV1sw%3D%3D";
		url += "&pageNo=1";
		url += "&numOfRows=290";
		url += "&base_date=" + yesterday;
		url += "&base_time=2300";
		url += "&dataType=JSON";
		url += "&nx=58";
		url += "&ny=126";
		
		int count = 0;
		String responseText = "";
		JSONObject bodyObj = null;
		
		while(true) {
					
			URL requestUrl = new URL(url);
			
			HttpURLConnection urlCon;
			try {
				
				urlCon = (HttpURLConnection)requestUrl.openConnection();
			
				urlCon.setRequestMethod("GET");
				urlCon.setRequestProperty("Content-type", "application/json");
				urlCon.setRequestProperty("Accept", "application/json");
				urlCon.setConnectTimeout(1500);
				urlCon.setReadTimeout(1500);
				
				BufferedReader br = new BufferedReader(new InputStreamReader(urlCon.getInputStream()));
				
				String line;
				
				while((line = br.readLine()) != null) {
					responseText += line;
				}
				
				br.close();
				urlCon.disconnect();
				
			} catch (SocketTimeoutException e) {
				System.out.println("shortTerm 타임아웃 발생");
				responseText = ""; // 초기화 시켜줌
				count++;
				if(count == 10) {
					chkError = "NNNN";
					h.put("TMN", errorImg());
					h.put("TMX", errorImg());
					h.put("chkError", chkError);
					return h;
				}
				continue;
			} catch (IOException e1) {
			}
			
			System.out.println("shortTerm : " + responseText);
			
			if(responseText.charAt(0) == '<') { //error code = 04뜰 경우  (HTTP_ERROR)
				Thread.sleep(2500);
				responseText = ""; // 초기화 시켜줌
				count++;
				if(count == 10) {
					chkError = "NNNN";
					h.put("TMN", errorImg());
					h.put("TMX", errorImg());
					h.put("chkError", chkError);
					return h;
				}
				continue;
			}
			
			JSONObject totalObj = (JSONObject) new JSONParser().parse(responseText);
			bodyObj = (JSONObject) totalObj.get("response");
			
			JSONObject head = (JSONObject) bodyObj.get("header");
			if(head.get("resultCode").equals("03")) { //error code = 03뜰 경우 (NO DATA)
				Thread.sleep(2500);
				System.out.println("shortTerm 2.5초지연");
				responseText = ""; // 초기화 시켜줌
				count++;
				if(count == 10) {
					chkError = "NNNN";
					h.put("TMN", errorImg());
					h.put("TMX", errorImg());
					h.put("chkError", chkError);
					return h;
				}
			}else {
				break; //while 탈출
			}
		}
		
		JSONObject body = (JSONObject) bodyObj.get("body");
		JSONObject b = (JSONObject) body.get("items");
		JSONArray arr = (JSONArray) b.get("item");
		
		ArrayList<WeatherVo> list = new ArrayList<>();
		
		for(int i=0; i<arr.size(); i++) {
			JSONObject item = (JSONObject) arr.get(i);
			WeatherVo weather = new WeatherVo();
			weather.setCategory((String)item.get("category"));
			weather.setFcstValue((String)item.get("fcstValue"));
			list.add(weather);
		}
		
		//TMP - 1시간 온도, TMN - 일 최저 온도, TMX - 일 최고 온도
		
		int setTmp = 0;
		int setMin = 0;
		int setMax = 0;
		
		String min = "";
		String max = "";
		
		for(int i=0; i<list.size(); i++) {
			/* 일 최저,최고기온 추출 */ 
			if(list.get(i).getCategory().equals("TMP")) {
				
				setTmp = Integer.parseInt(list.get(i).getFcstValue());
				
				if(i != 0) {
					if(setMin > setTmp) { //최저기온
						min = list.get(i).getFcstValue();
						setMin = setTmp;
					}else if(setMax < setTmp){ //최고기온
						max = list.get(i).getFcstValue();
						setMax = setTmp;
					}
				}else {
					setMin = setTmp;
					min = list.get(i).getFcstValue();
					max = list.get(i).getFcstValue();
				}
			}
		}
		
		h.put("TMN", min);
		h.put("TMX", max);
		h.put("chkError", chkError);
		
		return h; 
	}
	
	/* ========== 초단기 실황 ========== */
	public HashMap<String, String> ultraShortTerm() throws ParseException, MalformedURLException, InterruptedException {
		
		String d = new SimpleDateFormat("HHmm").format(new Date());
		String d2 = d.substring(2,4);
		String f = d.substring(0,2);
		String time = "";
		String day = new SimpleDateFormat("yyyyMMdd").format(new Date());
		
		if(Integer.parseInt(d) < 1000) { //10:00 이전(즉 0?:00), ?시 30분전 처리
			if(Integer.parseInt(f) == 0) { //00시일 경우 어제일자로 변경
				if(Integer.parseInt(d2)<30) {
					try {
						day = yesterday();
					} catch (Exception e) {
					}
					time = "2330";
				}else {
					time = "0000";
				}
			}else {
				if(Integer.parseInt(d2) < 30) {
					time = Integer.parseInt(f)-1 + "30";
					time = "0" + time;
				}else {
					time = f + "00";
				}
			}
		}else { //10:00 이후
			if(Integer.parseInt(d2) < 30) { //??시 30분전 처리
				int a = Integer.parseInt(f)-1;
				if(a == 9) {
					time = "0" + a + "30";
				}else {
					time = a + "30";
				}
			}else {//??시 30분이후 처리
				time = f + "00";
			}
		}
		
		HashMap<String, String> h = new HashMap<>(); //최종 해쉬맵
		String chkError = "YYYY"; //비정상 처리 판별
		
		String url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst";
		url += "?serviceKey=LV1haHMzhSQa4G%2Fy3Z9xbZ9hC9LKdHt3g2Z4M5SQwQVcGxx6M7HRJqVs30pL9H4MdL7POcjH78%2FBspjr%2FNV1sw%3D%3D";
		url += "&pageNo=1";
		url += "&numOfRows=10";
		url += "&base_date=" + day;
		url += "&base_time=" + time;
		url += "&dataType=JSON";
		url += "&nx=58";
		url += "&ny=126";
		
		int count = 0; //에러 발생 횟수 담을 변수
		String responseText = "";
		JSONObject bodyObj = null;
		while(true) {
			URL requestUrl = new URL(url);
			HttpURLConnection urlCon;
			try {
				urlCon = (HttpURLConnection)requestUrl.openConnection();
				urlCon.setRequestMethod("GET");
				urlCon.setRequestProperty("Content-type", "application/json");
				urlCon.setRequestProperty("Accept", "application/json");
				urlCon.setConnectTimeout(1500);
				urlCon.setReadTimeout(1500);
				
				BufferedReader br = new BufferedReader(new InputStreamReader(urlCon.getInputStream()));
				String line;
				while((line = br.readLine()) != null) {
					responseText += line;
				}
				br.close();
				urlCon.disconnect();
			} catch (SocketTimeoutException e) {
				System.out.println("ultraShortTerm 타임아웃 발생");
				responseText = ""; // 초기화 시켜줌
				count++;
				if(count == 10) {
					chkError = "NNNN";
					h.put("T1H", errorImg());
					h.put("chkError", chkError);
					return h;
				}
				continue; //재실행
			} catch (IOException e1) {
			}
			
			if(responseText.charAt(0) == '<') { //error code = 04뜰 경우  (HTTP_ERROR)
				Thread.sleep(2500);
				responseText = ""; // 초기화 시켜줌
				count++;
				if(count == 10) {
					chkError = "NNNN";
					h.put("T1H", errorImg());
					h.put("chkError", chkError);
					return h;
				}
				continue; //재실행
			}
			
			System.out.println("ultraShortTerm : " + responseText);
			
			JSONObject totalObj = (JSONObject) new JSONParser().parse(responseText);
			bodyObj = (JSONObject) totalObj.get("response");
			
			JSONObject head = (JSONObject) bodyObj.get("header");
			if(head.get("resultCode").equals("03")) { //error code = 03뜰 경우 (NO DATA)
				Thread.sleep(2500);
				System.out.println("ultraShortTerm 2.5초지연");
				responseText = ""; // 초기화 시켜줌
				count++;
				if(count == 10) {
					chkError = "NNNN";
					h.put("T1H", errorImg());
					h.put("chkError", chkError);
					return h;
				}
			}else {
				break; //while 탈출
			}
		}
		
		JSONObject body = (JSONObject) bodyObj.get("body");
		JSONObject b = (JSONObject) body.get("items");
		JSONArray arr = (JSONArray) b.get("item");
		
		ArrayList<WeatherVo> list = new ArrayList<>();
		for(int i=0; i<arr.size(); i++) {
			JSONObject item = (JSONObject) arr.get(i);
			WeatherVo weather = new WeatherVo();
			
			weather.setCategory((String)item.get("category"));
			weather.setObsrValue((String)item.get("obsrValue"));
			
			list.add(weather);
		}
		
		for(int i=0; i<list.size(); i++) {
			//기온
			if(list.get(i).getCategory().equals("T1H")) {
				h.put("T1H", list.get(i).getObsrValue());
				h.put("chkError", chkError);
			}
		}
		return h;
	}
	
	/* ========== 초단기예보 ========== */
	public HashMap<String, String> ultraShortforecast() throws ParseException, MalformedURLException, InterruptedException{
		
		String d = new SimpleDateFormat("HHmm").format(new Date());
		String d2 = d.substring(2,4);
		String f = d.substring(0,2);
		int f2 = Integer.parseInt(f);
		String time = ""; //현재 시간
		String fcstTime = ""; //예보시간
		String day = new SimpleDateFormat("yyyyMMdd").format(new Date());
		
		if(Integer.parseInt(d) < 1000) { //10:00 이전(즉 0?:00), ?시 30분전 처리
			if(f2 == 0) { //00시일 경우
				if(Integer.parseInt(d2)<30) { //30분전일 경우 어제일자로 변경
					try {
						day = yesterday();
					} catch (Exception e) {
					}
					time = "2330";
					fcstTime = "0000";
				}else {
					time = "0030";
					fcstTime = "0100";
				}
			}else {
				if(Integer.parseInt(d2) < 30) {
					time = f2-1 + "30";
					time = "0" + time;
				}else {
					time = f + "30";
				}
				if((f2+1) < 10) {
					fcstTime = "0" + (f2+1) + "00";
				}else {
					fcstTime = (f2+1) + "00";
				}
			}
		}else { //10:00 이후
			if(Integer.parseInt(d2) < 30) { //??시 30분전 처리
				int a = f2-1;
				if(a == 9) {
					time = "0" + a + "30";
				}else {
					time = a + "30";
				}
			}else {//??시 30분이후 처리
				time = f + "30";
			}
			fcstTime = (f2+1) + "00";
			if(f2 == 23) {
				fcstTime = "0000";
			}
		}
		
		HashMap<String, String> h = new HashMap<>();
		String chkError = "YYYY";
		
		String url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst";
		url += "?serviceKey=LV1haHMzhSQa4G%2Fy3Z9xbZ9hC9LKdHt3g2Z4M5SQwQVcGxx6M7HRJqVs30pL9H4MdL7POcjH78%2FBspjr%2FNV1sw%3D%3D";
		url += "&pageNo=1";
		url += "&numOfRows=60";
		url += "&base_date=" + day;
		url += "&base_time=" + time;
		url += "&dataType=JSON";
		url += "&nx=58";
		url += "&ny=126";
		
		int count = 0;
		String responseText = "";
		JSONObject bodyObj = null;
		
		while(true) {
			URL requestUrl = new URL(url);
		
			HttpURLConnection urlCon;
			try {
				urlCon = (HttpURLConnection)requestUrl.openConnection();
			
				urlCon.setRequestMethod("GET");
				urlCon.setRequestProperty("Content-type", "application/json");
				urlCon.setRequestProperty("Accept", "application/json");
				urlCon.setConnectTimeout(1500);
				urlCon.setReadTimeout(1500);
			
				BufferedReader br = new BufferedReader(new InputStreamReader(urlCon.getInputStream()));
				
				String line;
				
				while((line = br.readLine()) != null) {
					responseText += line;
				}
				
				br.close();
				urlCon.disconnect();
			} catch (SocketTimeoutException e) {
				System.out.println("ultraShortforecast 타임아웃 발생");
				responseText = ""; // 초기화 시켜줌
				count++;
				if(count == 10) {
					chkError = "NNNN";
					h.put("SKY", errorImg());
					h.put("PTY", errorImg());
					h.put("chkError", chkError);
					return h;
				}
				continue;
			} catch (IOException e1) {
			}
			
			if(responseText.charAt(0) == '<') { //error code = 04뜰 경우 (HTTP_ERROR)
				Thread.sleep(2500);
				responseText = ""; // 초기화 시켜줌
				count++;
				if(count == 10) {
					chkError = "NNNN";
					h.put("SKY", errorImg());
					h.put("PTY", errorImg());
					h.put("chkError", chkError);
					return h;
				}
				continue;
			}
			
			System.out.println("ultraShortforecast : " + responseText);
			
			JSONObject totalObj = (JSONObject) new JSONParser().parse(responseText);
			bodyObj = (JSONObject) totalObj.get("response");
			
			JSONObject head = (JSONObject) bodyObj.get("header");
			if(head.get("resultCode").equals("03")) { //error code = 03뜰 경우 (NO DATA)
				Thread.sleep(2500); //2.5초 후 다시 재요청
				System.out.println("ultraShortforecast 2.5초지연");
				responseText = ""; // 초기화 시켜줌
				count++;
				if(count == 10) {
					chkError = "NNNN";
					h.put("SKY", errorImg());
					h.put("PTY", errorImg());
					h.put("chkError", chkError);
					return h;
				}
			}else {
				break; //03while 탈출
			}
		}
		JSONObject body = (JSONObject) bodyObj.get("body");
		JSONObject b = (JSONObject) body.get("items");
		JSONArray arr = (JSONArray) b.get("item");
		
		ArrayList<WeatherVo> list = new ArrayList<>();
		
		for(int i=0; i<arr.size(); i++) {
			JSONObject item = (JSONObject) arr.get(i);
			WeatherVo weather = new WeatherVo();
			
			weather.setCategory((String)item.get("category"));
			weather.setFcstTime((String)item.get("fcstTime"));
			weather.setFcstValue((String)item.get("fcstValue"));
			
			list.add(weather);
		}
		
		for(int i=0; i<list.size(); i++) {
			
			//기온
			if(list.get(i).getCategory().equals("SKY") && list.get(i).getFcstTime().equals(fcstTime)) {
				h.put("SKY", list.get(i).getFcstValue());
			}
			if(list.get(i).getCategory().equals("PTY") && list.get(i).getFcstTime().equals(fcstTime)) {
				h.put("PTY", list.get(i).getFcstValue());
			}
		}
		h.put("chkError", chkError);
		return h;
	}

	
	/* ========== 강수형태 아이콘 처리 ========== */
	public HashMap<String, String> weatherIcon(HashMap<String, String> icon) {
		
		HashMap<String, String> result = new HashMap<>();
		
		//강수형태  => 없음(0), 비(1), 비/눈(2), 눈(3), 빗방울(5), 빗방울눈날림(6), 눈날림(7) 
		int pty = Integer.parseInt(icon.get("pty"));
		//하늘상태  => 하늘상태  = 맑음(1), 구름많음(3), 흐림(4)
		int sky = Integer.parseInt(icon.get("sky"));
		
		//아이콘
		String img = "";
		//날씨상태
		String resultSky = "";
		
		switch(pty) {
			case 0 :
					if(sky == 1) {
						resultSky = "맑음";
						img = "<img src='resources/icon/sun.png'>";
					}else if(sky == 3) {
						resultSky = "구름많음";
						img = "<img src='resources/icon/clearSky.png'>";
					}else {
						resultSky = "흐림";
						img = "<img src='resources/icon/cloud.png'>";
					}
				break;
			case 1 : 
					resultSky = "비";
					img = "<img src='resources/icon/rain.png'>";
				break;
			case 6 : 
			case 2 : 
					resultSky = "비/눈";
					img = "<img src='resources/icon/snowRain.png'>";
				break;
			case 7 : 
			case 3 :
					resultSky = "눈";
					img = "<img src='resources/icon/snow.png'>";
				break;
			case 5 : 
					resultSky = "빗방울";
					img = "<img src='resources/icon/minRain.png'>";
		}

		result.put("IMG", img);
		result.put("SKY", resultSky);
		
		return result;
	}
	
	//에러 이미지 처리
	public String errorImg() {
		
		String img = "<span><img id='dustErrorGif' src='resources/icon/dust_error.gif' data-animated='resources/icon/dust_error.gif'></span>";
		
		return img;
	}
	
	//최저,최고기온 캐시 삭제
	@ResponseBody
	@RequestMapping("tmnTmxCache.api")
	public void tmnTmxCache() {
		cacheManager.getCache("tmnTmx").clear();
	}
	
	//하늘상태,강수형태 캐시 삭제
	@ResponseBody
	@RequestMapping("skyPtyCache.api")
	public void skyPtyCache() {
		cacheManager.getCache("skyPty").clear();
	}
	
	//현재온도 캐시 삭제
	@ResponseBody
	@RequestMapping("weatherCache.api")
	public void weatherCache() {
		cacheManager.getCache("weather").clear();
	}

}
