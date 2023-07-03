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
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.univ.fin.common.model.vo.WeatherVo;

@EnableCaching
@Controller
public class Weather {

	@Autowired
	private CacheManager cacheManager;
	
	@Autowired
	private Weather weatherIoc;
	
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
	@Scheduled(cron = "0 30 23 * * *") //매 23시 30분마다 갱신
	public void updateShortTerm() throws Exception {
		cacheManager.getCache("tmnTmx").clear(); //전 캐쉬 삭제
		weatherIoc.tmnTmx();
	}
	
	/* ========== 실시간 온도 ========== */
	@Cacheable("weather")
	@ResponseBody
	@RequestMapping(value="weather.api",produces="application/json; charset=UTF-8")
	public String weather() throws Exception{

		//기온
		HashMap<String, String> h = ultraShortTerm();
		
		return new Gson().toJson(h);
	}
	
	/* ========== 하늘상태, 강수형태  ========== */
	@Cacheable("skyPty")
	@ResponseBody
	@RequestMapping(value="skyPty.api",produces="application/json; charset=UTF-8")
	public String skyPty() throws Exception{

		//하늘 상태, 강수형태
		HashMap<String, String> h = ultraShortforecast();
		
		//강수, 하늘 가공처리
		HashMap<String, String> icon = new HashMap<>();
		icon.put("sky", h.get("SKY"));
		icon.put("pty", h.get("PTY"));
		
		HashMap<String,String> setIcon = weatherIcon(icon);
		/* IMG - 아이콘, SKY - 하늘상태 */
		
		return new Gson().toJson(setIcon);
	}
	
	/* ========== 최저,최고 온도 ========== */
	@Cacheable("tmnTmx")
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
		
		String url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst";
		url += "?serviceKey=LV1haHMzhSQa4G%2Fy3Z9xbZ9hC9LKdHt3g2Z4M5SQwQVcGxx6M7HRJqVs30pL9H4MdL7POcjH78%2FBspjr%2FNV1sw%3D%3D";
		url += "&pageNo=1";
		url += "&numOfRows=290";
		url += "&base_date=" + yesterday;
		url += "&base_time=2300";
		url += "&dataType=JSON";
		url += "&nx=58";
		url += "&ny=126";
		
		String responseText = "";
		JSONObject bodyObj = null;
		
		
		while(true) { //03에러 while문
			while(true) { //04에러  while문
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
						
						br.close();
						urlCon.disconnect();
						
					} catch (SocketTimeoutException e) {//URL커넥션 timeout발생 시 소켓타임아웃 예외가 발생하므로 1.5초안에 200~300사이 코드를 반환하지 않을 시 소켓타임아웃 예외발생시킨후 재요청
						System.out.println("shortTerm 타임아웃 발생");
						success = false;
						responseText = ""; // 초기화 시켜줌
					} catch (IOException e1) {
					}
				}
				
				System.out.println("shortTerm : " + responseText);
				
				if(responseText.charAt(0) == '<') { //error code = 04뜰 경우  (HTTP_ERROR)
					Thread.sleep(2500);
					responseText = ""; // 초기화 시켜줌
				}else {
					break; //04 while 탈출
				}
			}
			JSONObject totalObj = (JSONObject) new JSONParser().parse(responseText);
			bodyObj = (JSONObject) totalObj.get("response");
			
			JSONObject head = (JSONObject) bodyObj.get("header");
			if(head.get("resultCode").equals("03")) { //error code = 03뜰 경우 (NO DATA)
				Thread.sleep(2500);
				System.out.println("shortTerm 2.5초지연");
				responseText = ""; // 초기화 시켜줌
			}else {
				break; //03 while 탈출
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
		
		HashMap<String, String> h = new HashMap<>();
		
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
				}
			}
		}
		
		h.put("TMN", min);
		h.put("TMX", max);
		
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
					time = "0030";
				}
			}else {
				if(Integer.parseInt(d2) < 30) {
					time = Integer.parseInt(f)-1 + "30";
					time = "0" + time;
				}else {
					time = f + "30";
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
				time = f + "30";
			}
		}
		
		String url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst";
		url += "?serviceKey=LV1haHMzhSQa4G%2Fy3Z9xbZ9hC9LKdHt3g2Z4M5SQwQVcGxx6M7HRJqVs30pL9H4MdL7POcjH78%2FBspjr%2FNV1sw%3D%3D";
		url += "&pageNo=1";
		url += "&numOfRows=10";
		url += "&base_date=" + day;
		url += "&base_time=" + time;
		url += "&dataType=JSON";
		url += "&nx=58";
		url += "&ny=126";
		
		String responseText = "";
		JSONObject bodyObj = null;
		
		while(true) { //03에러 while문
			while(true) { //04에러 while문
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
						
						br.close();
						urlCon.disconnect();
					} catch (SocketTimeoutException e) { 
						System.out.println("ultraShortTerm 타임아웃 발생");
						responseText = ""; // 초기화 시켜줌
						success = false;
					} catch (IOException e1) {
					}
				}
				
				if(responseText.charAt(0) == '<') { //error code = 04뜰 경우  (HTTP_ERROR)
					Thread.sleep(500);
					responseText = ""; // 초기화 시켜줌
				}else {
					break; //04while 탈출
				}
			}
			System.out.println("ultraShortTerm : " + responseText);
			
			JSONObject totalObj = (JSONObject) new JSONParser().parse(responseText);
			bodyObj = (JSONObject) totalObj.get("response");
			
			JSONObject head = (JSONObject) bodyObj.get("header");
			if(head.get("resultCode").equals("03")) { //error code = 03뜰 경우 (NO DATA)
				Thread.sleep(2500);
				System.out.println("ultraShortTerm 2.5초지연");
				responseText = ""; // 초기화 시켜줌
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
			weather.setObsrValue((String)item.get("obsrValue"));
			
			list.add(weather);
		}
		
		HashMap<String, String> h = new HashMap<>();
		
		for(int i=0; i<list.size(); i++) {
			//기온
			if(list.get(i).getCategory().equals("T1H")) {
				h.put("T1H", list.get(i).getObsrValue());
			}
		}
		
		return h;
	}
	
	/* ========== 초단기예보 ========== */
	public HashMap<String, String> ultraShortforecast() throws ParseException, MalformedURLException{
		
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
		
		String url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst";
		url += "?serviceKey=LV1haHMzhSQa4G%2Fy3Z9xbZ9hC9LKdHt3g2Z4M5SQwQVcGxx6M7HRJqVs30pL9H4MdL7POcjH78%2FBspjr%2FNV1sw%3D%3D";
		url += "&pageNo=1";
		url += "&numOfRows=60";
		url += "&base_date=" + day;
		url += "&base_time=" + time;
		url += "&dataType=JSON";
		url += "&nx=58";
		url += "&ny=126";
		
		String responseText = "";
		JSONObject bodyObj = null;
		while(true) { //03에러 while문
			while(true) { //04에러 while문
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
						
						br.close();
						urlCon.disconnect();
					} catch (SocketTimeoutException e) {
						System.out.println("ultraShortforecast 타임아웃 발생");
						success = false;
						responseText = ""; // 초기화 시켜줌
					} catch (IOException e1) {
					}
				}
				
				if(responseText.charAt(0) == '<') { //error code = 04뜰 경우 (HTTP_ERROR)
					try {
						Thread.sleep(2500);
					} catch (InterruptedException e) {
					}
					responseText = ""; // 초기화 시켜줌
				}else {
					break; //04while 탈출
				}
			}
			System.out.println("ultraShortforecast : " + responseText);
			
			JSONObject totalObj = (JSONObject) new JSONParser().parse(responseText);
			bodyObj = (JSONObject) totalObj.get("response");
			
			JSONObject head = (JSONObject) bodyObj.get("header");
			if(head.get("resultCode").equals("03")) { //error code = 03뜰 경우 (NO DATA)
				try {
					Thread.sleep(2500); //2.5초 후 다시 재요청
				} catch (InterruptedException e) {
				}
				System.out.println("ultraShortforecast 2.5초지연");
				responseText = ""; // 초기화 시켜줌
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
		
		HashMap<String, String> h = new HashMap<>();
		
		for(int i=0; i<list.size(); i++) {
			
			//기온
			if(list.get(i).getCategory().equals("SKY") && list.get(i).getFcstTime().equals(fcstTime)) {
				h.put("SKY", list.get(i).getFcstValue());
			}
			if(list.get(i).getCategory().equals("PTY") && list.get(i).getFcstTime().equals(fcstTime)) {
				h.put("PTY", list.get(i).getFcstValue());
			}
			
		}
		
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

}
