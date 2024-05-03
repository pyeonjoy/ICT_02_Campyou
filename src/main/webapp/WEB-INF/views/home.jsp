<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link href="${path}/resources/css/reset.css" rel="stylesheet" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
	
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
body {background-image : url(${path}/resources/images/back.png);
width: 100%}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}
.py-2 img{
width: 30px;
}
.py-2 {
color: #FFFDDE;
}
.wrap{
margin: auto;
margin-top: 1000px;
margin-bottom: 500px;
width: 1200px;
text-align: center;
font-weight: bold;
color: #FFFDDE;

}
.popular img{
	width: 300px;
	height: 500px;
	margin: 30px;
}
.find>p{
margin: 50px;
color: black;
height:40px;
line-height:40px;
background-color: #FFFDDE;}
</style>
</head>
<body>
	<div class="container py-3">
		<header>
			<div class="d-flex flex-column flex-md-row align-items-cent er pb-3 mb-4 border-bottom">
				<title>Bootstrap</title>
				<a class="me-3 py-2 text-dark text-decoration-none" href="community_board.do">게시판</a> 
				<span class="fs-4">임시메인 페이지</span>
				<nav class="d-inline-flex mt-2 mt-md-0 ms-md-auto">
					<c:choose>
						<c:when test="${empty memberInfo}">
							<a class="me-3 py-2 text-dark text-decoration-none" href="sign_up_page_go.do"><span style="color:white">회원가입</span></a> 
							<a class="py-2 text-dark text-decoration-none" style="color:white" href="login_form.do"><span style="color:white">로그인</span></a>&nbsp;&nbsp;
							<a class="py-2 text-dark text-decoration-none" style="color:white" href="together_list.do"><span style="color:white">동행</span></a>
						</c:when>		
						<c:otherwise>
						<div  style="line-height:41px;">
							<span style="color:white"><b>${memberInfo.member_name}님 환영합니다.</b></span> &nbsp;
							
							<c:if test="${admin == 'ok'}">
					    		<a href="admin_page_go.do"><span style="color:white"><b>관리자페이지</b></span></a> &nbsp;&nbsp;
							</c:if>	
						</div>
							<a class="py-2 " href="logout_form.do"><span style="color:white"><b>로그아웃</b></span></a> &nbsp;&nbsp;
							<a class="py-2" href="#"><img src="${path}/resources/images/chat1.png"></a> &nbsp;&nbsp;
							<a class="py-2" href="#"><img src="${path}/resources/images/user1.png"></a> &nbsp;&nbsp;
							<a class="py-2 text-dark text-decoration-none" href="together_list.do"><span style="color:white"><b>동행</b></span></a>
						</c:otherwise>
					</c:choose>
				</nav>				
			</div>
			<div class="wrap">
				<div class="popular">
				<h3>Popular campsites</h3>
					<img src="${path}/resources/images/2.jpg">
					<img src="${path}/resources/images/2.jpg">
					<img src="${path}/resources/images/2.jpg">
				</div>
				<p><button>Show More</button></p>
				<div class="find" style="margin-top: 500px;">
				<h3>Find camping mates</h3>
					<c:forEach var="k" items="${bwlist}" varStatus="vs">
							<p>${k.t_content }</p>
					</c:forEach>
				</div>
				<p><button>Show More</button></p>
			</div>

		</header>
	</div>
	<div style="background-color: #053610; height: 500px;"></div>
</body>
</html>
