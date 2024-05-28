<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=qpvmsbuult"></script>
<link rel="stylesheet" href="/resources/public/css/jun/camp_detail.css">
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

        if (!rating) {
            alert("별점을 선택해주세요.");
            return;
        }
        let requestData = {
            r_comment: comment,
            rating: rating,
            contentid: contentId,
            member_img: member_img,
        };

        $.ajax({
            url: 'addReview.do', 
            type: 'post',
            contentType: 'application/json',
            data: JSON.stringify(requestData),
            success:function(data){
					if(data != "error") {
                    alert("리뷰가 정상적으로 등록되었습니다.");
                    $('#r_comment').val('');
                    $("input[name='rating']").prop('checked', false);
                    loadReview();
                }else {
                    alert("리뷰 작성에 오류가 발생하였습니다.");
                }
            },
            error: function() {
                alert("로그인 후 이용 부탁드립니다.");
                location.href='login_form.do';
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
            alert("로그인 후 이용 부탁드립니다.");
            location.href='login_form.do';
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
function preloadImages() {
    $("#detail_img img").each(function() {
        let imageUrl = $(this).attr("src");
        let img = new Image();
        img.src = imageUrl;
    });
}

let totalImages = $("#detail_img img").length;
$(document).ready(function() {
    $("#detail_img img").each(function() {
        $("<img>").attr("src", $(this).attr("src")).on("load", function() {
        });
    });
    $(document).on("click", "#detail_img img", function() {
        let imageUrl = $(this).attr("src");
        let modalContent = '<div id="myModal" class="modal">' +
                           '<span class="close"></span>' +
                           '<img class="modal-content" src="' + imageUrl + '">' +
                           '<img class="left_button" src="/resources/images/left.png">' +
                           '<img class="right_button" src="/resources/images/right_.png">' +
                           '</div>';
        console.log(imageUrl);
        $("#modal_show").append(modalContent);
        let modal = document.getElementById("myModal");
        let span = document.getElementsByClassName("close")[0];

        modal.style.display = "block";
        $("body").css("overflow", "hidden");
        
        
        $(".modal-content").data("index", $(this).index());
        
        $(".modal-content").on("load", function() {
            modal.style.display = "block";
        });
        span.onclick = function() {
            modal.style.display = "none";
            $("#myModal").remove();
            $("body").css("overflow", "auto");
        }

        window.onclick = function(e) {
            if (e.target == modal) {
                modal.style.display = "none";
                $("#myModal").remove();
                $("body").css("overflow", "auto");
            }
        };
        
        $(".left_button").on("click", function() {
            navigateImage("before");
            console.log("이전");
        });

        $(".right_button").on("click", function() {
            navigateImage("next");
            console.log("다음");
        });
    });

    function navigateImage(direction) {
        let images = $("#detail_img img");
        let currentIndex = $(".modal-content").data("index");

        if (direction === "before") {
            currentIndex = (currentIndex - 1 + images.length) % images.length;
        } else if (direction === "next") {
            currentIndex = (currentIndex + 1) % images.length;
        }

        let nextImageSrc = images.eq(currentIndex).attr("src");
        $("<img>").attr("src", nextImageSrc).on("load", function() {
            $(".modal-content").attr("src", nextImageSrc);
            $(".modal-content").data("index", currentIndex);
        });
    }
});




function loadReview() {
    $.ajax({
        url: "loadReview.do",
        type: "get",
        data: {contentid: contentId},
        dataType: "json",
        success: function(data) {
            if (!data) {
                data = { avgRating: 0, count: 0, reviews: [] };
            }

            let avgRating = data.avgRating;
            let count = data.count;
            console.log(count);
            let resAvg = Math.round((avgRating / count) * 10) / 10;
            
            console.log(resAvg);
            
            $("#comment_list").empty();
            if (data.reviews.length === 0) {
                let commentItem = "<div>";
                commentItem += "<p style='text-align:center; font-size:25px;'>작성된 리뷰가 없습니다. 리뷰를 작성해주세요 !</p>";
                commentItem += "</div>";
                $("#comment_list").append(commentItem);
            } else {
            $("#avg_rating").text(resAvg);
                $.each(data.reviews, function(index, review) {
                    let commentItem = "<div>";
                    let stars = "";
                    let member_profile_img = "/resources/images/";
                    for (let i = 0; i < review.rating; i++) {
                        stars += "⭐";
                    }
                    commentItem += "<img src=" + member_profile_img + review.member_img + " class='profile_show' data-memberidx='" + review.member_idx + "'>";
                    commentItem += "<p><b>작성자 : </b>" + review.member_nickname + "<br>";
                    commentItem += "<b>별점 : </b>" + stars + "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp";
                    let regDate = new Date(review.r_regdate);
                    let formattedDate = regDate.getFullYear() + "년 " +
                                        (regDate.getMonth() + 1).toString().padStart(2, '0') + "월 " +
                                        regDate.getDate().toString().padStart(2, '0') + "일 " +
                                        regDate.getHours().toString().padStart(2, '0') + "시 " +
                                        regDate.getMinutes().toString().padStart(2, '0') + "분";
                    commentItem += "" + formattedDate + "</p>";
                    commentItem += "<p> " + review.r_comment + "</p>";
                    commentItem += "</div>";
                    $("#comment_list").append(commentItem);
                });
            }
        }
    });
}
let filledHeartHtml = function(contentid) {
    return "<img class='heart-button' src='resources/images/heart_fill.png' data-contentid='" + contentid + "' alt='하트'>";
};

let emptyHeartHtml = function(contentid) {
    return "<img class='heart-button' src='resources/images/heart_empty.png' data-contentid='" + contentid + "' alt='빈하트'>";
};


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
                detailButton += emptyHeartHtml(contentId);
                detailButton += "</div>";
                $("#detail_button").append(detailButton);
            } else if (data === false) {
                let detailButton = "<div>";
                detailButton += "<input type='button' name='page' value='홈페이지' onclick=\"window.open('${info.homepage}')\">";
                detailButton += "<input type='button' name='page' value='예약페이지' onclick='resvego()'>";
                detailButton += filledHeartHtml(contentId);
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
            detailButton += emptyHeartHtml(contentId);
            detailButton += "</div>";
            $("#detail_button").append(detailButton);
        }
    });
}


	function resvego() {
		let resveurl = "${info.resveurl}";
		if (resveurl == "") {
			alert("주소 없음");
		}else{
			window.open('${info.resveurl}');
		}
	}
    $(document).on("click", ".heart-button", function() {
        let contentid = $(this).data("contentid");
        if ($(this).attr("src") === 'resources/images/heart_fill.png') {
            delHeart(contentid);
            $(this).attr("src", 'resources/images/heart_empty.png');
        } else {
            Heart(contentid);
            $(this).attr("src", 'resources/images/heart_fill.png');
        }
    });
</script>
<title>캠핑장 상세 페이지</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
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
					<span class="text-bold">평균 별점 : <span id ="avg_rating"> </span></span>
					<input type="radio" value="5" name="rating" id="rate1"><label for="rate1">★</label>
					<input type="radio" value="4" name="rating" id="rate2"><label for="rate2">★</label>
					<input type="radio" value="3" name="rating" id="rate3"><label for="rate3">★</label>
					<input type="radio" value="2" name="rating" id="rate4"><label for="rate4">★</label>
					<input type="radio" value="1" name="rating" id="rate5"><label for="rate5">★</label>
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
	<%@ include file="../hs/profile_small_info.jsp" %>
</body>
</html>