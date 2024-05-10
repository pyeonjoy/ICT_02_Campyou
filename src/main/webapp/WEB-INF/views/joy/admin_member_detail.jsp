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
/* @charset "UTF-8"; */
body {
	background-color: #F6FFF1;
}

.head {
	padding-top: 250px;
	text-align: center;
}

.wrap {
	display: grid;
	grid-template-columns: 1fr 1fr;
	grid-gap: 10px;
	margin: 0 auto;
	padding: 10px;
	width: 1000px;
}

.proimg {
	width: 90px;
	height: 90px;
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
}

table {
	width: 100%;
	border-top: 1px solid #032805;
	border-collapse: collapse;
}

th, td {
	border-bottom: 1px solid #032805;
	padding: 11px;
	text-align: center;
	width: 100%;
	height: 40px;
}

th {
	background-color: #032805;
	color: white;
}

button {
	margin-top: 20px;
	width: 140px;
	height: 30px;
	background-color: #032805;
	color: white;
	border: 0px;
	border-radius: 3px;
	margin: 0 auto;
}

button:hover {
	margin-top: 20px;
	width: 140px;
	height: 30px;
	background-color: #FFBA34;
	color: white;
	border: 0px;
	border-radius: 3px;
	margin: 0 auto;
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
	color: black;
}

.top>button:hover {
	margin-top: 20px;
	width: 467px;
	height: 50px;
	background-color: #FFBA34;
	border: 1px solid black;
	border-radius: 3px;
	margin: 15px;
	background-color: #053610;
	color: white;
}

.right input {
	text-align: center;
}

h2 {
	text-align: center;
}

/*모달 팝업 영역 스타일링*/
.modal {
	/*팝업 배경*/
	display: none;
    width: 10px;
    height: 0px;
}

.modal .modal_popup {
	/*팝업*/
	position: absolute;
    top: 100%;
    left: 64%;
	transform: translate(-50%, -50%);
	padding: 20px;
	background: #ffffff;
	border-radius: 20px;
	box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
}
/*모달 팝업 영역 스타일링*/
.modal2 {
	/*팝업 배경*/
	display: none;
    width: 10px;
    height: 0px;
}

.modal2 .modal_popup2 {
	/*팝업*/
	position: absolute;
    top: 71%;
    left: 44%;
	transform: translate(-50%, -50%);
	padding: 20px;
	background: #ffffff;
	border-radius: 20px;
	box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
}
</style>



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
		<div class="wrap">
			<div class="left">
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
							<td><button type="button"
									onclick="location.href='member_upgrade.do?member_idx=${m.member_idx}'">관리자
									지정</button></td>
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
				<div class="modal2">
				<c:forEach var="r" items="${reporteach}">
							<div class="modal_popup2">
								<form action="admin_report.do" method="post">
								<input type="hidden" name=member_idx value="${r.member_idx }" >
								<input type="hidden" name=report_idx value="${r.report_idx }" >
								<input type="radio" name="report_day" value="0">해제
								<input type="radio" name="report_day" value="3">3일
								<input type="radio" name="report_day" value="7">7일
								<input type="radio" name="report_day" value="30">30일
								<input type="radio" name="report_day" value="60">60일
								<input type="radio" name="report_day" value="90">90일
								<input type="radio" name="report_day" value="9999">무기한
								<div style="margin-top: 20px;">
								<button type="submit" onclick="location.href='member_stop.do?member_idx=${r.member_idx}">확인</button>
								<button type="button" class="close_btn2">닫기</button>
								</div>
								</form>
							</div>
				</c:forEach>
						</div>
						<!--end 모달 팝업-->		
								<button type="button" class="modal_btn2">회원 정지</button>
				<button type="button"
					onclick="location.href='member_edit.do?member_idx=${m.member_idx}'">회원수정</button>
				<button type="button"
					onclick="location.href='member_stop.do?member_idx=${m.member_idx}'">회원삭제</button>
				<button type="button" onclick="location.href='admin_member_list.do'">목록으로</button>
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
						<td>${r.report_status }</td>
						<!--모달 팝업-->
						<td>
						<div class="modal">
							<div class="modal_popup">
								<form action="admin_report.do" method="post">
								<input type="hidden" name=member_idx value="${r.member_idx }" >
								<input type="hidden" name=report_idx value="${r.report_idx }" >
								<input type="radio" name="report_day" value="0">해제
								<input type="radio" name="report_day" value="3">3일
								<input type="radio" name="report_day" value="7">7일
								<input type="radio" name="report_day" value="30">30일
								<input type="radio" name="report_day" value="60">60일
								<input type="radio" name="report_day" value="90">90일
								<input type="radio" name="report_day" value="100">무기한
								<div style="margin-top: 20px;">
								<button type="submit" onclick="location.href='admin_report.do?member_idx=${r.member_idx}'">확인</button>
								<button type="button" class="close_btn">닫기</button>
								</div>
								</form>
							</div>
						</div>
						<!--end 모달 팝업-->
						<div>
							<div>
								<button type="button" class="modal_btn">회원 정지</button>
							</div>
						</div>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>

		<!-- <div class="under">
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
		</div> -->
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
		<script type="text/javascript">
const modal2 = document.querySelector('.modal2');
const modal2Open = document.querySelector('.modal_btn2');
const modal2Close = document.querySelector('.close_btn2');


//열기 버튼을 눌렀을 때 모달팝업이 열림
modal2Open.addEventListener('click',function(){
    //display 속성을 block로 변경
    modal2.style.display = 'block';
});
//닫기 버튼을 눌렀을 때 모달팝업이 닫힘
modal2Close.addEventListener('click',function(){
   //display 속성을 none으로 변경
    modal2.style.display = 'none';
});
</script>
		<jsp:include page="../hs/footer.jsp" />
</body>
</html>
