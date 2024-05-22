<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('.profile_show').click(function(event) {
			let member_idx = this.getAttribute('data-memberidx'); 
			console.log(member_idx);
			console.log( $(this));
			
			var imageSrc = this.getAttribute('src');
			console.log(imageSrc);
			
			$.ajax({
			    url: "getProfile.do",
			    method: "post",
			    dataType: "xml",
			    data: { member_idx:member_idx },
			    success: function(data) {
			    	
			    },
			    error: function() {
			    	console.log("읽기 실패");
			    }
			});
			
			
			$('.profile_small_info_container').css('display', 'block');
		});

	    $(document).click(function(event) {
	        const target = $(event.target).offset(); 
	        const click_position_top = target.top + 60;
	        const click_position_left = target.left;
            $('.profile_small_info_container').css('top', click_position_top+'px');
            $('.profile_small_info_container').css('left', click_position_left+'px');
	        if (!$('.profile_small_info_container').is(event.target) && !$('.profile_show').is(event.target)) {
	            $('.profile_small_info_container').css('display', 'none');
	        }
	    });
	    
	    
	    
	});
</script>
<style type="text/css">
.profile_small_info_container {
	border: 1px solid lightgray;
	width: 330px;
	position: absolute;
	background-color: white;
	z-index: 10;
	display: none;
}

.profile_small_info_wrap {
	padding: 20px;
	position: relative;
}

.profile_img {
	width: 4rem;
	height: 4rem;
	background-color: green;
	border-radius: 100%;
	float: left;
	position: relative;
	margin-right: 10px;
}

.top_info strong {
	font-size: 16px;
}

.member_age {
	color: gray;
	font-size: 12px;
}

.top_info {
	display: flex;
	flex-direction: column;
	margin-top: 10px;
	height: 4rem;
}

.top_info input[type="button"] {
	float: right;
	margin-left: 5px;
	text-align: center;
	padding: 3px 20px;
}

.bottom_info {
	font-size: 14px;
	line-height: 25px;
}
</style>
<style>
.rating_wrap {
	width: 200px;
    height: 40px;
}

.rating_stars {
	display: flex;
}
.rating {
	display:flex;
    overflow: hidden;
    width: 200px;
    height: 40px;
   	position: relative;
}
.rating_empty {
	display:flex;
    overflow: hidden;
    width: 200px;
    height: 40px;
   	position: relative;
}

.rating__label {
    display: inline-block;
    width: 40px;
    height: 40px;
    position: relative;
}

.empty, .filled {
    display: block;
    position: absolute;
    width: 100%;
    height: 100%;
    background-repeat: no-repeat;
    background-size: 100%;
}

.empty {
    background-image: url(${path}/resources/images/ico-star-empty.png);
}

.filled {
    background-image: url(${path}/resources/images/ico-star.png);
    z-index: 5;
}
.asd {
	position: absolute;
}

</style>
</head>
<body>
	<div class="profile_small_info_container">
		<div class="profile_small_info_wrap">
			<div class="profile_img"></div>
			<div class="top_info">
				<div>
					<strong>닉네임</strong> <span class="member_role">등급</span>
				</div>
				<span class="member_age">20대</span>
				<div>
					<input type="button" value="채팅"> <input type="button"
						value="신고"
						onclick="location.href='report_write.do?member_idx=${k.member_idx}'">
				</div>
			</div>
			<hr>
			<div class="bottom_info">
				<div class="rating_wrap">
					<div class="asd">
						<div class="rating_empty">
							<c:forEach var="i" begin="1" end="5">
							    <div class="rating__label rating__label--full">
							        <span class="star-icon empty" id="star${i}" ></span>
							    </div>
							</c:forEach>
						</div>
					</div>
					<div class="asd">
						<div class="rating">
							<div class="rating_stars">
								<c:forEach var="i" begin="1" end="5">
								    <div class="rating__label rating__label--full">
								        <span class="star-icon filled" id="star${i}" ></span>
								    </div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
$(document).ready(function(){
    const member_rating = 2.5; 
    const full_rating = 10;
    const partialWidth = member_rating / full_rating * 100;

    $(".rating").css("width", partialWidth + "%");
});
</script>
</body>
</html>