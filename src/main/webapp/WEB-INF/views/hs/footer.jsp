<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="../../../resources/css/reset.css" rel="stylesheet" />
<style type="text/css">
.footer a, .footer a:visited, .footer a:hover, .footer_wrap {
	color: #FFFDDE;
}

.footer {
	background-color: #053610; height : 250px;
	width: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 250px;
}

.footer_wrap {
	position: absolute;
	display: flex;
	left: 50px;
}

.footer_wrap ul {
	list-style: none;
	display: flex;
}

.footer_wrap li {
	padding: 0 15px;
	white-space: nowrap;
}

.footer_text_container, .logo {
	display: grid;
	place-items: center;
}

.footer_text {
	margin: 15px;
}

.logo-03 {
	width: 300px;
	padding: 20px;
}
</style>
</head>
<body>
	<div class="footer" id="footer">
		<div class="footer_wrap">
			<div class="logo">
				<img class="logo-03" src="../../../resources/img/logo-03.png"
					alt="CampYou">
			</div>
			<div class="footer_text_container">
				<div class="footer_text_wrap">
					<div class="footer_link">
						<ul>
							<li><a href="#">개인정보취급방침</a></li>
							<li>|</li>
							<li><a href="#">AGREEMENT</a></li>
							<li>|</li>
							<li><a href="#">PRIVACY POLICY</a></li>
							<li>|</li>
							<li><a href="#">어쩌구저쩌구</a></li>
						</ul>
					</div>
					<div class="footer_text">
						<span> 캠프유(주) | 대표이사: 노준형 | 사업자등록번호: 123-12-12345 | 주소:
							서울특별시 마포구 백범로 23, 3층 <br>
						</span>
					</div>
					<div class="footer_text">
						<span> 대표전화: 010-1234-1234(상담시간: 10:00~18:00) | 이메일 :
							ICT14_3@naver.com </span>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>