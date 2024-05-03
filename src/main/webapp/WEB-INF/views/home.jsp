<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="hs/header.jsp" %>
	
<!doctype html>
<html lang="ko">
<link href="${path}/resources/css/reset.css" rel="stylesheet" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">

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
<script type="text/javascript">
var toggleMainPopup = function() {
	  
	  /* 쿠키 제어 함수 정의 */
	  var handleCookie = {
	    // 쿠키 쓰기
	    // 이름, 값, 만료일
	    setCookie: function (name, val, exp) {
	      var date = new Date();
	      
	      // 만료 시간 구하기(exp를 ms단위로 변경)
	      date.setTime(date.getTime() + exp * 24 * 60 * 60 * 1000);
	      console.log(name + "=" + val + ";expires=" + date.toUTCString() + ";path=/");
	      
	      // 실제로 쿠키 작성하기
	      document.cookie = name + "=" + val + ";expires=" + date.toUTCString() + ";";
	    },
	    // 쿠키 읽어오기(정규식 이용해서 가져오기)
	    getCookie: function (name) {
	      var value = document.cookie.match("(^|;) ?" + name + "=([^;]*)(;|$)");
	      return value ? value[2] : null;
	    }
	  };
	  console.log(handleCookie.getCookie("today"));
	  
	  // 쿠키 읽고 화면 보이게
	  if (handleCookie.getCookie("today") == "y") {
	    $(".main_popup").removeClass("on");
	  } else {
	    $(".main_popup").addClass("on");
	  }

	  // 오늘하루 보지 않기 버튼
	  $(".main_popup").on("click", ".btn_today_close", function () {
	    handleCookie.setCookie("today", "y", 1);
	    $(this).parents(".main_popup.on").removeClass("on");
	  });

	  // 일반 버튼
	  $(".main_popup").on("click", ".btn_close", function () {
	    $(this).parents(".main_popup.on").removeClass("on");
	  });
	}

	$(function() {
	  toggleMainPopup();
	});   
</script>
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
	<div class="main_popup">
  <div class="layer_cont">
    <div class="img_wrap">
      팝업 콘텐츠
    </div>
    <div class="btn_wrap">
      <!-- 오늘 하루 보지 않기 --->
      <button class="btn_today_close"><span>오늘 하루 보지 않기</span></button>
      <!-- 그냥 닫기 --->
      <button class="btn_close">close</button>
    </div>
  </div>
</div>
				<h1 class="display-4 fw-normal">임시 메인 페이지</h1>
				<h1 class="display-4 fw-normal"><button onclick="location.href='together_list.do'">준수</button></h1>
				<h1 class="display-4 fw-normal"><button onclick="location.href='inquiry_form.do'">보미</button></h1>
				<h1 class="display-4 fw-normal"><button onclick="location.href='inquiry_form.do'">해성</button></h1>
				<h1 class="display-4 fw-normal"><button onclick="location.href='sign_up_page_go.do'">한욱</button></h1>
				<h1 class="display-4 fw-normal"><button onclick="location.href='admin_member_detail.do'">조이</button></h1>
				<h1 class="display-4 fw-normal"><button onclick="location.href='camplist.do'">준형</button></h1>
<a href="inquiry_form.do">1:1문의작성</a>
<a href="my_info.do">내정보</a>
<a href="my_faq.do">faq</a>
<a href="my_main.do">마이페이지</a>
<a href="together_list.do">동행</a>
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
	<%@ include file="hs/footer.jsp" %>
</body>
</html>
