$(document).ready(function() {
	const page_count = 4;
    let pageNo = 1;
    
    let markerArr = new Array();
    let markers = new Array();
    let infoWindows = new Array();
    
    var mapDiv = document.getElementById('map'); // 'map'으로 선언해도 동일

	var map = new naver.maps.Map(mapDiv,{
			zoom: 9
		}
	);
	
	function marker_empty(){
        for (let i = 0; i < markers.length; i++){
            markers[i].setMap(null);
        }
		markerArr.length = 0;
        markers.length = 0;
        infoWindows.length = 0;
	}
	
	function data_show(item){
        let firstImageUrl = $(item).find("firstImageUrl").text();
        let doNm = $(item).find("doNm").text();
        let sigunguNm = $(item).find("sigunguNm").text();
        let facltNm = $(item).find("facltNm").text();
        let induty = $(item).find("induty").text();
        let addr1 = $(item).find("addr1").text();
        let tel = $(item).find("tel").text();
        let homepage = $(item).find("homepage").text();
        let contentid = $(item).find("contentId").text();
        
        let campItem = "<div class='camp_item'>";
        campItem += "<img src='" + firstImageUrl + "' alt='이미지'>";
        campItem += "<div class='camp_info'>";
        campItem += "<p> ["+ doNm + sigunguNm+"] </p>";
        campItem += "<h4>" + facltNm + "</h4><span>" + induty + "</span>";
        campItem += "<p>" + addr1 + "</p>";
        campItem += "<p>" + tel + "</p>";
        campItem += "</div>";
        campItem += "<div class='button_container'><button onclick=\"window.open('camp_detail.do?contentid=" + contentid +"')\">상세보기</button></div>";
        campItem += "</div>";
			
        $("#camp_list_show").append(campItem);
        
        // 지도
        let mapX = $(item).find("mapX").text();
        let mapY = $(item).find("mapY").text();
        
        markerArr.push({lat: mapY, lng: mapX, facltNm: facltNm, addr1: addr1,tel:tel});
	}
	
	function marker_show() {
		for (let i = 0; i < markerArr.length; i++) {
        	let LatLng = new naver.maps.LatLng(markerArr[i].lat, markerArr[i].lng);
        	let marker = new naver.maps.Marker({
	            map: map,
	            position: LatLng,
	            title: markerArr[i].facltNm
        	});
        	
        	
	        let infoWindow = new naver.maps.InfoWindow({
                content: '<div style="padding:20px;"><p><b>' 
                + markerArr[i].facltNm
                + '</b></p><p>주소: '
                + markerArr[i].addr1 
                + '</p><p>전화번호: '
                + markerArr[i].tel
                + '</p></div>'
	        });
        	markers.push(marker)
        	infoWindows.push(infoWindow)
   		}
   		
   		 function getClickHandler(seq) {
			return function(e) { 
                var marker = markers[seq],
                    infoWindow = infoWindows[seq]; 

                if (infoWindow.getMap()) {
                    infoWindow.close();
                } else {
                    infoWindow.open(map, marker);
                }
			}
		}

	    for (let i = 0; i < markers.length; i++) {
	        naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
	    }
	}

 
    function camp_all_list() {
    	marker_empty();
        $.ajax({
            url: "camp_list.do",
            method: "post",
            data: { pageNo: pageNo },
            dataType: "xml",
            success: function(data) {
                $("#camp_list_show").empty();
                $(data).find("item").each(function(i, k) {
                	 data_show(this); 
                });
                marker_show()
            },
            error: function() {
                alert("읽기 실패");
            }
        });
    }
   	camp_all_list();

    function searchByKeywords() {
        let keywordInput = $("#keyword_input").val();
        markerArr.length = 0;
        for (let i = 0; i < markers.length; i++){
            markers[i].setMap(null);
        }
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
                    data_show(this); 
                });
                marker_show()
            },
            error: function() {
                alert("검색 실패");
            }
        });
    }
	
	function pageNumbers(){
		$(".campe_list_page").empty();
	    c_Pages = Math.floor((pageNo - 1) / page_count) * page_count; 
	    
	    let pageShow = (pageNo <= page_count) ? '<li class="to_disable ">' : '<li class="to_able ">';
	    pageShow += '<i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
		pageShow += (pageNo <= page_count) ? '<li class="to_disable ' : '<li class="to_able ';
		pageShow +=	' camp_list_before"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
	    
	    for (i = c_Pages; i < c_Pages + page_count ; i++){
	    	pageNm = i + 1;
        	pageShow += (pageNm == pageNo) ? '<li class="nowpagecolor">' + pageNm : '<li class="nowpage">' + pageNm;
        	pageShow += '</li>';
	    }
	    
	    pageShow += '<li><i class="fa-solid fa-chevron-right to_able camp_list_next" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
		pageShow +=	'<li><i class="fa-solid fa-angles-right to_able" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
	    
        $(".campe_list_page").append(pageShow);
    }
	pageNumbers();
	   
	$(document).on("click", ".camp_list_next, .camp_list_before, .nowpage", function() {
		$(".camp_list_wrap").scrollTop(0); 
		if ($(this).hasClass("camp_list_next")) {
        	pageNo = Math.floor(pageNo / page_count + 1) * page_count + 1;
	    } else if ($(this).hasClass("camp_list_before")) {
	    	console.log("aa");
	    	if (pageNo <= 1) {
	    		return false; 
	    	} else { 
	    		pageNo = Math.floor((pageNo - 1)  / page_count) * page_count; 
	    	}
	    } else if ($(this).hasClass("nowpage")) {
	    	pageNo = $(this).text();
	    	console.log(pageNo);
	    } 
		pageNumbers();
        camp_all_list();
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
