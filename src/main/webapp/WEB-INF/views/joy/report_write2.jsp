<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>정지 하기</title>
<style>
body{
background-color: #F6FFF1; 
}
.head{
    text-align: center;
    padding-top: 200px;
}
.wrap {
    margin: 0 auto;
    height: 500px;
    text-align: center;
}
.wbtn{
margin: 20px auto;
    width: 300px;
}
.text{
margin: 26px 0px 10px 0px;
}
button{
padding-left: 10px;
padding-right: 10px;
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
	top: 70%;
    left: 42%;
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
<%@ include file="../hs/header.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
    <h3 class="head">정지 사유</h3>
    <div class="wrap">
            <form action="report_writeok2.do" method="post">
            <c:forEach var="m" items="${member}">
				<input type="hidden" name="member_idx" value="${m.member_idx}" />
			</c:forEach>
						<div>
						<p class="text">신고 내용</p>
						<textarea rows="10" cols="60" name="stop_content" maxlength="100"></textarea>
						</div>
						<div class="modal">
								<div class="modal_popup">
										<input type="radio" name="stop_day" value="3">3일
										<input type="radio" name="stop_day" value="7">7일
										<input type="radio" name="stop_day" value="30">30일
										<input type="radio" name="stop_day" value="60">60일
										<input type="radio" name="stop_day" value="90">90일
										<input type="radio" name="stop_day" value="9999">무기한
									<div style="margin-top: 20px;">
											<button type="submit" onclick="location.href='report_writeok2.do?member_idx=${m.member_idx}">확인</button>
											<button type="button" class="close_btn">닫기</button>
									</div>
								</div>
						</div>
						
						<div class="wbtn">
						<button type="button" class="modal_btn">회원 정지</button>
						<button type="button"  onclick="history.go(-1)">취소</button>
						</div>
			</form>
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
    </body>
    <jsp:include page="../hs/footer.jsp" />
</html>