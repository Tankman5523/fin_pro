package com.univ.fin.common.template;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.univ.fin.common.model.vo.WeatherVo;


@Controller
public class Weather {

	@ResponseBody
	@RequestMapping(value="weather.api",produces = "application/json; charset=UTF-8")
	public String weather() throws IOException, ParseException{
		
		/* 날짜 및 시간 계산 */
		String date = "";
		String time = "";
		/*
		 * {"response":{"header":{"resultCode":"03","resultMsg":"NO_DATA"}}}
		  현재 시간 - 30분
		  ex) 12시 11분이면 11시 30
		  ex) 0시 11분이라면 전 날의 23시30분
		  
		 */
		
		String url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst";
		url += "?serviceKey=LV1haHMzhSQa4G%2Fy3Z9xbZ9hC9LKdHt3g2Z4M5SQwQVcGxx6M7HRJqVs30pL9H4MdL7POcjH78%2FBspjr%2FNV1sw%3D%3D";
		url += "&pageNo=1";
		url += "&numOfRows=100";
		url += "&base_date=" + new SimpleDateFormat("yyyyMMdd").format(new Date());
//		url += "&base_time=" + new SimpleDateFormat("HHmm").format(new Date());
		url += "&base_time=1530";
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
		System.out.println(list.toString());
		System.out.println(list.get(0).getCategory());
		return responseText;
	}

}
