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
<link rel="stylesheet" href="${path}/resources/public/css/bjs/together_detail.css">
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=6ho1djyfzb"></script>
<%@ include file="../hs/header.jsp" %>
<script type="text/javascript">
function to_list_go(f) {
	f.action="together_list.do";
	f.submit();
}

$(function() {
	initMap();
	toggleApplyButton();
});
function initMap() {
    let markers = [];
    let infoWindows = [];


    let t_mapx = document.getElementById('t_mapx').value;
    let t_mapy = document.getElementById('t_mapy').value;
    let tf_name = document.getElementById('tf_name').value;
    let t_campname = document.getElementById('t_campname').value;
    let t_induty = document.getElementById('t_induty').value;
    let t_facltdivnm = document.getElementById('t_facltdivnm').value;
    let t_mangedivnm = document.getElementById('t_mangedivnm').value;
    
    var map = new naver.maps.Map('map', {
        center: new naver.maps.LatLng(t_mapy, t_mapx),
        zoom: 15
    });
    
    if (t_mapx && t_mapy) {
        var marker = new naver.maps.Marker({
            position: new naver.maps.LatLng(t_mapy, t_mapx),
            map: map
        });

        markers.push(marker);
        
        let infoWindow = new naver.maps.InfoWindow({
            content: '<div style="width:220px;text-align:center;padding:10px;"><img src="' + tf_name + '" alt="" style="width:100%;" /><b>' + t_campname + '</b><br><br> ' + t_induty + '<br>(' + t_facltdivnm + '/' + t_mangedivnm + ') <br><br></div>',
            disableAutoPan: true
        });
        
        infoWindow.open(map, marker);
        
        naver.maps.Event.addListener(marker, 'click', function() {
        	if (infoWindow.getMap()) {
                infoWindow.close();
            } else {
                infoWindow.open(map, marker);
            }
        	infoWindows.push(infoWindow);
		})
	}
}

function toggleApplyButton() {
    let applyButton = document.getElementById('toDetailContent1Button2');
    let cancelButton = document.getElementById('toDetailContent1Button3');
    let tMemberIdx = document.getElementById('t_member_idx').value;
    let tIdx = document.getElementById('t_idx').value;
    
    $.ajax({
        type: "POST",
        url: "to_promise_chk.do",
        data: {
            member_idx: tMemberIdx,
            t_idx: tIdx
        },
        success: function(response) {
        	if(response === "me") {
        		applyButton.style.display = "none";
                cancelButton.style.display = "none";
        	} else if (response === "ok") {
                applyButton.style.display = "none";
                cancelButton.style.display = "block";
            } else {
                applyButton.style.display = "block";
                cancelButton.style.display = "none";
            }
        },
        error: function(xhr, status, error) {
            console.error(error);
        }
    });
}

function to_apply() {
	let memberIdx = document.getElementById('member_idx').value;
	let tIdx = document.getElementById('t_idx').value;
	let applyNumPeople = parseInt($('.toDetailContent1Num').text().split('/')[0]);
	let totalNumPeople = parseInt($('.toDetailContent1Num').text().split('/')[1]);

	if (applyNumPeople >= totalNumPeople) {
        alert("동행 인원이 초과되었습니다.");
        return;
	}
	
	$.ajax({
        type: "POST",
        url: "to_promise.do",
        data: {
            member_idx: memberIdx,
            t_idx: tIdx
        },
        success: function(response) {
        	if (response > 0) {
                alert("신청이 완료되었습니다.");
                $('.toDetailContent1Num').text(response + '/' + totalNumPeople + '명');
            } else {
	            alert(response);
            }
        	toggleApplyButton();
        },
        error: function(xhr, status, error) {
            console.error(error);
        }
    });
}

function to_cancel() {
	let memberIdx = document.getElementById('member_idx').value;
    let tIdx = document.getElementById('t_idx').value;
    let applyNumPeople = parseInt($('.toDetailContent1Num').text().split('/')[0]);
	let totalNumPeople = parseInt($('.toDetailContent1Num').text().split('/')[1]);
    
    $.ajax({
        type: "POST",
        url: "to_promise_cancel.do",
        data: {
            member_idx: memberIdx,
            t_idx: tIdx
        },
        success: function(response) {
        	if (response > 0) {
                alert("신청이 취소되었습니다.");
                $('.toDetailContent1Num').text(response + '/' + totalNumPeople + '명');
            } 
        	toggleApplyButton();
        },
        error: function(xhr, status, error) {
            console.error(error);
        }
    });
}

function to_update_go(f) {
	f.action="to_update.do";
	f.submit();
}
function to_delete_go(f, t_idx) {
	setTimeout(function(){
	    let result = confirm("정말 삭제하시겠습니까?");
	    if (result) {
	        f.action="to_delete_ok.do";
	        f.submit();
	    }else{
	    	return;
	    }
	 }, 150);
}
</script>
</head>
<body>
<div class="toDetailContainer">
        <div class="togetherUpImg">
        	<c:choose>
        		<c:when test="${empty tvo.tf_name }">
		            <img src="${path}/resources/images/to_camp.jpg" class="togetherUpImg2">
        		</c:when>
        		<c:otherwise>
        			<img src="${tvo.tf_name }" class="togetherUpImg2">
        		</c:otherwise>
        	</c:choose>
        </div>
        <form class="toDetailContent" method="post">
            <div class="toDetailContent1">
                <div class="userImage"><img src="${path}/resources/images/${tvo.member_img }" class="userImage2"></div>
                <div class="toContentOne1span">
                    <span class="to_member_nickname">${tvo.member_nickname }</span>
					<span class="to_member_age">(${tvo.member_dob })</span>
                </div>
<!--                 <input type="button" value="1:1 채팅하기" id="" onclick="" class="toDetailContent1Button toDetailContent1Button1"> -->
<!--                 <input type="button" value="참가 신청하기" id="" onclick="to_application()" class="toDetailContent1Button toDetailContent1Button2"> -->
                <button type="button" id="" onclick="" class="toDetailContent1Button toDetailContent1Button1">1:1 채팅하기</button>
                <button type="button" id="toDetailContent1Button2" onclick="to_apply()" class="toDetailContent1Button toDetailContent1Button2">참가신청하기</button>
                <button type="button" id="toDetailContent1Button3" onclick="to_cancel()" class="toDetailContent1Button toDetailContent1Button2">참가신청취소</button>
<!--                 <input type="button" value="참가 취소하기" id="" onclick=""> -->
                <input type="hidden" id="t_member_idx" value="${tvo.member_idx }">
                <input type="hidden" name="t_idx" id="t_idx" value="${tvo.t_idx }">
                <input type="hidden" id="member_idx" value="${memberUser.member_idx }">
                <span class="toDetailContent1Num">${appluNum }/${tvo.t_numpeople }명</span>
                <span>${tvo.t_regdate }</span>
            </div>
            <div class="toDetailContent2">
                <div class="toDetailContent2Sub1">
                	<c:choose>
		        		<c:when test="${empty tvo.tf_name }">
				            <img src="${path}/resources/images/to_camp.jpg" class="togetherUpImg2">
		        		</c:when>
		        		<c:otherwise>
		        			<img src="${tvo.tf_name }" class="togetherUpImg2">
		        		</c:otherwise>
		        	</c:choose>
                    <div class="toDetailContent2Sub1Div">
                        <h3>${tvo.t_subject }</h3>
                        <span>조회수&nbsp;${tvo.t_hit }</span>
                    </div>
                    <pre class="toDetailTContent">${tvo.t_content }</pre>
                </div>
                <div class="toDetailContent2Sub2">
                    <h3>캠핑 일정</h3>
                    <p>캠핑장소&nbsp;${tvo.t_campname }</p>
                    <div class="toDetailContent2Sub2flex">
                    	<p class="toDetailContent2Sub2flexP" style="margin: 0">캠핑주소&nbsp;</p>
                    	<p class="toDetailContent2Sub2flexP">${tvo.t_address }</p>
                    </div>
                    <p>캠핑날짜&nbsp;${tvo.t_startdate } - ${tvo.t_enddate }</p>
                    <p>캠핑타입&nbsp;${tvo.t_camptype }</p>
<!--                     <div class="toDetailContent2Sub2ImgDiv"><div id="map" class="toDetailContent2Sub2Img"></div></div> -->
					<div id="map" style="width:100%;height:400px;"></div>
					<input type="hidden" id="t_mapx" value="${tvo.t_mapx }">
					<input type="hidden" id="t_mapy" value="${tvo.t_mapy }">
					<input type="hidden" id="tf_name" value="${tvo.tf_name }">
					<input type="hidden" id="t_campname" value="${tvo.t_campname }">
					<input type="hidden" id="t_induty" value="${tvo.t_induty }">
					<input type="hidden" id="t_facltdivnm" value="${tvo.t_facltdivnm }">
					<input type="hidden" id="t_mangedivnm" value="${tvo.t_mangedivnm }">
                </div>
            </div>
            <div class="toDetailContent3">
            	<c:choose>
            		<c:when test="${memberUser.member_idx eq tvo.member_idx }">
		                <input type="button" value="수정하기" onclick="to_update_go(this.form)" class="toDetailContent3Button">
		                <input type="button" value="삭제하기" onclick="to_delete_go(this.form, ${tvo.t_idx})" class="toDetailContent3Button">
            		</c:when>
            		<c:otherwise>
						            		
            		</c:otherwise>
            	</c:choose>
                <input type="button" value="목 록" id="" onclick="to_list_go(this.form)" class="toDetailContent3Button">
                <input type="hidden" name="cPage" value="${cPage }" >
            </div>
            <div class="toDetailContent4">
                <p class="toDetailContent4Sub1">댓글</p>
                <form method="post">
                    <div class="toDetailInput">
                        <div class="userImageDiv2"><img src="${path}/resources/images/tree-4.jpg" class="userImage32"></div>
                        <input type="text" value="" id="" class="toDetailInputBox">
                        <input type="submit" value="입력" id="" class="toDetailInputBox toDetailInputSubmit">
                    </div>
                    <div class="toDetailContent4Sub2">
                        <div class="toDetailContent4Sub3">
                            <div class="toDetailContent4Sub2Sub1">
                                <div class="toDetailContent4Sub2Sub1Div">
                                    <div class="userImageDiv"><img src="${path}/resources/images/tree-4.jpg" class="userImage3"></div>
                                    <div>
                                        <strong>짱구</strong>
                                        <p>2024-04-23 16:53</p>
                                    </div>
                                </div>
                                <div class="toDetailContent4Sub2Sub2">
                                    <input type="button" value="답글 달기" id="" onclick=""
                                        class="toDetailContent4Sub2Sub2Button">
                                </div>
                            </div>
                            <div class="toDetailContent4Sub2Sub3">
                                <div class="toDetailContent2Sub1Div2">
                                    <span class="toDetailContent2Sub1Div2Span">언제 어디서 몇시에 무슨차로 어떻게 출발하나요? 언제 어디서 몇시에 무슨차로 어떻게 출발하나요? 언제 어디서 몇시에 무슨차로 어떻게 출발하나요?</span>
                                </div>
                                <div>
                                    <input type="button" value="X" id="" onclick="" class="toDetailContent4Sub2Sub2Button">
                                </div>
                            </div>
                        </div>
                        <div class="toDetailContent4Sub3">
                            <div class="toDetailContent4Sub2Sub1">
                                <div class="toDetailContent4Sub2Sub1Div">
                                    <div class="userImageDiv"><img src="${path}/resources/images/tree-4.jpg" class="userImage3"></div>
                                    <div>
                                        <strong>짱구</strong>
                                        <p>2024-04-23 16:53</p>
                                    </div>
                                </div>
                                <div class="toDetailContent4Sub2Sub2">
                                    <input type="button" value="답글 달기" id="" onclick=""
                                        class="toDetailContent4Sub2Sub2Button">
                                </div>
                            </div>
                            <div class="toDetailContent4Sub2Sub3">
                                <div class="toDetailContent2Sub1Div2">
                                    <span class="toDetailContent2Sub1Div2Span">언제 어디서 몇시에 무슨차로 어떻게 출발하나요? 언제 어디서 몇시에 무슨차로 어떻게 출발하나요? 언제 어디서 몇시에 무슨차로 어떻게 출발하나요?</span>
                                </div>
                                <div>
                                    <input type="button" value="X" id="" onclick="" class="toDetailContent4Sub2Sub2Button">
                                </div>
                            </div>
                        </div>
                        <div class="toDetailContent4Sub3">
                            <div class="toDetailContent4Sub2Sub1">
                                <div class="toDetailContent4Sub2Sub1Div">
                                    <div class="userImageDiv"><img src="${path}/resources/images/tree-4.jpg" class="userImage3"></div>
                                    <div>
                                        <strong>짱구</strong>
                                        <p>2024-04-23 16:53</p>
                                    </div>
                                </div>
                                <div class="toDetailContent4Sub2Sub2">
                                    <input type="button" value="답글 달기" id="" onclick=""
                                        class="toDetailContent4Sub2Sub2Button">
                                </div>
                            </div>
                            <div class="toDetailContent4Sub2Sub3">
                                <div class="toDetailContent2Sub1Div2">
                                    <span class="toDetailContent2Sub1Div2Span">언제 어디서 몇시에 무슨차로 어떻게 출발하나요? 언제 어디서 몇시에 무슨차로 어떻게 출발하나요? 언제 어디서 몇시에 무슨차로 어떻게 출발하나요?</span>
                                </div>
                                <div>
                                    <input type="button" value="X" id="" onclick="" class="toDetailContent4Sub2Sub2Button">
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </form>
    </div>
<%@ include file="../hs/footer.jsp" %>
</body>
</html>