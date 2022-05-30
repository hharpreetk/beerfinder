<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Beer Detail</title>
<link rel='stylesheet'
	href='webjars/bootstrap/5.1.3/css/bootstrap.min.css'>
<link rel="stylesheet" type="text/css" href="css/custom.css">
<script type='text/javascript'
	src='webjars/bootstrap/5.1.3/js/bootstrap.min.js'></script>
</head>
<body class="d-flex flex-column h-100">
	<!-- Navigation -->
	<header class="p-3 bg-dark text-white">
		<div class="container">
			<div
				class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
				<a href="#"
					class="d-flex align-items-center mx-2 mb-2 mb-lg-0 text-white text-decoration-none">
					<img src="resources/images/beer-icon.svg" width="45" height="45">
				</a>
				<ul
					class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
					<li><a href="index.html" class="nav-link px-2 text-white">Home</a></li>
					<li><a href="#" class="nav-link px-2 text-white">Features</a></li>
					<li><a href="#" class="nav-link px-2 text-secondary">About</a></li>
				</ul>

				<form class="d-none d-md-block col-12 col-lg-auto me-lg-3">
					<div class="input-group">
						<input type="text" class="form-control"
							placeholder="Search for Beer" aria-label="Beer"
							autocomplete="off" id="beer_name" name="beer_name" required>
						<button class="input-group-text btn-warning" id="submitButton"
							type="submit">Search</button>
					</div>
				</form>

			</div>
		</div>
	</header>
	<main>
		<div class="container py-4">
			<c:forEach var="beerArr" items="${beer_info}">
				<div>
					<div class="row justify-content-center">
						<div class="col-auto col-lg-3 col-md-4 my-md-4 d-flex flex-column">
							<c:choose>
								<c:when test="${empty beerArr.getImageUrl()}">
									<img style="object-fit: scale-down; max-height: 500px;"
										src="resources/images/default_beer.png"
										alt="${beerArr.getName()}">
								</c:when>
								<c:otherwise>
									<img style="object-fit: scale-down; max-height: 500px;"
										src="${beerArr.getImageUrl()}" alt="${beerArr.getName()}">
								</c:otherwise>
							</c:choose>
						</div>
						<div class="col-auto col-lg-9 col-md-8 my-md-4 d-flex flex-column">
							<h1>${beerArr.getName()}</h1>
							<p>${beerArr.getTagline()}</p>
							<p>
								<span>${beerArr.getAbv()} ABV</span>
							</p>
							<p>
								<span>${beerArr.getIbu()} IBU</span>
							</p>
							<p>
								<span>${beerArr.getSrm()} SRM</span>
							</p>
							<h3>About ${beerArr.getName()}</h3>
							<p>${beerArr.getDescription()}</p>
							<p>
								Pairs with
								<c:forEach var="foodPairing" items="${beerArr.getFoodPairing()}">
									<c:out value="• ${foodPairing}" />
								</c:forEach>
							<p>
						</div>
					</div>
				</div>
				<div class="card">
					<div class="card-header">
						<h2>Brew Sheet</h2>
					</div>
					<div class="card-body">
						<div class="card-title">
							<h3>Ingredients</h3>
						</div>
						<div class="card-text">
							<p>
								Hops:
								<c:forEach var="hop"
									items="${beerArr.getIngredients().getHops()}">
									<c:out value="• ${hop.getName()}" />
								</c:forEach>
							</p>
							<p>
								Malts:
								<c:forEach var="malt"
									items="${beerArr.getIngredients().getMalt()}">
									<c:out value="• ${malt.getName()}" />
								</c:forEach>
							</p>
							<p>
								Yeast:
								<c:out value="${beerArr.getIngredients().getYeast()}" />
							</p>
							<p>Water: Varies</p>
						</div>

						<hr />

						<div class="card-title">
							<h3>Brewer Tips</h3>
						</div>
						<div class="card-text">
							<p>${beerArr.getBrewersTips()}</p>
						</div>
					</div>

				</div>
			</c:forEach>
		</div>
	</main>
	<footer class="footer mt-auto py-3 bg-light text-center">
		<div class="container">
			<p>
				Created by <a href="https://github.com/hharpreetk">harpreetk</a>
			</p>
			<p>
				<a href="#">Back to top</a>
			</p>
		</div>
	</footer>
</body>
</html>