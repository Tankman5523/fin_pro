package com.univ.fin.common.template;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class Sms {
	
	@SuppressWarnings("unchecked")
	public void send_msg(String tel, String rand) {
		
		String hostNameUrl = "https://sens.apigw.ntruss.com";
		
		String requestUrl= "/sms/v2/services/";
		
		String requestUrlType = "/messages";
		
		String accessKey = "Z4o2KRTkdQuK3LNi864X";
		
		String secretKey = "l1oMq7OtR96ENBOp5kpBNI3VHS7XkdLSVDBJLQn3";
		
		String serviceId = "ncp:sms:kr:309204385843:final_sms";
		
		String method = "POST";
		
		String timestamp = Long.toString(System.currentTimeMillis());
        requestUrl += serviceId + requestUrlType;
        String apiUrl = hostNameUrl + requestUrl;
        
        JSONObject bodyJson = new JSONObject();
        JSONObject toJson = new JSONObject();
        JSONArray  toArr = new JSONArray();
        
        toJson.put("to",tel);
        toArr.add(toJson);
        
        bodyJson.put("type","sms");
        bodyJson.put("contentType","COMM");
        bodyJson.put("countryCode","82");
        
        bodyJson.put("from","01027552324");		
        bodyJson.put("content","[FEASIBLE UNIVERSITY] 인증번호 : ["+rand+"] 인증번호를 입력해 주세요.");		
        bodyJson.put("messages", toArr);
        
        String body = bodyJson.toJSONString();
        
        System.out.println("body : " + body);
        
        try {
			URL url = new URL(apiUrl);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setUseCaches(false);
			con.setDoOutput(true);
			con.setDoInput(true);
			con.setRequestProperty("content-type", "application/json");
			con.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
			con.setRequestProperty("x-ncp-iam-access-key", accessKey);
			con.setRequestProperty("x-ncp-apigw-signature-v2",makeSignature(requestUrl, timestamp, method, accessKey, secretKey));
            con.setRequestMethod(method);
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			
            wr.write(body.getBytes());
            wr.flush();
            wr.close();
            
            int responseCode = con.getResponseCode();
            BufferedReader br;

            //202떠야 정상 그외 실패
            System.out.println("responseCode" +" " + responseCode);
            
            if(responseCode == 202) {
            	br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            }else {
            	br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            
            String inputLine;
            StringBuffer response = new StringBuffer();
            
            while((inputLine = br.readLine()) != null) {
            	response.append(inputLine);
            }
            br.close();
            
            System.out.println(response.toString());
            
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	
	public static String makeSignature(String url, String timestamp, String method
									  ,String accessKey, String secretKey)throws NoSuchAlgorithmException, InvalidKeyException{
		
		String space = " ";
		String newLine = "\n";
		
		String message = new StringBuilder()
							.append(method).append(space)
							.append(url).append(newLine)
							.append(timestamp).append(newLine)
							.append(accessKey).toString();
		
		SecretKeySpec signingKey;
		String encodeBase64String;
		
		try {
			signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"),"HmacSHA256");
			
			Mac mac = Mac.getInstance("HmacSHA256");
			mac.init(signingKey);
			byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
			encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);
		} catch (UnsupportedEncodingException e) {
			encodeBase64String = e.toString();
		}
		
		return encodeBase64String;
	}
	
	@SuppressWarnings("unchecked") //등록금 독촉 메시지
	public int dunningMsg(String tel, int nonPaidAmount, String studentName) {
		
		String hostNameUrl = "https://sens.apigw.ntruss.com";
		
		String requestUrl= "/sms/v2/services/";
		
		String requestUrlType = "/messages";
		
		String accessKey = "Z4o2KRTkdQuK3LNi864X";
		
		String secretKey = "l1oMq7OtR96ENBOp5kpBNI3VHS7XkdLSVDBJLQn3";
		
		String serviceId = "ncp:sms:kr:309204385843:final_sms";
		
		String method = "POST";
		
		String timestamp = Long.toString(System.currentTimeMillis());
        requestUrl += serviceId + requestUrlType;
        String apiUrl = hostNameUrl + requestUrl;
        
        JSONObject bodyJson = new JSONObject();
        JSONObject toJson = new JSONObject();
        JSONArray  toArr = new JSONArray();
        
        toJson.put("to","01000000000"); //보내는사람
        toArr.add(toJson);
        
        bodyJson.put("type","sms");
        bodyJson.put("contentType","COMM");
        bodyJson.put("countryCode","82");
        
        bodyJson.put("from",tel);	//받는사람	
        bodyJson.put("content","[FEASIBLE UNIVERSITY] "+studentName+"님의 등록금 미납액 ["+nonPaidAmount+"(원)] 입니다. 등록 기간내에 납부바랍니다.");		
        bodyJson.put("messages", toArr);
        
        String body = bodyJson.toJSONString();
        
        System.out.println("body : " + body);
        
        int flag = 0;
        try {
			URL url = new URL(apiUrl);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setUseCaches(false);
			con.setDoOutput(true);
			con.setDoInput(true);
			con.setRequestProperty("content-type", "application/json");
			con.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
			con.setRequestProperty("x-ncp-iam-access-key", accessKey);
			con.setRequestProperty("x-ncp-apigw-signature-v2",makeSignature(requestUrl, timestamp, method, accessKey, secretKey));
            con.setRequestMethod(method);
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			
            wr.write(body.getBytes());
            wr.flush();
            wr.close();
            
            int responseCode = con.getResponseCode();
            BufferedReader br;

            //202떠야 정상 그외 실패
            System.out.println("responseCode" +" " + responseCode);
            
            if(responseCode == 202) {
            	br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            	flag=1;
            }else {
            	br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            	flag=0;
            }
            
            String inputLine;
            StringBuffer response = new StringBuffer();
            
            while((inputLine = br.readLine()) != null) {
            	response.append(inputLine);
            }
            br.close();
            
            System.out.println(response.toString());
            
		} catch (Exception e) {
			System.out.println(e);
		}
        return flag;
	}
	
}
