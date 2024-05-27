<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.Gson"%>

<c:set var="path" value="${pageContext.request.contextPath}" />

<!doctype html>
<html lang="ko">
<head>
<title>HOME</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<c:choose>
    <c:when test="${admin != null}">
        <%@ include file="hs/admin_header.jsp" %>
    </c:when>
    <c:otherwise>
        <%@ include file="hs/header.jsp" %>
    </c:otherwise>
</c:choose>
<link href="${path}/resources/css/reset.css" rel="stylesheet" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, 그리고 Bootstrap 기여자들">
<meta name="generator" content="Hugo 0.88.1">
<style>
/* #header {
   background-color: rgba(5, 54, 16, 0.7);
} */

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
	color: white;
	height: 40px;
	line-height: 40px;
	background-color: #032805;
	width: 1000px;
    margin: 20px auto;

}

#footer {
	width: 100%;
	position: absolute;
	left: 0px;
}
.popularinner{
	display: flex;
	justify-content: center;

	
}
.show{
padding-left: 60px;
padding-right: 60px;
background-color: #FFBA34;
    margin-top: 35px;
}
/* slider__wrap */
        .slider__wrap {
            width: 100%;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .slider__img { /* 이미지가 보이는 영역 */
            position: relative;
            width: 1100px;
		    height: 550px;
		    top: 50px;
            overflow: hidden;
                border-radius: 20px;
        }
        .slider__inner { /* 이미지 움직이는 영역 */
            display: flex;
            flex-wrap: wrap;
            width: 5500px;  /* 총 이미지가 4800px */
            height: 550px;
        }
        .slider { /* 개별적인 이미지 */
            position: relative;
            width: 1100px;
            height: 550px;
        }
        .slider__btn a {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            width: 50px;
            height: 50px;
            line-height: 50px;
            text-align: center;
            background-color: #041601;
            color: #fff;
            transition: all 0.3s ease;
        }
        .slider__btn a:hover {
            border-radius: 50%;
            background-color: #FFBA34;
            color: #black;
        }
        .slider__btn a.prev {
            left: 320px;
    		top: 520px;
    		color: white;
    		    font-size: 2rem;
    line-height: 42.5px;
        }
        .slider__btn a.next {
            right: 320px;
    		top: 520px;
    		color: white;
    		    font-size: 2rem;
    line-height: 42.5px;
        }
        .slider__dot {
            position: absolute;
            left: 50%;
            bottom: 30px;
            transform: translateX(-50%);
        }
        .slider__dot .dot {
            width: 20px;
            height: 20px;
            background-color: rgba(255, 255, 255, 0.3);
            display: inline-block;
            border-radius: 50%;
            text-indent: -9999px;
            transition: all 0.3s;
            margin: 2px;
        }
        .slider__dot .dot.active {
            background-color: rgba(255, 255, 255, 1);
        }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!--  <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=6ho1djyfzb"></script> -->

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
	                    naver.maps.Event.addListener(markers[i], 'click', 
	                    getClickHandler(i, campList[i].addr1, campList[i].firstimageurl, campList[i].facltnm));
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
<main id="main">
    <div class="slider__wrap">
        <div class="slider__img">
            <div class="slider__inner">
                <div class="slider s1">
                <c:forEach var="c" items="${camphit}">
                <a href="camp_detail.do?contentid=${c.contentid}">
                <img src="${path}/resources/images/main-01.png" alt="이미지1"></a>
                </c:forEach>
                </div>
                <div class="slider s2">
                <a href='together_list.do'>
                <img src="${path}/resources/images/main-02.png" alt="이미지2">
                </a>
                </div>
                <div class="slider s3"><a href="camplist.do"><img src="${path}/resources/images/main-03.png" alt="이미지3"></a></div>
                <div class="slider s4"><a href="camp_map_list.do"><img src="${path}/resources/images/main-04.png" alt="이미지4"></a></div>
                <div class="slider s5"><a href="community_board.do"><img src="${path}/resources/images/main-05.png" alt="이미지5"></a></div>
            </div>
        </div>
        <div class="slider__btn">
            <a href="#" class="prev" title="<"><</a>
            <a href="#" class="next" title=">">></a>
        </div>
    </div>
</main>

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

	<div class="wrap">
		<div class="popular">
			<h3>인기 캠핑장</h3>
			<div class="popularinner">
			<c:forEach var="c" items="${camphit}">
			    <div>
			        <div style="position: relative;">
			            <a href="camp_detail.do?contentid=${c.contentid}">
			                <img class="popularimg" src="${c.firstimageurl}">
			            </a>
			            <div class="popularimg" style="position: absolute; top: 30px;
    left: 30px;
    width: 83.5%;
    height: 89%; background-color: rgba(4, 22, 1, 0.3);"></div>
			            <h4 style="position: absolute; bottom: 105px; left: 50px; color: white; padding: 5px; text-align: left;">${c.facltnm}</h4>
			            <p style="position: absolute; bottom: 73px; left: 50px; color: white; padding: 5px; text-align: left; width: 250px; line-height: 24px;">${c.addr1}</p>
			        </div>
			    </div>
			</c:forEach>

			</div>
			<p>
				<button class="show" onclick="location.href='camplist.do'"><h4>Show More</h4></button>
			</p>
		</div>
		<div class="popular">
			<div style="width: 1000px;     margin: 0 auto;">
				<h3 style="margin-bottom: 20px;" >동행 찾기</h3>
				<c:forEach var="k" items="${board}" varStatus="vs">
					<a href="together_detail.do?t_idx=${k.t_idx}"><p class="find">${k.t_subject }</p></a>
				</c:forEach>
			</div>
			<p>
				<button  class="show" onclick="location.href='together_list.do'"><h4>Show
					More</h4></button>
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
<!--  -->
<script type="text/javascript">
const sliderWrap = document.querySelector(".slider__wrap");
const sliderImg = sliderWrap.querySelector(".slider__img");             // 보여지는 영역
const sliderInner = sliderWrap.querySelector(".slider__inner");         // 움직이는 영역
const slider = sliderWrap.querySelectorAll(".slider");                  // 개별 이미지
const sliderDot = sliderWrap.querySelector(".slider__dot");             // 닷 메뉴
const sliderBtn = sliderWrap.querySelectorAll(".slider__btn a");        // 버튼 

let currentIndex = 0;                                                   // 현재 보이는 이미지
let sliderCount = slider.length;                                        // 이미지 갯수
let sliderInterval = 2000;                                              // 이미지 변경 간격 시간
let sliderWidth = slider[0].clientWidth;                                // 이미지 가로값 구하기
let dotIndex = "";
</script>
<script type="text/javascript">
//이미지 이동시키기
function gotoSlider(num){
    sliderInner.style.transition = "all 400ms";
    sliderInner.style.transform = "translateX(" + -sliderWidth * num + "px)";
    currentIndex = num;

    // 닷 메뉴 활성화하기
    let dotActive = document.querySelectorAll(".slider__dot .dot");
    dotActive.forEach((active) => active.classList.remove("active"));
    dotActive[num].classList.add("active");
}
//버튼을 클릭했을 때
sliderBtn.forEach((btn, index) => {
    btn.addEventListener("click", () => {
        let prevIndex = (currentIndex + (sliderCount-1)) % sliderCount;
        let nextIndex = (currentIndex+1) % sliderCount;

        if(btn.classList.contains("prev")){
            gotoSlider(prevIndex);
        } else {
            gotoSlider(nextIndex);
        }
    });
});
</script>


<%@ include file="hs/footer.jsp"%>
</html>