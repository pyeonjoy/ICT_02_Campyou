
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>동행글 상세보기</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="${path}/resources/public/css/bjs/together_detail.css">
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=6ho1djyfzb"></script>
<%@ include file="../hs/header.jsp" %>

<script>
function enterChatRoom(t_idx){
	 const popup = window.open("chatroom.do?t_idx="+t_idx, "new", 
	    "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=400, height=670, right=0, top=0, location=no, titlebar=no");
}
function to_list_go(f) {
	let promiseStatus = f.querySelector('input[name="promise_status"]').value;
    console.log(promiseStatus);
    if (promiseStatus === null || promiseStatus === '') {
        f.action = "together_list.do";
    } else if(promiseStatus === "ing" || promiseStatus === "ready" || promiseStatus === "end"){
        f.action = "together_partner.do";
    } else if(promiseStatus === "apply" || promiseStatus === "send"){
    	f.action = "together_history.do";
    }
    
    f.submit();
}

$(function() {
	initMap();
	toggleApplyButton();
	to_comment();
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
    
    let map = new naver.maps.Map('map', {
        center: new naver.maps.LatLng(t_mapy, t_mapx),
        zoom: 15
    });
    
    if (t_mapx && t_mapy) {
    	let marker = new naver.maps.Marker({
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
	let tStartdate = document.getElementById('t_startdate').value;
	let tIdx = document.getElementById('t_idx').value;
	let applyNumPeople = parseInt($('.toDetailContent1Num').text().split('/')[0]);
	let totalNumPeople = parseInt($('.toDetailContent1Num').text().split('/')[1]);
	
	let currentDate = new Date();
    let startDate = new Date(tStartdate);
	
    if (startDate <= currentDate) {
        alert("동행이 시작되어 신청하실 수 없습니다.");
        return;
    }
	
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
        	if(response === "ban"){
				alert("재신청 불가합니다.");
        	}else{
	        	if (response > 0) {
	                alert("신청이 완료되었습니다.");
	                $('.toDetailContent1Num').text(response + '/' + totalNumPeople + '명');
	            } else {
		            alert(response);
	            }
	        	toggleApplyButton();
        	}
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

function to_comment() {
    let tIdx = document.getElementById('t_idx').value;
    $('.toDetailContent4').empty();
    $.ajax({
        type: "POST",
        url: "to_comment_list.do",
        data: {
            t_idx: tIdx
        },
        dataType: "json",
        success: function(data) {
            if (data.toCommentList != null) {
            	let commentHTML = '';
            	commentHTML += '<p class="toDetailContent4Sub1">댓글</p>';
            	commentHTML += '<form method="post">';
            	commentHTML += '<div class="toDetailInput">';
            	if(data.memberUser && data.memberUser.member_img != null){
	                commentHTML += '<div class="userImageDiv2"><img src="${path}/resources/images/' + data.memberUser.member_img + '" class="userImage32 profile_show" data-memberidx="' + data.memberUser.member_idx + '"></div>';
            		commentHTML += '<input type="text" value="" id="" class="toDetailInputBox">';
            	}else{
            		commentHTML += '<div class="userImageDiv2"><img src="${path}/resources/images/user2.png" class="userImage32 profile_show" data-memberidx="' + data.memberUser.member_idx + '"></div>';
            		commentHTML += '<input type="text" value="" id="" class="toDetailInputBox" placeholder="로그인 후 작성가능합니다" readonly>';
            	}
            	commentHTML += '<input type="button" value="입력" id="" class="toDetailInputSubmit" onclick="submitComment()">';
            	commentHTML += '</div>';
            	commentHTML += '</form>';
            	for (let i = 0; i < data.toCommentList.length; i++) {
            		let comment = data.toCommentList[i];
            	    let indentation = '';
            	    
           	    	if(comment.wc_step > 0){
               	        for (let j = 1; j <= comment.wc_lev; j++) {
               	        	indentation += '&nbsp;&nbsp;&nbsp;&nbsp;';
               	        }
               	        indentation += 'ㄴ';
               	        commentHTML += '<div class="toDetailContent4Sub6">';
               	        commentHTML += '<span class="toSpace">' + indentation + '</span>';
               	        commentHTML += '<div class="toCommentWidth">';
           	    	}else{
           	    		commentHTML += '<div class="toDetailContent4Sub3">';
           	    	}
           	        commentHTML += '<div class="toDetailContent4Sub2Sub1">';
           	        commentHTML += '<div class="toDetailContent4Sub2Sub1Div">';
           	        commentHTML += '<div class="userImageDiv"><img src="${path}/resources/images/' + comment.member_img + '" class="userImage3 profile_show" data-memberidx="' + comment.member_idx + '"></div>';
           	        commentHTML += '<div>';
           	        commentHTML += '<p class="member_nicknameP profile_show" data-memberidx="' + comment.member_idx + '">' + comment.member_nickname + '<img src="${path}/resources/images/' + comment.member_grade + '" class="member_gradeImg" ></p>';
           	        commentHTML += '<p>' + comment.wc_regdate + '</p>';
           	        commentHTML += '</div>';
           	        commentHTML += '</div>';
           	        commentHTML += '<div class="toCommentDelUpdateButton">';
           	       	if(data.memberUser.member_idx != null && data.memberUser.member_idx == comment.member_idx){
	           	        commentHTML += '<input type="button" value="X" class="toDetailContent4Sub2Sub2ButtonX">';
	           	        commentHTML += '<input type="button" value="수 정" class="toDetailContent4Sub2Sub2ButtonUpdate">';
           	       	}
           	        commentHTML += '</div>';
           	        commentHTML += '</div>';
           	        commentHTML += '<div class="toDetailContent4Sub2Sub3">';
           	        commentHTML += '<div class="toDetailContent2Sub1Div2">';
           	    	 if (comment.wc_active == 1) {
         	       	 	commentHTML += '<span class="toDetailContent2Sub1Div2Span" style="color: lightgrey">삭제된 댓글입니다.</span>';
           	    	 }else{
		            	commentHTML += '<span class="toDetailContent2Sub1Div2Span">' + comment.wc_content + '</span>';
           	    	 }
           	        commentHTML += '</div>';
           	        commentHTML += '<div class="toDetailContent4Sub2Sub2">';
           	        if(data.memberUser.member_idx != null){
	           	        commentHTML += '<input type="button" value="답 글" class="toDetailContent4Sub2Sub2Button" >';
           	        }
           	        commentHTML += '</div>';
           	        commentHTML += '</div>';
           	        commentHTML += '<form method="post" class="toDetailInputForm" style="display:none;">';
           	        commentHTML += '<span class="toDetailInputSpan">ㄴ</span>';
           	        commentHTML += '<div class="toDetailInput">';
           	        commentHTML += '<div class="userImageDiv2"><img src="${path}/resources/images/' + data.memberUser.member_img + '" class="userImage32"></div>';
           	        commentHTML += '<input type="text" value="" id="" class="toDetailInputBox">';
           	        commentHTML += '<input type="button" value="입 력" id="" class="toDetailInputSubmit" onclick="submitComment()">';
           	        commentHTML += '<input type="hidden" value="' + comment.wc_idx + '" id="wc_idx" >';
           	        commentHTML += '<input type="hidden" value="' + comment.wc_groups + '" id="wc_groups" >';
           	        commentHTML += '<input type="hidden" value="' + comment.wc_step + '" id="wc_step" >';
           	        commentHTML += '<input type="hidden" value="' + comment.wc_lev + '" id="wc_lev" >';
           	        commentHTML += '</div>';
           	        commentHTML += '</form>';
           	        commentHTML += '<form method="post" class="toDetailInputForm2" style="display:none;">';
           	        commentHTML += '<span class="toDetailInputSpan">ㄴ</span>';
           	        commentHTML += '<div class="toDetailInput">';
           	        commentHTML += '<div class="userImageDiv2"><img src="${path}/resources/images/' + data.memberUser.member_img + '" class="userImage32"></div>';
           	        commentHTML += '<input type="text" value="' + comment.wc_content + '" id="" class="toDetailInputBox2">';
           	        commentHTML += '<input type="button" value="수정하기" id="" class="toCommentUpdate">';
//            	        commentHTML += '<input type="hidden" value="' + comment.wc_idx + '" id="wc_idx" >';
//            	        commentHTML += '<input type="hidden" value="' + comment.wc_groups + '" id="wc_groups" >';
//            	        commentHTML += '<input type="hidden" value="' + comment.wc_step + '" id="wc_step" >';
//            	        commentHTML += '<input type="hidden" value="' + comment.wc_lev + '" id="wc_lev" >';
					commentHTML += '<input type="hidden" value="' + comment.wc_idx + '" id="wc_idx" >';
           	        commentHTML += '<input type="hidden" value="' + comment.wc_content + '" id="beforeContent" >';
           	        commentHTML += '</div>';
           	        commentHTML += '</form>';
           	        commentHTML += '</div>';
           	        if(comment.wc_step > 0){
           	        	commentHTML += '</div>';
           	        }
            }
            $('.toDetailContent4').append(commentHTML);
        }
        },
        error: function(xhr, status, error) {
            console.error(error);
        }
    });
}

$(document).on("click", ".toDetailContent4Sub2Sub2Button", function() {
	let parentDiv = $(this).closest(".toDetailContent4Sub3, .toDetailContent4Sub6");
    let commentForm = parentDiv.find(".toDetailInputForm");

    $(".toDetailInputForm").not(commentForm).hide();
    $(".toDetailInputForm2").hide();
    
    commentForm.toggle();
    commentForm.find(".toDetailInputBox").focus();
});

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

$(document).on("click", ".toDetailInputSubmit", function() {
    saveComment();
});

$(document).on("keypress", ".toDetailInputBox", function(e) {
    if (e.which === 13) {
        e.preventDefault();
        saveComment($(this));
    }
});

function saveComment(element) {
    let parentDiv = element.closest(".toDetailInput");
    let commentInput = parentDiv.find(".toDetailInputBox").val();
    let memberIdx = $("#member_idx").val();
    let tIdx = $("#t_idx").val();
    let wcGroups = parentDiv.find("#wc_groups").val();
    let wcStep = parentDiv.find("#wc_step").val();
    let wcLev = parentDiv.find("#wc_lev").val();
    let wcIdx = null;
    if (parentDiv.find('#wc_idx').length) {
        wcIdx = parentDiv.find('#wc_idx').val();
    }
    
    let badWord = hasBadWords(commentInput.replace(/\s+/g, ''));
    if (badWord !== null) {
        alert("'" + badWord + "'는(은) 사용할수 없습니다. 다시 작성해주세요.");
        return;
    }
 	
    if (commentInput.trim() === "") {
        alert("댓글을 입력해주세요.");
        return;
    }
    console.log("wcGroups : ", wcGroups);
    console.log("wcStep : ", wcStep);
    console.log("wcLev : ", wcLev);
    $.ajax({
        type: "POST",
        url: "to_comment_write.do",
        data: {
        	member_idx: memberIdx,
            t_idx: tIdx,
            wc_content: commentInput,
            wc_groups: wcGroups,
            wc_step: wcStep,
            wc_lev: wcLev,
            wc_idx: wcIdx
        },
        success: function(response) {
            to_comment();
        },
        error: function(xhr, status, error) {
            console.error(error);
        }
    });
}

$(document).on("click", ".toDetailContent4Sub2Sub2ButtonUpdate", function() {
    let parentDiv = $(this).closest(".toDetailContent4Sub3, .toDetailContent4Sub6");
    let commentForm = parentDiv.find(".toDetailInputForm2");
    
    $(".toDetailInputForm").hide();
    $(".toDetailInputForm2").not(commentForm).hide();
    
    commentForm.toggle();
    let inputField = commentForm.find(".toDetailInputBox2");
    inputField.focus();
    let valueLength = inputField.val().length;
    inputField[0].setSelectionRange(valueLength, valueLength);
});

$(document).on("click", ".toCommentUpdate", function() {
	updateComment();
});

$(document).on("keypress", ".toDetailInputBox2", function(e) {
    if (e.which === 13) {
        e.preventDefault();
        updateComment($(this));
    }
});

// $(document).on("click", ".toCommentUpdate", function() {
function updateComment(element) {
    let parentDiv = element.closest(".toDetailInput");
    let commentInput = parentDiv.find(".toDetailInputBox2").val();
    let beforeContent = parentDiv.find("#beforeContent").val();
    let wcIdx = parentDiv.find('#wc_idx').val();
    
    let badWord = hasBadWords(commentInput.replace(/\s+/g, ''));
    if (badWord !== null) {
        alert("'" + badWord + "'는(은) 사용할수 없습니다. 다시 작성해주세요.");
        return;
    }
 	
    if (commentInput.trim() === "") {
        alert("댓글을 입력해주세요.");
        return;
    }else if(beforeContent === commentInput){
    	alert("수정할 내용을 입력해주세요");
    	return;
    }
    
    $.ajax({
        type: "POST",
        url: "to_comment_update.do",
        data: {
            wc_content: commentInput,
            wc_idx: wcIdx
        },
        success: function(response) {
            to_comment();
        },
        error: function(xhr, status, error) {
            console.error(error);
        }
    });
// });
};

$(document).on("click", ".toDetailContent4Sub2Sub2ButtonX", function() {
	    let result = confirm("정말 삭제하시겠습니까?");
	    if (result) {
	        let wcIdx = $(this).closest(".toDetailContent4Sub3, .toDetailContent4Sub6").find('#wc_idx').val();
	        
	        $.ajax({
	            type: "POST",
	            url: "to_comment_delete.do",
	            data: {
	                wc_idx: wcIdx
	            },
	            success: function(response) {
	                to_comment();
	            },
	            error: function(xhr, status, error) {
	                console.error(error);
	            }
	        });
	    }else{
	    	return;
	    }
});
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
                <div class="deatailUserImage"><img src="${path}/resources/images/${tvo.member_img }" class="deataiUserImage2 profile_show" data-memberidx="${tvo.member_idx }"></div>
                <div class="toDetailContentOne1span">
                    <span class="to_member_nickname profile_show" data-memberidx="${tvo.member_idx }">${tvo.member_nickname }</span>
                    <img src="${path}/resources/images/${tvo.member_grade}" class="member_gradeImg" >
					<span class="to_member_age">(${tvo.member_dob } ${tvo.member_gender })</span>
                </div>

                <button type="button" id="" onclick="enterChatRoom(${tvo.t_idx})" class="toDetailContent1Button toDetailContent1Button1">1:1 채팅하기</button>
                <button type="button" id="toDetailContent1Button2" onclick="to_apply()" class="toDetailContent1Button toDetailContent1Button2">참가신청하기</button>
                <button type="button" id="toDetailContent1Button3" onclick="to_cancel()" class="toDetailContent1Button toDetailContent1Button2">참가신청취소</button>
                <input type="hidden" id="t_startdate" value="${tvo.t_startdate }">
                <input type="hidden" id="t_member_idx" value="${tvo.member_idx }">
                <input type="hidden" name="t_idx" id="t_idx" value="${tvo.t_idx }">
                <input type="hidden" id="member_idx" value="${memberUser.member_idx }">
                <span class="toDetailContent1Num">${proCount }/${tvo.t_numpeople }명</span>

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
                    <p>캠핑타입&nbsp;${tvo.t_induty }</p>
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
                <input type="hidden" name="promise_status" id="promiseStatus" value="${promise_status }" >
            </div>
            <div class="toDetailContent4">
<!--                 <p class="toDetailContent4Sub1">댓글</p> -->
<!--                 <form method="post"> -->
<!--                     <div class="toDetailInput"> -->
<%--                         <div class="userImageDiv2"><img src="${path}/resources/images/tree-4.jpg" class="userImage32"></div> --%>
<!--                         <input type="text" value="" id="" class="toDetailInputBox"> -->
<!--                         <input type="button" value="입력" id="" class="toDetailInputBox toDetailInputSubmit" onclick=""> -->
<!--                     </div> -->
<!--                 </form> -->
<!--                 <div class="toDetailContent4Sub2"> -->
<!--                     <div class="toDetailContent4Sub3"> -->
<!--                         <div class="toDetailContent4Sub2Sub1"> -->
<!--                             <div class="toDetailContent4Sub2Sub1Div"> -->
<%--                                 <div class="userImageDiv"><img src="${path}/resources/images/tree-4.jpg" class="userImage3"></div> --%>
<!--                                 <div> -->
<!--                                     <strong>짱구</strong> -->
<!--                                     <p>2024-04-23 16:53</p> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                             <div class="toDetailContent4Sub2Sub2"> -->
<!--                                 <input type="button" value="답글 달기" id="" onclick="to_coment_write(this.form)" class="toDetailContent4Sub2Sub2Button"> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                         <div class="toDetailContent4Sub2Sub3"> -->
<!--                             <div class="toDetailContent2Sub1Div2"> -->
<!--                                 <span class="toDetailContent2Sub1Div2Span">언제 어디서 몇시에 무슨차로 어떻게 출발하나요? 언제 어디서 몇시에 무슨차로 어떻게 출발하나요? 언제 어디서 몇시에 무슨차로 어떻게 출발하나요?</span> -->
<!--                             </div> -->
<!--                             <div> -->
<!--                                 <input type="button" value="X" id="" onclick="" class="toDetailContent4Sub2Sub2Button"> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
                </div>
            </div>
        </form>
    </div>
<%@ include file="../hs/footer.jsp" %>
<%@ include file="../hs/profile_small_info.jsp" %>
</body>
</html>