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
                    
                    let campItem = "<div class='camp_item'>";
                    if(firstImageUrl != null && firstImageUrl !== ""){
                    campItem += "<img src='" + firstImageUrl + "' alt='이미지'>";
              		} else {
                    campItem += "<img src='/resources/images/2.jpg' alt='대체 이미지'>";
               		}
                    campItem += "<div class='camp_info' onclick='location.href=\"camp_detail.do?contentid=" + contentid + "\"'>";
                    campItem += "<p> ["+ doNm + sigunguNm+"] </p>";
                    campItem += "<h4>" + facltNm + "</h4><span>" + induty + "</span>";
                    campItem += "<p>" + addr1 + "</p>";
                    campItem += "<p>" + tel + "</p>";
                    campItem += "</div>";
                    campItem += "<div class='button_container'><button onclick=\"window.open('" + homepage + "')\">홈페이지</button></div>";
                    campItem += "<div class='Heart_button'></div>";
                    campItem += "</div>";
                    
                    
                    $("#camp_list_show").append(campItem);
                    let $container = $("#camp_list_show").find(".Heart_button:last");
                    loadHeart(contentid, $container);

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
function loadHeart(contentid, $container) {
    $.ajax({
        url: "checkHeart.do",
        type: "get",
        data: { 
            contentid: contentid
        },
        dataType: "json",
        success: function(data) {
            let detailButton = "<div class='Heart_button'>";
            if (data === true) {
                detailButton += "<button data-contentid='" + contentid + "' onclick='Heart(" + contentid + ")'>🤍</button>";
            } else if (data === false) {
                detailButton += "<button data-contentid='" + contentid + "' onclick='delHeart(" + contentid + ")'>❤️</button>";
            } else {
                alert("찜 여부를 확인하는 중 오류가 발생했습니다.");
            }
            detailButton += "</div>";
            $container.html(detailButton);
        },
        error: function() {
            let detailButton = "<div class='Heart_button'>";
            detailButton += "<button data-contentid='" + contentid + "' onclick='Heart(" + contentid + ")'>🤍</button>";
            detailButton += "</div>";
            $container.html(detailButton);
        }
    });
}


function Heart(contentid) {
    let $container = $(this).closest(".camp_item").find(".Heart_button");
    $.ajax({
        url: "addHeart.do",
        method: "post",
        data: { contentid: contentid },
        success: function(data) {
            if(data != "error") {
                alert("관심 캠핑장에 등록이 되었습니다.");
                loadHeart(contentid, $container);
            } else {
                delHeart(contentid, $container);
            }
        },
        error: function() {
            alert("로그인 후 이용 부탁드립니다.");
            location.href='login_form.do';
        }
    });
}

function delHeart(contentid,$container) {
	$.ajax({
		url:"delHeart.do",
		method: "post",
		data: {contentid: contentid},
		success: function(data){
			if (data != "error") {
				alert("관심캠핑장에서 제거하였습니다.");
				loadHeart(contentid, $container);
			}
		}
	});
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

                    let campItem = "<div class='camp_item'>";
                    if(firstImageUrl != null && firstImageUrl !== ""){
                    campItem += "<img src='" + firstImageUrl + "' alt='이미지'>";
              		} else {
                    campItem += "<img src='/resources/images/2.jpg' alt='대체 이미지'>";
               		}
                    campItem += "<div class='camp_info' onclick='location.href=\"camp_detail.do?contentid=" + contentid + "\"'>";
                    campItem += "<p> ["+ doNm + sigunguNm+"] </p>";
                    campItem += "<h4>" + facltNm + "</h4><span>" + induty + "</span>";
                    campItem += "<p>" + addr1 + "</p>";
                    campItem += "<p>" + tel + "</p>";
                    campItem += "</div>";
                    campItem += "<div class='button_container'><button onclick=\"window.open('" + homepage + "')\">홈페이지</button></div>";
                    campItem += "<div class='Heart_button'></div>";
                    campItem += "</div>";
                    
                    
                    $("#camp_list_show").append(campItem);
                    let $container = $("#camp_list_show").find(".Heart_button:last");
                    loadHeart(contentid, $container);
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
    $("#camp_list_show").on("click", ".Heart_button button", function() {
        let contentid = $(this).data("contentid");
        Heart(contentid);
    });
});
