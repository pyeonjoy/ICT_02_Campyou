<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=qpvmsbuult"></script>


<style type="text/css">
	#detail_img img {
		width: 300px;
		height: 300px;
	}
	.camp_detail_wrap h4{
		width : 80%;
		height: 50px;
		background-color: #FFBA34;
		text-align: center;
		line-height: 50px;
	}
	    #detail_img {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        grid-gap: 10px;
    }
    #detail_img img {
        width: 60%;
        height: 60%;
    }
    #detail_img img:first-child {
        grid-column: 1 / span 2;
        grid-row: 1 / span 2;
    }
    .camp_detail_second_title{
    	width : 80%;
		height: 50px;
		background-color: #FFBA34;
		text-align: left;
		line-height: 50px;
		font-size: 20px;
    	margin: 0 auto;
    }
</style>
<script>
$(document).ready(function() {
    const urlParams = new URLSearchParams(window.location.search);
    const contentId = urlParams.get('contentid');
    
    if (contentId) {
        $.ajax({
            url: "camp_detail_img.do",
            method: "post",
            data: { contentid: contentId },
            dataType: "xml",
            success: function(data) {
                $("#detail_img").empty();
                $(data).find("item").each(function() {
                    let imageUrl = $(this).find("imageUrl").text();
                    let contentId = $(this).find("contentId").text();
                    
                    let campImg = "<div>";
                    campImg += "<img src='" + imageUrl + "' alt='이미지'>";
                    campImg += "</div>";

                    $("#detail_img").append(campImg);
                });

                let latlng = new naver.maps.LatLng(${info.mapy}, ${info.mapx});
                let map = new naver.maps.Map("map", {
                    center: latlng,
                    zoom: 16
                });
                let marker = new naver.maps.Marker({
                    position: latlng,
                    map: map
                });
                naver.maps.Event.addListener(marker, 'click', function(e) {
                    let infoWindow = new naver.maps.InfoWindow({
                        content: '<div style="padding:20px;"><b>이름 : ${info.facltnm}<br><br>주소 : ${info.addr1}<br><br>전화번호 : ${info.tel}</b></div>'
                    });
                    infoWindow.open(map, marker);
                });
            },
            error: function() {
                alert("읽기 실패");
            }
        });
    }
});
</script>

<title>캠핑장 상세 페이지</title>
</head>
<body>
<jsp:include page="../hs/header.jsp" />
<div class="camp_detail_wrap">
<div style="height: 100px;"><!-- 헤더 너무 딱 붙어있어서 임시 거리 --></div>
    <h4>상세보기</h4>
    <div id="detail_img">
    	<!-- 이미지 들어간 자리  -->
    </div>
    <p>${info.facltnm}</p>
    <span>${info.lctcl}/${info.induty}</span>
    <p>${info.addr1}</p>
    <p>${info.tel}</p>
    <div class="camp_detail_second_title">
    <a href="#">소개 및 시설</a>
    <a href="#">위치</a>
    <a href="#">후기</a>
    </div>
    <p>운영기간 : ${info.operpdcl}</p>
    <p>운영일 : ${info.operdecl}</p>
    <p>주변이용가능 시설 : ${info.posblfcltycl}</p>
    <p>예약방법 : ${info.resved}</p>
    
    <p>${info.intro }</p>
<div id="map" style="width:100%;height:400px;"></div>
</div>
<jsp:include page="../hs/footer.jsp" />
<script>
let map = new naver.maps.Map("map", {
    center: new naver.maps.LatLng(
      37.552758094502494,
      126.98732600494576
    ),
    zoom: 10,
  });
</script>
</body>
</html>
