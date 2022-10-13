<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8 ">
    <title>Insert title here</title>
</head>
<body>
<%--  admin  --%>
<h1>/sample/admin page</h1>
<p>principal : <sec:authentication property="principal"/></p> <!-- UserDetailsService에서 반환된 객체. 즉 customUserDetailsService를 이용했다면 loadUserByUsername()에서 반환된 CustomUser 객체 -->
<%-- principal : org.zerock.domain.CustomUser@bc1272a6: Username: admin90; Password: [PROTECTED]; Enabled: true; AccountNonExpired: true; credentialsNonExpired: true; AccountNonLocked: true; Granted Authorities: ROLE_ADMIN --%>

<p>MemberVO : <sec:authentication property="principal.member"/></p> <!-- CustomUser의 getMember()를 호출 -->
<%-- MemberVO : MemberVO(userid=admin90, userpw=$2a$10$OktbYAraJx7WbTzinNaHC.J3/o3iJArDo/TOTTgFl3wwH72KgY/PK, userName=관리자90, enabled=false, regDate=Wed Oct 12 09:00:30 KST 2022, updateDate=Wed Oct 12 09:00:30 KST 2022, authList=[AuthVO(userid=admin90, auth=ROLE_ADMIN)]) --%>

<p>사용자 이름 : <sec:authentication property="principal.member.userName"/></p>
<%-- 사용자 이름 : 관리자90 --%>

<p>사용자 아이디 : <sec:authentication property="principal.username"/></p>
<%-- 사용자 아이디 : admin90 --%>

<p>사용자 권한 리스트 : <sec:authentication property="principal.member.authList"/></p>
<%-- 사용자 권한 리스트 : [AuthVO(userid=admin90, auth=ROLE_ADMIN)] --%>

<a href="/customLogout">Logout</a>
</body>
</html>