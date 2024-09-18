<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
    <title><fmt:message key="login.page.title"/></title>

</head>
<body>

<form action="login" method="post" class="form2">

    <h2><fmt:message key="login.header"/></h2>


        <div>
            <label for="username"><fmt:message key="login.username"/></label>
            <input type="text" id="username" name="username" required>
        </div>
        <div>
            <label for="password"><fmt:message key="login.password"/></label>
            <input type="password" id="password" name="password" required>
        </div>
        <div>
            <input type="submit" value="<fmt:message key="login.button"/>">
        </div>
        <input type="hidden" name="locale" value="${loc}"/>


</form>
    <c:if test="${not empty errorMessage}">
        <div style="color: red;">
            <p>${errorMessage}</p>
        </div>
    </c:if>
</fmt:bundle>
</body>
</html>
