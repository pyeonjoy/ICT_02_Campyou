package com.ict.campyou.bjs.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.ict.campyou.bjs.dao.PromiseVO;
import com.ict.campyou.bjs.dao.TogetherVO;
import com.ict.campyou.bjs.service.TogetherService;
import com.ict.campyou.common.Paging2;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.jun.dao.CampVO;

@RestController
public class TogetherAjaxController {
	@Autowired
	private TogetherService togetherService;
	@Autowired
	private Paging2 paging;

	@RequestMapping(value = "together_Write2.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String getTogetherWrite(TogetherVO tvo, HttpSession session) throws Exception{
		List<CampVO> campList = togetherService.getTogetherCampList();
		if(campList != null) {
			Gson gson = new Gson();
			String jsonCampList = gson.toJson(campList);
			return jsonCampList;
		}
		return "fail";
	}
	
	@RequestMapping(value = "together_Write_ok.do", produces = "application/plain; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String getTogetherWriteOK(TogetherVO tvo, HttpSession session, HttpServletResponse response) throws Exception{
		MemberVO memberUser = (MemberVO) session.getAttribute("memberInfo");
//		System.out.println(tvo.getT_content());
		if(memberUser != null) {
			tvo.setMember_idx(memberUser.getMember_idx());
			int result = togetherService.getTogetherWriteOK(tvo);
			if(result > 0) {
				PromiseVO pvo = new PromiseVO();
				pvo.setT_idx(String.valueOf(result));
				pvo.setMember_idx(tvo.getMember_idx());
				int promiseUpdate = togetherService.getPromiseUpdate(pvo);
				return String.valueOf(result);
			}
		}
		return "0" ;
	}
	
	@RequestMapping(value = "searchCamp.do", produces = "application/plain; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String getSearchCamp(@RequestParam("campName") String campName) throws Exception{
		String result = "";
		if(campName != null) {
			campName = campName.replaceAll("\\s", "").toLowerCase();
			result = togetherService.getSearchCamp(campName);
			if(result.equals("ok")) {
				CampVO campDetail = togetherService.getSearchCampDetail(campName);
				if(campDetail != null) {
					Gson gson = new Gson();
					String jsoncampDetail = gson.toJson(campDetail);
					return jsoncampDetail;
				}
			}
		}
		return result;
	}
	
	@RequestMapping(value = "to_promise_chk.do", produces = "application/plain; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String getPromiseChk(PromiseVO pvo, HttpSession session) throws Exception{
		MemberVO memberUser = (MemberVO) session.getAttribute("memberInfo");
		if(memberUser == null) {
			return "";
		}else if(memberUser.getMember_idx().equals(pvo.getMember_idx())) {
			return "me";
		}else {
			pvo.setMember_idx(memberUser.getMember_idx());
			int promiseChk = togetherService.getPromiseChk(pvo);
			if(promiseChk > 0) {
				return "ok";
			}else {
				return "no";
			}
		}
//		return "";
	}
	
	@RequestMapping(value = "to_promise.do", produces = "application/plain; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String getToPomise(PromiseVO pvo, HttpSession session) throws Exception{
		MemberVO memberUser = (MemberVO) session.getAttribute("memberInfo");
        if (memberUser == null) {
            return "로그인 후 가능합니다.";
        } else {
        	int result = togetherService.getToPomise(pvo);
        	if(result > 0) {
        		int pvo2 = togetherService.getPomiseCount(pvo.getT_idx());
        		return String.valueOf(pvo2);
        	}
        }
		return "error";
    }
	
	@RequestMapping(value = "to_promise_cancel.do", produces = "application/plain; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String getToPomiseCancel(PromiseVO pvo, HttpSession session) throws Exception{
//		MemberVO memberUser = (MemberVO) session.getAttribute("memberInfo");
		if (pvo.getMember_idx() != null && pvo.getT_idx() != null) {
			int result = togetherService.getToPomiseCancel(pvo);
			if(result > 0) {
				int pvo2 = togetherService.getPomiseCount(pvo.getT_idx());
        		return String.valueOf(pvo2);
			}
		} 
		return "error";
	}
	
	@RequestMapping(value = "together_update_ok.do", produces = "application/plain; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String getTogetherUpdateOK(TogetherVO tvo) throws Exception{
		int result = togetherService.getTogetherUpdateOK(tvo);
		if(result > 0) {
			return tvo.getT_idx();
		}
		return "error" ;
	}
}