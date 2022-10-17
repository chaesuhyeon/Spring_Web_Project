<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8 ">
    <title>Insert title here</title>
</head>
<body>
<%--  all  --%>
<h1>/sample/all page</h1>

<sec:authorize access="isAnonymous()"> <!-- 익명의 사용자의 경우(로그인을 하지 않은 경우도 해당) -->
    <a href="/customLogin">로그인</a>
</sec:authorize>

<sec:authorize access="isAuthenticated()"> <!-- 인증된 사용자면 true -->
    <a href="/customLogout">로그아웃</a>
</sec:authorize>
</body>
</html>
