package com.ict.campyou.hu.sns.naver;

import java.io.BufferedReader;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.ict.campyou.hu.service.MemberService;

@RestController
public class NaverAjaxController {
	
	@RequestMapping(value = "naverUser.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public  String memberChk(HttpSession session) {
	   
		String access_token = (String)session.getAttribute("access_token");
		
		String apiURL = "https://openapi.naver.com/v1/nid/me";
		
		try {
			URL url = new URL(apiURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			// POST �슂泥�
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			// �뿤�뜑 �슂泥�
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setRequestProperty("Authorization", "Bearer " +access_token);
				
			int responeseCode = conn.getResponseCode();
			if(responeseCode == HttpURLConnection.HTTP_OK) {
				BufferedReader br =
						new BufferedReader(new InputStreamReader(conn.getInputStream()));
				
				String line ="";
				StringBuffer sb = new StringBuffer();
				while((line=br.readLine()) !=null) {
					sb.append(line);
				}
				String result = sb.toString();
				
				Gson gson = new Gson();
				NaverUserVO nvo = gson.fromJson(result, NaverUserVO.class);
				 
				String naver_id = nvo.getResponse().getId();
				String naver_nickname = nvo.getResponse().getNickname();
				String naver_email = nvo.getResponse().getEmail();
				String naver_mobile = nvo.getResponse().getMobile();
				String naver_name = nvo.getResponse().getName();
				String naver_profile_image = nvo.getResponse().getProfile_image();
				
				return naver_id+"/"+naver_nickname+"/"+naver_email+"/"+naver_mobile+"/"+naver_name+"/"+naver_profile_image;
				
			}
			
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	

}

































