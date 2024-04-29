<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
	let contentId = {contentid};
	
    $.ajax({
        url: "camp_detail_img.do",
        method: "post",
        data: { contentid: contentId },
        dataType: "xml",
        success: function(data) {
        	console.log(contentid);
            $("#detail_img").empty();
            $(data).find("item").each(function() {
                let imageUrl = $(this).find("imageUrl").text();
                let contentid = $(this).find("contentId").text();
                
                let campImg = "<div>";
                campImg += "<img src='" + imageUrl + "' alt='이미지'>";
                campImg += "</div>";

                $("#detail_img").append(campImg);
            });
        },
        error: function() {
            alert("읽기 실패");
        }
    });
});
</script>

<title>캠핑장 상세 페이지</title>
</head>
<body>
	<h2>상세보기</h2>
	<div id="detail_img"></div>
    <p>주소: ${info.addr1}</p>
    <p>유형: ${info.induty}</p>
</body>
</html>