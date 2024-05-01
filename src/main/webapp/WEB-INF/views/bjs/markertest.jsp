<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>Insert title here</title>

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript" src="marker-clustering-custom.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=6ho1djyfzb"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=6ho1djyfzb&submodules=geocoder"></script>
<style type="text/css">    body { font-size: 12px; font-family: dotum; }    input { height: 22px; background-color: #efefef; border: 1px solid #333333; border-radius: 4px; }         .div_map { display:flex; flex-direction: row; }    .map { width: 1000px; height: 600px; border: 1px solid #c0c0c0; border-radius: 4px; }         .div_list { height: 600px; }    .list_title { height: 30px; line-height: 30px; background-color: #efefef; border: 1px solid #c0c0c0; border-radius: 4px; margin: 0 0 5px 5px; font-weight: bold; padding-left: 10px; }    .list { width: 320px; height: 563px; border: 1px solid #c0c0c0; border-radius: 4px; margin-left: 5px; overflow-y: auto; }    .list > ol { line-height: 1.7em; }         .ctl { display: flex; flex-direction: row; justify-content: space-between; width:1000px; margin-top: 5px; }    .pos { display: flex; flex-direction: row; justify-content: space-between; }    .ctl input {  text-align: center; }    .pos button { height: 26px; border: 1px solid #333333; border-radius: 4px; }    .pos > div:nth-child(2) { margin-left: 6px; }    </style>
<script type="text/javascript">
var _BASE = new naver.maps.LatLng(37.566605, 126.9783931);  // 서울시청
var _ZOOM = 16;     // 지도 표시 레벨
var _list = [];     // 현재 화면에 표시된 마커 목록
var marker1 = null; // 좌표 조회용 마커 
// 지도 옵션
var mapOptions = {    center: _BASE,    zoom: _ZOOM,    zoomControl: true,      // 확대,축소
		    zoomControlOptions:  { position : naver.maps.Position.TOP_RIGHT }, 
		   //logoControlOptions:  { position : naver.maps.Position.BOTTOM_RIGHT }, // 네이버로고
		    scaleControl: true,     // 축척    
		scaleControlOptions: { position : naver.maps.Position.BOTTOM_RIGHT },
		    mapDataControl: false,  // 저작권
		}; // 지도 표시
		var map = new naver.maps.Map('map', mapOptions); 
		// 지도 이벤트 설정
		naver.maps.Event.addListener(map, 'zoom_changed', function(e) {    if (e > 15) {        marker1.setMap(map);    // 마커1 표시
		    } else {        marker1.setMap(null);   // 마커1 삭제
		    }}); 
		// 마커 목록 삭제
		function clearList() {    $('#list').empty();} 
		// 마커 목록 표시
		function showList() {    _list.forEach(function(item) {        showMarkerInfo(item);    });         _list = [];}
		 // 현재 위치 표시
		showPosition(_BASE);
		 // 위도 경도 표시
		function showPosition(latlng) {    $('#lat').val(latlng.lat());    $('#lng').val(latlng.lng());} // 원위치 버튼 클릭
		function resetPosition() {    map.setCenter(_BASE);    map.setZoom(_ZOOM);         if (marker1) {        marker1.setPosition(_BASE);    }         showPosition(_BASE);    $('#info').val(null);} 
		// 좌표를 클립보드에 복사
		function copyPosition() {    var info = $('#info');         info.val($('#lat').val() +', '+ $('#lng').val());         info.select();    document.execCommand('copy');} 
		// 주소 변경
		function changeAddr(code) {    if (code == '') {        map.setCenter(_BASE);    } else {        showArea(code);    }} // 마커1(기본 마커)
		marker1 = new naver.maps.Marker({    position: _BASE,    map: map,    zIndex: 200,    draggable: true,    // 마커1 드래그 허용
			}); // 마커1 드래그 허용
			//marker1.setDraggable(true); // 마커1 드래그 이벤트 설정
			naver.maps.Event.addListener(marker1, 'drag', function(e) {    showPosition(e.coord);});
			
			var options = [    { pos: [ 37.5675575, 126.9778996 ], info: "code: '1001', name: '1001 사무실'", type: '사무실' },    { pos: [ 37.5674628, 126.9777064 ], info: "code: '1002', name: '1002 사무실'", type: '사무실' },    { pos: [ 37.56749,   126.9779417 ], info: "code: '1003', name: '1003 사무실'", type: '사무실' },    { pos: [ 37.5673746, 126.9778567 ], info: "code: '1004', name: '1004 사무실'", type: '사무실' },    { pos: [ 37.5671748, 126.9780283 ], info: "code: '1005', name: '1005 사무실'", type: '사무실' },    { pos: [ 37.5679912, 126.9779639 ], info: "code: '1006', name: '1006 사무실'", type: '사무실' },    { pos: [ 37.567515,  126.9781677 ], info: "code: '1007', name: '1007 사무실'", type: '사무실' },         { pos: [ 37.5696834, 126.980453  ], info: "code: '1011', name: '1011 사무실'", type: '사무실' },    { pos: [ 37.5698195, 126.9811396 ], info: "code: '1012', name: '1012 사무실'", type: '사무실' },    { pos: [ 37.5693093, 126.9813327 ], info: "code: '1013', name: '1013 사무실'", type: '사무실' },         { pos: [ 37.5698535, 126.9739299 ], info: "code: '1021', name: '1021 공실'", type: '공실' },    { pos: [ 37.56976,   126.9731896 ], info: "code: '1022', name: '1022 공실'", type: '공실' },         { pos: [ 37.5683143, 126.9765907 ], info: "code: '1031', name: '1031 호텔'", type: '호텔' },    { pos: [ 37.5685609, 126.9760328 ], info: "code: '1032', name: '1032 호텔'", type: '호텔' },    { pos: [ 37.5686204, 126.9764405 ], info: "code: '1033', name: '1033 호텔'", type: '호텔' },    { pos: [ 37.5680676, 126.9758611 ], info: "code: '1034', name: '1034 호텔'", type: '호텔' },    { pos: [ 37.5679315, 126.9765048 ], info: "code: '1035', name: '1035 호텔'", type: '호텔' },         { pos: [ 37.5670727, 126.9817405 ], info: "code: '1041', name: '1041 맛집'", type: '맛집' },    { pos: [ 37.5677275, 126.9823842 ], info: "code: '1042', name: '1042 맛집'", type: '맛집' },    { pos: [ 37.5678721, 126.9819122 ], info: "code: '1043', name: '1043 맛집'", type: '맛집' },         { pos: [ 37.5643939, 126.9755392 ], info: "code: '1051', name: '1051 공공기관'", type: '공공기관' },    { pos: [ 37.5643939, 126.9750028 ], info: "code: '1052', name: '1052 공공기관'", type: '공공기관' },         { pos: [ 37.5649382, 126.9818692 ], info: "code: '1061', name: '1061 쇼핑'", type: '쇼핑' },    { pos: [ 37.5647001, 126.9830279 ], info: "code: '1062', name: '1062 쇼핑'", type: '쇼핑' },    { pos: [ 37.5647001, 126.9838862 ], info: "code: '1063', name: '1063 쇼핑'", type: '쇼핑' },    { pos: [ 37.5651763, 126.9813972 ], info: "code: '1064', name: '1064 쇼핑'", type: '쇼핑' },    { pos: [ 37.5651678, 126.983146  ], info: "code: '1065', name: '1065 쇼핑'", type: '쇼핑' },    { pos: [ 37.5653294, 126.9837575 ], info: "code: '1066', name: '1066 쇼핑'", type: '쇼핑' },         { pos: [ 37.5657886, 126.9713335 ], info: "code: '1071', name: '1071 학교'", type: '학교' },    { pos: [ 37.5661118, 126.9706469 ], info: "code: '1072', name: '1072 학교'", type: '학교' },    { pos: [ 37.5656355, 126.9718056 ], info: "code: '1073', name: '1073 학교'", type: '학교' },         { pos: [ 37.5694623, 126.9856243 ], info: "code: '1081', name: '1081 은행'", type: '은행' },    { pos: [ 37.5693178, 126.9850128 ], info: "code: '1082', name: '1082 은행'", type: '은행' },    { pos: [ 37.5695133, 126.9862465 ], info: "code: '1083', name: '1083 은행'", type: '은행' },    { pos: [ 37.568782,  126.9859676 ], info: "code: '1084', name: '1084 은행'", type: '은행' },];
			
			var markers = []; for (var i = 0, ii = options.length; i &lt; ii; i++) {    // info, text 속성을 넣기 위해 HTML 마커 사용
				    markers.push(new naver.maps.Marker({        position: new naver.maps.LatLng(options[i].pos[0], options[i].pos[1]),        zIndex: 100,        icon: {            content: '',            anchor: new naver.maps.Point(11, 33),        }    }));} 
				// 마커 클릭 이벤트 설정
				for (var i = 0, ii = markers.length; i < ii; i++) {    naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));} 
				// 마커 클릭 이벤트
				function getClickHandler(seq) {    return function(e) {        clearList();        showMarkerInfo(markers[seq]);    }} 
				// html 속성값을 json 변환
				function attr2json(attr) {    var json = {};    var s = attr.trim().split(',');         for (var i = 0, ii = s.length; i &lt; ii; i++) {        var a = s[i].split(':');        json[a[0].trim()] = a[1].trim().replace(/''/g,'');    }         return json;}
				
				function newMarker(radius, count, name) {    var cvs = document.createElement('canvas');         return changeMarker(cvs, radius, count, name);} // 클러스터 마커 변경(HTML 마커)
				function changeMarker(cvs, radius, count, name) {    cvs.width = radius * 2;    cvs.height = radius * 2;     var ctx = cvs.getContext('2d');         // 원 표시    
				ctx.beginPath();     ctx.arc(radius, radius, radius, 0, Math.PI * 2);    ctx.fillStyle = 'rgba(3, 133, 255, 0.5)';   //#0385ff    //ctx.fillStyle = hex2rgba(fillColor, fillOpacity);
				    ctx.fill();     ctx.closePath();         // 텍스트 표시    
				ctx.textAlign = 'center';    ctx.fillStyle = 'white';            // text color         
				if (name != null) {        ctx.font = '16px dotum bold';        ctx.fillText(name, radius, radius - 4);        y = radius + 20 - 4;    } else {        ctx.textBaseline = 'middle';    // 텍스트가 1줄일 경우 사용
				        y = radius;    }         if (count != null) {        ctx.font = '20px dotum bold';        ctx.fillText(count, radius, y);    }     return {        content: cvs,        anchor: naver.maps.Point(radius, radius),    }}
				
				var cMarker1 = newMarker(50, 'm1', 0);var cMarker2 = newMarker(50, 'm2', 0);var cMarker3 = newMarker(50, 'm3', 0); // 마커 클러스터링
				var markerClustering = new MarkerClustering({    minClusterSize: 2,                      // 클러스터 마커를 표시할 최소 마커 개수    
					maxZoom: 17,                            // 최대 지도 확대 레벨(maxZoom &gt; map zoom, 클러스터 마커 표시)   
					 map: map,                               // 클러스터 마커 표시할 지도    
					markers: markers,                       // 클러스터 마커에서 사용할 마커 목록    
					disableClickZoom: true,                 // 클러스터 마커 클릭 시 지도 확대여부    //averageCenter: true,                  // 마커들의 중간 좌표를 계산하여 클러스터 마커 표시여부   
					 gridSize: 100,                          // 클러스터 마커 그리드 크기(단위: 픽셀)    
					icons: [cMarker1, cMarker2, cMarker3],  // 클러스터 마커용 아이콘    
					indexGenerator: [10, 50, 100],          // 아이콘 표시용 마커 개수 설정    
					stylingFunction: function(clusterMarker, count, name) { // 클러스터 마커 갱신 시 호출        
						_list = _list.concat(members);                 var radius = getRadius(count); 
						                // 클러스터 마커 표시        
						clusterMarker.setIcon(newMarker(radius, count, name));                 // 클러스터 마커 이벤트 설정       
						 naver.maps.Event.addListener(clusterMarker, 'mouseover', function(e) {            var cvs = clusterMarker.getIcon().content;            clusterMarker.setIcon(changeMarker(cvs, radius + 15, count, name));        });         naver.maps.Event.addListener(clusterMarker, 'mouseout', function(e) {               var cvs = clusterMarker.getIcon().content;            clusterMarker.setIcon(changeMarker(cvs, radius, count, name));        });                 naver.maps.Event.addListener(clusterMarker, 'click', function(e) {            clearList();                         members.forEach(function(item) {                showMarkerInfo(item);            });        });    }}); // 마커 개수에 따라 반지름 변경
						function getRadius(c) {    var r = 50;         switch (true) {        case (c <  3): r = 30; break;        case (c <  5): r = 40; break;        case (c < 10): r = 50; break;        case (c < 20): r = 60; break;        case (c < 50): r = 70; break;        case (c <100): r = 80; break;    }         return r;} // 마커 info 속성 표시
						function showMarkerInfo(marker) {    var info = $(marker.getIcon().content).attr('info');    var json = attr2json(info);    $('#list').append('마커 : code = '+ json.code +', name = '+ json.name +'');}
// 						_updateClusters: function() {        var clusters = this._clusters;                 clearList();    //추가                 
// 						for (var i = 0, ii = clusters.length; i < ii; i++) {            clusters[i].updateCluster();        }                 showList();     //추가    
// 						},         /**     * 클러스터를 구성하는 마커 수를 갱신합니다.     */    
// 						updateCount: function() {        var stylingFunction = this._markerClusterer.getStylingFunction();                 //추가  
// 						      var name = null;                 if (this._clusterMember.length > 0) {            var cZoom = this._markerClusterer.getMaxZoom();            var mZoom = this._markerClusterer.getMap().getZoom();                     //지도의 줌 레벨이 클러스터 마커 표시 최대 레벨일 때만 명칭 표시           
// 						 if (cZoom - 1 == mZoom) {                //첫번째 HTML 마커의 text 속성 조회                //문제점: 마커의 명칭이 여러 종류일 경우 명칭 표기에 혼선               
// name = $(this._clusterMember[0].getIcon().content).attr('text');            }        }        //추가                 
// stylingFunction && stylingFunction(this._clusterMarker, this.getCount(), name, this._clusterMember);    //추가    
// },

</script>
</head>
<body>
<div>    <div class="div_map">        <div id="map" class="map"> </div>        <div class="div_list">            <div class="list_title">마커 목록</div>            <div class="list"> </div>        </div>    </div>    <div class="ctl">        <div><input id="info" readonly="readonly" size="40" type="text" value="" /></div>        <div class="pos">            <div>                <input id="lat" readonly="readonly" size="20" type="text" value="" />                <input id="lng" readonly="readonly" size="20" type="text" value="" />            </div>            <div>                <button type="button">좌표 복사</button>                <button type="button">원위치</button>            </div>        </div>    </div></div>
</body>
</html>