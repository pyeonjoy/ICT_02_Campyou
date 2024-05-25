<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="resources/css/reset.css" rel="stylesheet" />
<%@ include file="../hs/admin_menu.jsp"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/80123590ac.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/summernote-lite.css">
<script src="/resources/public/js/bm/lang/summernote-ko-KR.js"></script>
<script src="/resources/public/js/bm/summernote-lite.js"></script>
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

.detail_info {
	width: 80%;
	height: 80%;
}
.active_button{
    position: absolute;
    right: 15%;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		w_board_load();
	});

	function initializeSummernote() {
		$('#summernote').summernote({
			height : 300,
			maxHeight : 300,
			focus : true,
			lang : "ko-KR",
			toolbar : false, // 툴바 비활성화
			disableDragAndDrop : true, // 드래그 앤 드롭 비활성화
			callbacks : {
				onInit : function() {
					$('.note-editable').attr('contenteditable', false); // 내용 수정 불가능하게 설정
					$('.note-editable').addClass('note-editable-readonly'); // CSS 클래스 추가
				}
			}
		});
	}

	function w_board_load(page) {
		$
				.ajax({
					url : "w_board_load.do",
					method : "get",
					dataType : "json",
					data : {
						cPage : page
					},
					success : function(data) {
						$("#board_list").empty();
						$('.search').show();
						$('.warpper_title').show();
						let list = '<div class="table_inquiry"><table>';
						list += "<thead><tr><th>번호</th><th>닉네임</th><th>제목</th><th>내용</th><th>날짜</th><th>상태</th></tr></thead><tbody>";
						$
								.each(
										data.res,
										function(index, item) {
											list += '<tr onclick="w_board_detail('
													+ item.t_idx + ')">';
											list += '<td>' + item.t_idx
													+ '</td>';
											list += '<td>'
													+ item.member_nickname
													+ '</td>';
											list += '<td>' + item.t_subject
													+ '</td>';
											let onlyText = item.t_content ? item.t_content
													.replace(/<\/?[^>]+(>|$)/g,
															"")
													: '';
											let shortenedContent = onlyText.length > 20 ? onlyText
													.substring(0, 20)
													+ '...'
													: onlyText;
											list += '<td>' + shortenedContent
													+ '</td>';
											list += '<td>' + item.t_regdate
													+ '</td>';
											if (item.t_active === 0) {
												list += '<td>게시중</td>';
											} else if (item.t_active === 1) {
												list += '<td>숨김처리</td>';
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
					error : function() {
						console.log("오류뜸요");
					}
				});
	}

	function w_board_detail(t_idx) {
	    $.ajax({
	        url: "w_board_detail.do",
	        method: "get",
	        data: {
	            t_idx: t_idx
	        },
	        dataType: "json",
	        success: function(data) {
	            $("#board_list").empty();
	            $('.th_paging').empty();
	            $('.search_th_paging').empty();
	            $('.search').hide();
	            $('.warpper_title').hide();

	            console.log(data);

	            let list = '';
	            list += '<div class="detail_info">';
	            list += '<h3 style="text-align: center;">게시글 상세보기</h3>';
	            list += '<p>번호: ' + (data.board.t_idx) + '</p><br>';
	            list += '<p>닉네임: ' + (data.board.member_nickname) + '</p><br>';
	            list += '<p>제목: ' + (data.board.t_subject) + '</p><br>';
	            list += '<p>게시글 작성일: ' + (data.board.t_regdate) + '</p><br>';
	            list += '<p>내용: </p><textarea id="summernote" name="qna_content">' + (data.board.t_content) + '</textarea><br><br><br><br>';

	            if (data.board.t_active === '0') {
	                list += '<h3 style="display: inline-block;">게시중</h3>';
	                list += '<button onclick="hide_post(' + data.board.t_idx + ')" style="display: inline-block; margin-left: 10px;">삭제(숨김)</button>';
	                list += '<button onclick="w_board_load()" style="display: inline-block; margin-left: 10px;">뒤로가기</button>';
	            } else if (data.board.t_active === '1') {
	                list += '<h3 style="display: inline-block;">숨김처리</h3>';
	                list += '<button onclick="show_post(' + data.board.t_idx + ')" style="display: inline-block; margin-left: 10px;">복원(보이기)</button>';
	                list += '<button onclick="w_board_load()" style="display: inline-block; margin-left: 10px;">뒤로가기</button>';
	            } else {
	                list += '<h3 style="display: inline-block;">알 수 없음</h3>';
	                list += '<button onclick="hide_post(' + data.board.t_idx + ')" style="display: inline-block; margin-left: 10px;">삭제</button>';
	                list += '<button onclick="w_board_load()" style="display: inline-block; margin-left: 10px;">뒤로가기</button>';
	            }

	            if (Array.isArray(data.comments)) {
	                console.log("댓글 목록:", data.comments);
	                for (let i = 0; i < data.comments.length; i++) {
	                    let comment = data.comments[i];
	                    let indentation = '';

	                    if (comment.wc_step > 0) {
	                        for (let j = 1; j <= comment.wc_lev; j++) {
	                            indentation += '&nbsp;&nbsp;&nbsp;&nbsp;';
	                        }
	                        indentation += '';
	                    }

	                    list += '<div class="toDetailContent4Sub3">';
	                    list += '<div class="toDetailContent4Sub2Sub1">';
	                    list += '<div class="toDetailContent4Sub2Sub1Div">';
	                    list += '</div>';
	                    list += '</div>';
	                    list += '</div>';
	                    list += '<div class="toDetailContent4Sub2Sub3">';
	                    list += '<div class="toDetailContent2Sub1Div2">';
	                    list += '<p>'+indentation+'작성자 : '+comment.member_nickname+'</p><br>';
	                    list += '<p>'+indentation+'작성일 : '+comment.wc_regdate+'</p><br>';
	                    list += '<span class="toDetailContent2Sub1Div2Span">' + indentation + 'ㄴ' + comment.wc_content + '</span>';
	                    if (comment.wc_active == 0) {
	                        list += '<button class="active_button" onclick="comment_hide(' + data.board.t_idx + ', ' + comment.wc_idx + ')"">삭제(숨김)</button><hr>';
	                    } else {
	                        list += '<button class="active_button" onclick="comment_show(' + data.board.t_idx + ', ' + comment.wc_idx + ')"">복원(보이기)</button><hr>';
	                    }
	                    list += '</div>';
	                    list += '<div class="toDetailContent4Sub2Sub2">';
	                    list += '</div>';
	                    list += '</div>';
	                }
	            } else {
	                console.log("댓글이 없습니다.");
	            }


	            list += '</div>';
	            $("#board_list").html(list);
	            
	            setTimeout(function() {
	                initializeSummernote();
	            }, 100);
	        },
	        error: function() {
	            console.log("에러");
	        }
	    });
	}





	function hide_post(t_idx) {
		$.ajax({
			url : "hide_post.do",
			method : "post",
			dataType : "json",
			data : {
				t_idx : t_idx
			},
			success : function(data) {
				alert("게시물 숨김처리 완료.");
				w_board_detail(t_idx);
			},
			error : function() {
				alert("게시물 숨김 처리 실패.");
			}
		});
	}
	function show_post(t_idx) {
		$.ajax({
			url : "show_post.do",
			method : "post",
			dataType : "json",
			data : {
				t_idx : t_idx
			},
			success : function(data) {
				alert("게시물 보이기 처리 완료.");
				w_board_detail(t_idx);
			},
			error : function() {
				alert("게시물 보이기 처리 실패.");
			}
		});
	}
	function comment_hide(t_idx, wc_idx) {
		$.ajax({
			url : "comment_hide.do",
			method : "post",
			dataType : "json",
			data : {
				t_idx : t_idx,
				wc_idx : wc_idx
			},
			success : function(data) {
				console.log(t_idx);
				console.log(wc_idx);
				alert("댓글 숨김 처리 완료");
				w_board_detail(t_idx);
			},
			error : function() {
				alert("댓글 숨김 처리 실패.");
			}
		});
	}

	function comment_show(t_idx, wc_idx) {
		$.ajax({
			url : "comment_show.do",
			method : "post",
			dataType : "json",
			data : {
				t_idx : t_idx,
				wc_idx : wc_idx
			},
			success : function(data) {
				alert("댓글 보이기 처리 완료.");
				w_board_detail(t_idx);
			},
			error : function() {
				alert("댓글 보이기 처리 실패.");
			}
		});
	}
	function search_go(page) {
		let searchType = $("select[name='searchType']").val();
		let keywordInput = $("#keyword_input").val();
		$.ajax({
					url : "w_board_search.do",
					method : "get",
					dataType : "json",
					data : {
						cPage : page,
						keywordInput : keywordInput,
						searchType : searchType
					},
					success : function(data) {
						$("#board_list").empty();
						$('.search').show();
						$('.warpper_title').show();
						let list = '<div class="table_inquiry"><table>';
						list += "<thead><tr><th>번호</th><th>닉네임</th><th>제목</th><th>내용</th><th>날짜</th><th>상태</th></tr></thead><tbody>";
						$.each(data.res,function(index, item) {
											list += '<tr onclick="w_board_detail('
													+ item.t_idx + ')">';
											list += '<td>' + item.t_idx
													+ '</td>';
											list += '<td>'
													+ item.member_nickname
													+ '</td>';
											list += '<td>' + item.t_subject
													+ '</td>';
											let onlyText = item.t_content ? item.t_content
													.replace(/<\/?[^>]+(>|$)/g,
															"")
													: '';
											let shortenedContent = onlyText.length > 20 ? onlyText
													.substring(0, 20)
													+ '...'
													: onlyText;
											list += '<td>' + shortenedContent
													+ '</td>';
											list += '<td>' + item.t_regdate
													+ '</td>';
											if (item.t_active === 0) {
												list += '<td>게시중</td>';
											} else if (item.t_active === 1) {
												list += '<td>숨김처리</td>';
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
							pagingHtml += '<li class="search_th_disable"><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
							pagingHtml += '<li class="search_th_disable"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
						} else {
							pagingHtml += '<li><a href="javascript:search_go('
									+ 1
									+ ')" class="search_th_able"><i class="fa-solid fa-angles-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
							pagingHtml += '<li><a href="javascript:search_go('
									+ (paging.beginBlock - paging.pagePerBlock)
									+ ')" class="search_th_able"><i class="fa-solid fa-chevron-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
						}
						for (let k = paging.beginBlock; k <= paging.endBlock
								&& k <= paging.totalPage; k++) {
							if (k === paging.nowPage) {
								pagingHtml += '<li class="search_nowpagecolor">'
										+ k + '</li>';
							} else {
								pagingHtml += '<li><a href="javascript:search_go('
										+ k
										+ ')" class="search_nowpage">'
										+ k
										+ '</a></li>';
							}
						}

						// 이후 버튼
						if (paging.endBlock >= paging.totalPage) {
							pagingHtml += '<li class="search_th_disable"><i class="fa-solid fa-chevron-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
							pagingHtml += '<li class="search_th_disable"><i class="fa-solid fa-angles-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
						} else {
							pagingHtml += '<li><a href="javascript:search_go('
									+ (paging.beginBlock + paging.pagePerBlock)
									+ ')" class="search_th_able"><i class="fa-solid fa-chevron-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
							pagingHtml += '<li><a href="javascript:search_go('
									+ paging.totalPage
									+ ')" class="search_th_able"><i class="fa-solid fa-angles-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
						}
						$('.th_paging').append(pagingHtml);
					},
					error : function() {
						alert("불러오는데 오류가 발생하셨습니다.")
					}
				});
	}
</script>
<title>관리자 - 게시판 관리</title>
</head>
<body>
	<div class="board_wrapper">
		<h3 style="text-align: center;" class="warpper_title">동행 관리</h3>
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
