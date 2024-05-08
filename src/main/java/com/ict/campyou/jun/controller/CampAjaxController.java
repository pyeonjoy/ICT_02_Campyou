package com.ict.campyou.jun.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.jun.dao.ReviewVO;
import com.ict.campyou.jun.service.CampService;

@RestController
public class CampAjaxController {

	@Autowired
	private CampService campService;

	@RequestMapping(value = "camp_list.do", produces = "text/xml; charset=utf-8")
	@ResponseBody
	public String Camp_list(@RequestParam(defaultValue = "1") int pageNo) {
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
			urlBuilder.append("&" + URLEncoder.encode("MobileOS", "UTF-8") + "="
					+ URLEncoder.encode("WIN", "UTF-8")); /* 한 페이지 결과 수 */
			urlBuilder.append("&" + URLEncoder.encode("MobileApp", "UTF-8") + "="
					+ URLEncoder.encode("CampYou", "UTF-8")); /* 한 페이지 결과 수 */
			urlBuilder.append("&pageNo=" + pageNo);
			urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "="
					+ URLEncoder.encode("10", "UTF-8")); /* 한 페이지 결과 수 */
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

	@RequestMapping(value = "camp_list_search.do", produces = "text/xml; charset=utf-8")
	@ResponseBody
	public String Camp_list_keyword(@RequestParam(defaultValue = "1") int pageNo, @RequestParam String keyword) {
		BufferedReader rd = null;
		HttpURLConnection conn = null;
		try {
			// contentId = 캠핑장 고유 번호
			StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B551011/GoCamping/searchList"); // 캠핑리스트
																													// 불러오기
			urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "="
					+ URLEncoder.encode(
							"X0kmMKfzM75AstLAvFpYYUYZ618haU808lrytcOmk+MX27oB2z1ds+qlA6/vupBqS2tNWmLuRfjricCDf+GZ/g==",
							"UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("MobileOS", "UTF-8") + "="
					+ URLEncoder.encode("WIN", "UTF-8")); /* 한 페이지 결과 수 */
			urlBuilder.append("&" + URLEncoder.encode("MobileApp", "UTF-8") + "="
					+ URLEncoder.encode("CampYou", "UTF-8")); /* 한 페이지 결과 수 */
			urlBuilder.append("&keyword=" + URLEncoder.encode(keyword, "UTF-8"));
			urlBuilder.append("&pageNo=" + pageNo);
			urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "="
					+ URLEncoder.encode("10", "UTF-8")); /* 한 페이지 결과 수 */
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

	@RequestMapping(value = "camp_detail_img.do", produces = "text/xml; charset=utf-8")
	@ResponseBody
	public String Camp_detail_img(@RequestParam() String contentid) {
		BufferedReader rd = null;
		HttpURLConnection conn = null;
		try {
			// contentId = 캠핑장 고유 번호
			StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B551011/GoCamping/imageList"); // 이미지
																												// 리스트
			urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "="
					+ URLEncoder.encode(
							"X0kmMKfzM75AstLAvFpYYUYZ618haU808lrytcOmk+MX27oB2z1ds+qlA6/vupBqS2tNWmLuRfjricCDf+GZ/g==",
							"UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "="
					+ URLEncoder.encode("8", "UTF-8")); /* 한 페이지 결과 수 */
			urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "="
					+ URLEncoder.encode("1", "UTF-8")); /* 한 페이지 결과 수 */
			urlBuilder.append("&" + URLEncoder.encode("MobileOS", "UTF-8") + "="
					+ URLEncoder.encode("ETC", "UTF-8")); /* 한 페이지 결과 수 */
			urlBuilder.append("&" + URLEncoder.encode("MobileApp", "UTF-8") + "="
					+ URLEncoder.encode("AppTest", "UTF-8")); /* 한 페이지 결과 수 */
			urlBuilder.append("&" + URLEncoder.encode("contentId", "UTF-8") + "="
					+ URLEncoder.encode(contentid, "UTF-8")); /* 캠핑장고유번호 */
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

	@RequestMapping(value = "addReview.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String addReview(@RequestBody ReviewVO rvo, HttpSession session) {
		MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
		rvo.setMember_idx(mvo.getMember_idx());
		rvo.setMember_nickname(mvo.getMember_nickname());
		int res = campService.addReview(rvo);
		if (res > 0) {
			return String.valueOf(res);
		}
		return "error";
	}

	@RequestMapping(value = "loadReview.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public List<ReviewVO> loadReview(@RequestParam() String contentid) {
	    List<ReviewVO> res = campService.loadReview(contentid);
	    if (res == null) {
	        return Collections.emptyList();
	    } else {
	        return res;
	    }
	}


	@RequestMapping(value = "checkHeart.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String checkHeart(@RequestParam()String contentid, HttpSession session) {
	    MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
	    if (mvo == null) {
	        return ("hu/loginForm");
	    } else {
	        String member_idx = mvo.getMember_idx();
	        String chkHeart = campService.checkHeart(contentid, member_idx);
	        if (chkHeart != null) {
	            return "false";
	        } else {
	        	return "true";
	        }
	    }
	}

	
	
	
	@RequestMapping(value = "addHeart.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String addHeart(@RequestParam() String contentid, HttpSession session) {
	    MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
	    String member_idx = mvo.getMember_idx();
	    String chkHeart = campService.checkHeart(contentid, member_idx);
	    if (chkHeart == null) {
	        int result = campService.addHeart(contentid, member_idx);
	        return String.valueOf(result);
	    } else {
	    	return "error";
	    }
	}
	
	@RequestMapping(value = "delHeart.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String delHeart(@RequestParam()String contentid, HttpSession session) {
		MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
		String member_idx = mvo.getMember_idx();
		int delHeart = campService.delHeart(contentid,member_idx);
		if (delHeart > 0) {
			return String.valueOf(delHeart);
		}
		return "error";
	}

}
