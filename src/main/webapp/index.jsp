<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <c:set var="loc" value="fr_FR"/>

    <c:if test="${!(empty param.locale)}">
        <c:set var="loc" value="${param.locale}"/>
    </c:if>
    <fmt:setLocale value="${loc}" />
    <fmt:bundle basename="messages">
    <title><fmt:message key="title"/></title>
</head>
<body>
    <h1><fmt:message key="welcome.message"/></h1>
    <h2><fmt:message key="welcome.message2"/></h2>
    <input type="hidden" name="locale" value="${loc}"/>
    <div class="btnLangue-container">
        <a class="btnLangue" href="login.jsp?locale=fr_FR"><fmt:message key="language.switch.fr"/></a>
        <a class="btnLangue" href="login.jsp?locale=en_US"><fmt:message key="language.switch.en"/></a>
    </div>
    <br>
</fmt:bundle>
</body>
</html>
