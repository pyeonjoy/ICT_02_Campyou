package com.ict.campyou.hu.service;

import java.io.BufferedReader;

import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.google.gson.Gson;
import com.ict.campyou.hu.dao.MemberDAO;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.hu.sns.kakao.KakaoUserVO;
import com.ict.campyou.hu.sns.kakao.KakaoVO;
import com.ict.campyou.hu.sns.naver.NaverUserVO;
import com.ict.campyou.hu.sns.naver.NaverVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO memberDAO;

	@Override
	public int getSignUp(MemberVO vo) {
		return memberDAO.getSignUp(vo);
	}
	
	@Override
	public String getIdChk(String member_id){
		return memberDAO.getIdChk(member_id);
	}
	
	@Override
	public String getLogInIdChk(String member_id) {
		return memberDAO.getLogInIdChk(member_id);
	}

	@Override
	public MemberVO getLogInOK(MemberVO vo) {
		return memberDAO.getLogInOK(vo);
	}

	@Override
	public MemberVO getMyPwd(MemberVO mvo2) {
		return memberDAO.getMyPwd(mvo2);
	}

	@Override
	public int getTempPwdUpdate(MemberVO mvo) {
		return memberDAO.getTempPwdUpdate(mvo);
	}

	@Override
	public MemberVO getMyID(String member_name) {
		return memberDAO.getMyID(member_name);
	}

	@Override
	public String getNickNameChk(String member_nickname) {
		return memberDAO.getNickNameChk(member_nickname);
	}
	
	//카카오 로그인 access token 받아오기
	@Override
	public String getKakaoAccessToken(String code) {
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

				return access_token;
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	@Override
	public int getInsertKakaoId(String access_token) {
		 Map<String, String> map = new HashMap<String, String>();
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
	                String line = "";
	                StringBuffer sb = new StringBuffer();
	                while ((line = br.readLine()) != null) {
	                    sb.append(line);
	                }
	                String result = sb.toString();

	                Gson gson = new Gson();
	                KakaoUserVO kvo = gson.fromJson(result, KakaoUserVO.class);

	                String kakao_id = kvo.getId();
	                String kakao_nickname = kvo.getProperties().getNickname();
	                String kakao_email = kvo.getKakao_account().getEmail();
	                
	                //System.out.println(kakao_nickname);
	                // 카카오에서 제공하는 정보
	                map.put("member_id", kakao_id);
	                map.put("member_nickname", kakao_nickname);
	                map.put("member_email", kakao_email);
	                
	                // 카카오에서 제공하지 않는 정보
	                map.put("member_name", "Kakao: Not Provided");
	                map.put("member_pwd", "Kakao: Not Provided");
	                map.put("member_dob", "Kakao: Not Provided");
	                map.put("member_phone", "Kakao: Not Provided");   
	                
	               return memberDAO.getInsertKakaoId(map);               
	            }
	        } catch (Exception e) {
	        	System.out.println(e);
	        }
			return 0;
	}
	
	//카카오 로그인 회원정보 받아오기
	@Override
	public MemberVO getKakaoLogInOk(String access_token) {
		 Map<String, String> map = new HashMap<String, String>();
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
	                String line = "";
	                StringBuffer sb = new StringBuffer();
	                while ((line = br.readLine()) != null) {
	                    sb.append(line);
	                }
	                String result = sb.toString();

	                Gson gson = new Gson();
	                KakaoUserVO kvo = gson.fromJson(result, KakaoUserVO.class);

	                String kakao_id = kvo.getId();
	                String kakao_nickname = kvo.getProperties().getNickname();
	                String kakao_email = kvo.getKakao_account().getEmail();
	                
	                //System.out.println(kakao_nickname);
	                // 카카오에서 제공하는 정보
	                map.put("member_id", kakao_id);
	                map.put("member_nickname", kakao_nickname);
	                map.put("member_email", kakao_email);
	                
	                // 카카오에서 제공하지 않는 정보
	                map.put("member_name", "Kakao: Not Provided");
	                map.put("member_pwd", "Kakao: Not Provided");
	                map.put("member_dob", "Kakao: Not Provided");
	                map.put("member_phone", "Kakao: Not Provided");   
	                
	                return memberDAO.getKakaoLogInOk(map);
	            }
	        } catch (Exception e) {
	        	System.out.println(e);
	        }
			return null;
	    }
	
	
	
	//네이버 로그인 access token 받아오기
	@Override
	public String getNaverAccessToken(String code) {
		String reqURL = "https://nid.naver.com/oauth2.0/token";
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

				return access_token;
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	//네이버 회원 데이터베이스에 삽입
	@Override
	public int getInsertNaverId(String access_token) {
		Map<String, String> map = new HashMap<String, String>();
		
		String apiURL = "https://openapi.naver.com/v1/nid/me";
		try {
			URL url = new URL(apiURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
		
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setRequestProperty("Authorization", "Bearer " + access_token);
				
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
				//String naver_nickname = nvo.getResponse().getNickname();
				String naver_email = nvo.getResponse().getEmail();
				//String naver_mobile = nvo.getResponse().getMobile();
				String naver_name = nvo.getResponse().getName();
				//String naver_profile_image = nvo.getResponse().getProfile_image();
				
				map.put("member_id", naver_id);
				map.put("member_name", naver_name);
                map.put("member_email", naver_email);
                
                //네이버에서 제공하지 하는데 필요없는 정보
                map.put("member_nickname", "Naver: Not Provided");
                map.put("member_pwd", "Naver: Not Provided");
                map.put("member_dob", " Naver: Not Provided");
                map.put("member_phone", "Naver: Not Provided");

               return memberDAO.getInsertNaverId(map);
           
			}		
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;	
	}
	
	//네이버 로그인 회원정보 받아오기
	@Override
	public MemberVO getNaverLogInOk(String access_token) {
		Map<String, String> map = new HashMap<String, String>();
		
		String apiURL = "https://openapi.naver.com/v1/nid/me";
		try {
			URL url = new URL(apiURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
		
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setRequestProperty("Authorization", "Bearer " + access_token);
				
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
				//String naver_nickname = nvo.getResponse().getNickname();
				String naver_email = nvo.getResponse().getEmail();
				//String naver_mobile = nvo.getResponse().getMobile();
				String naver_name = nvo.getResponse().getName();
				//String naver_profile_image = nvo.getResponse().getProfile_image();
				
				map.put("member_id", naver_id);
				map.put("member_name", naver_name);
                map.put("member_email", naver_email);
                
                //네이버에서 제공하지 하는데 필요없는 정보
                map.put("member_nickname", "Naver: Not Provided");
                map.put("member_pwd", "Naver: Not Provided");
                map.put("member_dob", " Naver: Not Provided");
                map.put("member_phone", "Naver: Not Provided");
		
                //없으면 db 에 새로운 네이버 아이디 저장
                return memberDAO.getNaverLogInOk(map);
            
			}		
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;	
	}
}