$(document).ready(function() {
	const page_num_count = 4;
    const numOfRows = 5;
    let pageNo = 1;
    let totalCount = 0;
	let last_page = 0; 
	let camp_list_option = "";

    let markerArr = new Array();
    let markers = new Array();
    let infoWindows = new Array();
    
    //  -------------- 지도 -------------- 
    let mapDiv = document.getElementById('map');

	let map = new naver.maps.Map(mapDiv,{
			center: new naver.maps.LatLng(35.907757, 127.766922),
			mapTypeId: naver.maps.MapTypeId.TERRAIN,
			mapTypeControl: true,
		    mapTypeControlOptions: {
		        style: naver.maps.MapTypeControlStyle.DROPDOWN,
		    },
			zoom: 8
		}
	);
	
	// 정보창 닫기
	function closeInfoWindow() {
	    for (let i = 0; i < infoWindows.length; i++) {
	        infoWindows[i].close();
    	}
	}
	
	// 다른 부분 눌렀을 때
	naver.maps.Event.addListener(map, 'click', function() {
    	closeInfoWindow();
	});
	
	// 마커 초기화
	function marker_empty(){
        closeInfoWindow();	
        for (let i = 0; i < markers.length; i++){
            markers[i].setMap(null);
        }
		markerArr.length = 0;
        markers.length = 0;
        infoWindows.length = 0;
	}
	
	//  -------------- 캠프 항목 생성 -------------- 
	function createCampItem(item){
        let firstImageUrl = $(item).find("firstImageUrl").text();
        let doNm = $(item).find("doNm").text();
        let sigunguNm = $(item).find("sigunguNm").text();
        let facltNm = $(item).find("facltNm").text();
        let induty = $(item).find("induty").text();
        let addr1 = $(item).find("addr1").text();
        let tel = $(item).find("tel").text();
        let homepage = $(item).find("homepage").text();
        let contentid = $(item).find("contentId").text();
        
        let campItem = "<div class='camp_item' data-contentid='" + contentid + "'>";

        if (firstImageUrl != null && firstImageUrl !== "") {
            campItem += "<img class='cmap_img' src='" + firstImageUrl + "' alt='이미지'>";
        } else {
            campItem += "<img class='cmap_img' src='/resources/images/2.jpg' alt='대체 이미지'>";
        }
        
        campItem += "<div class='camp_info'>";
        campItem += "<p class='location'> ["+ doNm + " " + sigunguNm+"] </p>";
        campItem += "<h4>" + facltNm + "</h4>";
        campItem += "<p class='induty'>" + induty + "</p>";
        campItem += "<p class='addr'>" + addr1 + "</p>";
        campItem += "<p class='tel'>" + tel + "</p>";
        campItem += "</div>";
        campItem += "<div class='button_container'>"
		campItem += "<button onclick=\"window.open('camp_detail.do?contentid=" + contentid +"')\">상세보기</button></div>";
		campItem += "<div class='Heart_button'></div>";
        campItem += "</div>";
        
        // 지도
        let mapX = $(item).find("mapX").text();
        let mapY = $(item).find("mapY").text();
        
        markerArr.push({lat: mapY, lng: mapX, facltNm: facltNm, addr1: addr1,tel:tel});
        
        return campItem;
	}
	
	//  -------------- 마커 생성 -------------- 
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
   		
  		 // 마커들의 중심 좌표
  		 let sumLat = 0, sumLng = 0;
  		 
  		 for (let i = 0; i < markerArr.length; i++) {
  			 sumLat += parseFloat(markerArr[i].lat);
  			 sumLng += parseFloat(markerArr[i].lng);
  		 }
  		 
  		 let centerLatLng = new naver.maps.LatLng(sumLat / markerArr.length, sumLng / markerArr.length);
  		 map.setCenter(centerLatLng);
		
		// 마커 클릭시 정보창 보이기
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

	//  -------------- 캠핑 리스트 -------------- 
    function camp_all_list() {
    	camp_list_option = "camp_all_list";
    	marker_empty();
        $.ajax({
            url: "camp_list_in_ms.do",
            method: "post",
            data: { pageNo: pageNo, numOfRows: numOfRows  },
            dataType: "xml",
            success: function(data) {
                $("#camp_list_show").empty();
                totalCount = $(data).find('totalCount').text();
                $(".totalCount").text(totalCount);
                
                $(data).find("item").each(function(i, k) {
                	 $("#camp_list_show").append(createCampItem(this));
                	 let contentid = $(this).find("contentId").text();
                	 let $container = $("#camp_list_show").find(".Heart_button:last");
                     loadHeart(contentid, $container);
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

   	

	//  -------------- 하트 -------------- 
   	let filledHeartHtml = function(contentid) {
   	    return "<img class='heart-button' src='resources/images/heart_fill.png' data-contentid='" + contentid + "' alt='하트'>";
   	    console.log("f: " + contentid);
   	};

   	let emptyHeartHtml = function(contentid) {
   		console.log("e: " + contentid);
   	    return "<img class='heart-button' src='resources/images/heart_empty.png' data-contentid='" + contentid + "' alt='빈하트'>";
   	};
   	
	function loadHeart(contentid, $container) {
	    $.ajax({
	        url: "checkHeart.do",
	        type: "get",
	        data: { contentid: contentid },
	        dataType: "json",
	        success: function(data) {
	        	let detailButton = "";
	            if (data === true) {
	                detailButton += emptyHeartHtml(contentid);
	            } else if (data === false) {
	            	detailButton += filledHeartHtml(contentid);
	            } else {
	                alert("찜 여부를 확인하는 중 오류가 발생했습니다.");
	            }
                $container.html(detailButton);
	        },
	        error: function() {
	        	let detailButton = emptyHeartHtml(contentid);
	            $container.html(detailButton);
	        }
	    });
	}
	
	function delHeart(contentid) {
		 let $container = $(".camp_item").find(".Heart_button").filter("[data-contentid='" + contentid + "']");
		$.ajax({
			url:"delHeart.do",
			method: "post",
			data: {contentid: contentid},
			success: function(data){
				if (data != "error") {
					alert("관심캠핑장에서 제거하였습니다.");
					$(".camp_item[data-contentid='" + contentid + "']").find(".Heart_button").html(emptyHeartHtml(contentid));
				}
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
	                $(".camp_item[data-contentid='" + contentid + "']").find(".Heart_button").html(filledHeartHtml(contentid));
	            } else {
	                delHeart(contentid);
	            }
	        },
	        error: function() {
	            alert("로그인 후 이용 부탁드립니다.");
	            // location.href='login_form.do';
	        }
	    });
	}
   	
    $(document).on("click", ".heart-button", function() {
        let contentid = $(this).data("contentid");
        Heart(contentid);
    });
	
   	
   	// -------------- 캠핑 검색 -------------- 
    // API
   	function ajaxData(url, dataObj, successCallback) {
   		$("#camp_list_show").empty();
   		$(".totalCount").empty();
   	    $.ajax({
   	        url: url,
   	        method: "post",
   	        dataType: "xml",
   	        traditional: true,
   	        data: dataObj,
   	        success: function(data) {
   	            successCallback(data);
   	            $(".totalCount").text(totalCount);
   	            pageNumbers();
   	            marker_show();
   	        },
   	        error: function () {
   	            alert("검색 실패");
   	        },
   	    });
   	}
   	
   	
   	// 검색 함수
    function search_camp() {
    	totalCount = 0;
    	marker_empty();
    	camp_list_option = "search_camp";
    	
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
        
        // 옵션이 있을 경우
        let searchDataItems= [];
        
       	function datailFilter(item) {
    		let s_lctCl = $(item).find("lctCl").text();
    		let s_induty = $(item).find("induty").text();
    		let s_sbrscl = $(item).find("sbrsCl").text();
    		let s_doNm = $(item).find("doNm").text();
    		let s_sigunguNm = $(item).find("sigunguNm").text();
         
    		const lctClArr = s_lctCl.split(",");
    		const indutyArr = s_induty.split(",");
    		const sbrsclArr = s_sbrscl.split(",");
    		 
    		
    		if ((sido_search == "" || sido_search == s_doNm ) && 
    			(sigungu_search == "" || sigungu_search == s_sigunguNm) &&
    			(selectedLctCl.length === 0 || selectedLctCl.some(k => lctClArr.includes(k))) &&
    			(selectedInduty.length === 0 || selectedInduty.some(k => indutyArr.includes(k))) &&
    			(selectedSbrscl.length === 0 || selectedSbrscl.every(k => sbrsclArr.includes(k))))
    		{
    			let contentid = $(item).find("contentId").text();
           	 	searchDataItems.push(createCampItem(item)); 
    		    totalCount += 1;
    		}
       	}
        // 키워드 검색
        if (keywordInput != "") {
        	$(".keyword").text("\"" + keywordInput + "\"");
	        if((selectedLctCl.length + selectedInduty.length + selectedSbrscl.length) == 0 && sido_search == "") {
	        	console.log("도칙")
	        	ajaxData("camp_list_keyword_detail.do",
	        			{ keyword: keywordInput, numOfRows: numOfRows,	pageNo: pageNo },
	        			function(data) {
		            		totalCount = $(data).find('totalCount').text();
		            		$(data).find("item").each(function () {
		                    	$("#camp_list_show").append(createCampItem(this));
		                    	let contentid = $(this).find("contentId").text();
		                    	console.log("inK: " + contentid);
			       	        	let $container = $("#camp_list_show").find(".Heart_button:last");
			       	            loadHeart(contentid, $container);
		                    });
			            });
	        } else if((selectedLctCl.length + selectedInduty.length + selectedSbrscl.length) > 0 || sido_search != ""){
	        	ajaxData("camp_list_keyword_detail.do",
	        			{ keyword: keywordInput, numOfRows: 5000 },
	        			function(data) {
	        				$(data).find("item").each(function (i, k) {
	        					datailFilter(this);
	        				});
	        				$("#camp_list_show").append(searchResultSlice(searchDataItems));
	        				
	        				$(".camp_item").each(function (i, k) {
	        					let contentid = $(this).data('contentid');
			       	        	let $container = $(this).find(".Heart_button:last");
		                        loadHeart(contentid, $container);
	        				});
			            });
	        }
	    // 옵션으로만 검색
        } else if (keywordInput == "" && ((selectedLctCl.length + selectedInduty.length + selectedSbrscl.length) > 0 || sido_search != "")) {
        	ajaxData("camp_list_in_ms.do",
        			{ numOfRows: 5000 },
        			function(data) {
        				$(".totalCount").text(totalCount);
        				$(data).find("item").each(function (i, k) {
        					datailFilter(this);
        				});
        				$("#camp_list_show").append(searchResultSlice(searchDataItems));
        				
        				$(".camp_item").each(function (i, k) {
        					let contentid = $(this).data('contentid');
		       	        	let $container = $(this).find(".Heart_button:last");
	                        loadHeart(contentid, $container);
        				});
		            });
        } else {
        	camp_all_list();
        	pageNo = 1;
        }
    }
    
    // 검색 페이지 이동
 	function searchResultSlice(items){
 		let showSearchResult = items.slice((pageNo - 1) * numOfRows, (pageNo - 1) * numOfRows + numOfRows);
 		markerArr = markerArr.slice((pageNo - 1) * numOfRows, (pageNo - 1) * numOfRows + numOfRows);
 		return showSearchResult;
 	}
    
	//  -------------- 페이징-------------- 
 	// 페이지 html 생성
 	let isLoading = false; 
 	
 	function pageNumbers(){
 		if (!isLoading) {
	 		$(".camp_list_page").empty(); 		
	        if(totalCount > 0) {
				last_page = Math.ceil(totalCount / numOfRows);
			    c_page_index = Math.floor((pageNo - 1) / page_num_count) * page_num_count; 
			    l_page_index = Math.floor((last_page - 1) / page_num_count) * page_num_count; 
			    
			    let pageShow = (pageNo <= page_num_count) ? '<li class="to_disable camp_list_first">' : '<li class="to_able camp_list_first">';
			    pageShow += '<i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
				pageShow += (pageNo <= page_num_count) ? '<li class="to_disable' : '<li class="to_able';
				pageShow +=	' camp_list_before"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
			    
			    for (i = c_page_index; i < c_page_index + page_num_count ; i++){
			    	if (i >= last_page) { break; }
			    	pageNums = i + 1;
		        	pageShow += (pageNums == pageNo) ? '<li class="nowpagecolor">' + pageNums : '<li class="nowpage">' + pageNums;
		        	pageShow += '</li>';
			    }
			    
			    pageShow += (c_page_index == l_page_index) ? '<li class="to_disable' : '<li class="to_able';
			    pageShow += ' camp_list_next"><i class="fa-solid fa-chevron-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
			    pageShow += (c_page_index == l_page_index) ? '<li class="to_disable' : '<li class="to_able';
				pageShow +=	' camp_list_last"><i class="fa-solid fa-angles-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
			    
		        $(".camp_list_page").append(pageShow);
	        } else {
	        	$(".camp_list_page").append("검색 결과가 없습니다.");
	        }
	 	}
    }
 	
	
	// 페이지 이동 계산
	$(document).on("click", ".camp_list_next, .camp_list_before, .nowpage, .camp_list_last, .camp_list_first", function() {
		isLoading = true;
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
	    if(camp_list_option === "camp_all_list") {
        	camp_all_list();
	    } else if (camp_list_option === "search_camp") {
	    	search_camp();
	    }
	    pageNumbers();
	    isLoading = false;
	});
    
    //  -------------- 캠프 div 클릭시 해당 캠핑장 마커로 이동 -------------- 
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
	            map.setZoom(12);
	            naver.maps.Event.trigger(markers[i], 'click',  getClickHandler(i));
	            break; 
	        }
    	}
    });
    
	// 엔터키 입력시
    $("#keyword_input").keypress(function(event) {
        if (event.which === 13) {
        	list_search();
        }
    });
    
	// 검색 onclick 함수
    window.list_search = function() {
		$(".keyword").empty();
		search_camp();
		pageNo = 1;
	}
});

// 리스트로 검색 
function go_list() {
	window.location = 'camplist.do';
}
