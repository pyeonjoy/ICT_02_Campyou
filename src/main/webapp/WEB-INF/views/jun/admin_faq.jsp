<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../hs/admin_menu.jsp"%>
<link href="resources/css/reset.css" rel="stylesheet" />
<meta charset="UTF-8">
<style type="text/css">
body {
	background-color: #F6FFF1;
}

.faq_wrapper {
	padding: 200px 100px 40px 100px;
}

#faq_list {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	width: 100%;
	padding: 20px;
}

#faq_list table {
	width: 1500px;
	margin: 20px;
	border-collapse: collapse;
	background-color: #F6FFF1;
	text-align: center;
}

#faq_list table th {
	background-color: #032805;
	padding: .8rem 1rem;
	color: white;
}

#faq_list table td {
	padding: .8rem 1rem;
}

.button_container {
	display: flex;
	justify-content: space-evenly;
	margin-bottom: 20px;
}

.faq_form {
	display: none;
	margin-top: 20px;
	background-color: rgba(255, 255, 255, 0.8);
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	width: 50%;
	margin: 20px auto;
}

.faq_form div {
	margin-bottom: 15px;
}

.faq_form label {
	display: block;
	font-weight: bold;
	margin-bottom: 5px;
}

#user_faq_title, #user_faq_content, #promise_faq_title,
	#promise_faq_content {
	width: 100%;
	padding: 10px;
	border: none;
	background-color: transparent;
	resize: none;
}

#user_faq_title, #promise_faq_title {
	height: 40px;
}

#user_faq_content, #promise_faq_content {
	height: 200px;
}

.faq_form input, .faq_form textarea {
	border: 1px solid #ccc;
	border-radius: 5px;
	outline: none;
}

.faq_form button {
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.faq_form .button_container {
	text-align: right;
}

.button_container button {
	width: auto;
	height: auto;
	padding: 10px 20px;
}

#user_faq_show .faq_form, #promise_faq_show .faq_form {
	width: 70%;
	margin: 20px auto;
}
.page_button_space {
	display: flex;
	justify-content: center;
	padding: 20px;
}
.page_button2{
	display: flex;
	justify-content: center;
	padding: 20px;
	flex-direction: row;
}
.page_button2 ul{
	display: flex;
}
.use_nowpagecolor{
	padding: 0 0.5rem;
	margin: 0 0.5rem;
	text-decoration: none;
	background-color: white;
	color: #FFBA34;
	font-size: 1.4rem;
}
.use_nowpage{
	padding: 0 0.5rem;
	margin: 0 0.5rem;
	background-color: white;
	color: black;
	text-decoration: none;
	font-size: 1.4rem;
}
.use_th_disable{
	color: silver;
	margin: 0 1rem;
	text-decoration: none;
}
.use_th_able{
	color: black;
	margin: 0 1rem;
	text-decoration: none;
}
.use_nowpage:hover{
	color: #FFBA34;
}
.use_nowpagecolor{
	padding: 0 0.5rem;
	margin: 0 0.5rem;
	text-decoration: none;
	background-color: white;
	color: #FFBA34;
	font-size: 1.4rem;
}
.use_nowpage{
	padding: 0 0.5rem;
	margin: 0 0.5rem;
	background-color: white;
	color: black;
	text-decoration: none;
	font-size: 1.4rem;
}
.use_th_disable{
	color: silver;
	margin: 0 1rem;
	text-decoration: none;
}
.use_th_able{
	color: black;
	margin: 0 1rem;
	text-decoration: none;
}
.use_nowpage:hover{
	color: #FFBA34;
}
.promise_nowpagecolor{
	padding: 0 0.5rem;
	margin: 0 0.5rem;
	text-decoration: none;
	background-color: white;
	color: #FFBA34;
	font-size: 1.4rem;
}
.promise_nowpage{
	padding: 0 0.5rem;
	margin: 0 0.5rem;
	background-color: white;
	color: black;
	text-decoration: none;
	font-size: 1.4rem;
}
.promise_th_disable{
	color: silver;
	margin: 0 1rem;
	text-decoration: none;
}
.promise_th_able{
	color: black;
	margin: 0 1rem;
	text-decoration: none;
}
.promise_nowpage:hover{
	color: #FFBA34;
}
.switch_menu{
    display: flex;
    justify-content: center;
    align-items: flex-start;
    margin-top: 20px;
}
.switch_menu button{
    width: 500px;
    height: 40px;
    margin-right: 30px;
}
.write_button button{
    float: right;
}
.choose_button button{
	float: left;
	margin-left: 10px;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://kit.fontawesome.com/80123590ac.js" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function() {
		user_go();
	});

	function promise_go(page) {
		console.log("찍히냐 동행"+page);
		$.ajax({
			url : "promise_faqload.do",
			method : "get",
			dataType : "json",
			data:{cPage: page},
			success : function(data) {
				$("#faq_list").show();
				$("#user_faq_show").hide();
				$("#promise_faq_show").hide();
				let list = '<div class="table-container"><table>';
				list += "<thead><tr><th></th><th>번호</th><th>제목</th><th>내용</th><th>상태</th></tr></thead><tbody>";
				$.each(data.res, function(index, item) {
					list += '<tr>';
					list += '<td><input type="checkbox" class="status_checkbox" data-faqidx="' + item.faq_idx + '"></td>';
					list += '<td>' + item.faq_idx + '</td>';
					list += '<td>' + item.faq_title + '</td>';
					list += '<td>' + item.faq_content + '</td>';
					if (item.faq_status === 0) {
						list += '<td>비활성화</td>';
					} else if (item.faq_status === 1) {
						list += '<td>활성화</td>';
					} else {
						list += '<td>알 수 없음</td>';
					}
					list += '</tr>';
				});
				list += '<tr><td colspan="3" class="choose_button"><button id="checkAllButton">전체선택 / 해제</button> <button id="PromiseShowOrHide">활성화/비활성화</button></td>';
				list += '<td colspan="2" class="write_button"><button onclick="promise_faq_write()">동행FAQ작성</button></td></tr>';
				list += '</tbody></table></div>';
				$("#faq_list").html(list);
	            let paging = data.paging;
	            $('.th_paging').empty();
	            $('.page_button').empty();
	            let pagingHtml = '';
	            if (paging.beginBlock <= paging.pagePerBlock) {
	                pagingHtml += '<li class="promise_th_disable"><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
	                pagingHtml += '<li class="promise_th_disable"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
	            } else {
	                pagingHtml += '<li><a href="javascript:promise_go(' + 1 + ')" class="promise_th_able"><i class="fa-solid fa-angles-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
	                pagingHtml += '<li><a href="javascript:promise_go(' + (paging.beginBlock - paging.pagePerBlock) + ')" class="promise_th_able"><i class="fa-solid fa-chevron-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
	            }
	            for (let k = paging.beginBlock; k <= paging.endBlock && k <= paging.totalPage; k++) {
	                if (k === paging.nowPage) {
	                    pagingHtml += '<li class="promise_nowpagecolor">' + k + '</li>';
	                } else {
	                    pagingHtml += '<li><a href="javascript:promise_go(' + k + ')" class="promise_nowpage">' + k + '</a></li>';
	                }
	            }
	            if (paging.endBlock >= paging.totalPage) {
	                pagingHtml += '<li class="promise_th_disable"><i class="fa-solid fa-chevron-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
	                pagingHtml += '<li class="promise_th_disable"><i class="fa-solid fa-angles-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
	            } else {
	                pagingHtml += '<li><a href="javascript:promise_go(' + (paging.beginBlock + paging.pagePerBlock) + ')" class="promise_th_able"><i class="fa-solid fa-chevron-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
	                pagingHtml += '<li><a href="javascript:promise_go(' + paging.totalPage + ')" class="promise_th_able"><i class="fa-solid fa-angles-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
	            }
	            $('.th_paging').append(pagingHtml);
			},
			error : function() {
				alert("오류가 발생했습니다.");
			}
		});
	}

	function user_go(page) {
		console.log("찍히냐유저"+page);
		$.ajax({
			url : "use_faqload.do",
			method : "get",
			dataType : "json",
			data:{cPage: page},
			success : function(data) {
				$("#faq_list").show();
				$("#user_faq_show").hide();
				$("#promise_faq_show").hide();
				let list = '<div class="table-container"><table>';
				list += "<thead><tr><th></th><th>번호</th><th>제목</th><th>내용</th><th>상태</th></tr></thead><tbody>";
				$.each(data.res, function(index, item) {
					list += '<tr>';
					list += '<td><input type="checkbox" class="status_checkbox" data-faqidx="' + item.faq_idx + '"></td>';
					list += '<td style="width:7%;">' + item.faq_idx + '</td>';
					list += '<td>' + item.faq_title + '</td>';
					list += '<td>' + item.faq_content + '</td>';
					if (item.faq_status === 0) {
						list += '<td style="width:7%;">비활성화</td>';
					} else if (item.faq_status === 1) {
						list += '<td style="width:7%;">활성화</td>';
					} else {
						list += '<td style="width:7%;">알 수 없음</td>';
					}
					list += '</tr>';
				});
				list += '<tr><td colspan="3" class="choose_button"><button id="checkAllButton">전체선택 / 해제</button> <button id="UserShowOrHide">활성화/비활성화</button></td>';
				list += '<td colspan="2" class="write_button"><button onclick="user_faq_write()">유저FAQ작성</button></td></tr>';
				list += '</tbody></table></div>';
				$("#faq_list").html(list);
				 let paging = data.paging;
		            $('.th_paging').empty();
		            $('.page_button').empty();
		            let pagingHtml = '';
		            if (paging.beginBlock <= paging.pagePerBlock) {
		                pagingHtml += '<li class="use_th_disable"><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
		                pagingHtml += '<li class="use_th_disable"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
		            } else {
		                pagingHtml += '<li><a href="javascript:user_go(' + 1 + ')" class="use_th_able"><i class="fa-solid fa-angles-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
		                pagingHtml += '<li><a href="javascript:user_go(' + (paging.beginBlock - paging.pagePerBlock) + ')" class="use_th_able"><i class="fa-solid fa-chevron-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
		            }
		            for (let k = paging.beginBlock; k <= paging.endBlock && k <= paging.totalPage; k++) {
		                if (k === paging.nowPage) {
		                    pagingHtml += '<li class="use_nowpagecolor">' + k + '</li>';
		                } else {
		                    pagingHtml += '<li><a href="javascript:user_go(' + k + ')" class="use_nowpage">' + k + '</a></li>';
		                }
		            }
		            if (paging.endBlock >= paging.totalPage) {
		                pagingHtml += '<li class="use_th_disable"><i class="fa-solid fa-chevron-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
		                pagingHtml += '<li class="use_th_disable"><i class="fa-solid fa-angles-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
		            } else {
		                pagingHtml += '<li><a href="javascript:user_go(' + (paging.beginBlock + paging.pagePerBlock) + ')" class="use_th_able"><i class="fa-solid fa-chevron-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
		                pagingHtml += '<li><a href="javascript:user_go(' + paging.totalPage + ')" class="use_th_able"><i class="fa-solid fa-angles-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
		            }
		            $('.th_paging').append(pagingHtml);
			},
			error : function() {
				alert("오류가 발생했습니다.");
			}
		});
	}
	$(document).on('click', '#checkAllButton', function(){
	    let isChecked = $('.status_checkbox:first').prop('checked');
	    $('.status_checkbox').prop('checked', !isChecked);
	});
    $(document).on('click', '#UserShowOrHide', function() {
    	StatusUserChange();
    });
    $(document).on('click', '#PromiseShowOrHide', function() {
    	StatusPromiseChange();
    });
    $(document).on('click', '#user', function() {
    	user_go();
    });
    $(document).on('click', '#promise', function() {
    	promise_go();
    });
	function user_faq_write() {
		console.log("버튼정상작동?");
		$("#faq_list").hide();
		$('.page_button').empty();
		$('.page_button2').empty();
		$("#user_faq_show").show();
	}

	function promise_faq_write() {
		console.log("동행정상작동?");
		$("#faq_list").hide();
		$('.page_button').empty();
		$('.page_button2').empty();
		$("#promise_faq_show").show();
	}

	function user_faq_write_go() {
		let title = $("#user_faq_title").val();
		let content = $("#user_faq_content").val();

		$.ajax({
			url : "faq_user_write_go.do",
			method : "post",
			contentType : "application/json",
			data : JSON.stringify({
				faq_title : title,
				faq_content : content
			}),
			success : function(data) {
				alert("유저 FAQ가 정상적으로 등록 되었습니다.");
				$("#user_faq_show").hide();
				user_go();
			},
			error : function() {
				alert("FAQ 저장 실패~")
			}
		});
	}

	function promise_faq_write_go() {
		let title = $("#promise_faq_title").val();
		let content = $("#promise_faq_content").val();

		$.ajax({
			url : "faq_promise_write_go.do",
			method : "post",
			contentType : "application/json",
			data : JSON.stringify({
				faq_title : title,
				faq_content : content
			}),
			success : function(data) {
				alert("동행 FAQ가 정상적으로 등록 되었습니다.");
				$("#promise_faq_show").hide();
				promise_go();
			},
			error : function() {
				alert("FAQ 저장 실패~")
			}
		});
	}
	function StatusUserChange(){
		let selectBox = [];
	    $('.status_checkbox:checked').each(function() {
	    	selectBox.push($(this).data('faqidx'));
	    });
		console.log(selectBox);
		
		if(selectBox.length === 0){
			alert("선택 항목이 없음.");
			return;
		}
		
		$.ajax({
			url : "StatusUserChange.do",
			method: "post",
	        contentType: "application/json",
	        data: JSON.stringify({
	            faq_ids: selectBox
	        }),
	        success:function(data){
	        	alert("상태가 변경되었습니다.");
	        	user_go();
	        },
	        error:function(){
	        	alert("오류임");
	        }
		});
	}
	function StatusPromiseChange(){
		let selectBox = [];
	    $('.status_checkbox:checked').each(function() {
	    	selectBox.push($(this).data('faqidx'));
	    });
		console.log(selectBox);
		
		if(selectBox.length === 0){
			alert("선택 항목이 없음.");
			return;
		}
		
		$.ajax({
			url : "StatusPromiseChange.do",
			method: "post",
	        contentType: "application/json",
	        data: JSON.stringify({
	            faq_ids: selectBox
	        }),
	        success:function(data){
	        	alert("상태가 변경되었습니다.");
	        	promise_go();
	        },
	        error:function(){
	        	alert("오류임");
	        }
		});
	}
</script>

<title>관리자 - FAQ 관리</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico"
	type="image/x-icon">
<link rel="icon" href="${path}/resources/images/favicon.ico"
	type="image/x-icon">
</head>
<body>
	<div class="faq_wrapper">
		<h3 style="text-align: center;">FAQ 관리</h3>
			<div class="switch_menu">
			<button id="user">사용자 이용 문의</button>
			<button id="promise">동행</button>
			</div>
		<div id="faq_list">
			<!-- 리스트 -->
		</div>
		<div class="page_button">
			<ul class="to_paging camp_list_page">
			</ul>
		</div>
	</div>
		<div class ="page_button2">
			<ul class="th_paging">
			</ul>
		</div>
		<div id="user_faq_show" class="faq_form">
			<form id="user_faq_form">
				<div>
					<h4 style="margin: 10px; text-align: center;">사용자 이용 문의 FAQ 작성</h4>
					<br> <br> <label for="user_faq_title">제목</label> <input
						type="text" id="user_faq_title" name="faq_title">
				</div>
				<div>
					<label for="user_faq_content">내용</label>
					<textarea id="user_faq_content" name="faq_content"></textarea>
				</div>
				<div class="button_container">
					<button type="button" onclick="user_faq_write_go()">저장</button>
				</div>
			</form>
		</div>

		<div id="promise_faq_show" class="faq_form">
			<form id="promise_faq_form">
				<div>
					<h4 style="margin: 10px; text-align: center;">동행 FAQ 작성</h4>
					<label for="promise_faq_title">제목</label> <input type="text"
						id="promise_faq_title" name="faq_title">
				</div>
				<div>
					<label for="promise_faq_content">내용</label>
					<textarea id="promise_faq_content" name="faq_content"></textarea>
				</div>
				<div class="button_container">
					<button type="button" onclick="promise_faq_write_go()">저장</button>
				</div>
			</form>
		</div>
</body>
</html>
