package com.ict.campyou.hs.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ict.campyou.hs.service.HsService;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.jun.dao.CampVO;

@Controller
public class HsAjaxController {
	@Autowired
	private HsService hsService;

	@RequestMapping(value = "camp_search_box_sido.do", produces = "text/xml; charset=utf-8")
	@ResponseBody
	public String campSearchBoxLocalSido() {
		try {
			List<CampVO> local = hsService.getLocalKeyword();
			List<String> sidolist = new ArrayList<String>();
			for (CampVO i : local) {
				if (!sidolist.contains(i.getDonm())) {
					sidolist.add(i.getDonm());
				}
			}

			StringBuffer sb = new StringBuffer();
			sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
			sb.append("<sidolist>");
			for (String i : sidolist) {
				sb.append("<sido>" + i + "</sido>");
			}
			sb.append("</sidolist>");
			return sb.toString();
		} catch (Exception e) {
			System.out.println(e);
		}
		return "fail";
	}

	@RequestMapping(value = "camp_search_box_sigungu.do", produces = "text/xml; charset=utf-8")
	@ResponseBody
	public String campSearchBoxLocalSigungu() {
		try {
			List<CampVO> local = hsService.getLocalKeyword();
			List<String> sidolist = new ArrayList<String>();

			StringBuffer sb = new StringBuffer();
			for (CampVO i : local) {
				if (!sidolist.contains(i.getDonm())) {
					sidolist.add(i.getDonm());
				}
			}

			sb.append("<locallist>");
			for (String k : sidolist) {
				sb.append("<" + k + ">");
				for (CampVO i : local) {
					if (k.equals(i.getDonm()) && !i.getSigungunm().isEmpty()) {
						sb.append("<sigungu>" + i.getSigungunm() + "</sigungu>");
					}
				}
				sb.append("</" + k + ">");
			}
			sb.append("</locallist>");
			return sb.toString();
		} catch (Exception e) {
			System.out.println(e);
		}
		return "fail";
	}

	@RequestMapping(value = "camp_list_keyword_detail.do", produces = "text/xml; charset=utf-8")
	@ResponseBody
	public String campListKeywordDetail(@RequestParam(defaultValue = "1") int pageNo, @RequestParam int numOfRows,
			@RequestParam String keyword) {
		BufferedReader rd = null;
		HttpURLConnection conn = null;
		try {

			StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B551011/GoCamping/searchList"); // 캠핑리스트
			// 불러오기
			urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "="
					+ URLEncoder.encode(
							"X0kmMKfzM75AstLAvFpYYUYZ618haU808lrytcOmk+MX27oB2z1ds+qlA6/vupBqS2tNWmLuRfjricCDf+GZ/g==",
							"UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("WIN", "UTF-8"));
			urlBuilder.append(
					"&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("CampYou", "UTF-8"));
			urlBuilder.append("&keyword=" + URLEncoder.encode(keyword, "UTF-8"));
			urlBuilder.append("&pageNo=" + pageNo);
			urlBuilder.append("&numOfRows=" + numOfRows);
			URL url = new URL(urlBuilder.toString());
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
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

	@RequestMapping(value = "camp_list_in_ms.do", produces = "text/xml; charset=utf-8")
	@ResponseBody
	public String campListInMapSearch(@RequestParam(defaultValue = "1") int pageNo, @RequestParam int numOfRows) {
		BufferedReader rd = null;
		HttpURLConnection conn = null;
		try {
			// contentId = 캠핑장 고유 번호
			StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B551011/GoCamping/basedList"); // 캠핑리스트
																												// 불러오기
			urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "="
					+ URLEncoder.encode(
							"X0kmMKfzM75AstLAvFpYYUYZ618haU808lrytcOmk+MX27oB2z1ds+qlA6/vupBqS2tNWmLuRfjricCDf+GZ/g==",
							"UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("WIN", "UTF-8"));
			urlBuilder.append(
					"&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("CampYou", "UTF-8"));
			urlBuilder.append("&pageNo=" + pageNo);
			urlBuilder.append("&numOfRows=" + numOfRows); /* 한 페이지 결과 수 */
			URL url = new URL(urlBuilder.toString());
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");

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

	@RequestMapping(value = "get_weather_3.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String getWeather(@RequestParam String regId) {
		BufferedReader rd = null;
		HttpURLConnection conn = null;
		StringBuilder sb = new StringBuilder();
		String line;
		try {
			StringBuilder urlBuilder = new StringBuilder("https://apis.data.go.kr/1360000/VilageFcstMsgService/getLandFcst");
			urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "="
					+ URLEncoder.encode("C51tJPloTgwrDfnsjWgf/huwUaxCo2qE18OpibrJm6hyCConEt3v8OLGVW0aCEnoBla46Q6PFDCScG1tZ/cumw==", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("10", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("dataType", "UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8"));
			urlBuilder.append("&" + "regId=" + regId);
			URL url = new URL(urlBuilder.toString());
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			
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
	
	@RequestMapping(value = "get_weather_10tem.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String getWeather10(@RequestParam String regId, @RequestParam String tmFc) {
		BufferedReader rd = null;
		HttpURLConnection conn = null;
		StringBuilder sb = new StringBuilder();
		String line;
		
		try {
			StringBuilder urlBuilder = new StringBuilder("https://apis.data.go.kr/1360000/MidFcstInfoService/getMidTa");
			urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "="
					+ URLEncoder.encode("C51tJPloTgwrDfnsjWgf/huwUaxCo2qE18OpibrJm6hyCConEt3v8OLGVW0aCEnoBla46Q6PFDCScG1tZ/cumw==", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("10", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("dataType", "UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8"));
			urlBuilder.append("&" + "regId=" + regId);
			urlBuilder.append("&" + "tmFc=" + tmFc);
			URL url = new URL(urlBuilder.toString());
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			
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
	
	
	@RequestMapping(value = "get_weather_10wf.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String getWeather10wf(@RequestParam String regId, @RequestParam String tmFc) {
		BufferedReader rd = null;
		HttpURLConnection conn = null;
		StringBuilder sb = new StringBuilder();
		String line;
		try {
			StringBuilder urlBuilder = new StringBuilder("https://apis.data.go.kr/1360000/MidFcstInfoService/getMidLandFcst");
			urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "="
					+ URLEncoder.encode("C51tJPloTgwrDfnsjWgf/huwUaxCo2qE18OpibrJm6hyCConEt3v8OLGVW0aCEnoBla46Q6PFDCScG1tZ/cumw==", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("10", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("dataType", "UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8"));
			urlBuilder.append("&" + "regId=" + regId);
			urlBuilder.append("&" + "tmFc=" + tmFc);
			URL url = new URL(urlBuilder.toString());
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			
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

	@RequestMapping(value = "getProfile.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public MemberVO getProfile(@RequestParam String member_idx) {
		try {
			MemberVO mvo = hsService.getMember(member_idx);
			return mvo;
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

}
