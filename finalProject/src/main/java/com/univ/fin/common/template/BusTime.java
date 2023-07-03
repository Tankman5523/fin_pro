package com.univ.fin.common.template;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

@Controller
public class BusTime {
	
	public static final String SERVICEKEY = "D793c7rZOIR7DfJWDPSqTPptQGuZ6Hrhrt1kfCfwFHpxjX84k6nfbsfkNc5bBc1H8S2nK1nvIQbP94%2F36ASFXA%3D%3D";
	
	//오시는길 버스 마커 
	@ResponseBody
	@RequestMapping(value="busMark.mp",produces = "application/json;charset=UTF-8")
	public String busMarker(String busRouteId) throws IOException, ParseException {
		
		String resultType= "json";
		
        StringBuilder urlBuilder = new StringBuilder("http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=" + SERVICEKEY); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("busRouteId","UTF-8") + "=" + URLEncoder.encode(busRouteId, "UTF-8")); /*노선ID*/
        urlBuilder.append("&" + URLEncoder.encode("resultType","UTF-8") + "=" + URLEncoder.encode(resultType, "UTF-8")); /*반환타입*/
        
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        String responseText="";
		String line;
		while((line=rd.readLine())!=null) {
			responseText += line;
		}
		
        rd.close();
        conn.disconnect();
        
        JSONObject totalObj = (JSONObject) new JSONParser().parse(responseText);
        JSONObject bodyObj =(JSONObject) totalObj.get("msgBody");
		JSONArray itemArr = (JSONArray)bodyObj.get("itemList");
		
		for(int i=0;i<itemArr.size();i++) {
			JSONObject item = (JSONObject)itemArr.get(i);
			
			String gpsX = (String) item.get("gpsX");
			String gpsY = (String) item.get("gpsY");
			
		}
		
		return new Gson().toJson(itemArr);
    }
}
