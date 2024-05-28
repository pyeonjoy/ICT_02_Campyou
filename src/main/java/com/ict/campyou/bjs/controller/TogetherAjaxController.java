package com.ict.campyou.bjs.controller;

import java.time.LocalDate;
import java.time.Period;
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
import com.ict.campyou.bjs.dao.StarRatingVO;
import com.ict.campyou.bjs.dao.TogetherCommentVO;
import com.ict.campyou.bjs.dao.TogetherVO;
import com.ict.campyou.bjs.service.TogetherService;
import com.ict.campyou.common.Paging4;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.jun.dao.CampVO;

@RestController
public class TogetherAjaxController {
	@Autowired
	private TogetherService togetherService;
	
	@Autowired
	private Paging4 paging;
//	@Autowired
//	private Paging2 paging2;

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
			String promiseChk = togetherService.getPromiseChk(pvo);
			if(promiseChk != null) {
				if(promiseChk.equals("0") || promiseChk.equals("1")) {
					return "ok";
				}else if(promiseChk.equals("2") || promiseChk.equals("3")) {
					return "no";
				}
			}else {
				return "no";
			}
		}
		return "error";
	}
	
	@RequestMapping(value = "to_promise.do", produces = "application/plain; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String getToPomise(PromiseVO pvo, HttpSession session) throws Exception{
		MemberVO memberUser = (MemberVO) session.getAttribute("memberInfo");
        if (memberUser == null) {
            return "로그인 후 가능합니다.";
        } else {
        	int pmStateChk = togetherService.getPmStateChk(pvo);
        	if(pmStateChk > 0) {
        		return "ban";
        	}else {
        		int result = togetherService.getToPomise(pvo);
        		if(result > 0) {
        			int pvo2 = togetherService.getPomiseCount(pvo.getT_idx());
        			return String.valueOf(pvo2);
        		}
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
				case 5: ageGroup = "50대"; break;
				case 6: ageGroup = "60대"; break;
				case 7: ageGroup = "70대"; break;
				default: ageGroup = "80대 이상"; break;
				}
				list.setMember_dob(ageGroup);
				int promiseCount = togetherService.getPromiseMyCount(list.getMember_idx());
				list.setPromise_count(promiseCount);
				
				switch (list.getMember_grade()) {
				case "1": list.setMember_grade("grade1.png"); break;
				case "2": list.setMember_grade("grade2.png"); break;
				case "3": list.setMember_grade("grade3.png"); break;
				case "4": list.setMember_grade("grade4.png"); break;
				default: list.setMember_grade("grade5.png"); break;
//				case "5": list.setMember_grade("grade5.png"); break;
				}
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
				case 5: ageGroup = "50대"; break;
				case 6: ageGroup = "60대"; break;
				case 7: ageGroup = "70대"; break;
				default: ageGroup = "80대 이상"; break;
				}
				pvo.setMember_dob(ageGroup);
				
				switch (pvo.getPm_state()) {
				case "0": pvo.setPm_state("신청중"); break;
				case "1": pvo.setPm_state("수락"); break;
				case "-1": pvo.setPm_state("거절"); break;
				case "2": pvo.setPm_state("동행완료"); break;
				case "3": pvo.setPm_state("추방"); break;
				}
				switch (pvo.getMember_grade()) {
				case "1": pvo.setMember_grade("grade1.png"); break;
				case "2": pvo.setMember_grade("grade2.png"); break;
				case "3": pvo.setMember_grade("grade3.png"); break;
				case "4": pvo.setMember_grade("grade4.png"); break;
				default: pvo.setMember_grade("grade5.png"); break;
//				case "5": pvo.setMember_grade("grade5.png"); break;
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
					case "3": pvo.setPm_state("추방"); break;
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
			switch (k.getMember_grade()) {
			case "1": k.setMember_grade("grade1.png"); break;
			case "2": k.setMember_grade("grade2.png"); break;
			case "3": k.setMember_grade("grade3.png"); break;
			case "4": k.setMember_grade("grade4.png"); break;
			default: k.setMember_grade("grade5.png"); break;
//			case "5": k.setMember_grade("grade5.png"); break;
			}
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
			int t_idx = Integer.parseInt(tcvo.getT_idx());
			
			wc_step++;
			wc_lev++;
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("wc_groups", wc_groups);
			map.put("wc_step", wc_step);
			map.put("wc_lev", wc_lev);
			map.put("t_idx", t_idx);
			int same = togetherService.getToCommentSame(map);
			if(same > 0) {
				if(wc_step == 1 && wc_lev == 1) {
					int maxStep = togetherService.getToCommentMaxStep(map);
					wc_step = maxStep + 1;
				}else {
					int groupStep = 0;
					boolean found = false;
					List<TogetherCommentVO> groupList = togetherService.getGroupList(map);
						for (TogetherCommentVO k : groupList) {
							if(wc_step != Integer.parseInt(k.getWc_step()) && wc_lev > Integer.parseInt(k.getWc_lev())) {
								groupStep = Integer.parseInt(k.getWc_step());
								found = true;
								break;
							}
						}
						// 반복문이 끝난 후 step이 같지않으면서 lev이 작은 값을 찾지 못한경우 같은 step lev에 있는 step 가져오기
						if (!found && !groupList.isEmpty()) {
						    TogetherCommentVO lastElement = groupList.get(groupList.size() - 1);
						    groupStep = Integer.parseInt(lastElement.getWc_step()) + 1;
						}
						wc_step = groupStep;
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
		int result = togetherService.getToCommentDelete(wc_idx);
		if(result > 0) {
			return result;
		}
		return -1;
	}
	
	@RequestMapping(value = "to_comment_update.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public int getToCommentUpdate(TogetherCommentVO tcvo) throws Exception {
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
		if(cPage == null || cPage.isEmpty()) {
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
		
		List<TogetherVO> toPromiseIng = togetherService.getPromiseIng(member_idx, paging.getOffset(), paging.getNumPerPage());
		if(toPromiseIng != null) {
			for (TogetherVO tvo : toPromiseIng) {
				int promiseCount = togetherService.getPomiseCount(tvo.getT_idx());
				tvo.setPromise_count(promiseCount);
			}
		}
		Map<String, Object> response = new HashMap<>();
		response.put("toPromiseIng", toPromiseIng);
		response.put("paging", paging);
		return response;
	}
	
	@RequestMapping(value = "promise_people_detail.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public List<PromiseVO> getPromisePeopleDetail(@RequestParam("t_idx")String t_idx) throws Exception {
		List<PromiseVO> proPeopleDetail = togetherService.getPromisePeopleDetail(t_idx);
		if(proPeopleDetail != null) {
			for (PromiseVO pvo : proPeopleDetail) {
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
				case 5: ageGroup = "50대"; break;
				case 6: ageGroup = "60대"; break;
				case 7: ageGroup = "70대"; break;
				default: ageGroup = "80대 이상"; break;
				}
				pvo.setMember_dob(ageGroup);
				
				switch (pvo.getMember_grade()) {
				case "1": pvo.setMember_grade("grade1.png"); break;
				case "2": pvo.setMember_grade("grade2.png"); break;
				case "3": pvo.setMember_grade("grade3.png"); break;
				case "4": pvo.setMember_grade("grade4.png"); break;
				default: pvo.setMember_grade("grade5.png"); break;
//				case "5": pvo.setMember_grade("grade5.png"); break;
				}
				
				int proOKCount = togetherService.getPromiseMyCount(pvo.getMember_idx());
				pvo.setPromise_my_count(proOKCount);
			}
		}
		return proPeopleDetail;
	}
	
	@RequestMapping(value = "star_rating_check.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public int getStarRatingCheck(StarRatingVO srvo) throws Exception {
		int result = togetherService.getStarRatingCheck(srvo);
		return result;
	}
	
	
	
	@RequestMapping(value = "promise_banish_member.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public int getPromiseBanMember(PromiseVO pvo) throws Exception {
		int result = togetherService.getPromiseBanMember(pvo);
		if(result > 0) {
			return result;
		}
		return -1;
	}

	@RequestMapping(value = "get_promise_ready.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getPromiseReady(@RequestParam("member_idx")String member_idx, HttpServletRequest request) throws Exception {
		int count = togetherService.getBoardWithCountReady(member_idx);
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
		if(cPage == null || cPage.isEmpty()) {
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
		List<TogetherVO> toPromiseReady = togetherService.getPromiseReady(member_idx, paging.getOffset(), paging.getNumPerPage());
		if(toPromiseReady != null) {
			for (TogetherVO tvo : toPromiseReady) {
				int promiseCount = togetherService.getPomiseCount(tvo.getT_idx());
				tvo.setPromise_count(promiseCount);
			}
		}
		Map<String, Object> response = new HashMap<>();
		response.put("toPromiseReady", toPromiseReady);
		response.put("paging", paging);
		return response;
	}
	
	@RequestMapping(value = "get_promise_end.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getPromiseEnd(@RequestParam("member_idx")String member_idx, HttpServletRequest request) throws Exception {
		int count = togetherService.getBoardWithCountEnd(member_idx);
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
		if(cPage == null || cPage.isEmpty()) {
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
		List<TogetherVO> toPromiseEnd = togetherService.getPromiseEnd(member_idx, paging.getOffset(), paging.getNumPerPage());
		if(toPromiseEnd != null) {
			for (TogetherVO tvo : toPromiseEnd) {
				int promiseCount = togetherService.getPomiseCount(tvo.getT_idx());
				tvo.setPromise_count(promiseCount);
			}
		}
		Map<String, Object> response = new HashMap<>();
		response.put("toPromiseEnd", toPromiseEnd);
		response.put("paging", paging);
		return response;
	}
	
	@RequestMapping(value = "promise_confirm.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public int getPromiseConfirm(PromiseVO pvo, @RequestParam("member_idx")List<String> memberIdxArray) throws Exception {
		if(pvo.getT_startdate() != null) {
			int res = togetherService.getStartdateUpdate(pvo.getT_idx());
		}
		int totalUpdated = 0;
		for (String memberIdx : memberIdxArray) {
			pvo.setMember_idx(memberIdx);
			int result = togetherService.getPromiseConfirm(pvo);
			if(result > 0) {
				totalUpdated += result;
			}
		}
		return totalUpdated;
	}
	
	@RequestMapping(value = "confirm_partner.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public int getConfirmPartner(PromiseVO pvo, @RequestParam("member_idx")List<String> memberIdxArray) throws Exception {
		if(pvo.getT_enddate() != null) {
			int res = togetherService.getEnddateUpdate(pvo.getT_idx());
		}
		int totalUpdated = 0;
		for (String memberIdx : memberIdxArray) {
			pvo.setMember_idx(memberIdx);
			int result = togetherService.getConfirmPartner(pvo);
			if(result > 0) {
				totalUpdated += result;
			}
	    }
		return totalUpdated;
	}
	
	@RequestMapping(value = "with_promise_state_update.do", produces = "application/plain; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public int getConfirmPartner(@RequestParam("member_idx")String member_idx) throws Exception {
		int num = 0;
		int res= 0;
		List<PromiseVO> startCampChk = togetherService.getStartCampChk(member_idx);
		if(startCampChk != null) {
			for (PromiseVO k : startCampChk) {
				num = 1; 
				res = togetherService.getWPStateUpdate(k.getT_idx(), num);
			}
		}
		List<PromiseVO> endCampChk = togetherService.getEndCampChk(member_idx);
		if(endCampChk != null) {
			for (PromiseVO k : endCampChk) {
				num = 2; 
				res = togetherService.getWPStateUpdate(k.getT_idx(), num);
			}
		}
		return res;
	}
	
	
//	@RequestMapping(value = "weather_search.do", produces = "application/json; charset=utf-8")
//	@ResponseBody
//	public String getWeatherSearch(@RequestParam("lat") String lat, @RequestParam("lon") String lon, @RequestParam("startDate") String startDate, @RequestParam("endDate") String endDate) throws Exception {
//	    System.out.println(lat);
//	    System.out.println(lon);
//	    System.out.println(startDate);
//	    System.out.println(endDate);
//	    StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"); /*URL*/
//        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=QoIa3JzLJDjy8nyNR%2BcQQbdhN0Uy48CfKIpYby13Ybs35hzG43uelkaR8i4gpTafPY2MFHcWV7%2F8rfSRVwtKPQ%3D%3D"); /*Service Key*/
//        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
//        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("1000", "UTF-8")); /*한 페이지 결과 수*/
//        urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*요청자료형식(XML/JSON) Default: XML*/
//        urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode(startDate, "UTF-8")); /*‘21년 6월 28일발표*/
//        urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode("0500", "UTF-8")); /*05시 발표*/
//        urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode(lat, "UTF-8")); /*예보지점의 X 좌표값*/
//        urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode(lon, "UTF-8")); /*예보지점의 Y 좌표값*/
//        URL url = new URL(urlBuilder.toString());
//        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//        conn.setRequestMethod("GET");
//        conn.setRequestProperty("Content-type", "application/json");
//        System.out.println("Response code: " + conn.getResponseCode());
//        BufferedReader rd;
//        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
//            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//        } else {
//            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
//        }
//        StringBuilder sb = new StringBuilder();
//        String line;
//        while ((line = rd.readLine()) != null) {
//            sb.append(line);
//        }
//        rd.close();
//        conn.disconnect();
//        System.out.println(sb.toString());
//		return sb.toString();
//    }
}