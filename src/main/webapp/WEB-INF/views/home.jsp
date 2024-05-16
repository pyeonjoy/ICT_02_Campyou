<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.Gson"%>

<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="hs/header.jsp"%>

<!doctype html>
<html lang="ko">
<link href="${path}/resources/css/reset.css" rel="stylesheet" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, 그리고 Bootstrap 기여자들">
<meta name="generator" content="Hugo 0.88.1">
<title>임시 메인페이지</title>
<style>
#header {
   background-color: rgba(5, 54, 16, 0.7);
}

.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

body {
	background-image: url(${path}/resources/images/back.png);
	width: 100%
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

.py-2 img {
	width: 30px;
}

.py-2 {
	color: #FFFDDE;
}

.wrap {
	margin: auto;
	width: 1500px;
	text-align: center;
	font-weight: bold;
	color: #FFFDDE;
}

.popular img {
	width: 300px;
	height: 500px;
	margin: 30px;
}

button {
	height: 40px;
}

.layer_popup {
	display: none;
	position: fixed;
	background-color: black;
	display: inline-block;
	z-index: 9999;
	padding: 10px;
	top: 130px;
	left:130px;
}

.popimg {
	display: block;
	margin: 0 auto;
	max-width: 100%;
	max-height: 100%;
}

#check1 {
	background-color: #FFBA34;
	text-align: center;
	position: absolute;
	left: 50%;
	width: 100%;
	transform: translateX(-50%);
}

.popular {
	opacity: 0;
	margin-top: 100px;
	max-width: 100%;
	height: 700px;
}

.popularimg {
	object-fit: cover;
	border-radius: 10px;
}

.find {
	margin: 50px;
	color: black;
	height: 40px;
	line-height: 40px;
	background-color: #FFFDDE;
}

#footer {
	width: 100%;
	position: absolute;
	left: 0px;
}
.popularinner{
	display: flex;
	justify-content: center;
	margin-bottom: 35px;
	
}
.show{
padding-left: 60px;
padding-right: 60px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=6ho1djyfzb"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=6ho1djyfzb&submodules=geocoder"></script>
<script  type="text/javascript" src="resources/js/MarkerClustering.js"></script>
<!-- 이펙트  -->
<script type="text/javascript">
$(document).ready(function() {
    $(window).scroll( function(){
        $('.popular').each( function(i){
            
            var bottom_of_element = $(this).offset().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();
            
            if( bottom_of_window > bottom_of_element ){
                $(this).animate({'opacity':'1','margin-top':'200px'},1000);
            }
            
        }); 
    });
 
 

// 	$(function() {
		initMap();
// 	});

	function initMap() {
	    let markers = [];
	    let infoWindows = [];
	    navigator.geolocation.getCurrentPosition(function(position) {
	    $.ajax({
	        url: "together_Write2.do",
	        type: "post",
	        dataType: "json",
	        success: function(data) {
	        	if (data !== "fail") {
					let campList = data;
					 const lat = position.coords.latitude;
				        const lng = position.coords.longitude;
				        let map = new naver.maps.Map('map', {
				            center: new naver.maps.LatLng(lat, lng),
				            zoom: 15
				        });

	                for (var i = 0; i < campList.length; i++) {
	                	let camp = campList[i];
	                    let position = new naver.maps.LatLng(camp.mapy, camp.mapx);

	                    let marker = new naver.maps.Marker({
	                        map: map,
	                        title: "test", // 지역구 이름 
	                        position: position
	                    });
	                    let infoWindow = new naver.maps.InfoWindow({
	                        content: '<div style="width:220px;text-align:center;padding:10px;"><img src="' + camp.firstimageurl + '" alt="" style="width:100%;" /><b>' + camp.facltnm + '</b><br><br> ' + camp.induty + '<br>(' + camp.facltdivnm + '/' + camp.mangedivnm + ') <br><br></div>',
	                        disableAutoPan: true // 정보창열릴때 지도이동 안함
	                    });

	                    markers.push(marker); // 생성한 마커를 배열에 담는다.
	                    infoWindows.push(infoWindow); // 생성한 정보창을 배열에 담는다.
	                }
	                

	                var htmlMarker1 = {
	        	            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(/resources/images/cluster-marker-1.png);background-size:contain;"></div>',
	        	            size: N.Size(40, 40),
	        	            anchor: N.Point(20, 20)
	        	        },
	        	        htmlMarker2 = {
	        	            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(/resources/images/cluster-marker-2.png);background-size:contain;"></div>',
	        	            size: N.Size(40, 40),
	        	            anchor: N.Point(20, 20)
	        	        },
	        	        htmlMarker3 = {
	        	            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(/resources/images/cluster-marker-3.png);background-size:contain;"></div>',
	        	            size: N.Size(40, 40),
	        	            anchor: N.Point(20, 20)
	        	        },
	        	        htmlMarker4 = {
	        	            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(/resources/images/cluster-marker-4.png);background-size:contain;"></div>',
	        	            size: N.Size(40, 40),
	        	            anchor: N.Point(20, 20)
	        	        },
	        	        htmlMarker5 = {
	        	            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(/resources/images/cluster-marker-5.png);background-size:contain;"></div>',
	        	            size: N.Size(40, 40),
	        	            anchor: N.Point(20, 20)
	        	        };
	                
	                function getClickHandler(seq, addr, imageUrl, campName) {
	                    return function(e) {  // 마커를 클릭하는 부분
	                    	let marker = markers[seq], // 클릭한 마커의 시퀀스로 찾는다.
	                            infoWindow = infoWindows[seq]; // 클릭한 마커의 시퀀스로 찾는다

	                        if (infoWindow.getMap()) {
	                            infoWindow.close();
	                        } else {
	                            infoWindow.open(map, marker);
	                        }
	                    }
	                }

	                var markerClustering = new MarkerClustering({
	        	        minClusterSize: 2,
	        	        maxZoom: 13,
	        	        map: map,
	        	        markers: markers,
	        	        disableClickZoom: false,
	        	        gridSize: 120,
	        	        icons: [htmlMarker1, htmlMarker2, htmlMarker3, htmlMarker4, htmlMarker5],
	        	        indexGenerator: [10, 100, 200, 500, 1000],
	        	        stylingFunction: function(clusterMarker, count) {
	        	            $(clusterMarker.getElement()).find('div:first-child').text(count);
	        	        }
	        	    });

	                for (var i = 0, ii = markers.length; i < ii; i++) {
//	                    console.log(markers[i], getClickHandler(i));
	                    naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i, campList[i].addr1, campList[i].firstimageurl, campList[i].facltnm)); // 클릭한 마커 핸들러
	                }
	            }
	            
	        }, // success function 종료

	        error: function(xhr, status, error) {
	            console.error("AJAX Error: ", status, error);
	        }
	        });
	    });
	}
});
   
</script>

</head>
<body>

	<div id="layer_popup1" class="layer_popup"
		style=" background-color: white;">
		<c:forEach var="k" items="${pop}" varStatus="vs">
			<c:if test="${k.active == 1}">
				<img class="popimg" style="object-fit: cover;"
					src="resources/popup/${k.f_name}">
			</c:if>
		</c:forEach>
		<div id="check1">
			<input type="checkbox" id="chkbox1"> <label for="chkbox1">오늘
				하루동안 안 보기</label>
			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
			<a href="javascript:closePop(1);" class="x">닫기</a>
		</div>
	</div>



	<h1 class="display-4 fw-normal" style="padding: 200px;">.</h1>
	<h1 class="display-4 fw-normal">
		<button onclick="location.href='together_list.do'">준수</button>
	</h1>
	<h1 class="display-4 fw-normal">
		<button onclick="location.href='inquiry_form.do'">보미</button>
	</h1>
	<h1 class="display-4 fw-normal">
		<button onclick="location.href='inquiry_form.do'">해성</button>
	</h1>
	<h1 class="display-4 fw-normal">
		<button onclick="location.href='sign_up_page_go.do'">한욱</button>
	</h1>
	<h1 class="display-4 fw-normal">
		<button onclick="location.href='admin_main.do'">조이</button>
	</h1>
	<h1 class="display-4 fw-normal">
		<button onclick="location.href='camplist.do'">준형</button>
	</h1>
	<a href="inquiry_form.do">1:1문의작성</a>
	<a href="my_info.do">내정보</a>
	<a href="my_faq.do">faq</a>
	<a href="my_main.do">마이페이지</a>
	<a href="together_list.do">동행</a>
	<div class="wrap">
		<div class="popular">
			<h3>Popular campsites</h3>
			<div class="popularinner">
			<c:forEach var="c" items="${camphit}">
			<div>
			<div>
				<a href="camp_detail.do?contentid=${c.contentid}"> <img
					class="popularimg" src="${c.firstimageurl}">
					</a>
			</div>
			<div>
				<h4>${c.facltnm }</h4>
			</div>
			</div>
			</c:forEach>
			</div>
			<p>
				<button class="show" onclick="location.href='camplist.do'">Show More</button>
			</p>
		</div>
		<div class="popular">
			<div style="paddig-top: 500px;">
				<h3>Find camping mates</h3>
				<c:forEach var="k" items="${board}" varStatus="vs">
					<a href="together_detail.do?t_idx=${k.t_idx}"><p class="find">${k.t_subject }</p></a>
				</c:forEach>
			</div>
			<p>
				<button  class="show" onclick="location.href='together_list.do'">Show
					More</button>
			</p>
		</div>
	</div>
	<div id="map" style="width: 100%; height: 75vh; margin: 0 auto;"></div>
</body>

<script type="text/javascript">
	function setCookie(name, value, exDay) {
		var todayDate = new Date();
		todayDate.setDate(todayDate.getDate() + exDay);
		document.cookie = name + "=" + escape(value) + ";expires="
				+ todayDate.toGMTString() + ";path=/";
	}

	function getCookie(name) {
		var nameEQ = name + "=";
		var ca = document.cookie.split(';');
		for (var i = 0; i < ca.length; i++) {
			var c = ca[i];
			while (c.charAt(0) == ' ')
				c = c.substring(1, c.length);
			if (c.indexOf(nameEQ) == 0)
				return c.substring(nameEQ.length, c.length);
		}
		return null;
	}

	function closePop(popId) {
		var cookiedata = document.cookie;
		if (document.getElementById('chkbox' + popId).checked) {
			setCookie("popup" + popId, "done", 1);
		}
		document.getElementById('layer_popup' + popId).style.display = "none";
	}

	document.addEventListener("DOMContentLoaded", function() {
		checkPopup();
	});
	function checkPopup() {
	    for (var i = 1; i <= 5; i++) {
	        if (getCookie("popup" + i) === "done") {
	            var popup = document.getElementById('layer_popup' + i);
	            if (popup) {
	                popup.style.display = "none";
	            }
	        } else {
	            var popup = document.getElementById('layer_popup' + i);
	            if (popup) {
	                popup.style.display = "block";
	            }
	        }
	    }
	}
</script>

<%@ include file="hs/footer.jsp"%>
</html>