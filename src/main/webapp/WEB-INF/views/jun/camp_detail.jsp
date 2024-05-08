<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript"
	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=qpvmsbuult"></script>


<style type="text/css">
* {
	font-size: 18px;
}

#img_box {
	width: 80%;
	height: 715px;
	margin-left: 195px;
	margin-top: 10px;
}

#detail_img img {
	width: 370px;
	height: 340px;
}

.camp_detail_wrap h4 {
	width: 80%;
	height: 50px;
	background-color: #FFBA34;
	text-align: center;
	line-height: 50px;
}

#detail_img {
	width: 300px;
	height: 300px;
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	grid-gap: 10px;
	justify-items: center;
}

.camp_detail_second_title {
	width: 80%;
	height: 50px;
	background-color: #FFBA34;
	text-align: left;
	line-height: 50px;
	font-size: 20px;
	margin: 0 auto;
}

#map {
	width: 80%;
	height: 600px;
	margin-left: 190px;
	margin-top: 30px;
	margin-bottom: 30px;
}

.detail_info_1 {
	margin-left: 190px;
}

#detail_button {
	position: relative;
	left: 1268px;
	top: -35px;
}

.camp_intro {
	width: 90%;
	height: 300px;
}

#camp_item_g {
	width: 80%;
	height: 670px;
	margin-left: 190px;
	background-color: #FFFDDE;
	border-radius: 30px;
	margin-top: 30px;
	margin-bottom: 30px;
}

#camp_item_g li {
	display: inline-block;
    list-style-type: none;
    margin: 20px;
    padding: 52px;
    text-align: center;
    background-color: #FFFAA5;
    border-radius: 60px;
    width: 260px;
    height: 220px;
}

#camp_item_g img {
	width: 50px;
	height: 50px;
	background-repeat: no-repeat;
}

#camp_item_g span {
    display: block;
    margin-top: 10px;
    font-size: large;
}
#review_form fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
}
#review_form fieldset legend{
    text-align: right;
}
#review_form input[type=radio]{
    display: none;
}
#review_form label{
    font-size: 3em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
}
#review_form label:hover{
    text-shadow: 0 0 0 #FFD700;
}
#review_form label:hover ~ label{
    text-shadow: 0 0 0 #FFD700;
}
#review_form input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 #FFD700;
}
#r_comment {
    width:1520px;
    height: 150px;
    padding: 10px;
    box-sizing: border-box;
    border: solid 1.5px #D3D3D3;
    border-radius: 5px;
    font-size: 16px;
    resize: none;
}
#review_section{
	margin-left : 190px;
}
#comment_list {
    margin-top: 20px;
}

#comment_list div {
	width:80%;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    padding: 10px;
    border-radius: 5px;
    margin-left : 190px;
}

#comment_list p {
    margin: 0;
    padding: 2px 40px 35px;
    line-height: 30px;
}

#comment_list img {
	border : 2px solid black;
	border-radius: 100px;
	width: 65px;
	height: 65px;
	float: left;
}

.modal {
    display: none;
    position: fixed; 
    z-index: 1000;
    width: 100%;
    height: 100%;
    overflow: hidden;
  	height: 100%;
    background-color: rgba(0, 0, 0, 0.7); 
}

.modal-content {
    margin: auto;
    display: block;
    width: auto;
    max-width: 80%;
    max-height: 80%;
    height: 500px;
    margin-top : 180px;
}
#detail_button input[type="button"]{
	height: 40px;
	padding-left: 30px;
	padding-right: 30px;
}
.review_submit{
	height: 40px;
	padding-left: 30px;
	padding-right: 30px;
	position: relative;
    left: 1380px;
}

</style>
<script>
const urlParams = new URLSearchParams(window.location.search);
const contentId = urlParams.get('contentid');

$(document).ready(function() {
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
                    zoom: 18
                });
                let marker = new naver.maps.Marker({
                    position: latlng,
                    map: map
                });
                let infoWindow = new naver.maps.InfoWindow({
                    content: '<div style="padding:20px;"><b>이름 : ${info.facltnm}<br><br>주소 : ${info.addr1}<br><br>전화번호 : ${info.tel}</b></div>'
                });
                infoWindow.open(map, marker);
                
                naver.maps.Event.addListener(marker, 'click', function(e) {
                    infoWindow.open(map, marker);
                });

                naver.maps.Event.addListener(map, 'click', function(e) {
                    infoWindow.close();
                });
            },
            error: function() {
                alert("읽기 실패");
            }
        });
    }

    let facilityList = "${info.sbrscl}";

    let facilities = facilityList.split(',');

    let iconMapping = {
        "전기": "resources/detail_ico/ico_thunder.png",
        "장작판매": "resources/detail_ico/ico_wood.png",
        "트렘폴린": "resources/detail_ico/ico_tramp.png",
        "산책로": "resources/detail_ico/ico_trail.png",
        "수영장": "resources/detail_ico/ico_swim.png",
        "샤워시설": "resources/detail_ico/ico_shower.png",
        "놀이터": "resources/detail_ico/ico_playground.png",
        "운동장": "resources/detail_ico/ico_playground_place.png",
        "마트.편의점": "resources/detail_ico/ico_mart24.png",
        "온수" : "resources/detail_ico/ico_hot_water.png",
        "운동시설" : "resources/detail_ico/ico_gym.png",
        "무선인터넷" : "resources/detail_ico/ico_wifi.png",
    };

    let facilityIcons = "";

    facilities.forEach(function(facility) {
        let iconUrl = iconMapping[facility.trim()];
        if (iconUrl) {
            facilityIcons += "<li><img src='" + iconUrl + "' alt='" + facility.trim() + "'><span>"+facility.trim()+"</span></li>";
        }
    });
    $("#camp_item_g").append(facilityIcons);
    
    loadReview();
    loadHeart();
    $('#review_form').submit(function(e) {
        e.preventDefault();

        let comment = $('#r_comment').val();
        let rating = $("input[name='rating']:checked").val();
		let member_img = "${mvo.member_img}";
		let member_idx = "${mvo.member_idx}";
        let requestData = {
            r_comment: comment,
            rating: rating,
            contentid: contentId,
            member_img: member_img,
            member_idx: member_idx
        };

        $.ajax({
            url: 'addReview.do', 
            type: 'post',
            contentType: 'application/json',
            data: JSON.stringify(requestData),
            success:function(data){
            	 if (member_idx === "" || member_idx === null) {
            		alert("로그인 후 이용 부탁드립니다.");
            		location.href="login_form.do";
				}else if(data != "error") {
                    alert("리뷰가 정상적으로 등록되었습니다.");
                    $('#r_comment').val('');
                    $("input[name='rating']").prop('checked', false);
                    loadReview();
                } else {
                    alert("리뷰 작성에 오류가 발생하였습니다.");
                }
            }
        });
    });	
});
function Heart() {
    $.ajax({
        url: "addHeart.do",
        method: "post",
        data: { contentid: contentId },
        success: function(data) {
            if(data != "error") {
                alert("관심 캠핑장에 등록이 되었습니다.");
                loadHeart();
            } else {
            	delHeart();
            	loadHeart();
            }
        },
        error: function() {
            alert("찜 추가에 실패했습니다.");
        }
    });
}
function delHeart() {
	$.ajax({
		url:"delHeart.do",
		method: "post",
		data: {contentid: contentId},
		success: function(data){
			if (data != "error") {
				alert("관심캠핑장에서 제거하였습니다.");
				loadHeart();
			}
		}
	});
}
$(document).on("click", "#detail_img img", function() {
    let imageUrl = $(this).attr("src");
    let modalContent = '<div id="myModal" class="modal">' +
                       '<span class="close"></span>' +
                       '<img class="modal-content" src="' + imageUrl + '">' +
                       '</div>';

    $("#modal_show").append(modalContent);

    let modal = document.getElementById("myModal");
    let span = document.getElementsByClassName("close")[0];

    modal.style.display = "block";

    span.onclick = function() {
        modal.style.display = "none";
        $("#myModal").remove();
    }

    window.onclick = function(e) {
        if (e.target == modal) {
            modal.style.display = "none";
            $("#myModal").remove();
        }
    }
});
function loadReview(){
    $.ajax({
        url: "loadReview.do",
        type: "get",
        data: {contentid : contentId},
        dataType: "json",
        success: function(data) {
        	console.log(data.length);
        	if (Array.isArray(data) && data.length === 0) {
        		$("#comment_list").empty();
				let commentItem = "<div>"
				commentItem += "<p style='text-align:center; font-size:25px;'>작성된 리뷰가 없습니다. 리뷰를 작성해주세요 !</p>"
				commentItem += "</div>"
				$("#comment_list").append(commentItem);
			}else{
            $("#comment_list").empty();
            $.each(data, function(index, review) {
                let commentItem = "<div>";
                let stars = "";
                let member_profile_img = "/resources/images/"
                for (let i = 0; i < review.rating; i++) {
                    stars += "⭐";
                }
                commentItem += "<img src="+member_profile_img+review.member_img+">";
                commentItem += "<p><b>작성자 : </b>" +review.member_nickname +"<br>";
                commentItem += "<b>별점 : </b>" + stars + "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp";
                let regDate = new Date(review.r_regdate);
                let formattedDate = regDate.getFullYear() + "년 " +
                					(regDate.getMonth() + 1).toString().padStart(2, '0') + "월 " +
                					regDate.getDate().toString().padStart(2, '0') + "일 " +
                					regDate.getHours().toString().padStart(2, '0') + "시 " +
                					regDate.getMinutes().toString().padStart(2, '0') + "분";
                commentItem += ""+formattedDate+"</p>";
                commentItem += "<p> " + review.r_comment + "</p>";
                commentItem += "</div>";
                $("#comment_list").append(commentItem);
            
            });
			}
        },
        error: function() {
            alert("리뷰를 불러오는 중 오류가 발생했습니다.");
        }
    });
}
function loadHeart() {
    $.ajax({
        url: "checkHeart.do",
        type: "get",
        data: { contentid: contentId },
        dataType: "json",
        success: function(data) {
            $("#detail_button").empty();
            if (data === true) {
                let detailButton = "<div>";
                detailButton += "<input type='button' name='page' value='홈페이지' onclick=\"window.open('${info.homepage}')\">";
                detailButton += "<input type='button' name='page' value='예약페이지' onclick='resvego()'>";
                detailButton += "<input type='button' name='page' value='🤍관심등록' onclick='Heart()'>";
                detailButton += "</div>";
                $("#detail_button").append(detailButton);
            } else if (data === false) {
                let detailButton = "<div>";
                detailButton += "<input type='button' name='page' value='홈페이지' onclick=\"window.open('${info.homepage}')\">";
                detailButton += "<input type='button' name='page' value='예약페이지' onclick='resvego()'>";
                detailButton += "<input type='button' id='Heart' name='page' value='❤️관심해제' onclick='delHeart()'>";
                detailButton += "</div>";
                $("#detail_button").append(detailButton);
            } else {
                alert("찜 여부를 확인하는 중 오류가 발생했습니다.");
            }
        },
        error: function() {
            let detailButton = "<div>";
            detailButton += "<input type='button' name='page' value='홈페이지' onclick=\"window.open('${info.homepage}')\">";
            detailButton += "<input type='button' name='page' value='예약페이지' onclick='resvego()'>";
            detailButton += "<input type='button' id='Heart' name='page' value='🤍관심등록' onclick='Heart()'>";
            detailButton += "</div>";
            $("#detail_button").append(detailButton);
        }
    });
}

</script>
<script>
// DB에 페이지 이동 주소가 없는 경우 
	function resvego() {
		let resveurl = "${info.resveurl}";
		if (resveurl == "") {
			alert("주소 없음");
		}else{
			window.open('${info.resveurl}');
		}
	}
</script>
<title>캠핑장 상세 페이지</title>
</head>
<body>
	<div id="modal_show"></div>
	<jsp:include page="../hs/header.jsp" />
	<div class="camp_detail_wrap">
		<div style="height: 100px;">
			<!-- 헤더 너무 딱 붙어있어서 임시 거리 -->
		</div>
		<h4>상세보기</h4>
		<div id="img_box">
			<div id="detail_img">
				<!-- 이미지 들어간 자리  -->
			</div>
		</div>
		<div style="display: inline-block;">
			<h2 style="display: inline; margin-left: 190px;">${info.facltnm}</h2>
			<p style="display: inline;">${info.lctcl}/${info.induty}</p>
			<div id="detail_button"></div>
		</div>
		<div class="detail_info_1">
			<p style="line-height: 30px;">${info.addr1}</p>
			<c:choose>
				<c:when test="${info.tel == null }">
					<p style="line-height: 30px;">전화번호가 없는 사업장입니다.</p>
				</c:when>
				<c:otherwise>
					<p style="line-height: 30px;">${info.tel}</p>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="camp_detail_second_title" id="intro_title">
			<b><a href="#intro_title">소개 및 시설</a> | <a
				href="#map_go">위치</a> | <a href="#review_section">후기</a></b>
		</div>
		<div class="detail_info_1">
			<p style="line-height: 30px;">운영기간 : ${info.operpdcl}</p>
			<p style="line-height: 30px;">운영일 : ${info.operdecl}</p>
			<p style="line-height: 30px;">주변이용가능 시설 : ${info.posblfcltycl}</p>
			<c:choose>
				<c:when test="${info.resved == null }">
					<p style="line-height: 30px;">
						예약방법 : 온라인 실시간 예약<br> <br>
					</p>
				</c:when>
				<c:otherwise>
					<p style="line-height: 30px;">
						예약방법 : ${info.resved}<br> <br>
					</p>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${empty info.intro}">
					<div class="camp_intro">
						<p style="line-height: 30px;">자연 속에서의 힐링을 찾는 이들을 위한 최적의 휴식처, 우리의 캠핑장은 새로운 모험과 즐거움이 가득한 곳입니다. 푸르른 숲속에서의 캠핑 생활은 일상의 모든 스트레스를 잊게 해주며, 여러분을 자유롭고 행복한 시간으로 안내합니다. 친구, 가족, 연인과 함께하는 특별한 순간들을 만들고 싶다면, 우리의 캠핑장을 방문해보세요. 새로운 경험과 아름다운 자연을 만나며, 소중한 추억을 만들어보실 수 있습니다.</p>
					</div>
				</c:when>
				<c:otherwise>
					<div class="camp_intro">
						<p style="line-height: 30px;">${info.intro }</p>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		<h4>시설</h4>
		<div id="camp_item_g"></div>
		<h4 id="map_go">위치</h4>
		<div id="map"></div>
		<h4>후기</h4>
		<div id="review_section">
			<form id="review_form" class="mb-3">
				<fieldset>
					<span class="text-bold">별점을 선택해주세요</span> <input type="radio"
						value="5" name="rating" id="rate1"><label for="rate1">★</label>
					<input type="radio" value="4" name="rating" id="rate2"><label
						for="rate2">★</label> <input type="radio" value="3" name="rating"
						id="rate3"><label for="rate3">★</label> <input
						type="radio" value="2" name="rating" id="rate4"><label
						for="rate4">★</label> <input type="radio" value="1" name="rating"
						id="rate5"><label for="rate5">★</label>
				</fieldset>
				<div>
					<textarea class="col-auto form-control" id="r_comment"
						placeholder="리뷰를 남겨주세요."></textarea>
				</div>
				<button class="review_submit" type="submit">리뷰 작성</button>
			</form>
		</div>

		<div id="comment_list">
			<!-- 댓글 보여지는 곳 -->
		</div>
	</div>
	<jsp:include page="../hs/footer.jsp" />
</body>
</html>