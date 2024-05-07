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
    <h2 class="head">팝업 관리</h2>
    <div class="wrap">
        <div class="left">
            <form action="popup_write_ok.do" method="post" enctype="multipart/form-data">
				<table width="700px">
				<tbody>
					<tr>
						<th>작성자</th>
						<td align="left"><input type="text" name="writer" value="나중에 세션 id 받아올예정"></td>
					</tr>
					<tr>
						<th>이름</th>
						<td align="left"> <input type="text" name="title"></td>
					</tr>
					<tr>
						<th>내용</th>
						<td align="left"><textarea rows="10" cols="60" name="content"></textarea>
						</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td align="left"><input type="file" name="file"></td>
					</tr>
					<tr>
						<td colspan="2">
						<input type="button" value="입력" onclick="popup_write_ok(this.form)" /> 
						<input type="reset" value="취소" />
						</td>
					</tr>
		            </tbody>
				</table>
			</form>
        </div>
    </div>
    </body>
</html>