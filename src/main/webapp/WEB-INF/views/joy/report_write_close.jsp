<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>신고가 성공적으로 처리되었습니다</title>
    <!-- 여기에 필요한 스타일이나 스크립트를 추가할 수 있습니다 -->
</head>
<style>
div{margin: 0 auto;
width: 600px;
text-align: center
}
h1{
margin-top: 300px;
}
</style>
<body>
<div>
    <h1>신고가 성공적으로 처리되었습니다</h1>
    <p>3초 뒤에 자동으로 창이 닫힙니다.</p>
</div>
    <!-- 원하는 내용을 추가할 수 있습니다 -->
    <script>
        // 신고가 성공적으로 처리되었을 때 추가적인 스크립트를 실행할 수 있습니다
        // 예를 들어, 일정 시간이 지난 후 창을 닫거나 다른 동작을 수행할 수 있습니다
        setTimeout(function() {
            window.close();
        }, 3000); // 3초 후에 창을 닫음
    </script>
</body>
</html>