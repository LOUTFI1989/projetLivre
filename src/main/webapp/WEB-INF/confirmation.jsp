<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <!-- Gestion de la locale -->
    <c:set var="loc" value="${sessionScope.locale != null ? sessionScope.locale : 'fr_FR'}"/>
    <c:if test="${!(empty param.locale)}">
        <c:set var="loc" value="${param.locale}"/>
    </c:if>
    <fmt:setLocale value="${loc}" />

    <fmt:bundle basename="messages">
    <title><fmt:message key="title.confirmation"/></title>
</head>
<body>

    <h1><fmt:message key="header.thankYou"/> ${user}!</h1>

    <p><fmt:message key="order.confirmation"/></p>

    <table>
        <thead>
        <tr>
            <th><fmt:message key="table.title"/></th>
            <th><fmt:message key="table.author"/></th>
            <th><fmt:message key="table.genre"/></th>
            <th><fmt:message key="table.price"/></th>
            <th><fmt:message key="table.quantity"/></th>
            <th><fmt:message key="table.subtotal"/></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="book" items="${shoppingcart}">
            <tr>
                <td>${book.title}</td>
                <td>${book.author}</td>
                <td>${book.genre}</td>
                <td>${book.price} $</td>
                <td>${book.quantity}</td>
                <td>${book.price * book.quantity} $</td>
            </tr>
        </c:forEach>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="5" style="text-align:right;"><strong><fmt:message key="table.total"/>:</strong></td>
            <td><strong>${amount} $</strong></td>
        </tr>
        </tfoot>
    </table>

    <p><fmt:message key="order.processing"/></p>
    <a href="Test"><fmt:message key="cart.pdf"/></a>
    <a href="${pageContext.request.contextPath}/logout"><fmt:message key="logout"/></a>
</fmt:bundle>
</body>
</html>
