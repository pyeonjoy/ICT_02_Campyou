<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, 그리고 Bootstrap 기여자들">
<meta name="generator" content="Hugo 0.88.1">
<title>임시 메인페이지</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}
</style>
</head>
<body>
	<div class="container py-3">
		<header>
			<div class="d-flex flex-column flex-md-row align-items-center pb-3 mb-4 border-bottom">
				<title>Bootstrap</title>
				
				<span class="fs-4">임시메인 페이지</span>

				<nav class="d-inline-flex mt-2 mt-md-0 ms-md-auto">
					<c:choose>
						<c:when test="${empty memberInfo}">
							<a class="me-3 py-2 text-dark text-decoration-none" href="sign_up_page_go.do">회원가입</a> 
							<a class="py-2 text-dark text-decoration-none" href="login_form.do">로그인</a>
							<a class="py-2 text-dark text-decoration-none" href="together.do">동행</a>
						</c:when>		
						<c:otherwise>
						<a class="py-2 text-dark text-decoration-none" href="together.do">동행&nbsp;&nbsp;&nbsp;&nbsp;</a>
						<div  style="line-height:41px;">
							${memberInfo.member_name}님 환영합니다. &nbsp;
							
							<c:if test="${admin == 'ok'}">
					    		<a href="admin_page_go.do">관리자페이지</a> &nbsp;&nbsp;
							</c:if>	
						</div>					
							<a class="py-2 text-dark text-decoration-none" href="logout_form.do">로그아웃</a>
						</c:otherwise>
					</c:choose>
				</nav>				
				
			</div>
		
				<h1 class="display-4 fw-normal">임시 메인 페이지</h1>

		</header>
	</div>
</body>
</html>
