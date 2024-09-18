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
    <title><fmt:message key="checkoutTitle"/></title>
</head>
<body class="home-page">

<h1><fmt:message key="checkoutTitle"/></h1>

<c:choose>
    <c:when test="${not empty shoppingcart}">
        <table>
            <thead>
            <tr>
                <th><fmt:message key="title2"/></th>
                <th><fmt:message key="author"/></th>
                <th><fmt:message key="quantity"/></th>
                <th><fmt:message key="unitPrice"/></th>
                <th><fmt:message key="total"/></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="book" items="${shoppingcart}">
                <tr>
                    <td>${book.title}</td>
                    <td>${book.author}</td>
                    <td>${book.quantity}</td>
                    <td>${book.price} $</td>
                    <td>${book.price * book.quantity} $</td>
                </tr>
            </c:forEach>
            </tbody>
            <tfoot>
            <tr>
                <td colspan="4" style="text-align:right;"><strong><fmt:message key="totalAmount"/>:</strong></td>
                <td><strong>${amount} $</strong></td>
            </tr>
            </tfoot>
        </table>
    </c:when>
    <c:otherwise>
        <p><fmt:message key="emptyCart"/></p>
    </c:otherwise>
</c:choose>

<form action="panier?action=confirm" method="post">
    <input type="hidden" name="locale" value="${loc}">
    <input type="submit" value="<fmt:message key="confirmOrder"/>">
</form>
<a href="shop?action=Continuer"><fmt:message key="continueShopping"/></a>

</fmt:bundle >
</body>
</html>
