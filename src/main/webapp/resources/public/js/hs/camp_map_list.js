$(document).ready(function() {
	    let pageNo = 1;
	    
	    let markerArr = new Array();
	    let markers = new Array();
	    let infoWindows = new Array();
	    
        var mapDiv = document.getElementById('map'); // 'map'으로 선언해도 동일

		var map = new naver.maps.Map(mapDiv,{
				zoom: 10		
			}
		);
     
	    function camp_all_list() {
	        $.ajax({
	            url: "camp_list.do",
	            method: "post",
	            data: { pageNo: pageNo },
	            dataType: "xml",
	            success: function(data) {
	            	for (let i = 0; i < markers.length; i++) {
                        markers[i].setMap(null);
                    }
                    markers = [];
                    
	            	console.log(markers)
	                $("#camp_list_show").empty();
	                $(data).find("item").each(function(i, k) {
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
	                    let mapX = $(this).find("mapX").text();
	                    let mapY = $(this).find("mapY").text();
	                    
	                    markerArr.push({lat: mapY, lng: mapX, facltNm: facltNm, addr1: addr1,tel:tel})
	                });
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
		       		
	            },
	            error: function() {
	                alert("읽기 실패");
	            }
	        });
	    }
	   	camp_all_list();
	
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
	                });
	            },
	            error: function() {
	                alert("검색 실패");
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
	    
	    $(".camp_list_next").on("click", function() {
	        nextPage();
	    });
	    $(".camp_list_before").on("click", function() {
	     	if(pageNo <= 1) {
	     		return false;
	     	} else {
	     		beforePage();
	     	}
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
