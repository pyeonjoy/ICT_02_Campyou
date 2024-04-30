<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
.profile_small_info_container {
	border: 1px solid lightgray;
	width: 330px;
	height: auto;
	position: absolute;
}

.profile_small_info_wrap {
	padding: 20px;
	position: relative;
	height: 4rem;
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

.left_info, .right_info {
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.left_info strong {
	font-size: 16px;
}

.member_age {
	color: gray;
	font-size: 12px;
}

.right_info {
	float: right;
	width: auto;
}

.both_info {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	margin-top: 10px;
}

</style>
</head>
<body>
<div class="profile_small_info_container">
	<div class="profile_small_info_wrap">
		<div class="profile_img">
		</div>
		<div class="both_info">
			<div class="left_info">
				<div>
					<strong>닉네임</strong>
					<span class="member_role">등급</span>
				</div>
				<span class="member_age">20대</span>
			</div>
			<div class="right_info">
				<input type="button" value="채팅">
			</div>
		</div>
	</div>
</div>
</body>
</html>