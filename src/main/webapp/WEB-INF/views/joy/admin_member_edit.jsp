<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="resources/css/reset.css" rel="stylesheet" />
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>회원관리 상세</title>
<style>
body {
	background-color: #F6FFF1;
}

.head {
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

.proimg {
	width: 100px;
	height: 100px;
	margin: 30px auto;
	border-radius: 100%;
	background-color: gainsboro;
}

.left {
	width: 200px;
	height: 200px;
}

.right {
	width: 700px;
	height: 900px;
}

table {
	width: 100%;
	border-top: 1px solid #032805;
	border-collapse: collapse;
}

th, td {
	border-bottom: 1px solid #032805;
	padding: 10px;
	text-align: center;
	width: 100%;
}

th {
	background-color: #032805;
	color: white;
}

.b1 button {
	margin-top: 20px;
	width: 140px;
	height: 30px;
	background-color: #032805;
	color: white;
	border: 0px;
	border-radius: 3px;
	margin: 0 auto;
}
.top >button:hover {
margin-top: 20px;
	width: 467px;
	height: 50px;
	background-color: #F6FFF1;
	border: 1px solid black;
	border-radius: 3px;
	margin: 15px;
	background-color: #053610;
	color: white;
}

.b2 {
	margin: 50 auto;
	text-align: center;
}

.under {
	margin-top: 200px;
	width: 1000px;
	margin: 200px auto;
}

.top button {
	margin-top: 20px;
	width: 467px;
	height: 50px;
	background-color: #F6FFF1;
	border: 1px solid black;
	border-radius: 3px;
	margin: 15px;
}
</style>
</head>
<body>
	<h2 class="head">회원 관리 상세</h2>
	<h3 style="text-align: center;">회원 상세 정보</h3>
	<div class="wrap">
			<div class="left">
				<div class="proimg"></div>
				<div style="margin: auto; width: 140px;">
					<p style="text-align: center;" class="b1"><button onclick="removeimg.do">이미지 삭제</button></p>
				</div>
			</div>
			<div class="right">
		<c:forEach var="m" items="${member}"> 
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
						<c:if test="${m.member_login == 0 }">
						<td>O</td>
						<td>카카오</td>
						</c:if>
						
						 <c:if test="${m.member_login == 1 }">
						<td>X</td>
						<td>카카오</td>
						</c:if>
						
						<c:if test="${m.member_login == 2 }">
						<td>X</td>
						<td>네이버</td>
						</c:if> 
						
						<td>${report}</td>
						
						 <c:if test="${m.member_active== 0}">
						<td>활동중</td>
						</c:if>
						
						<c:if test="${m.member_active== 1}">
						<td>정지</td>
						</c:if> 
					</tr>
				</table>
				<p style="text-align: center; margin-top: 50px;">
				 <button type="submit">수정완료</button>
				</p>
				</form>
		</c:forEach>
			</div>
		</div>
</body>
</html>
