<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>관리자 페이지 메인</title>
<style>
    body{
    background-color: #F6FFF1;
}
.head{
    text-align: center;
    margin: 100px;;
}
.wrap{
    margin: auto;
    width: 500px;
}

.pwd{
    width: 340px;
    text-align: right;
}
.pb{
    width: 200px;
    margin: 0 auto;
}
.pb>button{
    margin-top: 20px;
    height: 30px;
    background-color: #032805;
    color: white;
    border: 0px;
    border-radius: 3px;
}
</style>
<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	$(".check_btn").on("keyup",function(key){
		   	let pwdchk = "${user_pwd}";
	        if (key.keyCode == 13) {
        }
    });
});
	</script>
</head>
<body>
    <h2 class="head">비밀번호 변경</h2>
    <div class="wrap">
    <form method="post" action="admin_pwd_ok.do">
        <div class="pwd">
            <p>새비밀번호
                <input type="password" id="password" name="member_pwd" placeholder="비밀번호를 입력하세요">
            </p>
        </div>
        <div class="pwd">
        <p>비밀번호 확인
            <input class="pwd_box" type="password" id="password" name="member_pwd" placeholder="비밀번호를 입력하세요">
        </p>
        </div>
        <p class="pb">
            <input class="check_btn" type="submit" value="비밀번호변경">
            <button onclick="location.href='admin_main.do'">취소</button>
        </p>
        </form>
    </div>
</body>
</html>
