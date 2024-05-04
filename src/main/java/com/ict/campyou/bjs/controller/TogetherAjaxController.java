package com.ict.campyou.bjs.controller;

import java.time.LocalDate;
import java.time.Period;
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
import com.ict.campyou.bjs.dao.TogetherVO;
import com.ict.campyou.bjs.service.TogetherService;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.jun.dao.CampVO;

@RestController
public class TogetherAjaxController {
	@Autowired
	private TogetherService togetherService;

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
	
	@RequestMapping(value = "together_list_search.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String getTogetherListSearch(@RequestParam("searchType") String searchType, @RequestParam("searchKeyword") String searchKeyword) throws Exception{
		String result = "";
		if (searchType != null && searchKeyword != null) {
	        List<TogetherVO> toListSearch = togetherService.getTogetherListSearch(searchType, searchKeyword);
	        
	        if (toListSearch != null) {
	        	 for (TogetherVO tvo : toListSearch) {
	                 LocalDate dob = LocalDate.parse(tvo.getMember_dob());
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
	                 tvo.setMember_dob(ageGroup);
	             }
	            Gson gson = new Gson();
	            String jsontoListSearch = gson.toJson(toListSearch);
	            return jsontoListSearch;
	        }
	    }
	    return result;
	}
	
	
}