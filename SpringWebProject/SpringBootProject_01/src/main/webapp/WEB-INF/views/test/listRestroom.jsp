<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>화장실 목록</title>
</head>
<body>
    <h1>화장실 목록</h1>
    <table border="1">
        <thead>
            <tr>
                <th>이름</th>
                <th>위도</th>
                <th>경도</th>
                <th>작업</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="restMap" items="${restrooms}">
                <tr>
                    <td>${restMap.pname}</td>
                    <td>${restMap.x_wgs84}</td>
                    <td>${restMap.y_wgs84}</td>
                    <td>
               			<a href="${pageContext.request.contextPath}/member/edit/${restMap.id}">수정</a>
                        <a href="${pageContext.request.contextPath}/member/delete/${restMap.id}" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <a href="${pageContext.request.contextPath}/member/add">화장실 추가</a>
</body>
</html>