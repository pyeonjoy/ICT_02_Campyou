<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>동행글 수정</title>
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
<script src="resources/js/summernote-lite.js" ></script>
<script src="resources/js/lang/summernote-ko-KR.js" ></script>
<link rel="stylesheet" href="resources/css/summernote-lite.css">
<script src="https://cdn.jsdelivr.net/npm/markerclustererplus/dist/markerclusterer.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#t_content").summernote({
			lang : 'ko-KR',
			height : 300,
			focus : true,
			placeholder: '최대3000자까지 쓸 수 있습니다'	,
// 				disableHtmlResizing: true, // <p> 태그 자동 생성 비활성화
			callbacks : {
				onImageUpload : function(files, editor) {
					for (var i = 0; i < files.length; i++) {
						sendImage(files[i], editor);						
					}
				}
			}
		});
	});
	//	var extract_html = content.replace(/(<([^>]+)>)/ig,"");
	//	if (extract_html == "") {
	//	    alert("내용없음");
	//	}
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
	  });
	});
	
	let campImageUrl;
	let t_mapx;
	let t_mapy;
	let t_induty;
	let t_facltdivnm;
	let t_mangedivnm;
	
	function together_update_ok() {
		let formData = new FormData(document.getElementsByClassName('togetherWriteForm')[0]);
	    let startDate = $('input[name="datetimes"]').data('daterangepicker').startDate.format('YYYY/MM/DD');
	    let endDate = $('input[name="datetimes"]').data('daterangepicker').endDate.format('YYYY/MM/DD');

// 	    if (!t_induty) {
// 	        alert("캠핑 타입을 선택해주세요.");
// 	        return;
// 	    }
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
	        url: 'together_update_ok.do',
	        type: 'post',
	        data: formData,
	        processData: false,
	        contentType: false,
	        async: false,
	        success: function(response) {
	        	let cPage = $('#cPage').val();
	        	location.href='together_detail.do?t_idx=' + response + '&cPage=' + cPage;
	        },
	        error: function(xhr, status, error) {
	            console.error(error);
	        }
	    });
	    return false;
	}
	
	$(document).ready(function() {
	    $('.togetherSub1Button').click(function() {
	        $('.togetherSub1Button').removeClass('active');
	        $(this).addClass('active');
	    });
	});
		
	
	
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
                    
                    $('.togetherSub1DivP').val(addr);
                    $('.togetherSub1DivP1').val(campName);
                    t_induty = $('.togetherCampType').text(induty);
                    campImageUrl = imageUrl;
                    t_mapx = mapx;
                    t_mapy = mapy;
                    t_induty = induty;
                    t_facltdivnm = facltdivnm;
                    t_mangedivnm = mangedivnm;
                	
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
	    t_mapx = $('input[name="t_mapxh"]').val();
	    t_mapy = $('input[name="t_mapyh"]').val();
	    campImageUrl = $('input[name="tf_nameh"]').val();
// 	    let selectedCampname = $('input[name="t_campname"]').val();
	    t_induty = document.querySelector('.togetherCampType').innerText;
	    t_facltdivnm = $('input[name="t_facltdivnmh"]').val();
	    t_mangedivnm = $('input[name="t_mangedivnmh"]').val();
	    
	    $.ajax({
	        url: "together_Write2.do",
	        type: "post",
	        dataType: "json",
	        success: function(data) {
	            if(data !== "fail") {
	                let campList = data;

                	map = new naver.maps.Map('map', {
	                    center: new naver.maps.LatLng(t_mapy, t_mapx),
	                    zoom: 15
	                });

	                for (let i = 0; i < campList.length; i++) {
	                	let camp = campList[i];
	                    let position = new naver.maps.LatLng(camp.mapy, camp.mapx);

	                    let marker = new naver.maps.Marker({
	                        map: map,
	                        title: camp.facltnm,
	                        position: position
	                    });
	                    
	                    let infoWindow = new naver.maps.InfoWindow({
	                        content: '<div style="width:220px;text-align:center;padding:10px;"><img src="' + camp.firstimageurl + '" alt="" style="width:100%;" /><b>' + camp.facltnm + '</b><br><br> ' + camp.induty + '<br>(' + camp.facltdivnm + '/' + camp.mangedivnm + ') <br><br></div>',
	                        disableAutoPan: true // 정보창열릴때 지도이동 안함
	                    });
// 	                    let infoWindow2 = new naver.maps.InfoWindow({
// 	                        content: '<div style="width:220px;text-align:center;padding:10px;"><img src="' + selectedImage + '" alt="" style="width:100%;" /><b>' + selectedCampname + '</b><br><br> ' + selectedInduty + '<br>(' + selectedFacltdivnm + '/' + selectedMangedivnm + ') <br><br></div>',
// 	                        disableAutoPan: true // 정보창열릴때 지도이동 안함
// 	                    });

	                    markers.push(marker);
	                    infoWindows.push(infoWindow);
	                    
	                    if (t_mapx == camp.mapx && t_mapy == camp.mapy) {
	                        infoWindow.open(map, marker);
	                    }
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
	
	
	// 페이지 로드 시 셀렉트 박스에 옵션을 추가하고 기본값 설정
	window.onload = function() {
		let t_numpeople2 = document.querySelector('input[name="t_numpeople2"]').value;
		let selectBox = document.getElementById("numberOfPeople");
		
		for (let i = 2; i <= 30; i++) {
		  let option = document.createElement("option");
		  option.value = i;
		  option.text = i;
		  selectBox.appendChild(option);
		}
		  
		let optionToSelect = document.querySelector('#numberOfPeople option[value="' + t_numpeople2 + '"]');
		  if (optionToSelect) {
		    optionToSelect.selected = true;
		  }
	}
</script>
</head>
<body>
	<div class="towContainer">
	    <form class="togetherWriteForm">
	        <div class="togetherWriteInput">
	            <div class="togetherh2">
	                <h2>동 행 수정하기</h2>
	            </div>
	            <input type="text" name="t_subject" class="togetherWriteInput1" value="${tvo.t_subject }" placeholder="제목을 입력하세요" required>
	            <textarea class="togetherWriteInput2" name="t_content" id="t_content" placeholder="내용을 입력하세요" required>${tvo.t_content }</textarea>
	            <input type="button" value="수정하기" class="togetherWriteInputSubmit" onclick="together_update_ok()">
	            <input type="hidden" name="t_idx" id="t_idx" value="${tvo.t_idx }">
	            <input type="hidden" name="cPage" id="cPage" value="${cPage }" >
	        </div>
	        <div class="togetherWriteSelect">
	            <span class="togetherSub5Strong">캠핑타입</span>
				<span class="togetherCampType">${tvo.t_induty }</span>
<!-- 	            <div class="togetherSub1"> -->
<!-- 	            	<button type="button" name="카라반" value="카라반" class="togetherSub1Button">카라반</button> -->
<!-- 	            	<button type="button" name="글램핑" value="글램핑" class="togetherSub1Button">글램핑</button> -->
<!-- 	            	<button type="button" name="야영지" value="야영지" class="togetherSub1Button">야영지</button> -->
<!-- 	            </div> -->
	            <div class="togetherSub1">
	                <strong class="togetherSub5Strong">캠핑장</strong>
	                <div class="togetherSub1Div">
	                	<div class="searchForm">
		                	<input type="search" name="" class="searchbar" placeholder="캠핑장 이름">
	        				<input type="button" class="res" value="검색">
        				</div>
        				<input type="text" name="t_campname" value="${tvo.t_campname }" class="togetherSub1DivP1">
	                    <textarea name="t_address" class="togetherSub1DivP" readonly>${tvo.t_address }</textarea>
	                </div>
	            </div>
	            <div>
	                <div id="map" class="togetherSub1Img"></div>
	                <input type="hidden" name="t_mapxh" value="${tvo.t_mapx }">
	                <input type="hidden" name="t_mapyh" value="${tvo.t_mapy }">
	                <input type="hidden" name="tf_nameh" value="${tvo.tf_name }">
<%-- 	                <input type="hidden" name="t_campname" value="${tvo.t_campname }"> --%>
<%-- 	                <input type="hidden" name="t_indutyh" value="${tvo.t_induty }"> --%>
	                <input type="hidden" name="t_facltdivnmh" value="${tvo.t_facltdivnm }">
	                <input type="hidden" name="t_mangedivnmh" value="${tvo.t_mangedivnm }">
	            </div>
	            <div class="togetherSub5">
	                <strong class="togetherSub5Strong">캠핑인원&nbsp;</strong>
	                <select name="t_numpeople" class="numberOfPeople" id="numberOfPeople"></select>
	                <span>명</span>
	                <input type="hidden" name="t_numpeople2" value="${tvo.t_numpeople }">
	            </div>
	            <div class="togetherSub2">
	                <strong>캠핑기간</strong>
	                <p><input type="text" name="datetimes" value="" class="datetimes" /></p>
	            </div>
	        </div>
	    </form>
	</div>
<%@ include file="../hs/footer.jsp" %>
</body>
</html>