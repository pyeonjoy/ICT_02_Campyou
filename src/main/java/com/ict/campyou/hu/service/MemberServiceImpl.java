package com.ict.campyou.hu.service;

import java.io.BufferedReader;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.google.gson.Gson;
import com.ict.campyou.hu.dao.CommBoardVO;
import com.ict.campyou.hu.dao.MemberDAO;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.hu.sns.kakao.KakaoUserVO;
import com.ict.campyou.hu.sns.naver.NaverUserVO;

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
	
	//카카오 회원 insert 하기
	@Override
	public int getInsertKakaoId(HttpSession session) {
		String access_token = (String) session.getAttribute("access_token");
		
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
	                
	                
	                //카카오 맴버 데이터베이스에 존재하나 체크
	                MemberVO mvo = memberDAO.getKakaoMemberById(map);
	                
	                //존재하지 않으면 insert
	                if(mvo == null){
	                	return memberDAO.getInsertKakaoId(map);
	                }
	            }
	        } catch (Exception e) {
	        	System.out.println(e);
	        }
			return 0;
	}
	
	//카카오 로그인 회원정보 받아오기
	@Override
	public MemberVO getKakaoLogInOk(HttpSession session) {
		 Map<String, String> map = new HashMap<String, String>();
	        String apiURL = "https://kapi.kakao.com/v2/user/me";
	        
	        String access_token = (String) session.getAttribute("access_token");
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
	                
	                //카카오 로그인
	                return memberDAO.getKakaoLogInOk(map);
	            }
	        } catch (Exception e) {
	        	System.out.println(e);
	        }
			return null;
	    }
	
	//네이버 회원 insert 하기
	@Override
	public int getInsertNaverId(HttpSession session) {
		Map<String, String> map = new HashMap<String, String>();
		
		String access_token = (String) session.getAttribute("access_token");
		
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
                
               //네이버 맴버 데이터베이스에 존재하나 체크
               MemberVO mvo = memberDAO.getNaverMemberById(map);
               //존재하지 않으면 insert
               if(mvo == null) {
            	   return memberDAO.getInsertNaverId(map);
               }
			}		
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;	
	}
	
	//네이버 로그인 회원정보 받아오기
	@Override
	public MemberVO getNaverLogInOk(HttpSession session) {
		Map<String, String> map = new HashMap<String, String>();
		
		String access_token = (String) session.getAttribute("access_token");
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
		
                //네이버 로그인
                return memberDAO.getNaverLogInOk(map);
            
			}		
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;	
	}
	
	//자유 게시판과 캠핑게시판 글쓸때 마다 member_free 등급 올리기
	@Override
	public int getMemberFreeUpdate(String member_idx) {
		return memberDAO.getMemberFreeUpdate(member_idx);
	}

	@Override
	public int getUpdateMemberGrade(String member_idx) {
		
		return memberDAO.getUpdateMemberGrade(member_idx);
	}

	@Override
	public int getUpdateMemberGrade2(String member_idx) {
		// TODO Auto-generated method stub
		return memberDAO.getUpdateMemberGrade2(member_idx);
	}

	@Override
	public int getUpdateMemberGrade3(String member_idx) {
		// TODO Auto-generated method stub
		return memberDAO.getUpdateMemberGrade3(member_idx);
	}

	@Override
	public int getUpdateMemberGrade4(String member_idx) {
		// TODO Auto-generated method stub
		return memberDAO.getUpdateMemberGrade4(member_idx);
	}

	@Override
	public int getUpdateMemberGrade5(String member_idx) {
		// TODO Auto-generated method stub
		return memberDAO.getUpdateMemberGrade5(member_idx);
	}
	
	
	
	
	//맴버 디테일
	@Override
	public MemberVO getMemeberDetail(String member_idx) {
		
		return memberDAO.getMemeberDetail(member_idx);
	}

	
}