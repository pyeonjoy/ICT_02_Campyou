<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="resources/css/reset.css" rel="stylesheet" />
<title>캠핑장리스트</title>
<style type="text/css">
#camp_list_show {
    display: flex;
    justify-content: center;
    align-items: flex-start;
    flex-wrap: wrap;
}

.camp_item {
    position: relative;
    display: flex;
    width: 45%;
    margin-bottom: 40px;
    padding: 20px;
    border: 1px solid black;
    box-sizing: border-box;
    margin-right: 4%;
}

.camp_item img {
    width: 220px;
    height: 180px;
    margin-right: 20px;
}

.camp_info {
    width: 60%;
}

.camp_item p {
    margin: 0;
    margin-bottom: 10px;
}

.button_container {
    position: absolute;
    top: 10px;
    right: 10px;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
    let pageNo = 1;
    
    function camp_all_list() {
        $.ajax({
            url: "camp_list.do",
            method: "post",
            data: { pageNo: pageNo },
            dataType: "xml",
            success: function(data) {
                $("#camp_list_show").empty();
				/* 
				doNm = "지역명(강원도)"
				sigunguNm = "시군(춘천시)"
				facltNm = "캠핑장 이름"
				induty = "캠핑유형"
				addr1 = "주소"
				tel = "캠핑장 전화번호"
				homepage = "홈페이지 버튼"			
				*/
                $(data).find("item").each(function() {
                    let firstImageUrl = $(this).find("firstImageUrl").text();
                    let doNm = $(this).find("doNm").text();
                    let sigunguNm = $(this).find("sigunguNm").text();
                    let facltNm = $(this).find("facltNm").text();
                    let induty = $(this).find("induty").text();
                    let addr1 = $(this).find("addr1").text();
                    let tel = $(this).find("tel").text();
                    let homepage = $(this).find("homepage").text();

                    let campItem = "<div class='camp_item'>";
                    campItem += "<img src='" + firstImageUrl + "' alt='이미지'>";
                    campItem += "<div class='camp_info'>";
                    campItem += "<p> ["+ doNm + sigunguNm+"] </p>";
                    campItem += "<p><b>" + facltNm + "</b><br>" + induty + "</p>";
                    campItem += "<p>" + addr1 + "</p>";
                    campItem += "<p>" + tel + "</p>";
                    campItem += "</div>";
                    campItem += "<div class='button_container'><button onclick=\"window.open('" + homepage + "')\">홈페이지</button></div>";
                    campItem += "</div>";

                    $("#camp_list_show").append(campItem);
                });
            },
            error: function() {
                alert("읽기 실패");
            }
        });
    }
	
    function nextPage() {
        pageNo++;
        camp_all_list();
    }
    function beforePage() {
        pageNo--;
        camp_all_list();
    }

    camp_all_list();

    $(".camp_list_next").on("click", function() {
        nextPage();
    });
    $(".camp_list_before").on("click", function() {
        beforePage();
    });
});
</script>
</head>
<body>
    <div id="camp_list_show"></div>
    <div id ="camp_list_button">
    <button class="camp_list_before">이전 페이지</button>
    <button class="camp_list_next">다음 페이지</button>
    </div>
</body>
</html>
