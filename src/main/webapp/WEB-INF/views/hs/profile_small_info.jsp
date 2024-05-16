<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('.userImage2').click(function(event) {
			$('.profile_small_info_container').css('display', 'block');
		});

	    $(document).click(function(event) {
	        const target = $(event.target).offset(); 
	        const click_position_top = target.top + 60;
	        const click_position_left = target.left;
	        console.log(click_position_top)
	        console.log(click_position_left)
            $('.profile_small_info_container').css('top', click_position_top+'px');
            $('.profile_small_info_container').css('left', click_position_left+'px');
	        if (!$('.profile_small_info_container').is(event.target) && !$('.userImage2').is(event.target)) {
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
	margin-left: 5px;
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
					<input type="button" value="채팅">
					<input type="button" value="신고" onclick="location.href='report_write.do?member_idx=${k.member_idx}'">

				</div>
			</div>
			<hr>
			<div class="bottom_info">
				<span>게시글 개수: </span><br> <span>동행글 개수: </span>
			</div>
		</div>
	</div>
</body>
</html>