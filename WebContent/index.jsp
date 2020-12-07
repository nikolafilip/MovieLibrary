<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="CRUD.GetMovies" %>
<!DOCTYPE html>

<html>

<head>
    <title>Movie Library</title>
    <meta name="author" content="Nikola Filip">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/main.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" type="text/javascript"></script>
    <%
    	String basketJSON = GetMovies.listMovies();
    %>
    <script type="text/javascript">

    	//Function that renders the basket
    	function showBasket() {
    	    var basket = <%=basketJSON%>;
			
    	    var movieTable = document.getElementById("movie-table");

    	    //Checks if anything is already in the table, if yes then it's deleted
    	    while (movieTable.rows.length > 0) {
    	        movieTable.deleteRow(0);
    	    }

    	    var totalPrice = 0;
    	    var discount = 0;

    	    //Iterate movies in the basket, create table and populate it with values
    	    for (var product in basket) {
    	        var row = movieTable.insertRow();
    	        var cellID = row.insertCell(0);
    	        var cellTitle = row.insertCell(1);
    	        var cellPrice = row.insertCell(2);
                cellID.width = "20%";
                cellID.style.padding = "20px";
                cellTitle.width = "40%";
                cellPrice.width = "40%";
    	        cellID.innerHTML = basket[product].ID;
    	        cellTitle.innerHTML = basket[product].Title;
    	        cellPrice.innerHTML = basket[product].Price;
    	        totalPrice += basket[product].Price;
    	    }


    	    //Show sum, discount and total
    	    document.getElementById("basket-sum").innerHTML = totalPrice.toFixed(2) + " USD";
    	    if (movieTable.rows.length > 1) {
    	        discount = totalPrice * 0.05;
    	        document.getElementById("basket-discount").innerHTML = "-" + discount.toFixed(2) + " USD";
    	    }
    	    document.getElementById("basket-total").innerHTML = (totalPrice - discount).toFixed(2) + " USD";
    	}
    	
    	//Validation
    	$(document).on("click", "#add-movie", function(e) {
    	    e.preventDefault();
    	    var result = isValidForm();
    	    if (result == "true") {
    	        $("#formAddMovie").submit();
    	    } else {
    	        document.getElementById("errorMsg").innerHTML = result;
    	    }
    	});

    	function isValidForm() {
    		var movieTitleNotFilled = $.trim($("#movie-title").val()) == "";
    		var moviePriceNotFilled = $.trim($("#movie-price").val()) == "";
    		if (movieTitleNotFilled && moviePriceNotFilled) {
    	    	document.getElementById("movie-title").style.borderColor = 'red';
    	    	document.getElementById("movie-price").style.borderColor = 'red';
				return "Enter movie title and price.";
    		}
    	    if (movieTitleNotFilled) {
    	    	document.getElementById("movie-price").style.borderColor = 'lightgray';
    	    	document.getElementById("movie-title").style.borderColor = 'red';
    	        return "Enter movie title.";
    	    }
    	    if (moviePriceNotFilled) {
    	    	document.getElementById("movie-title").style.borderColor = 'lightgray';
    	    	document.getElementById("movie-price").style.borderColor = 'red';
    	        return "Enter price.";
    	    }
    	    return "true";
    	}
	</script>
</head>

<body onload="showBasket()">

    <div class="container">
        <div class="text-center">
            <h1>Movie Library</h1>
        </div>

        <!-- Input for adding new movies -->
        <form action="controller/insert_controller.jsp" id="formAddMovie">
            <div class="row">
                <div class="col-lg-5 col-sm-12">
                    <input name="movie_title" id="movie-title" type="text" placeholder="Movie Title">
                </div>
                <div class="col-lg-5 col-sm-12">
                    <div class="price-wrapper">
                        <input name="movie_price" id="movie-price" type="number" min="0" placeholder="Price">
                        <div class="usd">USD</div>
                    </div>
                </div>
                <div class="col-lg-2 col-sm-12">
                    <input id="add-movie" type="submit" value="Add movie">
                </div>
            </div>
            <div class="row">
            	<div class="col-lg-12 col-sm-12">
            		<span id="errorMsg"></span>
            	</div>
            </div>
        </form>

        <!--Basket table-->
        <div class="row">
            <div class="col-12">
                <div class="basket">
                    <div class="basket-head">
                        <table>
                            <thead>
                                <tr>
                                    <th class="column1">#</th>
                                    <th class="column2">Movie Title</th>
                                    <th class="column3">Price</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="basket-body">
                        <table>
                            <tbody id="movie-table">
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!--Sum, discount and total-->
        <div class="row">
            <div class="col-7"></div>
            <div class="col-lg-5 col-sm-12 sum-wrapper">
                <div class="total">
                    <label>Sum: </label>
                    <div class="total-value" id="basket-sum"></div>
                </div>
                <div class="total red">
                    <label>Discount: </label>
                    <div class="total-value" id="basket-discount"></div>
                </div>
                <div class="total">
                    <div class="upper-border">
                        <label>Total: </label>
                        <div class="total-value" id="basket-total"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>