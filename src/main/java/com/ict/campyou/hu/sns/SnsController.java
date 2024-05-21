package com.ict.campyou.hu.sns;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.ict.campyou.hu.sns.kakao.KakaoVO;
import com.ict.campyou.hu.sns.naver.NaverVO;

@Controller
public class SnsController {
	
   //카카오 로그인 access token 받아오기
   @RequestMapping("kakaologin.do")
   public ModelAndView getKakaoAccessToken(String code, HttpSession session) {
	  ModelAndView mv = new ModelAndView("redirect:kakaologinok.do");
	  
	  String reqURL = "https://kauth.kakao.com/oauth/token";
	  try {
		URL url = new URL(reqURL);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setDoOutput(true);
		conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));

		StringBuffer sb = new StringBuffer();
		sb.append("grant_type=authorization_code");
		sb.append("&client_id=4a601447a1662d2919cfc432b342bc38");
		sb.append("&redirect_uri=http://localhost:8090/kakaologin.do");
		sb.append("&code="+code);
		bw.write(sb.toString());
		bw.flush();
			
		int responseCode = conn.getResponseCode();

		if (responseCode == HttpURLConnection.HTTP_OK) {
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String line = "";
			StringBuffer sb2 = new StringBuffer();
			while ((line = br.readLine()) != null) {
				sb2.append(line);
			}
			String result = sb2.toString();
			// System.out.println(result);

			Gson gson = new Gson();
			KakaoVO kvo = gson.fromJson(result, KakaoVO.class);
			String access_token = kvo.getAccess_token();
			//String refresh_token = kvo.getRefresh_token();
			//String token_type = kvo.getToken_type();
			
			if(access_token != null) {
				session.setAttribute("access_token", access_token);
				mv.addObject("access_token", access_token);
				return mv;
			}
		 }
	 } catch (Exception e) {
		 System.out.println(e);
	 }
	 return null;
  }
   
   //네이버 로그인 access token 받아오기
   @RequestMapping("naverlogin.do")
 	public ModelAndView getNaverAccessToken(String code, HttpSession session) {
 		String reqURL = "https://nid.naver.com/oauth2.0/token";
 		
 		ModelAndView mv = new ModelAndView("redirect:naverloginok.do");
 		
 		try {
 			URL url = new URL(reqURL);
 			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

 			conn.setRequestMethod("POST");
 			conn.setDoOutput(true);
 			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

 			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));

 			StringBuffer sb = new StringBuffer();
 			sb.append("grant_type=authorization_code");
 			sb.append("&client_id=Yg5gbW0JV9cs8cbMiejA");
 			sb.append("&client_secret=N0wncgpOA_");
 			sb.append("&code="+code);
 			sb.append("&state=logintest");
 			bw.write(sb.toString());
 			bw.flush();

 			int responseCode = conn.getResponseCode();
 			if (responseCode == HttpURLConnection.HTTP_OK) {
 				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

 				String line = "";
 				StringBuffer sb2 = new StringBuffer();
 				while ((line = br.readLine()) != null) {
 					sb2.append(line);
 				}
 				String result = sb2.toString();
 				Gson gson = new Gson();
 				NaverVO nvo = gson.fromJson(result, NaverVO.class);
 				String access_token = nvo.getAccess_token();
 				//String refresh_token = nvo.getRefresh_token();
 				//String token_type = nvo.getToken_type();

 				if(access_token != null) {
 					session.setAttribute("access_token", access_token);
 					mv.addObject("access_token", access_token);
 					return mv;
 				}
 			}
 		} catch (Exception e) {
 			System.out.println(e);
 		}
 		return null;
 	}
	
	//네이버 로그아웃
	@RequestMapping("naverlogout2.do")
	public ModelAndView getSnsLogout(HttpSession session) {
		try {
			// session.invalidate();
			 session.removeAttribute("naverMemberInfo");
		     return new ModelAndView("home");
		   }catch (Exception e) {
		     return null;
		}
	}
	
	//카카오 로그아웃
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
	            
	            //session.invalidate();
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