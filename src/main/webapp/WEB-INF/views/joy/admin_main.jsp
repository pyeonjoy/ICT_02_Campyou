<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<link href="resources/css/reset.css" rel="stylesheet" />
<%@ include file="../hs/admin_menu.jsp" %>
<head>
<meta charset="utf-8">
<title>관리자 페이지 메인</title>
<style>
@font-face {
    font-family: 'JalnanGothic';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_231029@1.1/JalnanGothic.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
h2{
     font-family: 'JalnanGothic';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_231029@1.1/JalnanGothic.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
h4{
    font-family: 'JalnanGothic';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_231029@1.1/JalnanGothic.woff') format('woff');
    font-weight: normal;
    font-style: normal;
    line-height: 30px;
}
body{
  background-color: #F6FFF1;
}
.admhead{
    text-align: center;
    color: #053610;
}
.wrap{
    margin: 0 auto;
    width: 960px;
    height: 900px;
    padding-top: 200px;
}
.inner {
    text-align: center;
    width: 300px;
    height:200px;
    padding: 30px;
    float: left;
    border-radius: 10px;
    box-shadow: 0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
    margin: 10px;
    margin-top: 50px;
}
.inner h4{
display:inline-block;
background-color: #FFBA34;
border-radius: 10px;
padding: 10px;
margin-bottom: 10px;
padding-bottom: 5px;
}
.inner > *{
margin: 7px;
line-height: 15px;
font-size: 15px;
}

</style>
</head>
<body>
    <div class="wrap">
    <h2 class="admhead">관리자님 환영합니다</h2>
            <div class="inner">
            <c:forEach var="k" items="${member}">
                <h4>유저 현황</h4>
                <p>총 회원: ${k.totalMembers}</p>
                <p>오늘 가입자: ${k.todayMembers}</p>
                <p>누적 탈퇴 회원: ${k.unactiveMembers}</p>
            </c:forEach>
            </div>
            <div class="inner">
				 <c:forEach var="b" items="${board}">
				    <h4>금일 커뮤니티 현황</h4>
				    <p>자유게시판: ${b.totalb_idx}</p>
				    <p>동행 게시판: ${b.totalt_idx} | 매칭: ${match}</p>
				    <p>추천게시판: ${b.totalcp_idx}</p>
				</c:forEach>

            </div>
            <div class="inner">
                <h4>미처리 문의</h4>
                <c:choose>
                    <c:when test="${admin_qna == 0}">
                        <p>미처리 문의가 없습니다</p>
                    </c:when>
                    <c:otherwise>
                        <p>1:1문의: ${qna}</p>
                    </c:otherwise>
                </c:choose>
                <p>신고 내역: ${report}</p>
            </div>
</div>
<jsp:include page="../hs/footer.jsp" />
</body>
</html>
