<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
li{
list-style: none;
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
        </div>
        <div class="right">
            <p style="text-align: center;">이전팝업창</p>
            <div class="category">
                <p class="child">번호</p>
                <p class="child">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제목</p>
                <p class="child">작성 날짜</p>
            </div>
            	<c:forEach var="p" items="${pop}">
            <div class="inner">
            	<input type="checkbox">
                <p>${p.popidx }</p>
                <img style="object-fit: cover;" class="subimg" src="resources/popup/${p.f_name}">
                <p class="child">${p.title }</p>
                <p class="child">${p.writer }</p>
                <p class="child">${p.regdate }</p>
            </div>
            <button class="b1" onclick="location.href='popup_write.do'">추가</button>
                </c:forEach>
            <button class="b1" onclick="location.href='popup_delete.do'">삭제</button>
            <hr>
						<input type="button" value="글쓰기" onclick="board_write()">
            <table>
            <tr>
					<td colspan="4">
						<ol class="paging">
							<!-- 이전 버튼 -->
							<c:choose>
								<c:when test="${paging.beginBlock <= paging.pagePerBlock }">
									<li class="disable">이전으로</li>
								</c:when>
								<c:otherwise>
									<li><a href="board_list.do?cPage=${paging.beginBlock - paging.pagePerBlock }">이전으로</a></li>
								</c:otherwise>
							</c:choose>
							<!-- 페이지번호들 -->
							<c:forEach begin="${paging.beginBlock}" end="${paging.endBlock}" step="1" var="k">
							    <c:choose>
							        <c:when test="${k == paging.nowPage}">
							            <li class="now">${k}</li>
							        </c:when>
							        <c:otherwise>
							            <li><a href="board_list.do?cPage=${k}">${k}</a></li>
							        </c:otherwise>
							    </c:choose>
							</c:forEach>
							
							<!-- 이후 버튼 -->
								<c:choose>
								<c:when test="${paging.endBlock >= paging.totalPage }">
									<li class="disable">다음으로</li>
								</c:when>
								<c:otherwise>
									<li><a href="board_list.do?cPage=${paging.beginBlock + paging.pagePerBlock }">다음으로</a></li>
								</c:otherwise>
							</c:choose>
						</ol>	
					</td>
					<td>
					</td>
				</tr>
            </table>
            
        </div>
    </div>
    </body>
</html>