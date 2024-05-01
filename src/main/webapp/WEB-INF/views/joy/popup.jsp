<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>관리자 페이지 메인</title>
<style>
body {
	background-color: #F6FFF1;
}
.head{
    text-align: center;
    margin: 100px;;
}
.wrap {
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-gap: 10px;
    margin: 0 auto;
    padding: 10px;
    height: 100px;
    width: 1000px;
}
.hr{
    width: 500px;
}
.mainimg{
    width: 400px;
    height: 400px;
    margin: 30px auto;
    background-color: gainsboro;
}
.left {
    width: 500px;
    height: 500px;
}
.right {
    width: 500px;
    height: 500px;
}
.category{
    width: 450px;
    background-color: #053610;
    display: grid;
    grid-template-columns: 0.5fr 1fr 0.5fr;
    grid-gap: 10px;
    height: 50px;
    padding-left: 50px;
}
.inner{
    width: 450px;
    display: grid;
    grid-template-columns: 0.5fr 0.2fr 0.8fr 0.5fr;
    grid-gap: 10px;
    height: 50px;
    padding-left: 50px;
    padding-top: 10px;
}
.child {
width: 100px;
height: 50px;
}
.subimg{
    width: 50px;
    height: 50px;
    background-color: gainsboro;
}
button{
    margin-top: 20px;
    width: 100px;
    height: 30px;
    background-color: #032805;
    color: white;
    border: 0px;
    border-radius: 3px;
    margin: 0 auto;
    
}
.b1{
    float: right;
}
</style>
</head>
<body>
    <h2 class="head">팝업 관리</h2>
    <div class="wrap">
        <div class="left">
            <hr class="hr">
            <div class="mainimg"></div>
            <hr class="hr">
            <button>수정</button>
            <button>추가</button>
        </div>
        <div class="right">
            <p style="text-align: center;">이전팝업창</p>
            <div class="category">
                <p class="child">번호</p>
                <p class="child">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제목</p>
                <p class="child">작성 날짜</p>
            </div>
            <div class="inner">
                <p class="child">번호</p>
                <div class="subimg"></div>
                <p class="child">이벤트 팝업</p>
                <p class="child">2024-00-00</p>
                <button class="b1">작성</button>
            </div>
            <hr>
        </div>
    </div>
    </body>
</html>