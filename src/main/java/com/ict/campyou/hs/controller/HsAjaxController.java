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
					if (k.equals(i.getDonm())) {
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

}
