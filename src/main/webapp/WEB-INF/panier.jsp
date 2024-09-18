<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title><fmt:message key="cart.title"/></title>
</head>
<body>

<h2><fmt:message key="cart.header"/> ${user}!</h2>
<c:choose>
    <c:when test="${not empty sessionScope.shoppingcart and sessionScope.shoppingcart.size() > 0}">
        <center>
            <table border="0" cellpadding="0" width="100%" bgcolor="#FFFFFF">
                <tr>
                    <td><b><fmt:message key="cart.title"/></b></td>
                    <td><b><fmt:message key="cart.author"/></b></td>
                    <td><b><fmt:message key="cart.genre"/></b></td>
                    <td><b><fmt:message key="cart.price"/></b></td>
                    <td><b><fmt:message key="cart.quantity"/></b></td>
                    <td></td>
                </tr>
                <c:forEach var="aBook" items="${sessionScope.shoppingcart}" varStatus="status">
                    <tr>
                        <td><b>${aBook.title}</b></td>
                        <td><b>${aBook.author}</b></td>
                        <td><b>${aBook.genre}</b></td>
                        <td><b>${aBook.price}</b></td>
                        <td><b>${aBook.quantity}</b></td>
                        <td>
                            <form name="deleteForm" action="shop" method="POST">
                                <input type="hidden" name="locale" value="${loc}">
                                <input class="supp" type="submit" name="action" value="-">
                                <input type="hidden" name="delindex" value="${status.index}">
                                <input type="hidden" name="action" value="DELETE">
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <p>
            <form name="checkoutForm" action="shop" method="POST">
                <input type="hidden" name="locale" value="${loc}">
                <input type="hidden" name="action" value="CHECKOUT">
                <input type="submit" name="Checkout" value="<fmt:message key='cart.checkout'/>">
            </form>
        </center>

    </c:when>
    <c:otherwise>
        <center>
            <p><fmt:message key="cart.empty"/></p>
        </center>
    </c:otherwise>
</c:choose>
    </fmt:bundle >
</body>
</html>
