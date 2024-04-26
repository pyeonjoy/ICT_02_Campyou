package com.ict.campyou.hu.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailService {
	@Autowired
	private JavaMailSender mailSender;
	
	// Controller에서 호출
	// 비번 찾기
	public void sendEmail(String randomNumber, String toMail) {
		try {
			MailHandler sendMail = new MailHandler(mailSender);
			// 메일 제목
			sendMail.setSubject("[ICT EDU 인증 메일입니다]");
			
			// 메일 내용
			// 내용
			sendMail.setText("<table><tbody>"
					+ "<tr><td><h2>ICT EDU 메일 인증</h2></td></tr>"
					+ "<tr><td><h3>ICT EDU</h3></td></tr>"
					+ "<tr><td><font size='5px'>인증번호 안내입니다</font></td></tr>"
					+ "<tr><td><font size='8px'>확인번호 : "+randomNumber +"</font></td></tr>"
					+ "</tbody></table>");
			
			// 보내는 이
			sendMail.setFrom("ictsamjo@gmail.com", "hchoi");
			
			// 받는 이
			sendMail.setTo(toMail);
			sendMail.send();
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	
	//아이디 찾기
	public void sendMyIDEmail(String userId, String toMail) {
		try {
			MailHandler sendMail = new MailHandler(mailSender);
			// 메일 제목
			sendMail.setSubject("[ICT EDU 인증 메일입니다]");
			
			// 메일 내용
			// 내용
			sendMail.setText("<table><tbody>"
					+ "<tr><td><h2>ICT EDU 메일 인증</h2></td></tr>"
					+ "<tr><td><h3>ICT EDU</h3></td></tr>"
					+ "<tr><td><font size='5px'>아이디 안내입니다</font></td></tr>"
					+ "<tr><td><font size='8px'>확인 아이디 : "+userId +"</font></td></tr>"
					+ "</tbody></table>");
			
			// 보내는 이
			sendMail.setFrom1("ictsamjo@gmail.com", "hchoi");
			
			// 받는 이
			sendMail.setTo1(toMail);
			sendMail.send();
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}