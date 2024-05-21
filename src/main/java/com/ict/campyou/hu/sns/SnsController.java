package com.ict.campyou.hu.sns;

import java.io.BufferedReader;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SnsController {
	@RequestMapping("naverlogout2.do")
	public ModelAndView getSnsLogout(HttpSession session) {
		String apiURL = "https://nid.naver.com/oauth2.0/token"
				+ "?grant_type=delete"
				+ "&client_id=Yg5gbW0JV9cs8cbMiejA"
				+ "&client_secret=N0wncgpOA_"
				+ "&access_token=" + session.getAttribute("access_token")
				+ "&service_provider='NAVER'";
		try {
			URL url = new URL(apiURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setDoOutput(true);

			int responseCode = conn.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) {
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				String line = "";
				StringBuffer sb = new StringBuffer();
				while ((line = br.readLine()) != null) {
					sb.append(line);
				}
				String result = sb.toString();
				System.out.println(result);
		
			 session.removeAttribute("naverMemberInfo");
		     return new ModelAndView("home");
		   }
		} catch (Exception e) {
		}
		return null;
	}

	@RequestMapping("kakaologout.do")
	public ModelAndView getKakaoLogout(HttpSession session) {
	    String accessToken = (String) session.getAttribute("access_token");
	    if (accessToken == null) {
	        return new ModelAndView("hu/loginForm");
	    }
	    String reqURL = "https://kapi.kakao.com/v1/user/logout";
	    try {
	        URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Authorization", "Bearer " + accessToken);

	        int responseCode = conn.getResponseCode();
	        if (responseCode == HttpURLConnection.HTTP_OK) {
	            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	            String line;
	            StringBuilder sb = new StringBuilder();
	            while ((line = br.readLine()) != null) {
	                sb.append(line);
	            }
	            String result = sb.toString();
	            System.out.println("Kakao logout response: " + result);

	            session.removeAttribute("kakaoMemberInfo");
	            return new ModelAndView("hu/loginForm");
	        } else {
	            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	            String line;
	            StringBuilder sb = new StringBuilder();
	            while ((line = br.readLine()) != null) {
	                sb.append(line);
	            }
	            String errorResponse = sb.toString();
	            System.out.println("Kakao logout error response: " + errorResponse);
	            return new ModelAndView("hu/sns/error");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return new ModelAndView("hu/sns/error");
	    }
	}
}