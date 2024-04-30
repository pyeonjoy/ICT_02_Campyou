package com.ict.campyou.bjs.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.ict.campyou.bjs.dao.TogetherVO;
import com.ict.campyou.bjs.service.TogetherService;
import com.ict.campyou.jun.dao.CampVO;

@RestController
public class TogetherAjaxController {
	@Autowired
	private TogetherService togetherService;

	@RequestMapping(value = "together_Write2.do", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	@ResponseBody
	public String getTogetherWrite(TogetherVO tvo, HttpSession session) throws Exception{
		List<CampVO> campList = togetherService.getTogetherCampList();
		for (CampVO k : campList) {
			System.out.println(k.getAddr1());
		}
		if(campList != null) {
			Gson gson = new Gson();
			String jsonCampList = gson.toJson(campList);
			return jsonCampList;
		}
		return "fail";
	}
}
