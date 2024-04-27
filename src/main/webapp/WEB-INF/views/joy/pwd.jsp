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
</head>
<body>
    <h2 class="head">비밀번호 변경</h2>
    <div class="wrap">
        <div class="pwd">
            <p>비밀번호
                <input type="text">
            </p>
        </div>
        <div class="pwd">
        <p>비밀번호 확인
            <input type="text">
        </p>
        </div>
        <p class="pb">
            <button>비밀번호변경</button>
            <button>뒤로가기</button>
        </p>
    </div>
</body>
</html>
