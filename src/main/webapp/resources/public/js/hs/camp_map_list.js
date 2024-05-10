$(document).ready(function() {
	const page_num_count = 4;
    const numOfRows = 10;
    let pageNo = 1;
    let totalCount = 0;
	let last_page = 0; 

    let markerArr = new Array();
    let markers = new Array();
    let infoWindows = new Array();
    
    	
    let mapDiv = document.getElementById('map');

	let map = new naver.maps.Map(mapDiv,{
			center: new naver.maps.LatLng(35.907757, 127.766922),
			zoom: 8
		}
	);
	
	
	naver.maps.Event.addListener(map, 'click', function() {
    	closeInfoWindow();
	});

	function closeInfoWindow() {
		console.log("실행");
	    for (let i = 0; i < infoWindows.length; i++) {
	        infoWindows[i].close();
    	}
	}
	
	function marker_empty(){
        closeInfoWindow();	
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
                let marker = markers[seq],
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
                totalCount = $(data).find('totalCount').text();
                
                $(data).find("item").each(function(i, k) {
                	 data_show(this); 
                });
                pageNumbers();
                marker_show();
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
                totalCount = $(data).find('totalCount').text();
                
                $(data).find("item").each(function() {
                    data_show(this); 
                });
                pageNumbers();
                marker_show();
            },
            error: function() {
                alert("검색 실패");
            }
        });
    }
    
	$(document).on("click", ".camp_item",  function() {
		let facltNm = $(this).find(".camp_info h4").text();
		
		function getClickHandler(seq) {
			return function(e) { 
                let marker = markers[seq],
                infoWindow = infoWindows[seq]; 
                infoWindow.open(map, marker);
			}
		}
		
		for (let i = 0; i < markerArr.length; i++) {
	        if (markerArr[i].facltNm === facltNm) {
	            let LatLng = new naver.maps.LatLng(markerArr[i].lat, markerArr[i].lng);
	            map.setCenter(LatLng);
	            naver.maps.Event.trigger(markers[i], 'click',  getClickHandler(i));
	            break; 
	        }
    	}
    	
    	
    });
    
	function pageNumbers(){
		$(".camp_list_page").empty();
		last_page = Math.ceil(totalCount / numOfRows);
	    c_Pages = Math.floor((pageNo - 1) / page_num_count) * page_num_count; 
	    
	    let pageShow = (pageNo <= page_num_count) ? '<li class="to_disable camp_list_first">' : '<li class="to_able camp_list_first">';
	    pageShow += '<i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
		pageShow += (pageNo <= page_num_count) ? '<li class="to_disable' : '<li class="to_able';
		pageShow +=	' camp_list_before"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
	    
	    for (i = c_Pages; i < c_Pages + page_num_count ; i++){
	    	if (i >= last_page) { break; }
	    	pageNums = i + 1;
        	pageShow += (pageNums == pageNo) ? '<li class="nowpagecolor">' + pageNums : '<li class="nowpage">' + pageNums;
        	pageShow += '</li>';
	    }
	    
	    pageShow += (pageNo > last_page - (last_page % page_num_count) ) ? '<li class="to_disable' : '<li class="to_able';
	    pageShow += ' camp_list_next"><i class="fa-solid fa-chevron-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
	    pageShow += (pageNo > last_page - (last_page % page_num_count) ) ? '<li class="to_disable' : '<li class="to_able';
		pageShow +=	' camp_list_last"><i class="fa-solid fa-angles-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
	    
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
	    
	    
	    $(".camp_list_wrap").scrollTop(0); 
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
