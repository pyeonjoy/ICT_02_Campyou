package com.ict.campyou.bjs.controller;

import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.ict.campyou.bjs.dao.PromiseVO;
import com.ict.campyou.bjs.dao.TogetherVO;
import com.ict.campyou.bjs.dao.TogetherCommentVO;
import com.ict.campyou.bjs.service.TogetherService;
import com.ict.campyou.common.Paging2;
import com.ict.campyou.common.Paging4;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.jun.dao.CampVO;

@RestController
public class TogetherAjaxController {
	@Autowired
	private TogetherService togetherService;
	
	@Autowired
	private Paging4 paging;
	@Autowired
	private Paging2 paging2;

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
	
	@RequestMapping(value = "promiseApplyList.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public List<PromiseVO> getPromiseApplyList(String member_idx) throws Exception {
		List<PromiseVO> result = togetherService.getPromiseList(member_idx);
		if(result != null) {
			for (PromiseVO list : result) {
//				System.out.println("Promise: " + list.getT_idx()); 
//				System.out.println("Promise: " + list.getMember_nickname());
//				System.out.println("Promise: " + list.getPm_idx()); 
//				System.out.println("Promise: " + list.getTf_name());
				LocalDate dob = LocalDate.parse(list.getMember_dob());
				LocalDate currentDate = LocalDate.now();
				int age = Period.between(dob, currentDate).getYears();
				
				String ageGroup;
				switch (age / 10) {
				case 0: ageGroup = "10대 미만"; break;
				case 1: ageGroup = "10대"; break;
				case 2: ageGroup = "20대"; break;
				case 3: ageGroup = "30대"; break;
				case 4: ageGroup = "40대"; break;
				case 5: ageGroup = "50대 이상"; break;
				case 6: ageGroup = "60대 이상"; break;
				case 7: ageGroup = "70대 이상"; break;
				default: ageGroup = "80대 이상"; break;
				}
				list.setMember_dob(ageGroup);
				int promiseCount = togetherService.getPromiseMyCount(list.getMember_idx());
				System.out.println(promiseCount);
				list.setPromise_count(promiseCount);
			}
		}
		return result;
    }
	
	@RequestMapping(value = "acceptPromise.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public int getAcceptPromise(String pm_idx) throws Exception {
		int result = togetherService.getAcceptPromise(pm_idx);
		if(result > 0) {
			return result;
		}
		return -1;
	}
	
	@RequestMapping(value = "declinePromise.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public int getDeclinePromise(String pm_idx) throws Exception {
		int result = togetherService.getDeclinePromise(pm_idx);
		if(result > 0) {
			return result;
		}
		return -1;
	}
	
	@RequestMapping(value = "get_together_history.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getTogetherHistoryGet(@RequestParam("member_idx")String member_idx, HttpServletRequest request) throws Exception {
		int count = togetherService.getToHistoryCount(member_idx);
		System.out.println(count);
		paging.setTotalRecord(count);
		if(paging.getTotalRecord() <= paging.getNumPerPage()) {
			paging.setTotalPage(1);
		}else {
			paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage());
			if(paging.getTotalRecord() % paging.getNumPerPage() != 0) {
				paging.setTotalPage(paging.getTotalPage() +1);
			}
		}
		String cPage = request.getParameter("cPage");
		if(cPage == null) {
			paging.setNowPage(1);
		}else {
			paging.setNowPage(Integer.parseInt(cPage));
		}
		
		paging.setOffset(paging.getNumPerPage() * (paging.getNowPage() -1));
		
		paging.setBeginBlock((int)((paging.getNowPage() -1) / paging.getPagePerBlock()) * paging.getPagePerBlock() +1);
		paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock() -1);
		
		if(paging.getEndBlock() > paging.getTotalPage()) {
			paging.setEndBlock(paging.getTotalPage());
		}
		List<PromiseVO> toHistory = togetherService.getTogetherHistoryGet(member_idx, paging.getOffset(), paging.getNumPerPage());
		
		if(toHistory != null) {
			for (PromiseVO pvo : toHistory) {
				LocalDate dob = LocalDate.parse(pvo.getMember_dob());
				LocalDate currentDate = LocalDate.now();
				int age = Period.between(dob, currentDate).getYears();
				String ageGroup;
				switch (age / 10) {
				case 0: ageGroup = "10대 미만"; break;
				case 1: ageGroup = "10대"; break;
				case 2: ageGroup = "20대"; break;
				case 3: ageGroup = "30대"; break;
				case 4: ageGroup = "40대"; break;
				case 5: ageGroup = "50대 이상"; break;
				case 6: ageGroup = "60대 이상"; break;
				case 7: ageGroup = "70대 이상"; break;
				default: ageGroup = "80대 이상"; break;
				}
				pvo.setMember_dob(ageGroup);
				
				switch (pvo.getPm_state()) {
				case "0": pvo.setPm_state("신청중"); break;
				case "1": pvo.setPm_state("수락"); break;
				case "-1": pvo.setPm_state("거절"); break;
				case "2": pvo.setPm_state("동행완료"); break;
			}
				
				int promiseCount = togetherService.getPomiseCount(pvo.getT_idx());
				int promiseMyCount = togetherService.getPromiseMyCount(pvo.getMember_idx());
				pvo.setPromise_count(promiseCount);
				pvo.setPromise_my_count(promiseMyCount);
			}
		}
		Map<String, Object> response = new HashMap<>();
		response.put("toHistory", toHistory);
	    response.put("paging", paging);
	    return response;
	}
	
	@RequestMapping(value = "get_together_send_history.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getTogetherSendHistory(@RequestParam("member_idx")String member_idx, HttpServletRequest request) throws Exception {
		int count = togetherService.getToHistorySendCount(member_idx);
		paging.setTotalRecord(count);
		if(paging.getTotalRecord() <= paging.getNumPerPage()) {
			paging.setTotalPage(1);
		}else {
			paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage());
			if(paging.getTotalRecord() % paging.getNumPerPage() != 0) {
				paging.setTotalPage(paging.getTotalPage() +1);
			}
		}
		String cPage = request.getParameter("cPage");
		if(cPage == null) {
			paging.setNowPage(1);
		}else {
			paging.setNowPage(Integer.parseInt(cPage));
		}
		
		paging.setOffset(paging.getNumPerPage() * (paging.getNowPage() -1));
		
		paging.setBeginBlock((int)((paging.getNowPage() -1) / paging.getPagePerBlock()) * paging.getPagePerBlock() +1);
		paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock() -1);
		
		if(paging.getEndBlock() > paging.getTotalPage()) {
			paging.setEndBlock(paging.getTotalPage());
		}
		List<PromiseVO> toSendHistory = togetherService.getTogetherSendHistory(member_idx, paging.getOffset(), paging.getNumPerPage());
		
		if(toSendHistory != null) {
			for (PromiseVO pvo : toSendHistory) {
				switch (pvo.getPm_state()) {
					case "0": pvo.setPm_state("신청중"); break;
					case "1": pvo.setPm_state("수락"); break;
					case "-1": pvo.setPm_state("거절"); break;
					case "2": pvo.setPm_state("동행완료"); break;
				}
				int promiseCount = togetherService.getPomiseCount(pvo.getT_idx());
				pvo.setPromise_count(promiseCount);
			}
		}
		Map<String, Object> response = new HashMap<>();
		response.put("toSendHistory", toSendHistory);
		response.put("paging", paging);
		return response;
	}
	
	@RequestMapping(value = "to_comment_list.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getToCommentList(String t_idx, HttpSession session) throws Exception {
		MemberVO memberUser = (MemberVO) session.getAttribute("memberInfo");
		if (memberUser == null) {
	        memberUser = new MemberVO();
	    }
		List<TogetherCommentVO> toCommentList = togetherService.getToCommentList(t_idx);
		for (TogetherCommentVO k : toCommentList) {
//			System.out.println(k.getWc_idx());
//			System.out.println(k.getMember_idx());
//			System.out.println(k.getWc_groups());
//			System.out.println(k.getMember_img());
//			System.out.println(k.getMember_nickname());
//			System.out.println(k.getWc_content());
//			System.out.println(k.getWc_active());
		}
		Map<String, Object> response = new HashMap<>();
	    response.put("memberUser", memberUser);
	    response.put("toCommentList", toCommentList);

	    return response;
	}
	
	@RequestMapping(value = "to_comment_write.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public int getToCommentWrite(TogetherCommentVO tcvo) throws Exception {
		// 대댓글인 경우만
		if(!tcvo.getWc_idx().isEmpty()) {
			int wc_groups = Integer.parseInt(tcvo.getWc_groups());
			int wc_step = Integer.parseInt(tcvo.getWc_step());
			int wc_lev = Integer.parseInt(tcvo.getWc_lev());
			
			wc_step++;
			wc_lev++;
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("wc_groups", wc_groups);
			map.put("wc_step", wc_step);
			map.put("wc_lev", wc_lev);
			int same = togetherService.getToCommentSame(map);
			if(same > 0) {
				if(wc_step == 1 && wc_lev == 1) {
					int maxStep = togetherService.getToCommentMaxStep(map);
					wc_step = maxStep + 1;
					map.put("wc_groups", wc_groups);
					map.put("wc_step", wc_step);
				}else {
					wc_step++;
					map.put("wc_groups", wc_groups);
					map.put("wc_step", wc_step);
					int GSUpdate = togetherService.getToCommentGSUpdate(map);
				}
			}else {
				int GSUpdate = togetherService.getToCommentGSUpdate(map);
			}
			tcvo.setWc_groups(String.valueOf(wc_groups));
			tcvo.setWc_step(String.valueOf(wc_step));
			tcvo.setWc_lev(String.valueOf(wc_lev));
		}
		
		int result = togetherService.getToCommentWrite(tcvo);
		if(result > 0) {
			return result;
		}
		return -1;
	}
	
	@RequestMapping(value = "to_comment_delete.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public int getToCommentDelete(String wc_idx) throws Exception {
		System.out.println(wc_idx);
		int result = togetherService.getToCommentDelete(wc_idx);
		if(result > 0) {
			return result;
		}
		return -1;
	}
	
	@RequestMapping(value = "to_comment_update.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public int getToCommentUpdate(TogetherCommentVO tcvo) throws Exception {
		System.out.println(tcvo.getWc_content());
		System.out.println(tcvo.getWc_idx());
		int result = togetherService.getToCommentUpdate(tcvo);
		if(result > 0) {
			return result;
		}
		return -1;
	}
	
	
	@RequestMapping(value = "get_promise_ing.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getPromiseIng(@RequestParam("member_idx")String member_idx, HttpServletRequest request) throws Exception {
		int count = togetherService.getBoardWithCount(member_idx);
		paging2.setTotalRecord(count);
		if(paging2.getTotalRecord() <= paging2.getNumPerPage()) {
			paging2.setTotalPage(1);
		}else {
			paging2.setTotalPage(paging2.getTotalRecord() / paging2.getNumPerPage());
			if(paging2.getTotalRecord() % paging2.getNumPerPage() != 0) {
				paging2.setTotalPage(paging2.getTotalPage() +1);
			}
		}
		String cPage = request.getParameter("cPage");
		if(cPage == null) {
			paging2.setNowPage(1);
		}else {
			paging2.setNowPage(Integer.parseInt(cPage));
		}
		
		paging2.setOffset(paging2.getNumPerPage() * (paging2.getNowPage() -1));
		
		paging2.setBeginBlock((int)((paging2.getNowPage() -1) / paging2.getPagePerBlock()) * paging2.getPagePerBlock() +1);
		paging2.setEndBlock(paging2.getBeginBlock() + paging2.getPagePerBlock() -1);
		
		if(paging2.getEndBlock() > paging2.getTotalPage()) {
			paging2.setEndBlock(paging2.getTotalPage());
		}
		
		List<TogetherVO> toPromiseIng = togetherService.getPromiseIng(member_idx, paging2.getOffset(), paging2.getNumPerPage());
		System.out.println(1);
		if(toPromiseIng != null) {
			for (TogetherVO tvo : toPromiseIng) {
				System.out.println(tvo.getT_campname());
				int promiseCount = togetherService.getPomiseCount(tvo.getT_idx());
				tvo.setPromise_count(promiseCount);
			}
		}
		Map<String, Object> response = new HashMap<>();
		response.put("toPromiseIng", toPromiseIng);
		response.put("paging", paging2);
		return response;
	}
}