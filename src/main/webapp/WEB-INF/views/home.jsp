<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="hs/header.jsp"%>
<!doctype html>
<html lang="ko">
<link href="${path}/resources/css/reset.css" rel="stylesheet" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
    href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap"
    rel="stylesheet">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
    content="Mark Otto, Jacob Thornton, 그리고 Bootstrap 기여자들">
<meta name="generator" content="Hugo 0.88.1">
<title>임시 메인페이지</title>
<style>
.bd-placeholder-img {
    font-size: 1.125rem;
    text-anchor: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    user-select: none;
}

body {
    background-image: url(${path}/resources/images/back.png);
    width: 100%
}

@media ( min-width : 768px) {
    .bd-placeholder-img-lg {
        font-size: 3.5rem;
    }
}

.py-2 img {
    width: 30px;
}

.py-2 {
    color: #FFFDDE;
}

.wrap {
    margin: auto;
    margin-top: 1000px;
    margin-bottom: 500px;
    width: 1200px;
    text-align: center;
    font-weight: bold;
    color: #FFFDDE;
}

.popular img {
    width: 300px;
    height: 500px;
    margin: 30px;
}
button {
    height: 40px;
}
.layer_popup {
    display: none; 
    position: fixed;
    background-color: black;
    display: inline-block;
    width: 500px;
    height: 500px;
    z-index: 9999;
    padding: 10px;
    margin:165px;
}

.popimg {
    display: block;
    margin: 0 auto; 
    max-width: 100%; 
    max-height: 100%; 
}
#check1 {
	background-color: #FFBA34;
	text-align: center;
    position: absolute;
    left: 50%;
    width:100%;
    transform: translateX(-50%);
}

.popular{ 
  opacity:0;
    margin-top:-150px;    
    max-width:100%;
    margin-bottom: 400px;
}
.popularimg{
object-fit: cover;
border-radius: 10px;
}

#footer{
width: 100%;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	function setCookie(name, value, exDay) {
		var todayDate = new Date();
		todayDate.setDate(todayDate.getDate() + exDay);
		document.cookie = name + "=" + escape(value) + ";expires="
				+ todayDate.toGMTString() + ";path=/";
	}

	function getCookie(name) {
		var nameEQ = name + "=";
		var ca = document.cookie.split(';');
		for (var i = 0; i < ca.length; i++) {
			var c = ca[i];
			while (c.charAt(0) == ' ')
				c = c.substring(1, c.length);
			if (c.indexOf(nameEQ) == 0)
				return c.substring(nameEQ.length, c.length);
		}
		return null;
	}

	function closePop(popId) {
		var cookiedata = document.cookie;
		if (document.getElementById('chkbox' + popId).checked) {
			setCookie("popup" + popId, "done", 1);
		}
		document.getElementById('layer_popup' + popId).style.display = "none";
	}

	document.addEventListener("DOMContentLoaded", function() {
		checkPopup();
	});
	function checkPopup() {
		for (var i = 1; i <= 5; i++) {
			if (getCookie("popup" + i) === "done") {
				document.getElementById('layer_popup' + i).style.display = "none";
			} else {
				document.getElementById('layer_popup' + i).style.display = "block";
			}
		}
	}
</script>
<script type="text/javascript">
$(document).ready(function() {
    $(window).scroll( function(){
        $('.popular').each( function(i){
            
            var bottom_of_element = $(this).offset().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();
            
            if( bottom_of_window > bottom_of_element ){
                $(this).animate({'opacity':'1','margin-top':'0px'},1000);
            }
            
        }); 
    });
});

</script>
</head>
<body>
   
	<div id="layer_popup1" class="layer_popup"
		style="top: 50px; left: 50px; width: 500px; height: 500px; background-color: white;">
		<c:forEach var="k" items="${pop}" varStatus="vs">
		    <c:if test="${k.active == 1}">
		        <img class="popimg" style="object-fit: cover;" src="resources/popup/${k.f_name}">
		    </c:if>
		</c:forEach>
		<div id="check1">
			<input type="checkbox" id="chkbox1"> 
			<label for="chkbox1">오늘 하루동안 안 보기</label>
			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
			<a href="javascript:closePop(1);" class="x">닫기</a>
		</div>
	</div>



    <h1 class="display-4 fw-normal">임시 메인 페이지</h1>
    <h1 class="display-4 fw-normal">
        <button onclick="location.href='together_list.do'">준수</button>
    </h1>
    <h1 class="display-4 fw-normal">
        <button onclick="location.href='inquiry_form.do'">보미</button>
    </h1>
    <h1 class="display-4 fw-normal">
        <button onclick="location.href='inquiry_form.do'">해성</button>
    </h1>
    <h1 class="display-4 fw-normal">
        <button onclick="location.href='sign_up_page_go.do'">한욱</button>
    </h1>
    <h1 class="display-4 fw-normal">
        <button onclick="location.href='admin_main.do'">조이</button>
    </h1>
    <h1 class="display-4 fw-normal">
        <button onclick="location.href='camplist.do'">준형</button>
    </h1>
    <a href="inquiry_form.do">1:1문의작성</a>
    <a href="my_info.do">내정보</a>
    <a href="my_faq.do">faq</a>
    <a href="my_main.do">마이페이지</a>
    <a href="together_list.do">동행</a>
    <div class="wrap">
        <div class="popular">
            <h3>Popular campsites</h3>
           
            <c:forEach var="c" items="${camphit}">
                <a href="camp_detail.do?contentid=${c.contentid}">
                
                <img class="popularimg" src="${c.firstimageurl}"></a>
            </c:forEach>
        <p>
            <button onclick="location.href='camplist.do'">Show More</button>
        </p>
        </div>
        <div class="popular">
        <div class="popular">
        <div style="margin-top: 500px;">
            <h3>Find camping mates</h3>
            <c:forEach var="k" items="${board}" varStatus="vs">
                <a href="together_detail.do?t_idx=${k.t_idx}"><p class="find">${k.t_subject }</p></a>
            </c:forEach>
        </div>
        <p>
            <button onclick="location.href='together_list.do'">Show More</button>
        </p>
    </div>
    </div>
</body>
    <%@ include file="hs/footer.jsp"%>
</html>