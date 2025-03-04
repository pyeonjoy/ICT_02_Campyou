<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="${path}/resources/public/css/bm/faq.css">
  <link rel="stylesheet" href="${path}/resources/css/menu_aside.css" />
 <script defer src="${path}/resources/public/js/bm/faq.js"></script>
   <script defer src="${path}/resources/public/js/bm/my_menu.js"></script>
</head>
<body>
<body>

<%@ include file="../hs/mypage_menu.jsp"%>

  <div class="faq_container">
    <h3 class="faq_title">FAQ</h3>
  	  <div class="question_box">
	     <div class="question-list list_active" data-list='1'>사이트 이용 문의 </div>
	     <div class="question-list" data-list='2'>동행 </div>
   	 </div>
   <div class="question_container question_container--1">
	    <c:forEach var="faqs" items="${faqs}">
	      <div class="questions">
	        <p class="question" data-question="${faqs.faq_idx}"> > ${faqs.faq_title}</p>
	        <p class = "answer answer--${faqs.faq_idx}">${faqs.faq_content}</p>  
	      </div> 
	      </c:forEach> 
   </div> 
   <div class="question_container question_container--2"> 
	      <c:forEach var="faqs2" items="${faqs2}">
	      <div class="questions2">
	        <p class="question" data-question="${faqs2.faq_idx}"> > ${faqs2.faq_title}</p>
	        <p class ="answer answer--${faqs2.faq_idx}">${faqs2.faq_content}</p>  
	      </div>
	       </c:forEach> 
   </div>
  </div>
 <%@ include file="../hs/footer.jsp"%>
</body>
</html>