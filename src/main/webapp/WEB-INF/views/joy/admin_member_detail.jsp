<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<link href="resources/css/reset.css" rel="stylesheet" />
<link href="resources/public/css/joy/admin_member_detail.css" rel="stylesheet" />
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=qpvmsbuult"></script>
<script type="module" src="https://ryj9d86xjh.execute-api.ap-northeast-2.amazonaws.com/v1/api/js/drop_fontstream_js/?sid=gAAAAABmQdUd8y-oUIO39NM2Moe5C2mGa0rE06hJqBQcaKXQO9x1HZhXz-WNG8kMCK3TAgzebfkuj-tJJActuz4i_AXWHPXtAQ5fYARL4KKKG5dpxVqwpQaS5_PtsJD2TxV7ifaxqHtTXbxaXLMohwIGqJLEHw0eOT1hI3cGDK2AvnoVfX2q2kSEKwbB4KqAYW5kVR3ESF5sekzdtMKkIeZ_QvAPFemEItrqqhsC-dfYLFu0qV7Cn9R_zUzqgTZCH6xF61N0t4vI" charset="utf-8"></script><head>
<%@ include file="../hs/admin_menu.jsp"%>
<meta charset="utf-8">
<style type="text/css">

</style>
<title>회원관리 상세</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
</head>
<body>
	<h3 class="head" style="">회원 관리 상세</h3>
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

						<c:if test="${m.member_active== 0}">
							<td>활동중</td>
						</c:if>

						<c:if test="${m.member_active== -1}">
							<td>정지중</td>
						</c:if>
						
						<c:if test="${m.member_active== -2}">
							<td>회원삭제</td>
						</c:if>
					</tr>
		</c:forEach>
				</table>
				<c:choose>
				<c:when test="${not empty reporteach}">
				<div class="modal">
						<c:forEach var="r" items="${reporteach}">
									<div class="modal_popup">
										<form action="admin_report.do" method="post">
										<input type="hidden" name="report_idx" value="${r.report_idx }" >
										<input type="hidden" name="reportmember_idx" value="${r.reportmember_idx }" >
										<input type="radio" name="report_day" value="3">3일
										<input type="radio" name="report_day" value="7">7일
										<input type="radio" name="report_day" value="30">30일
										<input type="radio" name="report_day" value="60">60일
										<input type="radio" name="report_day" value="90">90일
										<div style="margin-top: 20px;">
										<button type="submit" onclick="location.href='admin_report.do?member_idx=${r.member_idx}">확인</button>
										<button type="button" class="close_btn">닫기</button>
										</div>
										</form>
									</div>
						</c:forEach>
					</div>
					
					
					
					<c:forEach var="r" items="${reporteach}" varStatus="loop">
					    <!-- 첫 번째 배열만 처리 -->
					    <c:if test="${loop.index == 0}">
					        <!-- 처리할 내용 -->
					        <button type="button" class="modal_btn">신고 처리</button>
					    </c:if>
					</c:forEach>

					<script type="text/javascript">
					    document.addEventListener("DOMContentLoaded", function() {
					        const modalOpenButtons = document.querySelectorAll('.modal_btn');
					        const modalCloseButtons = document.querySelectorAll('.close_btn');
					        const modal = document.querySelector('.modal');
					
					        // 열기 버튼을 눌렀을 때 모달팝업이 열림
					        modalOpenButtons.forEach(function(button) {
					            button.addEventListener('click', function() {
					                modal.style.display = 'block';
					            });
					        });
					
					        // 닫기 버튼을 눌렀을 때 모달팝업이 닫힘
					        modalCloseButtons.forEach(function(button) {
					            button.addEventListener('click', function() {
					                modal.style.display = 'none';
					            });
					        });
					    });
					</script>
				</c:when>
				</c:choose>
				<c:forEach var="m" items="${member}">
				<c:if test="${m.member_active== 0}">
				<button type="button" onclick="location.href='report_write2.do?member_idx=${m.member_idx}'">정지하기</button>
				</c:if>
				<c:if test="${m.member_active== -1}">
				<button type="button" onclick="location.href='member_stopcancel.do?member_idx=${m.member_idx}'">정지해제</button>
				</c:if>
				<c:if test="${m.member_active== -2}">
				<button type="button" onclick="location.href='member_stopcancel.do?member_idx=${m.member_idx}'">탈퇴취소</button>
				</c:if>
				</c:forEach>
				<c:forEach var="m" items="${member}">
				<button type="button"
					onclick="location.href='member_edit.do?member_idx=${m.member_idx}'">회원수정</button>
				<button type="button"
					onclick="location.href='member_stop.do?member_idx=${m.member_idx}'">회원삭제</button>
				</c:forEach>
			</div>
				<button style="margin: 37px 157%; background-color: #041601; color: white" type="button"  onclick="history.go(-1)">목록으로</button>

		</div>
		<div class=under>
			<table style="table-layout: auto; width: 100%; table-layout: fixed;">
					<tr>
						<th>신고번호</th>
						<th>신고 내용</th>
						<th>신고 날짜</th>
						<th>처리 날짜</th>
						<th>정지 만료 날짜</th>
						<th>처리 관리자</th>
						<th>상태</th>
					</tr>
				<c:forEach var="r" items="${reporteach}">
					<tr>
						<td>${r.report_idx }</td>
						<td>${r.report_content }</td>
						<td>${r.report_date }</td>
						<td>${r.report_now_date }</td>
						<td>${r.report_ok_date }</td>
						<td>${r.admin_idx }</td>
						<c:if test="${r.report_status == 0}">
						<td>처리 대기</td>
						</c:if>
						<c:if test="${r.report_status == 1}">
						<td>처리 완료</td>
						</c:if>
					</tr>
				</c:forEach>
			</table>
			<table style="table-layout: auto; width: 100%; table-layout: fixed; margin-top: 20px;">
					<tr>
						<th>정지번호</th>
						<th>정지 내용</th>
						<th>정지 날짜</th>
						<th>정지 만료 날짜</th>
						<th>처리 관리자</th>
						<th>상태</th>
					</tr>
				<c:forEach var="r" items="${stop}">
					<tr>
						<td>${r.stop_idx }</td>
						<td>${r.stop_content }</td>
						<td>${r.stop_date }</td>
						<td>${r.stop_ok_date }</td>
						<td>${r.admin_idx }</td>
						<td>처리 완료</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		
		<jsp:include page="../hs/footer.jsp" />
</body>
</html>
