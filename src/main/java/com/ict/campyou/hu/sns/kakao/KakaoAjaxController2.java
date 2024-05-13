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

import com.google.gson.Gson;

import java.util.HashMap;
import java.util.Map;

@RestController
public class KakaoAjaxController2 {
    
    @RequestMapping(value = "kakaoUser2.do", produces = "text/plain; charset=utf-8")
    @ResponseBody
    public Map<String, String> memberChk(HttpSession session) {
        Map<String, String> userInfo = new HashMap<String, String>();
        
        String access_token = (String) session.getAttribute("access_token");
        String apiURL = "https://kapi.kakao.com/v2/user/me";
        
        try {
            URL url = new URL(apiURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            
            conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
            conn.setRequestProperty("Authorization", "Bearer " + access_token);
            
            int responseCode = conn.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String line="";
                StringBuffer sb = new StringBuffer();
                while((line=br.readLine()) != null) {
                    sb.append(line);
                }
                String result = sb.toString();
                
                Gson gson = new Gson();
                KakaoUserVO kvo = gson.fromJson(result, KakaoUserVO.class);
                
                String kakao_id = kvo.getId();
                String kakao_nickname = kvo.getProperties().getNickname();
                String kakao_email = kvo.getKakao_account().getEmail();
                
                // Map에 사용자 정보 추가
                userInfo.put("kakao_id", kakao_id);
                userInfo.put("kakao_nickname", kakao_nickname);
                userInfo.put("kakao_email", kakao_email);
                
                System.out.println(kakao_id);
                System.out.println(kakao_nickname);
                System.out.println(kakao_email);
                return userInfo;
            }
            
        } catch (Exception e) {
            System.out.println(e);
        }
        
        return null;
    }
}
