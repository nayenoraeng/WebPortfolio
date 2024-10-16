<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>화장실 수정</title>
</head>
<body>
    <h1>화장실 수정</h1>
    <form action="${pageContext.request.contextPath}/member/edit/${restMap.id}" method="post">
        <label for="pname">이름:</label>
        <input type="text" id="pname" name="pname" value="${restMap.pname}" required><br>
        
        <label for="x_wgs84">위도:</label>
        <input type="text" id="x_wgs84" name="x_wgs84" value="${restMap.x_wgs84}" required><br>
        
        <label for="y_wgs84">경도:</label>
        <input type="text" id="y_wgs84" name="y_wgs84" value="${restMap.y_wgs84}" required><br>
        
        <button type="submit">수정</button>
    </form>
        <a href="${pageContext.request.contextPath}/member/list">목록으로 돌아가기</a>
    
</body>
</html>