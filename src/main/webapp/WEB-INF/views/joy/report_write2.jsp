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
    top: 54.5%;
    left: 33.5%;
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	function popup_write_ok(f) {
		for (var i = 0; i < f.elements.length; i++) {
			if (f.elements[i].value == "") {
				if (i == 3) continue;
				alert(f.elements[i].name + "를 입력하세요");
				f.elements[i].focus();
				return;//수행 중단
			}
		}
		f.submit();
	}
</script>
</head>
<body>
    <h2 class="head">정지 내용 작성하기</h2>
    <div class="wrap">
        <div class="left">
							<form action="report_writeok2.do" method="post">
							<c:forEach var="m" items="${member}">
								<input type="hidden" name="member_idx" value="${m.member_idx}" />
								<h3>정지 내용</h3>
								<textarea rows="10" cols="60" name="stop_content" maxlength="100"></textarea>
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
								<button type="button" class="modal_btn">회원 정지</button>
								<input type="button" value="취소" onclick="history.go(-1)" />
							</c:forEach>
							</form>
						<!--end 모달 팝업-->		
        </div>
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
</html>