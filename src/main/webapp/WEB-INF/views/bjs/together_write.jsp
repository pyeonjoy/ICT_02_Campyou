<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>동행글 작성</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<%@ include file="../hs/header.jsp" %>
<link rel="stylesheet" href="${path}/resources/public/css/bjs/together_write.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=6ho1djyfzb"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=6ho1djyfzb&submodules=geocoder"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<%-- <script defer src="${path}/resources/public/js/bm/lang/summernote-ko-KR.js"></script> --%>
<script src="resources/js/lang/summernote-ko-KR.js" ></script>
<script defer src="${path}/resources/public/js/bm/summernote-lite.js"></script>
<script defer src="${path}/resources/public/js/bm/my_menu.js"></script>
<script src="https://cdn.jsdelivr.net/npm/markerclustererplus/dist/markerclusterer.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('.summernote').summernote({
	    lang : 'ko-KR',
    	height : 300,
    	focus : true,
    })
})
	$(function() {
	    $('input[name="datetimes"]').daterangepicker({
	        "locale": {
	            "format": "YYYY/MM/DD",
	            "separator": " ~ ",
	            "applyLabel": "확인",
	            "cancelLabel": "취소",
	            "fromLabel": "From",
	            "toLabel": "To",
	            "customRangeLabel": "Custom",
	            "weekLabel": "W",
	            "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
	            "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
	        },
	        "startDate": new Date(),
	        "endDate": new Date(),
	        "drops": "auto"
// 	    }
// 	    }, function(start, end, label) {
// 	        fetchWeatherInfo(start.format('20240522'), end.format('20240523'));
	    });
	});

// 	function fetchWeatherInfo(startDate, endDate) {
// 	    let lat = 37;
// 	    let lon = 126;
// 		console.log("날씨ajax왔나")
// 	    $.ajax({
// 	        url: 'weather_search.do',
// 	        type: 'post',
// 	        data: {
// 	            lat: lat,
// 	            lon: lon,
// 	            startDate: startDate,
// 	            endDate: endDate
// 	        },
// 	        dataType: 'json',
// 	        success: function(data) {
// 	            console.log(data);
// 	            displayWeatherInfo(data); // 날씨 정보를 표시하는 함수
// 	        },
// 	        error: function(xhr, status, error) {
// 	            console.error(error);
// 	        }
// 	    });
// 	}
// 	function displayWeatherInfo(data) {
// 	    $('#weatherInfo').html(weatherHTML);
// 	}

var badWords = new Array("시발", "병신", "개새끼");

function hasBadWords(comment) {
	const lowercaseComment = comment.trim().toLowerCase();
	for (let i = 0; i < badWords.length; i++) {
	    if (lowercaseComment.includes(badWords[i].toLowerCase())) {
	        return badWords[i];
	    }
	}
	return null;
}
	
	let campImageUrl;
	let t_mapx;
	let t_mapy;
	let t_induty;
	let t_facltdivnm;
	let t_mangedivnm;
	
	function together_write_ok() {
		let formData = new FormData(document.getElementsByClassName('togetherWriteForm')[0]);
	    let startDate = $('input[name="datetimes"]').data('daterangepicker').startDate.format('YYYY/MM/DD');
	    let endDate = $('input[name="datetimes"]').data('daterangepicker').endDate.format('YYYY/MM/DD');

	    let subject = $("input[name='t_subject']").val();
        let content = $("#summernote").summernote('code');
        
        let badWord = hasBadWords(content.replace(/\s+/g, ''));
        if (badWord !== null) {
            alert("'" + badWord + "'는(은) 사용할수 없습니다. 다시 작성해주세요.");
            return;
        }

        if (subject.trim() === '') {
            alert("제목을 입력하세요.");
            return;
        }
        if (content.trim() === '' || content === '<p><br></p>') {
            alert("내용을 입력하세요.");
            return;
        }
	    if (!t_mapx && !t_mapy) {
	        alert("동행할 캠핑장 위치를 선택해주세요.");
	        return;
	    }

	    formData.append("t_startdate", startDate);
	    formData.append("t_enddate", endDate);
	    formData.append("t_mapx", t_mapx);
	    formData.append("t_mapy", t_mapy);
	    formData.append("tf_name", campImageUrl);
	    formData.append("t_induty", t_induty);
	    formData.append("t_facltdivnm", t_facltdivnm);
	    formData.append("t_mangedivnm", t_mangedivnm);

	    $.ajax({
	        url: 'together_Write_ok.do',
	        type: 'post',
	        data: formData,
	        processData: false,
	        contentType: false,
	        async: false,
	        success: function(response) {
	           location.href='together_list.do';
	        },
	        error: function(xhr, status, error) {
	            console.error(error);
	        }
	    });
	    return false;
	}
	
	
	
	let map;
	
	$(document).ready(function() {
	    initMap();
	    $(".res").click(function() {
	        searchCamp();
	    });
	    // 엔터 키를 눌렀을 때 검색 실행
	    $(".searchbar").keydown(function(e) {
	        if (e.keyCode === 13) {
	            e.preventDefault();
	            searchCamp();
	        }
	    });
	});   
	
	function searchCamp() {
        let campName = $(".searchbar").val();
        $.ajax({
            url: 'searchCamp.do',
            type: 'post',
            data: {
                campName: campName
            },
            dataType: 'json',
            success: function(data) {
                if (data !== "fail") {
                    let camp = data;
                    let position = new naver.maps.LatLng(camp.mapy, camp.mapx);
                    
                    map.setCenter(position);
                    map.setZoom(17);
                    
                    let infoWindow = new naver.maps.InfoWindow({
                        content: '<div style="width:220px;text-align:center;padding:10px;"><img src="' + camp.firstimageurl + '" alt="" style="width:100%;" /><b>' + camp.facltnm + '</b><br><br> ' + camp.induty + '<br>(' + camp.facltdivnm + '/' + camp.mangedivnm + ') <br><br></div>',
                        disableAutoPan: true
                    });
                    infoWindow.open(map, position);
                    
                    $('.togetherSub1DivP').val(camp.addr1);
                    $('.togetherSub1DivP1').val(camp.facltnm);
                    t_induty = $('.togetherCampType').text(camp.induty);
                    campImageUrl = camp.firstimageurl;
                    t_mapx = camp.mapx;
                    t_mapy = camp.mapy;
                    t_induty = camp.induty;
                    t_facltdivnm = camp.facltdivnm;
                    t_mangedivnm = camp.mangedivnm;
                	
                	$(".searchbar").val("");
                } 
            },
            error: function(xhr, status, error) {
            	alert("검색 결과가 없습니다.");
            }
        });
    };
	    
	function initMap() {
	    let markers = [];
	    let infoWindows = [];

	    $.ajax({
	        url: "together_Write2.do",
	        type: "post",
	        dataType: "json",
	        success: function(data) {
	            if(data !== "fail") {
	                let campList = data;

	                // 지도 시작지점
                	map = new naver.maps.Map('map', {
	                    center: new naver.maps.LatLng(37.552758094502494, 126.98732600494576),
	                    zoom: 10
	                });
						
	                for (var i = 0; i < campList.length; i++) {
	                	let camp = campList[i];
	                    let position = new naver.maps.LatLng(camp.mapy, camp.mapx);

	                    let marker = new naver.maps.Marker({
	                        map: map,
	                        title: camp.facltnm, // 지역구 이름 
	                        position: position
	                    });
	                    
	                    /* 정보창 */
	                    let infoWindow = new naver.maps.InfoWindow({
	                        content: '<div style="width:220px;text-align:center;padding:10px;"><img src="' + camp.firstimageurl + '" alt="" style="width:100%;" /><b>' + camp.facltnm + '</b><br><br> ' + camp.induty + '<br>(' + camp.facltdivnm + '/' + camp.mangedivnm + ') <br><br></div>',
	                        disableAutoPan: true // 정보창열릴때 지도이동 안함
	                    });

	                    markers.push(marker);
	                    infoWindows.push(infoWindow);
	                }

	                function getClickHandler(seq, addr, imageUrl, campName, mapx, mapy, induty, facltdivnm, mangedivnm) {
	                    return function(e) { 
	                    	let marker = markers[seq], // 클릭한 마커의 시퀀스로 찾는다.
	                            infoWindow = infoWindows[seq]; // 클릭한 마커의 시퀀스로 찾는다

	                        if (infoWindow.getMap()) {
	                            infoWindow.close();
	                            $('.togetherSub1DivP').val("");
	                            $('.togetherSub1DivP1').val("");
	                            $('.togetherCampType').text("");
	                            campImageUrl = "";
	                            t_mapx = "";
	                            t_mapy = "";
	                            t_induty = "";
	                            t_facltdivnm = "";
	                            t_mangedivnm = "";
	                        } else {
	                            infoWindow.open(map, marker);
	                            $('.togetherSub1DivP').val(addr);
	                            $('.togetherSub1DivP1').val(campName);
	                            t_induty = $('.togetherCampType').text(induty);
	                            campImageUrl = imageUrl;
	                            t_mapx = mapx;
	                            t_mapy = mapy;
	                            t_induty = induty;
	                            t_facltdivnm = facltdivnm;
	                            t_mangedivnm = mangedivnm;
	                        }
	                    }
	                }

	                for (var i = 0, ii = markers.length; i < ii; i++) {
	                    naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i, campList[i].addr1, campList[i].firstimageurl, campList[i].facltnm, campList[i].mapx, campList[i].mapy, campList[i].induty, campList[i].facltdivnm, campList[i].mangedivnm)); // 클릭한 마커 핸들러
	                }
	            }
	        },
			error : function() {
				alert("읽기실패");
			}
	    });
	}
	
	
	// 셀렉트 박스에 옵션을 동적으로 추가하는 함수
	function selectBox() {
	  let selectBox = document.getElementById("numberOfPeople");
	  for (let i = 2; i <= 30; i++) {
		  let option = document.createElement("option");
	    option.value = i;
	    option.text = i;
	    selectBox.appendChild(option);
	  }
	}

	// 페이지 로드 시 셀렉트 박스에 옵션을 추가
	window.onload = function() {
	  selectBox();
	}
	
	
// 	var apiURI = "http://api.openweathermap.org/data/2.5/weather?q=seoul&appid="+"b00ec7b574ad2d29c4a0cba2566fc717";
//     $.ajax({
//         url: apiURI,
//         dataType: "json",
//         type: "GET",
//         async: "false",
//         success: function(resp) {
//             console.log(resp);
//             console.log("현재온도 : "+ (resp.main.temp- 273.15) );
//             console.log("현재습도 : "+ resp.main.humidity);
//             console.log("날씨 : "+ resp.weather[0].main );
//             console.log("상세날씨설명 : "+ resp.weather[0].description );
//             console.log("날씨 이미지 : "+ resp.weather[0].icon );
//             console.log("바람   : "+ resp.wind.speed );
//             console.log("나라   : "+ resp.sys.country );
//             console.log("도시이름  : "+ resp.name );
//             console.log("구름  : "+ (resp.clouds.all) +"%" );   
//             var imgURL = "http://openweathermap.org/img/w/" + resp.weather[0].icon + ".png";
//             $("html컴포넌트").attr("src", imgURL);
//         }
//     })
    
    

</script>
</head>
<body>
	<div class="towContainer">
	    <form class="togetherWriteForm">
	        <div class="togetherWriteInput">
	            <div class="togetherh2">
	                <h2>동 행 글쓰기</h2>
	            </div>
	            <input type="text" name="t_subject" class="togetherWriteInput1" placeholder="제목을 입력하세요" required>
	            <textarea class="togetherWriteInput2 summernote" name="t_content" id="summernote" placeholder="내용을 입력하세요" required></textarea>
	            <input type="button" value="작성하기" class="togetherWriteInputSubmit" onclick="together_write_ok()">
	        </div>
	        <div class="togetherWriteSelect">
	            <span class="togetherSub5Strong">캠핑타입</span>
				<span class="togetherCampType"></span>
	            <div class="togetherSub1">
	                <strong class="togetherSub5Strong">캠핑장</strong>
	                <div class="togetherSub1Div">
	                	<div class="searchForm">
		                	<input type="search" name="" class="searchbar" placeholder="캠핑장 이름">
	        				<input type="button" class="res" value="검색">
        				</div>
        				<input type="text" name="t_campname" class="togetherSub1DivP1">
	                    <textarea name="t_address" class="togetherSub1DivP" readonly></textarea>
	                </div>
	            </div>
	            <div>
	                <div id="map" class="togetherSub1Img"></div>
	            </div>
	            <div class="togetherSub5">
	                <strong class="togetherSub5Strong">캠핑인원&nbsp;</strong>
	                <select name="t_numpeople" class="numberOfPeople" id="numberOfPeople"></select>
	                <span>명</span>
	            </div>
	            <div class="togetherSub2">
	                <strong class="togetherSub5Strong">캠핑기간</strong>
	                <p><input type="text" name="datetimes" value="" class="datetimes" /></p>
	            </div>
	            <div id="weatherInfo"></div>
	        </div>
	    </form>
	</div>
<%@ include file="../hs/footer.jsp" %>
</body>
</html>