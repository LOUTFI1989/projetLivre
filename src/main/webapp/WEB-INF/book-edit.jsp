<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setBundle basename="messages"/>
<!DOCTYPE html>
<html lang="${pageContext.request.locale.language}">
<head>

    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <c:set var="loc" value="fr_FR"/>

    <c:if test="${!(empty param.locale)}">
        <c:set var="loc" value="${param.locale}"/>
    </c:if>
    <fmt:setLocale value="${loc}" />
    <fmt:bundle basename="messages">
    <title><fmt:message key="bookForm.title"/></title>
    <script type="text/javascript">
        function validateForm() {
            let title = document.forms["bookForm"]["title"].value;
            let author = document.forms["bookForm"]["author"].value;
            let genre = document.forms["bookForm"]["genre"].value;
            let price = document.forms["bookForm"]["price"].value;

            if (title == "" || author == "" || genre == "" || price == "") {
                alert("All fields must be filled out");
                return false;
            }
            if (isNaN(price) || parseFloat(price) <= 0) {
                alert("Price must be a positive number");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>

<h1><fmt:message key="bookForm.title"/></h1>
<form class="form2" name="bookForm" action="books?action=update" method="post" onsubmit="return validateForm()">
    <!-- Conserve la locale dans le formulaire -->
    <input type="hidden" name="locale" value="${loc}">
    <input type="hidden" name="id" value="${book.id}">
    <div>
        <label for="title"><fmt:message key="bookForm.title.label"/></label>
        <input type="text" id="title" name="title" value="${book.title}">
    </div>
    <div>
        <label for="author"><fmt:message key="bookForm.author.label"/></label>
        <input type="text" id="author" name="author" value="${book.author}">
    </div>
    <div>
        <label for="genre"><fmt:message key="bookForm.genre.label"/></label>
        <input type="text" id="genre" name="genre" value="${book.genre}">
    </div>
    <div>
        <label for="price"><fmt:message key="bookForm.price.label"/></label>
        <input type="text" id="price" name="price" value="${book.price}">
    </div>
    <div>
        <input type="submit" value="<fmt:message key="bookForm.submit"/>">
    </div>
</form>
</fmt:bundle>
</body>
</html>
