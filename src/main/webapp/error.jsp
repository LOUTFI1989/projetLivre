<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="${pageContext.request.locale.language}">
<head>
    <meta charset="UTF-8">
    <title><fmt:message key="error.title"/></title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<h1><fmt:message key="error.title"/></h1>
<p><fmt:message key="error.message"/></p>
<a href="index.jsp"><fmt:message key="error.backToHome"/></a>
</body>
</html>
