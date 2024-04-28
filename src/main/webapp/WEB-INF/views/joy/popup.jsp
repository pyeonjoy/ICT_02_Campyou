 <!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>회원관리 상세</title>
<style>
body{
    background-color: #F6FFF1;
}
.head{
    text-align: center;
    margin: 100px;;
}
.wrap {
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-gap: 10px;
    margin: 0 auto;
    padding: 10px;
    height: 100px;
    width: 1000px;
}
.proimg{
    width: 100px;
    height: 100px;
    margin: 30px auto;
    border-radius: 100%;
    background-color: gainsboro;
}
.left {
    width: 200px;
    height: 200px;
}
.right {
    width: 700px;
    height: 900px;
}
table {
    width: 100%;
    border-top: 1px solid #032805;
    border-collapse: collapse;
}
th, td {
    border-bottom: 1px solid #032805;
    padding: 10px;
    text-align: center;
    width: 100%;
}
th {
    background-color: #032805;
    color: white;
}

.b1 button{
    margin-top: 20px;
    width: 100px;
    height: 30px;
    background-color: #032805;
    color: white;
    border: 0px;
    border-radius: 3px;
    margin: 0 auto;
}
.b2{
    width: 415px;
    margin: 0 auto;
}
.b2 button{
    margin-top: 20px;
    width: 100px;
    height: 30px;
    background-color: #032805;
    color: white;
    border: 0px;
    border-radius: 3px;
    text-align: center;
}
.under{
    margin-top: 200px;
    width: 1000px;
    margin: 200px auto;
}
.top button{
    margin-top: 20px;
    width: 467px;
    height: 50px;
    background-color: #F6FFF1;
    border: 1px solid black;
    border-radius: 3px;
    margin: 15px;
}
</style>
</head>
<body>
    <h2 class="head">회원 관리 상세</h2>
    <p style="text-align: center;">회원 상세 정보</p>
    <div class="wrap">
        <div class="left">
            <div class="proimg"></div>
            <div style="margin: auto; width: 100px;">
                <p style="text-align: center;">
                    <div class="b1"><button>이미지 삭제</button></div>
                </p>
            </div>
        </div>
        <div class="right">
            <table style = "table-layout: auto; width: 100%; table-layout: fixed;">
                <tr>
                    <th>NO</th>
                    <th>ID</th>
                    <th>이름</th>
                    <th>닉네임</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>조이</td>
                    <td>편조이</td>
                    <td>이조</td>
                </tr>


                <tr>
                    <th>가입일</th>
                    <th>생년월일</th>
                    <th>전화번호</th>
                    <th>이메일</th>
                </tr>
                <tr>
                    <td>2024-02-02</td>
                    <td>1997-01-10</td>
                    <td>010-6800-4220</td>
                    <td>ppee@naver.com</td>
                </tr>
            
                
            <tr>
                <th>일반가입</th>
                <th>SNS</th>
                <th>신고</th>
                <th>상태</th>
            </tr>
            <tr>
                <td>X</td>
                <td>카카오</td>
                <td>3회</td>
                <td>종지</td>
            </tr>
        </table>
        </div>
    </div>
        <div class="under">
            <p style="text-align: center;">작성한글</p>
            <div class="top">
                <button>자유게시판</button>
                <button>캠핑제품추천</button>
            </div>
            <table style = "table-layout: auto; width: 100%; table-layout: fixed;">
                <tr>
                    <th>선택</th>
                    <th>번호</th>
                    <th>유형</th>
                    <th>제목</th>
                    <th>닉네임</th>
                    <th>작성일</th>
                    <th>조회수</th>
                    <th>상태</th>
                </tr>
                <tr>
                    <td><input type="checkbox"></td>
                    <td>1</td>
                    <td>유머글</td>
                    <td>게시판작성기준</td>
                    <td>닉네임</td>
                    <td>2024-04-04</td>
                    <td>34</td>
                    <td>게시중</td>
                </tr>
            </table>
            <div class="b2" >
            <button>회원정지</button>
            <button>회원수정</button>
            <button>회원삭제</button>
            <button>선택해제</button>
            </div>
        </div>
    </body>
    </html>
