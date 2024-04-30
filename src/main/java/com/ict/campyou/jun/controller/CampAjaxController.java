package com.ict.campyou.jun.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CampAjaxController {

	
	@RequestMapping(value = "camp_list.do", produces="text/xml; charset=utf-8")
	@ResponseBody
	public String Camp_list(@RequestParam(defaultValue = "1") int pageNo) {
	    BufferedReader rd = null;
	    HttpURLConnection conn = null;
		try {
			// contentId  = 캠핑장 고유 번호
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B551011/GoCamping/basedList"); //캠핑리스트 불러오기
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=" + URLEncoder.encode("X0kmMKfzM75AstLAvFpYYUYZ618haU808lrytcOmk+MX27oB2z1ds+qlA6/vupBqS2tNWmLuRfjricCDf+GZ/g==", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("MobileOS","UTF-8") + "=" + URLEncoder.encode("WIN", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("MobileApp","UTF-8") + "=" + URLEncoder.encode("CampYou", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&pageNo=" + pageNo);
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
        URL url = new URL(urlBuilder.toString());
        conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
    
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
        return sb.toString();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			  try {
				rd.close();
				conn.disconnect();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
        return null;
	}
	@RequestMapping(value = "camp_list_search.do", produces="text/xml; charset=utf-8")
	@ResponseBody
	public String Camp_list_keyword(@RequestParam(defaultValue = "1") int pageNo,@RequestParam String keyword) {
	    BufferedReader rd = null;
	    HttpURLConnection conn = null;
		try {
			// contentId  = 캠핑장 고유 번호
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B551011/GoCamping/searchList"); //캠핑리스트 불러오기
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=" + URLEncoder.encode("X0kmMKfzM75AstLAvFpYYUYZ618haU808lrytcOmk+MX27oB2z1ds+qlA6/vupBqS2tNWmLuRfjricCDf+GZ/g==", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("MobileOS","UTF-8") + "=" + URLEncoder.encode("WIN", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("MobileApp","UTF-8") + "=" + URLEncoder.encode("CampYou", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&keyword=" + URLEncoder.encode(keyword, "UTF-8"));
        urlBuilder.append("&pageNo=" + pageNo);
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
        URL url = new URL(urlBuilder.toString());
        conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
    
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
        return sb.toString();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			  try {
				rd.close();
				conn.disconnect();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
        return null;
	}
	@RequestMapping(value = "camp_detail_img.do", produces="text/xml; charset=utf-8")
	@ResponseBody
	public String Camp_detail_img(@RequestParam() String contentid) {
		System.out.println(contentid);
	    BufferedReader rd = null;
	    HttpURLConnection conn = null;
		try {
			// contentId  = 캠핑장 고유 번호
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B551011/GoCamping/imageList"); // 이미지 리스트
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=" + URLEncoder.encode("X0kmMKfzM75AstLAvFpYYUYZ618haU808lrytcOmk+MX27oB2z1ds+qlA6/vupBqS2tNWmLuRfjricCDf+GZ/g==", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("20", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("MobileOS","UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("MobileApp","UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("contentId","UTF-8") + "=" + URLEncoder.encode(contentid, "UTF-8")); /*캠핑장고유번호*/
        URL url = new URL(urlBuilder.toString());
        System.out.println(url);
        conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
    
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
        return sb.toString();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			  try {
				rd.close();
				conn.disconnect();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
        return null;
	}
	
}
