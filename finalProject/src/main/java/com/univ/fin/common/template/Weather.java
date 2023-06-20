package com.univ.fin.common.template;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.univ.fin.common.model.vo.WeatherVo;


@Controller
public class Weather {

	/* 날씨 정보 가공처리 */
	@ResponseBody
	@RequestMapping(value="weather.api",produces="application/json; charset=UTF-8")
	public String weather() throws Exception{
		
		//최저온도,최고온도
		HashMap<String, String> h = shortTerm();

		HashMap<String, String> h2 = ultraShortTerm();
		
		HashMap<String, String> result = new HashMap<>();
		
		result.put("T1H", h2.get("T1H"));	//기온
		result.put("PTY", h2.get("PTY"));	//강수형태
		result.put("TMN", h.get("TMN"));	//최저온도
		result.put("TMX", h.get("TMX"));	//최고온도
		
		return new Gson().toJson(result);
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
	public HashMap<String, String> shortTerm() throws IOException, Exception {

		String yesterday = yesterday();
		
		String url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst";
		url += "?serviceKey=LV1haHMzhSQa4G%2Fy3Z9xbZ9hC9LKdHt3g2Z4M5SQwQVcGxx6M7HRJqVs30pL9H4MdL7POcjH78%2FBspjr%2FNV1sw%3D%3D";
		url += "&pageNo=1";
		url += "&numOfRows=266";
		url += "&base_date=" + yesterday;
		url += "&base_time=2300";
		url += "&dataType=JSON";
		url += "&nx=58";
		url += "&ny=126";
		
		URL requestUrl = new URL(url);
		
		HttpURLConnection urlCon = (HttpURLConnection)requestUrl.openConnection();
		
		urlCon.setRequestMethod("GET");
		
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
		
		//TMP - 1시간 온도
		//TMN - 일 최저 온도
		//TMX - 일 최고 온도
		//SKY - 하늘상태  = 맑음(1), 구름많음(3), 흐림(4)
		
		HashMap<String, String> h = new HashMap<>();
		
		for(int i=0; i<list.size(); i++) {
			
			/* 일 최저 온도 */
			if(list.get(i).getCategory().equals("TMN")) {
				h.put("TMN", list.get(i).getFcstValue());
			}
			
			/* 일 최고 온도 */
			if(list.get(i).getCategory().equals("TMX")) {
				h.put("TMX", list.get(i).getFcstValue());
			}
		}
		
		return h; 
	}
	
	
	/* ========== 초단기 실황 ========== */
	public HashMap<String, String> ultraShortTerm() throws Exception {
		
		String d = new SimpleDateFormat("HHmm").format(new Date());
		String d2 = d.substring(2,4); //
		String f = d.substring(0,2);
		String time = "";
		String day = new SimpleDateFormat("yyyyMMdd").format(new Date());
		
		if(Integer.parseInt(d) < 1000 && Integer.parseInt(d2)<30) {
			if(Integer.parseInt(f) == 0) {
				day = yesterday();
				time = "1130";
			}
			time = Integer.parseInt(f)-1 + "30";
			time = "0" + time;
		}else {
			time = Integer.parseInt(f) + "00";
			time = "0" + time;
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
		
		URL requestUrl = new URL(url);
		
		HttpURLConnection urlCon = (HttpURLConnection)requestUrl.openConnection();
		
		urlCon.setRequestMethod("GET");
		
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
		JSONObject b = (JSONObject) body.get("items");
		JSONArray arr = (JSONArray) b.get("item");
		
		ArrayList<WeatherVo> list = new ArrayList<>();
		
		for(int i=0; i<arr.size(); i++) {
			JSONObject item = (JSONObject) arr.get(i);
			WeatherVo weather = new WeatherVo();
			
			weather.setBaseDate((String)item.get("baseDate"));
			weather.setBaseTime((String)item.get("baseTime"));
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
			
			//강수형태 => 없음(0), 비(1), 비/눈(2), 눈(3), 빗방울(5), 빗방울눈날림(6), 눈날림(7)
			if(list.get(i).getCategory().equals("PTY")) {
				h.put("PTY", list.get(i).getObsrValue());
			}
		}
		
		return h;
	}

}
