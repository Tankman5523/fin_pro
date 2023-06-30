package com.univ.fin.common.template;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class BusTime { //인증문제로 현재 사용 불가
	
	public static final String SERVICEKEY2 = "D793c7rZOIR7DfJWDPSqTPptQGuZ6Hrhrt1kfCfwFHpxjX84k6nfbsfkNc5bBc1H8S2nK1nvIQbP94%2F36ASFXA%3D%3D";
	
	public String busTimeCal(/* String stId,String busRouteId,String ord */) throws IOException {
		
		String stId = "118000137"; //선유고등학교
		String busRouteId = "100100346"; //7612 버스 노선 ID
		String ord = "12"; //선유고등학교 정류장 순서
		String resultType= "json";
		
		StringBuilder urlBuilder = new StringBuilder("http://ws.bus.go.kr/api/rest/arrive/getArrInfoByRoute"); /*URL*/
		urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + SERVICEKEY2); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("stId","UTF-8") + "=" + URLEncoder.encode(stId, "UTF-8")); /*정류소 고유 ID*/
        urlBuilder.append("&" + URLEncoder.encode("busRouteId","UTF-8") + "=" + URLEncoder.encode(busRouteId, "UTF-8")); /*버스 노선 ID*/
        urlBuilder.append("&" + URLEncoder.encode("ord","UTF-8") + "=" + URLEncoder.encode(ord, "UTF-8")); /*정류장 순서*/
        urlBuilder.append("&" + URLEncoder.encode("resultType","UTF-8") + "=" + URLEncoder.encode(resultType, "UTF-8")); /*반환타입*/
        URL url = new URL(urlBuilder.toString());
        
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        
        //오류코드 조건처리
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        System.out.println(sb.toString());
        
		return null;
	}
}
