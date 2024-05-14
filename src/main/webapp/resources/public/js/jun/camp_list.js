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

            let campItem = "<div class='camp_item'>";
            if (firstImageUrl != null && firstImageUrl !== "") {
                campItem += "<img src='" + firstImageUrl + "' alt='이미지'>";
            } else {
                campItem += "<img src='/resources/images/2.jpg' alt='대체 이미지'>";
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
                    detailButton += "<button class='heart-button' data-contentid='" + contentid + "'>🤍</button>";
                } else if (data === false) {
                    detailButton += "<button class='heart-button' data-contentid='" + contentid + "'>❤️</button>";
                } else {
                    alert("찜 여부를 확인하는 중 오류가 발생했습니다.");
                }
                detailButton += "</div>";
                $container.html(detailButton);
            },
            error: function() {
                let detailButton = "<div class='Heart_button'>";
                detailButton += "<button class='heart-button' data-contentid='" + contentid + "'>🤍</button>";
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
                    $(".camp_item").find(".Heart_button[data-contentid='" + contentid + "']").html("<button data-contentid='" + contentid + "' onclick='delHeart(" + contentid + ")'>❤️</button>");
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
                    $(".camp_item").find(".Heart_button[data-contentid='" + contentid + "']").html("<button data-contentid='" + contentid + "' onclick='Heart(" + contentid + ")'>🤍</button>");
                }
            }
        });
    }

    $(document).on("click", ".heart-button", function() {
        let contentid = $(this).data("contentid");
        if ($(this).hasClass("filled")) {
            delHeart(contentid);
            $(this).removeClass("filled").addClass("empty").html("🤍");
        } else {
            Heart(contentid);
            $(this).removeClass("empty").addClass("filled").html("❤️");
        }
    });

    $("#search_button").click(function() {
        let keywordInput = $("#keyword_input").val();
        let selectedLctCl = [];
        let selectedInduty = [];
        let selectedSbrscl = [];

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
        pageNo: pageNo,
        keyword: keywordInput,
        lctCl: selectedLctCl.join(),
        induty: selectedInduty.join(),
        sbrscl: selectedSbrscl.join()
    },
    dataType: "json",
    success: function(data) {
        $("#camp_list_show").empty();
        $(".camp_list_page").empty();
        
            $.each(data, function(index, camp) {
            let firstImageUrl = camp.firstimageurl;
            let doNm = camp.donm;
            let sigunguNm = camp.sigungunm;
            let facltNm = camp.facltnm;
            let induty = camp.induty;
            let addr1 = camp.addr1;
            let tel = camp.tel;
            let homepage = camp.homepage;
            let contentid = camp.contentid
            
            let campItem = "<div class='camp_item'>";
            if (firstImageUrl != null && firstImageUrl !== "") {
                campItem += "<img src='" + firstImageUrl + "' alt='이미지'>";
            } else {
                campItem += "<img src='/resources/images/2.jpg' alt='대체 이미지'>";
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
        
    },
    error: function() {
        alert("검색 실패");
    }
});



    });

    camp_all_list();

    $(".camp_list_next").on("click", function() {
        nextPage();
    });

    $(".camp_list_before").on("click", function() {
        beforePage();
    });

});
