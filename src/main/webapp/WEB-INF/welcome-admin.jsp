<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <!-- Gestion de la locale -->
    <c:set var="loc" value="${sessionScope.locale != null ? sessionScope.locale : 'fr_FR'}"/>
    <c:if test="${!(empty param.locale)}">
        <c:set var="loc" value="${param.locale}"/>
    </c:if>
    <fmt:setLocale value="${loc}" />
    <fmt:bundle basename="messages">
    <title><fmt:message key="welcome"/></title>
</head>
<body>

<h2><fmt:message key="welcome"/> ${user}!</h2>

<h1><fmt:message key="listBooks"/></h1>
<c:choose>
    <c:when test="${not empty books}">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th><fmt:message key="title"/></th>
                <th><fmt:message key="author"/></th>
                <th><fmt:message key="genre"/></th>
                <th><fmt:message key="price"/></th>
                <th><fmt:message key="actions"/></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="book" items="${books}">
                <tr>
                    <td>${book.id}</td>
                    <td>${book.title}</td>
                    <td>${book.author}</td>
                    <td>${book.genre}</td>
                    <td>${book.price}</td>
                    <td>
                        <input type="hidden" name="locale" value="${loc}"/>
                        <a href="books?action=edit&id=${book.id}"><fmt:message key="edit"/></a>
                        <a class="supp" href="books?action=delete&id=${book.id}" onclick="return confirm('<fmt:message key="confirmDelete"/>')"><fmt:message key="delete"/></a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <p><fmt:message key="noBooksFound"/></p>
    </c:otherwise>
</c:choose>
<a href="books?action=new"><fmt:message key="addNewBook"/></a>
<a href="${pageContext.request.contextPath}/logout"><fmt:message key="logout"/></a>
</fmt:bundle>
</body>
</html>
