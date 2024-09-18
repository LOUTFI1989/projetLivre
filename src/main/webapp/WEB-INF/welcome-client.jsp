<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <c:set var="loc" value="fr_FR"/>

    <c:if test="${!(empty param.locale)}">
        <c:set var="loc" value="${param.locale}"/>
    </c:if>
    <fmt:setLocale value="${loc}" />
    <fmt:bundle basename="messages">
    <title><fmt:message key="welcome.title" /></title>
</head>
<body>

<h2><fmt:message key="welcome2.message" /> ${user}!</h2>

<h1><fmt:message key="book.list.title" /></h1>
<form name="shoppingForm" action="shop" method="post">
    <!-- Conserve la locale dans le formulaire -->
    <input type="hidden" name="locale" value="${loc}">
    <c:choose>
        <c:when test="${not empty books}">
            <table class="table2">
                <thead>
                <tr>
                    <th><fmt:message key="book.title" /></th>
                    <th><fmt:message key="book.author" /></th>
                    <th><fmt:message key="book.genre" /></th>
                    <th><fmt:message key="book.price" /></th>
                    <th><fmt:message key="book.quantity" /></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="book" items="${books}">
                    <tr>
                        <td>${book.title}</td>
                        <td>${book.author}</td>
                        <td>${book.genre}</td>
                        <td>${book.price}</td>
                        <td>
                            <form action="shop" method="post" class="form2">
                                <input type="hidden" name="locale" value="${loc}">
                                <input type="hidden" name="bookId" value="${book.id}">
                                <input type="text" name="qty_${book.id}" size="3" value="1">
                                <input  type="submit" name="action" value="+">
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p><fmt:message key="book.notfound" /></p>
        </c:otherwise>
    </c:choose>
</form>
<jsp:include page="panier.jsp"/>
<a href="${pageContext.request.contextPath}/logout"><fmt:message key="logout" /></a>
</fmt:bundle>
</body>
</html>
