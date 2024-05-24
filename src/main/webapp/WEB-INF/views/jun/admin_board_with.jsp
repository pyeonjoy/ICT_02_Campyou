<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="resources/css/reset.css" rel="stylesheet" />
<%@ include file="../hs/admin_menu.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/80123590ac.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<style type="text/css">
body {
	background-color: #F6FFF1;
}

.board_wrapper {
	padding: 200px 100px 40px 100px;
}
#board_list {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	width: 100%;
	padding: 20px;
}

#board_list table {
	width: 1500px;
	margin: 20px;
	border-collapse: collapse;
	background-color: #F6FFF1;
	text-align: center;
}

#board_list table th {
	background-color: #032805;
	padding: .8rem 1rem;
	color: white;
}

#board_list table td {
	padding: .8rem 1rem;
}

.nowpagecolor {
	padding: 0 0.5rem;
	margin: 0 0.5rem;
	text-decoration: none;
	color: #FFBA34;
	font-size: 1.4rem;
}

.page_button {
	display: flex;
	justify-content: center;
	padding: 20px;
	flex-direction: row;
	margin-top: 20px;
}

.search_nowpagecolor {
	padding: 0 0.5rem;
	margin: 0 0.5rem;
	text-decoration: none;
	color: #FFBA34;
	font-size: 1.4rem;
}

.search_page_button {
	display: flex;
	justify-content: center;
	padding: 20px;
	flex-direction: row;
	margin-top: 20px;
}

.page_button ul {
	display: flex;
	margin-top: -84px;
}

.search_page_button {
	display: flex;
	justify-content: center;
	padding: 20px;
	flex-direction: row;
	margin-top: 20px;
}

.search_page_button ul {
	display: flex;
	margin-top: -84px;
}

.search {
	display: flex;
	margin-right: 70%;
	margin: 30px 93px;
}

.search select, .search input, .search button {
	margin-right: 5px;
}

.nowpage {
	padding: 0 0.5rem;
	margin: 0 0.5rem;
	color: black;
	text-decoration: none;
	font-size: 1.4rem;
}

.th_disable {
	color: silver;
	margin: 0 1rem;
	text-decoration: none;
}

.th_able {
	color: black;
	margin: 0 1rem;
	text-decoration: none;
}

.nowpage:hover {
	color: #FFBA34;
}

.search_nowpage {
	padding: 0 0.5rem;
	margin: 0 0.5rem;
	color: black;
	text-decoration: none;
	font-size: 1.4rem;
}

.search_th_disable {
	color: silver;
	margin: 0 1rem;
	text-decoration: none;
}

.search_th_able {
	color: black;
	margin: 0 1rem;
	text-decoration: none;
}

.search_nowpage:hover {
	color: #FFBA34;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	w_board_load();
});

	function w_board_load(page){
		$.ajax({
			url: "w_board_load.do",
			method: "get",
			dataType: "json",
			data : {
				cPage : page
			},
			success: function(data){
				$("#board_list").empty();
				let list = '<div class="table_inquiry"><table>';
				list += "<thead><tr><th>번호</th><th>닉네임</th><th>제목</th><th>내용</th><th>날짜</th><th>상태</th></tr></thead><tbody>";
				$.each(data.res, function(index, item) {
	                list += '<tr onclick="w_board_detail('+item.t_idx+')">';
					list += '<td>' + item.t_idx + '</td>';
					list += '<td>' + item.member_nickname + '</td>';
					list += '<td>' + item.t_subject + '</td>';
					let onlycontext = item.t_content.replace(/<img[^>]*>/g, '');
					let shortenedContent = onlycontext.substring(0, 20);

					shortenedContent = onlycontext.length > 20;

					list += '<td>' + shortenedContent + '</td>';
					list += '<td>' + item.t_regdate + '</td>';
					if (item.t_active === 0) {
						list += '<td>처리중</td>';
					} else if (item.t_active === 1) {
						list += '<td>처리완료</td>';
					} else {
						list += '<td>알 수 없음</td>';
					}
					list += '</tr>';
				});
				list += '</tbody></table></div>';
				$("#board_list").html(list);
				let paging = data.paging;
				$('.th_paging').empty();
				$('.search_th_paging').empty();
				let pagingHtml = '';
				if (paging.beginBlock <= paging.pagePerBlock) {
					pagingHtml += '<li class="th_disable"><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
					pagingHtml += '<li class="th_disable"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
				} else {
					pagingHtml += '<li><a href="javascript:w_board_load('
							+ 1
							+ ')" class="th_able"><i class="fa-solid fa-angles-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
					pagingHtml += '<li><a href="javascript:w_board_load('
							+ (paging.beginBlock - paging.pagePerBlock)
							+ ')" class="th_able"><i class="fa-solid fa-chevron-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
				}
				for (let k = paging.beginBlock; k <= paging.endBlock
						&& k <= paging.totalPage; k++) {
					if (k === paging.nowPage) {
						pagingHtml += '<li class="nowpagecolor">' + k
								+ '</li>';
					} else {
						pagingHtml += '<li><a href="javascript:w_board_load('
								+ k
								+ ')" class="nowpage">'
								+ k
								+ '</a></li>';
					}
				}
				if (paging.endBlock >= paging.totalPage) {
					pagingHtml += '<li class="th_disable"><i class="fa-solid fa-chevron-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
					pagingHtml += '<li class="th_disable"><i class="fa-solid fa-angles-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
				} else {
					pagingHtml += '<li><a href="javascript:w_board_load('
							+ (paging.beginBlock + paging.pagePerBlock)
							+ ')" class="th_able"><i class="fa-solid fa-chevron-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
					pagingHtml += '<li><a href="javascript:w_board_load('
							+ paging.totalPage
							+ ')" class="th_able"><i class="fa-solid fa-angles-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
				}
				$('.th_paging').append(pagingHtml);
			},
			error: function(){
			console.log("오류뜸요");
			}
		});
		
		
	}
function w_board_detail(){
	console.log("실험이닷!");
	
}
</script>
<title>관리자 - 게시판 관리</title>
</head>
<body>
<div class="board_wrapper">
		<h3 style="text-align: center;">동행 관리</h3>
		<div id="board_list">
			<!-- 리스트 -->
		</div>
		<div class="search">
			<select name="searchType">
				<option value="nickname">닉네임</option>
				<option value="content">내용</option>
			</select> <input type="text" id="keyword_input">
			<button onclick="search_go()">검색</button>
		</div>
		<div class="page_button">
			<ul class="th_paging">
				<!-- 기본 페이징 -->
			</ul>
		</div>
		<div class="search_page_button">
			<ul class="search_th_paging">
				<!-- 검색 페이징 -->
			</ul>
		</div>
</div>
</body>
</html>