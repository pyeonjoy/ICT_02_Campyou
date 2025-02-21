<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>신고하기</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="resources/css/reset.css">
<style>
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
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</script>
<script type="">

</script>
</head>
<body>
<h3 class="head">신고 글 작성하기</h3>
<div class="wrap">
    <form action="report_writeok" method="post">
        <input type="hidden" name="reportmember_idx" value="${reportmember_idx}" />
        <div>
            <p class="text">신고 내용</p>
            <textarea rows="10" cols="60" name="report_content" maxlength="100"></textarea>
        </div>
        <div class="wbtn">
            <button type="button">입력</button> 
            <button type="button" onclick="history.go(-1)">취소</button>
        </div>
    </form>
</div> 


</body>
</html>
