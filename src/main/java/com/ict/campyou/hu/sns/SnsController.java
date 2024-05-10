package com.ict.campyou.hu.sns;

import java.io.BufferedReader;

import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.json.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.ict.campyou.hu.sns.kakao.KakaoVO;
import com.ict.campyou.hu.sns.naver.NaverVO;
@Controller
public class SnsController {

	@Autowired
	private AddrDAO addrDAO ;
	
	@RequestMapping("spring_sns_go.do")
	public ModelAndView getSpringSnsGo() {
		return new ModelAndView("sns/loginForm");
	}

	@RequestMapping("kakaologin.do")
	public ModelAndView KakaoLogIn(HttpServletRequest request) {
		// 1. �씤利앹퐫�뱶 諛쏄린
		String code = request.getParameter("code");
		// System.out.println("code : " + code);

		// 2. �넗�겙 諛쏄린 (�씤利앹퐫�뱶�븘�슂)
		String reqURL = "https://kauth.kakao.com/oauth/token";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// POST �슂泥�
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			// �뿤�뜑 �슂泥�
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

			// 蹂몃Ц
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));

			StringBuffer sb = new StringBuffer();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=4a601447a1662d2919cfc432b342bc38");
			sb.append("&redirect_uri=http://localhost:8090/kakaologin.do");
			sb.append("&code="+code);
			bw.write(sb.toString());
			bw.flush();

			// 寃곌낵 肄붾뱶媛� 200�씠硫� �꽦怨�
			int responseCode = conn.getResponseCode();

			if (responseCode == HttpURLConnection.HTTP_OK) {
				// �넗�겙�슂泥��쓣 �넻�븳 寃곌낵瑜� �뼸�뒗�뜲 JSON ���엯
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

				String line = "";
				StringBuffer sb2 = new StringBuffer();
				while ((line = br.readLine()) != null) {
					sb2.append(line);
				}
				String result = sb2.toString();
				// System.out.println(result);

				// 諛쏅뒗 �젙蹂대뒗 session ���옣 ( ajax瑜� �궗�슜�빐�꽌 �궗�슜�옄�젙蹂대�� 媛��졇�삩�떎.)
				Gson gson = new Gson();
				KakaoVO kvo = gson.fromJson(result, KakaoVO.class);
				// System.out.println(kvo.getAccess_token());
				// System.out.println(kvo.getRefresh_token());
				// System.out.println(kvo.getToken_type());
				request.getSession().setAttribute("access_token", kvo.getAccess_token());
				request.getSession().setAttribute("refresh_token", kvo.getRefresh_token());
				request.getSession().setAttribute("token_type", kvo.getToken_type());

				return new ModelAndView("hu/sns/result");
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return new ModelAndView("hu/sns/error");

	}

	@RequestMapping("naverlogin.do")
	public ModelAndView NaverLogin(HttpServletRequest request) {
		String code = request.getParameter("code");
		String state = request.getParameter("state");

		// 2. �넗�겙 諛쏄린 (�씤利앹퐫�뱶�븘�슂)
		String reqURL = "https://nid.naver.com/oauth2.0/token";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// POST �슂泥�
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			// �뿤�뜑 �슂泥�
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

			// 蹂몃Ц
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));

			StringBuffer sb = new StringBuffer();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=Yg5gbW0JV9cs8cbMiejA");
			sb.append("&client_secret=N0wncgpOA_");
			sb.append("&code="+code);
			sb.append("&state=logintest");
			bw.write(sb.toString());
			bw.flush();

			// 寃곌낵 肄붾뱶媛� 200�씠硫� �꽦怨�
			int responseCode = conn.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) {
				// �넗�겙�슂泥��쓣 �넻�븳 寃곌낵瑜� �뼸�뒗�뜲 JSON ���엯
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

				String line = "";
				StringBuffer sb2 = new StringBuffer();
				while ((line = br.readLine()) != null) {
					sb2.append(line);
				}
				String result = sb2.toString();
				
				Gson gson = new Gson();
				NaverVO nvo = gson.fromJson(result, NaverVO.class);
				request.getSession().setAttribute("access_token", nvo.getAccess_token());
				request.getSession().setAttribute("token_type", nvo.getToken_type());
				request.getSession().setAttribute("refresh_token", nvo.getRefresh_token());

				return new ModelAndView("hu/sns/result2");
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return new ModelAndView("hu/sns/error");
	}

     //	�꽕�씠踰� 濡쒓렇�븘�썐 
	@RequestMapping("naverlogout.do")
	public ModelAndView getNaverLogout(HttpSession session) {
		session.invalidate();
	   return new ModelAndView("hu/loginForm");
	}
	
	// �꽕�씠踰� �꽌鍮꾩뒪 �빐�젣 
	@RequestMapping("naverlogout2.do")
	public ModelAndView getSnsLogout(HttpSession session) {
		// �뿰�룞�빐�젣
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

			// 寃곌낵 肄붾뱶媛� 200 �씠硫� �꽦怨�
			int responseCode = conn.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) {

				// �넗�겙 �슂泥��쓣 �넻�븳 寃곌낵瑜� �뼸�뒗�뜲 JSON ���엯�씠�떎.
				BufferedReader br = 
						new BufferedReader(new InputStreamReader(conn.getInputStream()));

				String line = "";
				StringBuffer sb = new StringBuffer();
				while ((line = br.readLine()) != null) {
					sb.append(line);
				}
				String result = sb.toString();
				System.out.println(result);
		     // �꽭�뀡 珥덇린�솕
		     session.invalidate();
		     // �떎�떆 濡쒓렇�씤 �뤌�쑝濡�
		     return new ModelAndView("hu/loginForm");
		   }
		} catch (Exception e) {
		}
		return null;
	}

	// 移댁뭅�삤 濡쒓렇�븘�썐
	@RequestMapping("kakaologout.do")
	public ModelAndView getKakaoLogout(HttpSession session) {
		session.invalidate();
		return new ModelAndView("hu/loginForm");
	}
}















