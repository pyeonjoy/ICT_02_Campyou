<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<link href="resources/css/reset.css" rel="stylesheet" />
<link href="resources/css/joy/admin_member_detail.css" rel="stylesheet" />
<%@ include file="../hs/admin_menu.jsp" %>
<head>
<meta charset="utf-8">
<title>회원관리 상세</title>
<!-- <script type="text/javascript">
window.addEventListener('DOMContentLoaded', function() {
	  showContent('A');
	});

	function showContent(content) {
	  var contentA = document.getElementById("contentA");
	  var contentB = document.getElementById("contentB");

	  // 내용 숨김
	  contentA.style.display = "none";
	  contentB.style.display = "none";

	  // 선택한 내용 보이기
	  if (content === "A") {
	    contentA.style.display = "block";
	  } else if (content === "B") {
	    contentB.style.display = "block";
	  }
	}
</script> -->
</head>
<body>
	<h2 class="head">회원 관리 상세</h2>
	<h3 style="text-align: center;">회원 상세 정보</h3>
		<c:forEach var="m" items="${member}"> 
	<div class="wrap">
			<div class="left">
				<p style="text-align: center"><img src="${path}/resources/images/${m.member_img}" class="proimg"></p>
				<div style="margin: auto; width: 140px;">
					<p style="text-align: center;" class="b1"><button onclick="location.href='removeimg.do?member_idx=${m.member_idx}'">이미지 삭제</button></p>
				</div>
			</div>
			<div class="right">
				<table style="table-layout: auto; width: 100%; table-layout: fixed;">
					<tr>
						<th>NO</th>
						<th>ID</th>
						<th>이름</th>
						<th>닉네임</th>
					</tr>
					<tr>
						<td>${m.member_idx }</td>
						<td>${m.member_id }</td>
						<td>${m.member_name }</td>
						<td>${m.member_nickname }</td>
					</tr>


					<tr>
						<th>가입일</th>
						<th>생년월일</th>
						<th>전화번호</th>
						<th>이메일</th>
					</tr>
					<tr>
						<td>${m.member_regdate }</td>
						<td>${m.member_dob }</td>
						<td>${m.member_phone }</td>
						<td>${m.member_email }</td>
					</tr>


					<tr>
						<th>관리자 권한</th>
						<th>등급</th>
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
				<p class="b2" style="margin-top: 15px;">
				<c:if test="${m.member_active== 1}">
				<button type="button" onclick="location.href='member_stop.do?member_idx=${m.member_idx}'">회원정지</button>
				</c:if>
				<c:if test="${m.member_active== 0}">
				<button type="button" onclick="location.href='member_stopcancel.do?member_idx=${m.member_idx}'">정지해제</button>
				</c:if>
				<button type="button" onclick="location.href='member_edit.do?member_idx=${m.member_idx}'">회원수정</button>
				<button type="button" onclick="location.href='member_stop.do?member_idx=${m.member_idx}'">회원삭제</button>
				<button type="button" onclick="location.href='admin_member_list.do'">목록으로</button>
			</p>
			</div>
		</div>
		<div class=under>
		</c:forEach>
			<table style="table-layout: auto; width: 100%; table-layout: fixed;">
				<c:forEach var="r" items="${reporteach}"> 
				<tr>
					<th>신고번호</th>
					<th>신고 내용</th>
					<th>신고 날짜</th>
					<th>신고 처리 날짜</th>
					<th>신고 처리 관리자</th>
					<th>신고 상태</th>
				</tr>
				<tr>
					<td>${r.report_idx }</td>
					<td>${r.report_content }</td>
					<td>${r.report_date }</td>
					<td>${r.report_ok_date }</td>
					<td>${r.member_idx }</td>
					<td>${r.report_status }</td>
				</tr>
				</c:forEach>
			</table>
		</div>
			
		<%-- <div class="under">
			<h3 style="text-align: center; margin-top: 300px;">작성한글</h3>
			<div class="top">
				<button id="buttonA"  onclick="showContent('A')">자유게시판</button>
				<button id="buttonB" onclick="showContent('B')">캠핑제품추천</button>
			</div>
			<c:forEach var="b" items="${board}"> 
			<div id="contentA">
			<table style="table-layout: auto; width: 100%; table-layout: fixed;">
				<tr>
					<th>번호</th>
					<th>유형</th>
					<th>제목</th>
					<th>닉네임</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>상태</th>
				</tr>
				<tr>
					
					<td>${b.b_idx }</td>
					<td>${b.b_type }</td>
					<td>${b.b_subject }</td>
					<td>${b.member_nickname }</td>
					<td>${b.b_regdate }</td>
					<td>${b.b_hit }</td>
					<td>${b.b_active }</td>
				</tr>
			</table>
			</div>
			<div id="contentB">
			<table style="table-layout: auto; width: 100%; table-layout: fixed;">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>닉네임</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
				<tr>
					<td>${b.cp_idx }</td>
					<td>${b.cpf_name }</td>
					<td>${b.cp_regdate }</td>
					<td>${b.cp_hit }</td>
					<td>${b.cp_active }</td>
				</tr>
			</table>
			</div>
			</c:forEach>
		</div> --%>
		<jsp:include page="../hs/footer.jsp" />
</body>
</html>
