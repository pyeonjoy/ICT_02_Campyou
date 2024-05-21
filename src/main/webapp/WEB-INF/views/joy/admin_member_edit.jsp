<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<link href="resources/css/reset.css" rel="stylesheet" />
<link href="resources/public/css/joy/admin_member_detail.css" rel="stylesheet" />
<%@ include file="../hs/admin_menu.jsp" %>
<head>
<meta charset="utf-8">
<title>회원관리 편집</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<style>
.wrqp {
height: 475px;}
.wrap input{
    width: 133px;
    text-align: center;}
</style>
</head>
<body>
	<h3 class="head">회원 관리 상세</h3>
	
	<div class="wrap">
		<c:forEach var="m" items="${member}"> 
			<div class="left">
				<p style="text-align: center"><img src="${path}/resources/images/${m.member_img}" class="proimg"></p>
				<div style="margin: auto; width: 140px;">
					<p style="text-align: center;" class="b1"><button onclick="removeimg.do">이미지 삭제</button></p>
				</div>
			</div>
			<div class="right">
				<form action="member_edit_ok.do" method="post">
				<table style="table-layout: auto; width: 100%; table-layout: fixed;">
					<tr>
						<th>NO</th>
						<th>ID</th>
						<th>이름</th>
						<th>닉네임</th>
					</tr>
					<tr>
						<td><input type="hidden" name="member_idx" value="${m.member_idx }">${m.member_idx }</td>
						<td><input type="text" name="member_id" value="${m.member_id }"></td>
						<td><input type="text" name="member_name" value="${m.member_name }"></td>
						<td><input type="text" name="member_nickname" value="${m.member_nickname }"></td>
					</tr>


					<tr>
						<th>가입일</th>
						<th>생년월일</th>
						<th>전화번호</th>
						<th>이메일</th>
					</tr>
					<tr>
						<td><input type="text" name="member_regdate" value="${m.member_regdate }"></td>
						<td><input type="text" name="member_dob" value="${m.member_dob }"></td>
						<td><input type="text" name="member_phone" value="${m.member_phone }"></td>
						<td><input type="text" name="member_email" value="${m.member_email }"></td>
					</tr>


					<tr>
						<th>일반가입</th>
						<th>SNS</th>
						<th>신고</th>
						<th>상태</th>
					</tr>
					<tr>
						<c:if test="${m.member_grade == 0}">
						<td><button type="button" onclick="location.href='member_upgrade.do?member_idx=${m.member_idx}'">관리자 지정</button></td>
						</c:if>
						<c:if test="${m.member_grade == 1}">
						<td>관리자</td>
						</c:if>
						<td>${m.member_grade}</td>
						<td>${report}</td>
						
						 <c:if test="${m.member_active== 1}">
						<td>활동중</td>
						</c:if>
						
						<c:if test="${m.member_active== 0}">
						<td>
							정지중
						</td>
						</c:if> 
					</tr>
				</table>
				<p style="text-align: center; margin-top: 50px;">
				 <button type="submit">수정완료</button>
				 <button type="button" onclick='history.go(-1)'>취소</button>

				</p>
				</form>
			</div>
		</c:forEach>
		</div>
		<%@ include file="../hs/footer.jsp" %>
</body>
</html>
