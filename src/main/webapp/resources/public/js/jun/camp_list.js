function list_search(page) {

		
        let keywordInput = $("#keyword_input").val();
        let selectedLctCl = [];
        let selectedInduty = [];
        let selectedSbrscl = [];

		let sido_search = $("#sido_search").val();
        let sigungu_search = $("#sigungu_search").val();
		
        $("input[name='lctCl']:checked").each(function() {
            selectedLctCl.push($(this).val());
        });

        $("input[name='induty']:checked").each(function() {
            selectedInduty.push($(this).val());
        });

        $("input[name='sbrscl']:checked").each(function() {
            selectedSbrscl.push($(this).val());
        });

$.ajax({
    url: "camp_list_search.do",
    method: "post",
    data: {
        keyword: keywordInput,
        lctCl: selectedLctCl.join(),
        induty: selectedInduty.join(),
        sbrscl: selectedSbrscl.join(),
        s_sido: sido_search,
        s_sigungu: sigungu_search,
        cPage: page
    },
    dataType: "json",
    success: function(data) {
        $("#camp_list_show").empty();
        if (data.cvo.length === 0) {
        	alert("검색 결과가 존재하지않습니다.");
            return ;
        }
        $.each(data.cvo, function(index, camp) {
            let firstImageUrl = camp.firstimageurl;
            let doNm = camp.donm;
            let sigunguNm = camp.sigungunm;
            let facltNm = camp.facltnm;
            let induty = camp.induty;
            let addr1 = camp.addr1;
            let tel = camp.tel;
            let homepage = camp.homepage;
            let contentid = camp.contentid;
            if (data.cvo.length === 1) {
                $("#camp_list_show").addClass("1_result");
            }
            let campItem = "<div class='camp_item'>";
            if (firstImageUrl != null && firstImageUrl !== "") {
                campItem += "<img class='firstImg' src='" + firstImageUrl + "' alt='이미지'>";
            } else {
                campItem += "<img class='firstImg' src='/resources/images/2.jpg' alt='대체 이미지'>";
            }
            campItem += "<div class='camp_info' onclick='location.href=\"camp_detail.do?contentid=" + contentid + "\"'>";
            campItem += "<p> [" + doNm + sigunguNm + "] </p>";
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
			
            // 페이징 처리
            let paging = data.paging;
            let totalCount = data.count;
            console.log(data.count);
            $('.total_count').empty();
            $(".total_count").text(totalCount);
            $('.th_paging').empty();
            $('.page_button').empty();
            let pagingHtml = '';
            // 이전 버튼
            if (paging.beginBlock <= paging.pagePerBlock) {
                pagingHtml += '<li class="search_th_disable"><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
                pagingHtml += '<li class="search_th_disable"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
            } else {
                pagingHtml += '<li><a href="javascript:list_search(' + 1 + ')" class="search_th_able"><i class="fa-solid fa-angles-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
                pagingHtml += '<li><a href="javascript:list_search(' + (paging.beginBlock - paging.pagePerBlock) + ')" class="search_th_able"><i class="fa-solid fa-chevron-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
            }
            // 페이지번호들
            for (let k = paging.beginBlock; k <= paging.endBlock && k <= paging.totalPage; k++) {
                if (k === paging.nowPage) {
                    pagingHtml += '<li class="search_nowpagecolor">' + k + '</li>';
                } else {
                    pagingHtml += '<li><a href="javascript:list_search(' + k + ')" class="search_nowpage">' + k + '</a></li>';
                }
            }
            // 이후 버튼
            if (paging.endBlock >= paging.totalPage) {
                pagingHtml += '<li class="search_th_disable"><i class="fa-solid fa-chevron-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
                pagingHtml += '<li class="search_th_disable"><i class="fa-solid fa-angles-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
            } else {
                pagingHtml += '<li><a href="javascript:list_search(' + (paging.beginBlock + paging.pagePerBlock) + ')" class="search_th_able"><i class="fa-solid fa-chevron-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
                pagingHtml += '<li><a href="javascript:list_search(' + paging.totalPage + ')" class="search_th_able"><i class="fa-solid fa-angles-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
            }
            $('.th_paging').append(pagingHtml);
        },
        error: function() {
        	alert("검색 결과가 존재하지 않습니다.");
        }
    });
    }
let filledHeartHtml = function(contentid) {
    console.log("f: " + contentid);
    return "<img class='heart-button' src='resources/images/heart_fill.png' data-contentid='" + contentid + "' alt='하트'>";
};

let emptyHeartHtml = function(contentid) {
    console.log("e: " + contentid);
    return "<img class='heart-button' src='resources/images/heart_empty.png' data-contentid='" + contentid + "' alt='빈하트'>";
};

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
                detailButton += emptyHeartHtml(contentid);
            } else if (data === false) {
                detailButton += filledHeartHtml(contentid);
            } else {
                alert("찜 여부를 확인하는 중 오류가 발생했습니다.");
            }
            detailButton += "</div>";
            $container.html(detailButton);
        },
        error: function() {
            let detailButton = "<div class='Heart_button'>";
            detailButton += emptyHeartHtml(contentid);
            detailButton += "</div>";
            $container.html(detailButton);
        }
    });
}

function Heart(contentid) {
    let $container = $(".camp_item").find(".Heart_button").filter("[data-contentid='" + contentid + "']");
    $.ajax({
        url: "addHeart.do",
        method: "post",
        data: { contentid: contentid },
        success: function(data) {
            if (data != "error") {
                alert("관심 캠핑장에 등록이 되었습니다.");
                $(".camp_item").find(".Heart_button[data-contentid='" + contentid + "']").html(filledHeartHtml(contentid));
            } else {
                delHeart(contentid);
            }
        },
        error: function() {
            alert("로그인 후 이용 부탁드립니다.");
            location.href = 'login_form.do';
        }
    });
}

function delHeart(contentid) {
    let $container = $(".camp_item").find(".Heart_button").filter("[data-contentid='" + contentid + "']");
    $.ajax({
        url: "delHeart.do",
        method: "post",
        data: { contentid: contentid },
        success: function(data) {
            if (data != "error") {
                alert("관심캠핑장에서 제거하였습니다.");
                $(".camp_item").find(".Heart_button[data-contentid='" + contentid + "']").html(emptyHeartHtml(contentid));
            }
        }
    });
}

function go_map(){
	window.location = 'camp_map_list.do';
}
$(document).ready(function() {
    const page_num_count = 4;
    const numOfRows = 10;
    let pageNo = 1;
    let totalCount = 0;
    let last_page = 0; 

    function loadCampList(data) {
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
			let totalCount = $(data).find("totalCount").text();
			
            let campItem = "<div class='camp_item'>";
            if (firstImageUrl != null && firstImageUrl !== "") {
                campItem += "<img class='firstImg' src='" + firstImageUrl + "' alt='이미지'>";
            } else {
                campItem += "<img class='firstImg' src='/resources/images/2.jpg' alt='대체 이미지'>";
            }
            campItem += "<div class='camp_info' onclick='location.href=\"camp_detail.do?contentid=" + contentid + "\"'>";
            campItem += "<p> [" + doNm + sigunguNm + "] </p>";
            campItem += "<h4 style=\'display: inline;'>" + facltNm + "</h4><p style=\'display: inline;font-weight: bold;'>" + " / "+ induty + "</p>";
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
		let totalCount = $(data).find("totalCount").text();
		$(".total_count").text(totalCount);
    }

    function camp_all_list() {
        $.ajax({
            url: "camp_list.do",
            method: "post",
            data: { pageNo: pageNo },
            dataType: "xml",
            success: function(data) {
                totalCount = $(data).find('totalCount').text();
                $("#camp_list_show").empty();
                loadCampList(data);
                pageNumbers();
            },
            error: function() {
                alert("읽기 실패");
            }
        });
    }

    function pageNumbers(){
        $(".camp_list_page").empty();
        last_page = Math.ceil(totalCount / numOfRows);
        c_Pages = Math.floor((pageNo - 1) / page_num_count) * page_num_count; 
        
        let pageShow = (pageNo <= page_num_count) ? '<li class="to_disable camp_list_first">' : '<li class="to_able camp_list_first">';
        pageShow += '<i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
        pageShow += (pageNo <= page_num_count) ? '<li class="to_disable' : '<li class="to_able';
        pageShow += ' camp_list_before"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
        
        for (i = c_Pages; i < c_Pages + page_num_count ; i++){
            if (i >= last_page) { break; }
            pageNums = i + 1;
            pageShow += (pageNums == pageNo) ? '<li class="nowpagecolor">' + pageNums : '<li class="nowpage">' + pageNums;
            pageShow += '</li>';
        }
        
        pageShow += (pageNo > last_page - (last_page % page_num_count) ) ? '<li class="to_disable' : '<li class="to_able';
        pageShow += ' camp_list_next"><i class="fa-solid fa-chevron-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
        pageShow += (pageNo > last_page - (last_page % page_num_count) ) ? '<li class="to_disable' : '<li class="to_able';
        pageShow += ' camp_list_last"><i class="fa-solid fa-angles-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
        
        $(".camp_list_page").append(pageShow);
    }

    $(document).on("click", ".camp_list_next, .camp_list_before, .nowpage, .camp_list_last, .camp_list_first", function() {
        if ($(this).hasClass("camp_list_next")) {
            pageNo = Math.ceil(pageNo / page_num_count) * page_num_count + 1;
            
        } else if ($(this).hasClass("camp_list_before")) {
            if (pageNo <= page_num_count) {
                return false; 
            } else { 
                pageNo = Math.floor((pageNo - 1)  / page_num_count) * page_num_count; 
            }
            
        } else if ($(this).hasClass("nowpage")) {
            pageNo = $(this).text();
            
        } else if ($(this).hasClass("camp_list_last")) {
            pageNo = last_page;
            
        } else if ($(this).hasClass("camp_list_first")) {
            pageNo = 1;
        } 
        
        $(".camp_list_container").scrollTop(0); 
        pageNumbers();
        camp_all_list();
        
    });
    let filledHeartHtml = function(contentid) {
        console.log("f: " + contentid);
        return "<img class='heart-button' src='resources/images/heart_fill.png' data-contentid='" + contentid + "' alt='하트'>";
    };

    let emptyHeartHtml = function(contentid) {
        console.log("e: " + contentid);
        return "<img class='heart-button' src='resources/images/heart_empty.png' data-contentid='" + contentid + "' alt='빈하트'>";
    };
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
                    detailButton += emptyHeartHtml(contentid);
                } else if (data === false) {
                    detailButton += filledHeartHtml(contentid);
                } else {
                    alert("찜 여부를 확인하는 중 오류가 발생했습니다.");
                }
                detailButton += "</div>";
                $container.html(detailButton);
            },
            error: function() {
                let detailButton = "<div class='Heart_button'>";
                detailButton += emptyHeartHtml(contentid);
                detailButton += "</div>";
                $container.html(detailButton);
            }
        });
    }

    function Heart(contentid) {
        let $container = $(".camp_item").find(".Heart_button").filter("[data-contentid='" + contentid + "']");
        $.ajax({
            url: "addHeart.do",
            method: "post",
            data: { contentid: contentid },
            success: function(data) {
                if (data != "error") {
                    alert("관심 캠핑장에 등록이 되었습니다.");
                    $(".camp_item").find(".Heart_button[data-contentid='" + contentid + "']").html(filledHeartHtml(contentid));
                } else {
                    delHeart(contentid);
                }
            },
            error: function() {
                alert("로그인 후 이용 부탁드립니다.");
                location.href = 'login_form.do';
            }
        });
    }

    function delHeart(contentid) {
        let $container = $(".camp_item").find(".Heart_button").filter("[data-contentid='" + contentid + "']");
        $.ajax({
            url: "delHeart.do",
            method: "post",
            data: { contentid: contentid },
            success: function(data) {
                if (data != "error") {
                    alert("관심캠핑장에서 제거하였습니다.");
                    $(".camp_item").find(".Heart_button[data-contentid='" + contentid + "']").html(emptyHeartHtml(contentid));
                }
            }
        });
    }

    $(document).on("click", ".heart-button", function() {
        let contentid = $(this).data("contentid");
        if ($(this).attr("src") === 'resources/images/heart_fill.png') {
            delHeart(contentid);
            $(this).attr("src", 'resources/images/heart_empty.png');
        } else {
            Heart(contentid);
            $(this).attr("src", 'resources/images/heart_fill.png');
        }
    });
    



    camp_all_list();

    $(".camp_list_next").on("click", function() {
        nextPage();
    });

    $(".camp_list_before").on("click", function() {
        beforePage();
    });

});
