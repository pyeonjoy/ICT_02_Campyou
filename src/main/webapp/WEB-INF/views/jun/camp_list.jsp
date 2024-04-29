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

.search_wrap {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin: 20px;
}

 .search_button_option {
 	display: flex;
 	text-align: center;
 	flex-direction: column;
 	width: 800px;
 }
 
 .search_button_option .option{
	border: 1px solid gray;
	border-radius: 5px;
	padding: 10px;
	margin-bottom: 10px;
	height: auto;
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

.camp_list_container ul {
    list-style: none;
}

.camp_list_container li {
    padding: 10px;
    overflow: hidden;
    float: left;
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

                    let campItem = "<div class='camp_item'>";
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
<jsp:include page="../hs/admin_header.jsp" />
<div style="height: 100px;"></div>
	<div class="camp_list_container">
		<div class="search_wrap">
			<select>
				<option>전체</option>
			</select>
			<select>
				<option>전체</option>
			</select>
			<input type="text" id="keyword_input" placeholder="검색어를 입력하세요">
		   	<input type="button" value="상세조건+" id="detail_search">
			<button id="search_button">검색</button>
	   	</div>
		<div class="search_button_option">
			<div class="option lct">
				<strong>입지구분</strong>
				<ul>
					<li><input type="checkbox" name="lctCl" id="lctcl01" value="lctcl01"><label for="lctcl01">해변</label></li>
					<li><input type="checkbox" name="lctCl" id="lctcl02" value="lctcl02"><label for="lctcl02">섬</label></li>
					<li><input type="checkbox" name="lctCl" id="lctcl03" value="lctcl03"><label for="lctcl03">산</label></li>
					<li><input type="checkbox" name="lctCl" id="lctcl04" value="lctcl04"><label for="lctcl04">숲</label></li>
					<li><input type="checkbox" name="lctCl" id="lctcl05" value="lctcl05"><label for="lctcl05">계곡</label></li>
					<li><input type="checkbox" name="lctCl" id="lctcl06" value="lctcl06"><label for="lctcl06">강</label></li>
					<li><input type="checkbox" name="lctCl" id="lctcl07" value="lctcl07"><label for="lctcl07">호수</label></li>
					<li><input type="checkbox" name="lctCl" id="lctcl08" value="lctcl08"><label for="lctcl08">도심</label></li>
				</ul>
			</div>
			<div class="option induty">
				<strong>주요시설</strong>
				<ul>
					<li><input type="checkbox" name="induty" id="induty01" value="induty01"><label for="induty01">일반야영장</label></li>
					<li><input type="checkbox" name="induty" id="induty02" value="induty02"><label for="induty02">자동차야영장</label></li>
					<li><input type="checkbox" name="induty" id="induty03" value="induty03"><label for="induty03">카라반</label></li>
					<li><input type="checkbox" name="induty" id="induty04" value="induty04"><label for="induty04">글램핑</label></li>
				</ul>
			</div>
			<div class="option sbrsd">
				<strong>부대시설</strong>
				<ul>
					<li><input type="checkbox" name="sbrsd" id="sbrsd01" value="sbrsd01"><label for="sbrsd01">놀이터</label></li>
					<li><input type="checkbox" name="sbrsd" id="sbrsd02" value="sbrsd02"><label for="sbrsd02">덤프스테이션</label></li>
					<li><input type="checkbox" name="sbrsd" id="sbrsd03" value="sbrsd03"><label for="sbrsd03">마트, 편의점</label></li>
					<li><input type="checkbox" name="sbrsd" id="sbrsd04" value="sbrsd04"><label for="sbrsd04">무선인터넷</label></li>
					<li><input type="checkbox" name="sbrsd" id="sbrsd05" value="sbrsd05"><label for="sbrsd05">물놀이장</label></li>
					<li><input type="checkbox" name="sbrsd" id="sbrsd06" value="sbrsd06"><label for="sbrsd06">산책로</label></li>
					<li><input type="checkbox" name="sbrsd" id="sbrsd07" value="sbrsd07"><label for="sbrsd07">온수</label></li>
					<li><input type="checkbox" name="sbrsd" id="sbrsd08" value="sbrsd08"><label for="sbrsd08">운동장</label></li>
					<li><input type="checkbox" name="sbrsd" id="sbrsd09" value="sbrsd09"><label for="sbrsd09">운동시설</label></li>
					<li><input type="checkbox" name="sbrsd" id="sbrsd10" value="sbrsd10"><label for="sbrsd10">전기</label></li>
					<li><input type="checkbox" name="sbrsd" id="sbrsd11" value="sbrsd11"><label for="sbrsd11">장작판매</label></li>
					<li><input type="checkbox" name="sbrsd" id="sbrsd12" value="sbrsd12"><label for="sbrsd12">트렘폴린</label></li>
				</ul>
			</div>
		</div>
	   	<div id="camp_list_show"></div>
	   	<div id ="camp_list_button">
	       <button class="camp_list_before">이전 페이지</button>
	       <button class="camp_list_next">다음 페이지</button>
	   	</div>
    </div>
<jsp:include page="../hs/footer.jsp" />
</body>

</html>
