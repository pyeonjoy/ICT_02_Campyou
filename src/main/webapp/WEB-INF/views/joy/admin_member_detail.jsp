<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<link href="resources/css/reset.css" rel="stylesheet" />
<link href="resources/css/joy/admin_member_detail.css" rel="stylesheet" />
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=qpvmsbuult"></script>
<%@ include file="../hs/admin_menu.jsp"%>
<head>
<meta charset="utf-8">
<style type="text/css">
</style>
<title>회원관리 상세</title>
</head>
<body>
	<h2 class="head">회원 관리 상세</h2>
	<h3 style="text-align: center;">회원 상세 정보</h3>
		<div class="wrap">
			<div class="left">
			<c:forEach var="m" items="${member}">
				<p style="text-align: center">
					<img src="${path}/resources/images/${m.member_img}" class="proimg">
				</p>
				<div style="margin: auto; width: 140px;">
					<p style="text-align: center;" class="b1">
						<button
							onclick="location.href='removeimg.do?member_idx=${m.member_idx}'">이미지
							삭제</button>
					</p>
				</div>
			</c:forEach>
			</div>
			<div class="right">
				<table style="table-layout: auto; width: 100%; table-layout: fixed;">
	<c:forEach var="m" items="${member}">
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
							<td>일반회원</td>
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
							<td>정지중</td>
						</c:if>
					</tr>
		</c:forEach>
				</table>
				<div class="modal">
				<c:forEach var="r" items="${reporteach}">
							<div class="modal_popup">
								<form action="admin_report.do" method="post">
								<input type="hidden" name="report_idx" value="${r.report_idx }" >
								<input type="hidden" name="member_idx" value="${r.member_idx }" >
								<input type="radio" name="report_day" value="0">${r.report_idx }
								<input type="radio" name="report_day" value="3">3일
								<input type="radio" name="report_day" value="7">7일
								<input type="radio" name="report_day" value="30">30일
								<input type="radio" name="report_day" value="60">60일
								<input type="radio" name="report_day" value="90">90일
								<input type="radio" name="report_day" value="9999">무기한
								<div style="margin-top: 20px;">
								<button type="submit" onclick="location.href='admin_report.do?member_idx=${r.member_idx}">확인</button>
								<button type="button" class="close_btn">닫기</button>
								</div>
								</form>
							</div>
				</c:forEach>
						</div>
						<!--end 모달 팝업-->		
								<button type="button" class="modal_btn">회원 정지</button>
				<c:forEach var="m" items="${member}">
				<button type="button"
					onclick="location.href='member_edit.do?member_idx=${m.member_idx}'">회원수정</button>
				<button type="button"
					onclick="location.href='member_stop.do?member_idx=${m.member_idx}'">회원삭제</button>
				<button type="button" onclick="location.href='admin_member_list.do'">목록으로</button>
				</c:forEach>
			</div>
		</div>
		<div class=under>
			<table style="table-layout: auto; width: 100%; table-layout: fixed;">
					<tr>
						<th>신고번호</th>
						<th>신고 내용</th>
						<th>신고 날짜</th>
						<th>신고 처리 날짜</th>
						<th>신고 처리 관리자</th>
						<th>신고 상태</th>
						<th>상태 변경</th>
					</tr>
				<c:forEach var="r" items="${reporteach}">
					<tr>
						<td>${r.report_idx }</td>
						<td>${r.report_content }</td>
						<td>${r.report_date }</td>
						<td>${r.report_ok_date }</td>
						<td>${r.member_idx }</td>
						<c:if test="${r.report_status == 0}">
						<td>신고 처리 대기</td>
						</c:if>
						<c:if test="${r.report_status == 1}">
						<td>신고 처리 완료</td>
						</c:if>
					</tr>
				</c:forEach>
			</table>
		</div>
		<script type="text/javascript">
const modal = document.querySelector('.modal');
const modalOpen = document.querySelector('.modal_btn');
const modalClose = document.querySelector('.close_btn');


//열기 버튼을 눌렀을 때 모달팝업이 열림
modalOpen.addEventListener('click',function(){
    //display 속성을 block로 변경
    modal.style.display = 'block';
});
//닫기 버튼을 눌렀을 때 모달팝업이 닫힘
modalClose.addEventListener('click',function(){
   //display 속성을 none으로 변경
    modal.style.display = 'none';
});
</script>
		<jsp:include page="../hs/footer.jsp" />
</body>
</html>
