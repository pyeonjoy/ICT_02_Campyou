<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="/resources/css/header.css" rel="stylesheet" />
</head>
<body>
<div class="header" id="header">
    <div class="header_wrap">
        <div class="header_left">
            <a href="/"> 
                <img class="logo-03" src="/resources/img/logo-03.png" alt="CampYou" >
            </a>
            <ul>
                <li>관리자</li>
            </ul>
        </div>
        <div class="header_right">
            <ul><c:choose>
                <c:when test="${empty memberInfo && empty admin}">
							<li><a href="login_form.do">로그인</a></li>
							<li><a href="sign_up_page_go.do">회원가입</a></li>
						</c:when>
				</c:choose>
            </ul>
       </div>
    </div>
</div>
</body>
</html>