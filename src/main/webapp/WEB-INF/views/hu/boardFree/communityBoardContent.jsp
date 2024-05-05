<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 내용</title>
<link rel="stylesheet" href="${path}/resources/public/css/hu/communityBoardContent.css">
<script type="text/javascript">
	function comm_board_list(f) {
		f.action="community_board.do";
		f.submit()
	}	
	function comm_board_update(f) {
		f.action="comm_board_update.do";
		f.submit()
	}	
	function comm_board_delete(f) {
		f.action="comm_board_delete.do";
		f.submit()
	}
	function comment_insert(f){
		f.action="comment_insert.do";
		f.submit();
	}
	
	
	
	
	
	
	
	
	
	///////////////////////////////////////////////////////////////////////
	//댓글의 댓글
	function comment_reply_insert(f) {
	  
	    f.action = "comment_reply_insert.do"; 

	
	    f.submit();
	 
	}
	
	
	
	
	
	
	
	
	
	function comment_delete(f) {
		f.action="comment_delete.do";
		f.submit();
	}
	function comm_board_admin_delete(f) {
		f.action="comm_board_admin_delete.do";
		f.submit();
	}
	function comment_update(f) {
	    // 해당 댓글의 내용을 가져옴
	    const content = f.querySelector('p').innerHTML;

	    // 내용을 input 요소로 변경
	    f.querySelector('p').innerHTML = '<input type="text" name="content" value="' + content + '">';

	    // 수정 완료 버튼 생성
	    const updateBtn = document.createElement('input');
	    updateBtn.type = 'button';
	    updateBtn.value = '수정완료';
	    updateBtn.onclick = function() {
	        // 수정된 내용을 서버로 전송
	        f.action="comment_update.do";
	        f.submit();
	    };
	    f.appendChild(updateBtn);
	    
	    // 댓글수정 버튼 제거
	    const updateGoBtn = f.querySelector('#updateGo');
	    updateGoBtn.parentNode.removeChild(updateGoBtn);
	}
</script>
<script type="text/javascript">
function comment_reply(f) {
	   
    var replyDiv = document.createElement('div');
    replyDiv.setAttribute('style', 'border: 1px solid #ccc; padding: 10px; margin-top: 10px;');

    var replyForm = document.createElement('form');
    replyForm.setAttribute('method', 'post');

    var nicknameInput = document.createElement('input');
    nicknameInput.setAttribute('type', 'text');
    nicknameInput.setAttribute('name', 'member_nickname');
    nicknameInput.setAttribute('value', '${memberInfo.member_nickname}');
    nicknameInput.setAttribute('style', 'padding: 5px;');
    nicknameInput.setAttribute('readonly', 'true');
    var nicknameLabel = document.createElement('label');
    nicknameLabel.textContent = '별명: ';
    replyForm.appendChild(nicknameLabel);
    replyForm.appendChild(nicknameInput);
    replyForm.appendChild(document.createElement('br'));

    var contentTextarea = document.createElement('textarea');
    contentTextarea.setAttribute('rows', '3');
    contentTextarea.setAttribute('cols', '40');
    contentTextarea.setAttribute('name', 'b_content');
    replyForm.appendChild(document.createElement('br'));
    var contentLabel = document.createElement('label');
    contentLabel.textContent = '내용: ';
    replyForm.appendChild(contentLabel);
    replyForm.appendChild(contentTextarea);
    replyForm.appendChild(document.createElement('br'));

    var bIdxInput = document.createElement('input');
    bIdxInput.setAttribute('type', 'hidden');
    bIdxInput.setAttribute('name', 'b_idx');
    bIdxInput.setAttribute('value', '${cbvo.b_idx}');
    replyForm.appendChild(bIdxInput);

   	var cPageInput = document.createElement('input');
   	cPageInput.setAttribute('type', 'hidden');
   	cPageInput.setAttribute('name', 'cPage');
    cPageInput.setAttribute('value', '${cPage}');
    replyForm.appendChild(cPageInput);

    var submitBtn = document.createElement('input');
    submitBtn.setAttribute('type', 'button');
    submitBtn.setAttribute('value', '댓글저장2');
    submitBtn.setAttribute('onclick', 'comment_reply_insert(this.form)');
    submitBtn.setAttribute('style', 'margin-left: 50px;');
    replyForm.appendChild(submitBtn);

    replyDiv.appendChild(replyForm);

    f.parentNode.appendChild(replyDiv); 
} 
</script>
</head>
<body>
<div>
	<h2>게시글</h2>
	<hr>
	<form method="post">
	<table>
	<tbody>
	<tr>
		<th bgcolor="#003300" style="color: white;">제목</th>
		<td>${cbvo.b_subject} </td>
	</tr>
	<tr>
		<th bgcolor="#003300" style="color: white;">닉네임</th>
		<td> ${cbvo.member_nickname}</td>
	</tr>
	<tr>
		<th bgcolor="#003300" style="color: white;">날짜</th>
		<td>${cbvo.b_regdate.substring(0,10)} </td>
	</tr>
	<tr>
		<th bgcolor="#003300" style="color: white;">첨부파일</th>
		<c:choose>
			<c:when test="${empty cbvo.bf_name}">
				<td><b>첨부파일없음</b></td>
			</c:when>
			<c:otherwise>
				<td>
					<a href="comm_board_down.do?f_name=${cbvo.bf_name}"><img src="resources/upload/${cbvo.bf_name}" style="width: 80px"> </a>
				</td>
			</c:otherwise>
		</c:choose>
	</tr>
	<tr>
		<th bgcolor="#003300" style="color: white;">내용</th>
		<td><pre>${cbvo.b_content}</pre></td>
	</tr>
	</tbody>
	<tfoot>
	<tr id="foot-tr">
     <td colspan="2">
     <c:choose>
     		<c:when test="${memberInfo.member_id eq 'admin'}">
     				<input type="hidden" value="${cbvo.b_idx}" name="b_idx"> 
	     			<input type="hidden" value="${cPage}" name="cPage">
	        		<input class="contentBtn" type="button" value="목록" onclick="comm_board_list(this.form)" />
	        		<input class="contentBtn" type="button" value="수정" onclick="comm_board_update(this.form)" />
	        		<input class="contentBtn" type="button" value="삭제" onclick="comm_board_delete(this.form)" />
	        		<input class="contentBtn" type="button" value="관리자삭제" onclick="comm_board_admin_delete(this.form)" />  
     		</c:when>
     		<c:otherwise>
     			<c:choose>			
     				<c:when test="${memberInfo.member_nickname eq cbvo.member_nickname}">
     					<input type="hidden" value="${cbvo.b_idx}" name="b_idx">
     					<input type="hidden" value="${cPage}" name="cPage">
        				<input class="contentBtn" type="button" value="목록" onclick="comm_board_list(this.form)" />
        				<input class="contentBtn" type="button" value="수정" onclick="comm_board_update(this.form)" />
        				<input class="contentBtn" type="button" value="삭제" onclick="comm_board_delete(this.form)" />
     				</c:when>
     				<c:otherwise>
     					<c:choose>
     						<c:when test="${memberInfo.member_nickname eq null}">
     							<input class="contentBtn" type="button" value="목록" onclick="comm_board_list(this.form)" />
     						</c:when>
     						<c:otherwise>
     							<input type="hidden" name="b_idx" value="${cbvo.b_idx}">
     							<input type="hidden" value="${cPage}" name="cPage">
     							<input class="contentBtn" type="button" value="목록" onclick="comm_board_list(this.form)" />
     						</c:otherwise>
     					</c:choose>
     				</c:otherwise>
     			</c:choose>
     		</c:otherwise>
     	</c:choose>
     </td>
	</tr>
	</tfoot>
	</table>
	</form>
</div>
<c:choose>
	<c:when test="${memberInfo.member_id == 'admin'}">
	<%-- 댓글 입력 --%>
		<div class="reply-function">
			<form method="post">
				<fieldset>
					<p>별명 : <input type="hidden" name="member_nickname" value="${memberInfo.member_nickname}">
								${memberInfo.member_nickname}
					</p>
					<p>내용 : <textarea rows="3" cols="40" name="content"></textarea>
					<input style="margin-left: 20px" type="button" value="댓글저장" onclick="comment_insert(this.form)">
					</p>
					<!-- 댓글 저장시 어떤 원글의 댓글인지 저장해야 한다. -->
					<input type="hidden" name ="b_idx" value="${cbvo.b_idx}" >
					<input type="hidden" value="${cPage}" name="cPage">
				</fieldset>
			</form>
		</div>
		
		
		
		
		
		
		




		
		
		
		
		
<%-- 댓글 출력 --%>
<div class="reply-output">
    <c:forEach var="k" items="${commBoard_list2}">
        <div class="reply-output2">
            <form method="post">
                <span>별명 : ${k.member_nickname}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                <span>날짜 : ${k.write_date.substring(0,10)}</span>
                <p>${k.content}</p>
                <c:forEach begin="1" end="${k.step}">&nbsp;[Re]</c:forEach>
                
                
                <div class="reply-output3">
                
                </div>
        
                <!-- 답글의 답글 입력창 -->
                <textarea rows="3" cols="40" name="content" placeholder="답글을 입력하세요!"></textarea>
                <!-- <input type="button" value="답글 작성" onclick="reply_reply_insert(this.form)"> <hr> --><hr>
                
                <input type="button" value="댓글삭제" onclick="comment_delete(this.form)">
                <input type="button" id="updateGo" value="댓글수정" onclick="comment_update(this.form)">
                <input type="button" value="답글답글" onclick="comment_reply_insert(this.form)">
                <input type="hidden" value="${cPage}" name="cPage">
                <input type="hidden" name="c_idx" value="${k.c_idx}">
                <input type="hidden" name="b_idx" value="${k.b_idx}">
            </form>
        </div>
    </c:forEach>
</div>







	</c:when>
	<c:otherwise>
		<c:choose>
			<%-- 댓글 입력 --%>
			<c:when test="${memberInfo.member_nickname != null}">
				<div class="reply-function">
					<form method="post">
						<fieldset>
							<p>별명 : <input type="hidden" name="member_nickname" value="${memberInfo.member_nickname}">
									${memberInfo.member_nickname}
							</p>
							<p>내용 <textarea rows="3" cols="40" name="content"></textarea>
							<input style="margin-left: 20px" type="button" value="댓글저장" onclick="comment_insert(this.form)"></p>
							<!-- 댓글 저장시 어떤 원글의 댓글인지 저장해야 한다. -->
							<input type="hidden" name ="b_idx" value="${cbvo.b_idx}" >
							<input type="hidden" value="${cPage}" name="cPage">
						</fieldset>
					</form>
				</div>
				
				
				<%-- 회원 댓글 출력 --%>
				<div class="reply-output">
					<c:forEach var="k" items="${commBoard_list2}">
						<div class="reply-output2" >
							<form method="post">
								<span>별명 : ${k.member_nickname}</span> &nbsp;&nbsp;&nbsp;&nbsp;
								<span>날짜 : ${k.write_date.substring(0,10)}</span>
								<p>${k.content}</p>
								
								  <c:forEach begin="1" end="${k.step}">&nbsp;[Re]</c:forEach>
								<c:choose>
									<c:when test="${memberInfo.member_nickname != k.member_nickname}">
									 	<!-- 답글의 답글 입력창 -->
                						<textarea rows="3" cols="40" name="content" placeholder="답글을 입력하세요"></textarea><hr>
										<input type="button" value="답글답글" onclick="comment_reply_insert(this.form)">
										<input type="hidden" value="${cPage}" name="cPage">
						                <input type="hidden" name="c_idx" value="${k.c_idx}">
						                <input type="hidden" name="b_idx" value="${k.b_idx}">
					
									</c:when>
									<c:otherwise>
								  		<!-- 답글의 답글 입력창 -->
						                <textarea rows="3" cols="40" name="content" placeholder="답글을 입력하세요!"></textarea>
						                <!-- <input type="button" value="답글 작성" onclick="reply_reply_insert(this.form)"> <hr> --><hr>
						                
						                <input type="button" value="댓글삭제" onclick="comment_delete(this.form)">
						                <input type="button" id="updateGo" value="댓글수정" onclick="comment_update(this.form)">
						                <input type="button" value="답글답글" onclick="comment_reply_insert(this.form)"> 
						                <input type="hidden" value="${cPage}" name="cPage">
						                <input type="hidden" name="c_idx" value="${k.c_idx}">
						                <input type="hidden" name="b_idx" value="${k.b_idx}">
									</c:otherwise>
								</c:choose>
							</form>
						</div>
					</c:forEach>
				</div>	    
			</c:when>
			<c:otherwise>
				<%-- 비회원 댓글만 보이게 하는 코드 --%>
				<div class="reply-output">
					<c:forEach var="k" items="${commBoard_list2}">
						<div class="reply-output2">
							<form method="post">
								<span>별명 : ${k.member_nickname}</span>&nbsp;&nbsp;&nbsp;&nbsp;
								<span>날짜 : ${k.write_date.substring(0,10)}</span>
								<p>${k.content}</p>
								<!-- <input type="button" value="댓글삭제" onclick="comment_delete(this.form)"> -->
								<input type="hidden" value="${cPage}" name="cPage">
								<input type="hidden" name ="c_idx" value="${k.c_idx}" >
								<input type="hidden" name ="b_idx" value="${k.b_idx}" >
							</form>
						</div>
					</c:forEach>
				</div>	
			</c:otherwise>
		</c:choose>	
	</c:otherwise>
</c:choose>
</body>
</html>