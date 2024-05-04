package com.ict.campyou.joy.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.campyou.common.Paging;
import com.ict.campyou.common.Paging2;
import com.ict.campyou.common.Paging3;
import com.ict.campyou.joy.dao.AdminVO;
import com.ict.campyou.joy.service.AdminService;

@Controller
public class PopupController {
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private Paging3 paging;
		
	
	@RequestMapping("popup.do")
	public ModelAndView boardList(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("joy/popup");

		// 페이징 기법
		// 전체 게시물의 수
		int count = adminService.getTotalCount();
		paging.setTotalRecord(count);
		
		// 전체 페이지의 수
		if (paging.getTotalRecord() <= paging.getNumPerPage()) {
			paging.setTotalPage(1);
		} else {
			paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage());
			if (paging.getTotalRecord() % paging.getNumPerPage() != 0) {
				paging.setTotalPage(paging.getTotalPage() + 1);
			}
		}

		// 현재 페이지 구함
		String cPage = request.getParameter("cPage");
		if (cPage == null) {
			paging.setNowPage(1);
		} else {
			paging.setNowPage(Integer.parseInt(cPage));
		}

		// begin, end 구하기 (Oracle)
		// offset 구하기
		// offset = limit * (현재페이지-1);
		paging.setOffset(paging.getNumPerPage() * (paging.getNowPage() - 1));

		// 시작 블록 // 끝블록
		paging.setBeginBlock(
				(int) ((paging.getNowPage() - 1) / paging.getPagePerBlock()) * paging.getPagePerBlock() + 1);
		paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock() - 1);

		if (paging.getEndBlock() > paging.getTotalPage()) {
			paging.setEndBlock(paging.getTotalPage());
		}

		List<AdminVO> pop_list = adminService.getPopList(paging.getOffset(), paging.getNumPerPage());
		if (pop_list != null) {
			mv.addObject("pop", pop_list);
			mv.addObject("paging", paging);
			return mv;
		}
		return new ModelAndView("");
	}

	@RequestMapping("popup_write.do")
	public ModelAndView popupwrite(){
		ModelAndView mv = new ModelAndView("joy/popup_write");
			return mv;
		}
	
	@RequestMapping("popup_write_ok.do")
	public ModelAndView popupwriteOK(AdminVO avo, HttpServletRequest request) {
		try {
			ModelAndView mv = new ModelAndView("redirect:popup.do");
			String path = request.getSession().getServletContext().getRealPath("/resources/popup");
			System.out.println(path);
			MultipartFile file = avo.getFile();
			if (file.isEmpty()) {
				avo.setF_name("");
			} else {
				UUID uuid = UUID.randomUUID();
				String f_name = uuid.toString() + "_" + file.getOriginalFilename();
				avo.setF_name(f_name);

				byte[] in = file.getBytes();
				File out = new File(path, f_name);
				FileCopyUtils.copy(in, out);
			}

			int result = adminService.getPopUPWrite(avo);
			if (result > 0) {
				return mv;
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return new ModelAndView("board/error");
	}
}