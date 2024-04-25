package com.ict.campyou.hu.service;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailHandler {
	private JavaMailSender mailSender;
	private MimeMessage message;
	private MimeMessageHelper messageHelper;
	
	public MailHandler(JavaMailSender mailSender) throws Exception{
		this.mailSender = mailSender;
		message = this.mailSender.createMimeMessage();
		// true�� ��Ƽ��Ʈ �޼����� ��밡��
		messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// �ܼ��� �ؽ�Ʈ �޼����� ���
		// messageHelper = new MimeMessageHelper(message, "UTF-8");
	}
	
	// ����
	public void setSubject(String subject) throws Exception{
		messageHelper.setSubject(subject);
	}
	// ����
	public void setText(String text) throws Exception{
		// true �±� ���
		messageHelper.setText(text, true);
	}
	// ���� ����� �̸��ϰ� ����
	public void setFrom(String email, String name) throws Exception{
		messageHelper.setFrom(email, name);
	}
	
	// �޴� �̸��� 
	public void setTo(String email) throws Exception{
		messageHelper.setTo(email);
	}
		
	// ���� ����� �̸��ϰ� ���� (���̵� ã���)
	public void setFrom1(String email, String name) throws Exception{
		messageHelper.setFrom(email, name);
	}
	
	// �޴� �̸��� (���̵� ã���)
	public void setTo1(String email) throws Exception{
		messageHelper.setTo(email);
	}
	
	// ������
	public void send() {
		mailSender.send(message);
	}
}
