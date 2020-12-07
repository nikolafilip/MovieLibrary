<%@page import="CRUD.AddMovie"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%

	String movie_title = request.getParameter("movie_title");
	String movie_price = request.getParameter("movie_price");	
	AddMovie.insertMovie(movie_title, Float.parseFloat(movie_price));
%>

<script type="text/javascript">

window.location.href="http://localhost:8080/MovieLibrary/";

</script>

</body>
</html>