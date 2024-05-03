<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>캠핑장리스트</title>
<style type="text/css">
.camp_list_container {
	display: flex;
	flex-direction: column;
	align-items: center;
}

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
#camp_list_button {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}

#camp_list_button button {
    margin: 0 10px;
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
                $(data).find("item").each(function() {
                    let firstImageUrl = $(this).find("firstImageUrl").text();
                    let doNm = $(this).find("doNm").text();
                    let sigunguNm = $(this).find("sigunguNm").text();
                    let facltNm = $(this).find("facltNm").text();
                    let induty = $(this).find("induty").text();
                    let addr1 = $(this).find("addr1").text();
                    let tel = $(this).find("tel").text();
                    let homepage = $(this).find("homepage").text();
                    let contentid = $(this).find("contentId").text();

                    let campItem = "<div class='camp_item' onclick='location.href=\"camp_detail.do?contentid=" + contentid + "\"'>";
                    campItem += "<img src='" + firstImageUrl + "' alt='이미지'>";
                    campItem += "<div class='camp_info'>";
                    campItem += "<p> ["+ doNm + sigunguNm+"] </p>";
                    campItem += "<h4>" + facltNm + "</h4>" + induty + "</p>";
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

    function searchByKeywords() {
        let keywordInput = $("#keyword_input").val();

        $.ajax({
            url: "camp_list_search.do",
            method: "post",
            data: { 
                pageNo: pageNo,
                keyword: keywordInput
            },
            dataType: "xml",
            success: function(data) {
                $("#camp_list_show").empty();
                $(data).find("item").each(function() {
                    let firstImageUrl = $(this).find("firstImageUrl").text();
                    let doNm = $(this).find("doNm").text();
                    let sigunguNm = $(this).find("sigunguNm").text();
                    let facltNm = $(this).find("facltNm").text();
                    let induty = $(this).find("induty").text();
                    let addr1 = $(this).find("addr1").text();
                    let tel = $(this).find("tel").text();
                    let homepage = $(this).find("homepage").text();
                    let contentid = $(this).find("contentId").text();

                    let campItem = "<div class='camp_item' onclick='location.href=\"camp_detail.do?contentid=" + contentid + "\"'>";
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
                alert("검색 실패");
            }
        });
    }


    camp_all_list();

    $(".camp_list_next").on("click", function() {
        nextPage();
    });
    $(".camp_list_before").on("click", function() {
        beforePage();
    });
    $("#search_button").on("click", function() {
        searchByKeywords();
    });
    $("#keyword_input").keypress(function(event) {
        if (event.which === 13) {
            searchByKeywords();
        }
    });
});
</script>
</head>
<body>
<jsp:include page="../hs/header.jsp" />
<div style="height: 100px;"></div>
	<div class="camp_list_container">
		<jsp:include page="../hs/camp_search_box.jsp" />
	   	<div id="camp_list_show"></div>
	   	<div id ="camp_list_button">
	       <button class="camp_list_before">이전 페이지</button>
	       <button class="camp_list_next">다음 페이지</button>
	   	</div>
    </div>
<jsp:include page="../hs/footer.jsp" />
</body>

</html>
