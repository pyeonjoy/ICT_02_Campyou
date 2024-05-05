package com.ict.campyou.hs.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HsAjaxController {

	@RequestMapping(value="camp_search_box_SiDo_json.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public String campSearchBoxLocalSiDo() {
		BufferedReader rd = null;
		HttpURLConnection conn = null;
		try {
			
			StringBuilder urlBuilder = new StringBuilder("https://api.vworld.kr/req/data");
			urlBuilder.append("?" + URLEncoder.encode("service", "UTF-8") + "=" + URLEncoder.encode("data", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("request", "UTF-8") + "=" + URLEncoder.encode("GetFeature", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("format", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("errorformat", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); // 수정된 부분
			urlBuilder.append("&" + URLEncoder.encode("size", "UTF-8") + "=" + URLEncoder.encode("17", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("data", "UTF-8") + "=" + URLEncoder.encode("LT_C_ADSIDO_INFO", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("geomfilter", "UTF-8") + "=" + URLEncoder.encode("BOX(124,33,132,43)", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("geometry", "UTF-8") + "=" + URLEncoder.encode("false", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("attribute", "UTF-8") + "=" + URLEncoder.encode("true", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("domain", "UTF-8") + "=" + URLEncoder.encode("http://localhost:8090", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("key", "UTF-8") + "=" + URLEncoder.encode("A4DEB3AF-CF6C-3C1F-A621-6F1447049467", "UTF-8"));
			URL url = new URL(urlBuilder.toString());
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");

			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
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
	
	
	@RequestMapping(value="camp_search_box_SiGunGu_json.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public String campSearchBoxLocalSiGunGu(String sido_selected) {
		BufferedReader rd = null;
		HttpURLConnection conn = null;
		try {
			System.out.println("11" + sido_selected);
			StringBuilder urlBuilder = new StringBuilder("https://api.vworld.kr/req/data");
			urlBuilder.append("?" + URLEncoder.encode("service", "UTF-8") + "=" + URLEncoder.encode("data", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("request", "UTF-8") + "=" + URLEncoder.encode("GetFeature", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("format", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("size", "UTF-8") + "=" + URLEncoder.encode("50", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("data", "UTF-8") + "=" + URLEncoder.encode("LT_C_ADSIGG_INFO", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("attrFilter", "UTF-8") + "=" + URLEncoder.encode("full_nm:like:", "UTF-8") + URLEncoder.encode(sido_selected, "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("geometry", "UTF-8") + "=" + URLEncoder.encode("false", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("domain", "UTF-8") + "=" + URLEncoder.encode("http://localhost:8090", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("key", "UTF-8") + "=" + URLEncoder.encode("A4DEB3AF-CF6C-3C1F-A621-6F1447049467", "UTF-8"));
			URL url = new URL(urlBuilder.toString());
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			
			System.out.println(urlBuilder);
			System.out.println(sb);
			
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
