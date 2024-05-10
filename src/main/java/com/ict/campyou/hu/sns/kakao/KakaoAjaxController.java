package com.ict.campyou.hu.sns.kakao;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class KakaoAjaxController {
	
	@RequestMapping(value = "kakaoUser.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String memberChk(HttpSession session) {
		
		String access_token = (String) session.getAttribute("access_token");
		String apiURL = "https://kapi.kakao.com/v2/user/me";
		String header = "Bearer " + access_token;
		
		Map<String, String> requestHeaders = new HashMap<String, String>();
		requestHeaders.put("Authorization", header);
		
		String responseBody = kakao_send(apiURL, requestHeaders, session);
		return responseBody;
	}
	
	public String kakao_send(String apiURL, Map<String, String> requestHeaders, HttpSession session) {
		
		HttpURLConnection conn = null;
		try {
			URL url = new URL(apiURL);
			conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
				conn.setRequestProperty(header.getKey(), header.getValue());
			}
			
			//	200 �씠硫� �꽦怨듦낵 媛숈� �쓽誘� (HttpURLConnection.HTTP_OK)
			int responseCode = conn.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) {
				System.out.println("�꽦怨�");
				return readBody(conn.getInputStream(), session); 
			}else {
				System.out.println("�떎�뙣");
				return readBody(conn.getErrorStream(), session);
			}
			
		} catch (Exception e) {
			System.out.println("�뿰寃곗떎�뙣");
		} finally {
			try {
				//	�젒�냽 �걡湲�
				conn.disconnect();
			} catch (Exception e2) {
			}
		}
		return null;
	}
	
	public String readBody(InputStream body, HttpSession session) {
		InputStreamReader isr = new InputStreamReader(body);
		try {
			BufferedReader br = new BufferedReader(isr);
			StringBuffer sb = new StringBuffer();
			String line = "";
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
			session.setAttribute("loginChk", "ok");
			
			return sb.toString();
			
		} catch (Exception e) {
			System.out.println("API �쓳�떟�쓣 �씫�뒗�뜲 �떎�뙣");
		}
		return null;
	}
}