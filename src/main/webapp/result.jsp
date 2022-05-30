<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Beer Search</title>
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
	<!-- Begin page content -->
	<main class="flex-shrink-0">
		<!-- Hero Section  -->
		<div class="container py-4">
			<div class="p-5 mb-4 bg-light rounded-0">
				<div>
					<h1 class="display-5 fw-bold">Beer Search</h1>
					<p class="col-md-8 fs-4">Looking for a beer? We can help.</p>
					<form method="GET" action="GetBeer.do">
						<div class="input-group mb-3">
							<input type="text" class="form-control form-control-lg"
								placeholder="Search for Beer" aria-label="Beer"
								autocomplete="off" id="beer_name" name="beer_name" required>
							<button class="input-group-text btn-warning btn-lg"
								id="submitButton" type="submit">Search</button>
						</div>
					</form>
				</div>
				<div class="container">
					<div class="filter-row row" style="max-width: 700px;">
						<div class="filter-col col py-2">
							<div class="card">
								<div class="card-header">Alcohol Volume (ABV)</div>
								<div class="card-body">
									<div
										class="d-flex align-items-center btn-group filter-hoppiness"
										role="group" aria-label="Alcohol volume options">
										<a class="btn btn-light" id="all-alcohol"
											href="GetBeer.do?beer_name=${beer_input}">All</a> <a
											class="btn" id="alcohol-sm"
											href="GetBeer.do?beer_name=${beer_input}&abv=weak"><img
											class="filterBtn" src="resources/images/beer-sm-a.png"
											alt="sm"></a> <a class="btn" id="alcohol-md"
											href="GetBeer.do?beer_name=${beer_input}&abv=medium"><img
											class="filterBtn" src="resources/images/beer-md-a.png"
											alt="md"></a> <a class="btn" id="alcohol-lg"
											href="GetBeer.do?beer_name=${beer_input}&abv=strong"><img
											class="filterBtn" src="resources/images/beer-lg-a.png"
											alt="lg"></a>
									</div>
								</div>
							</div>
						</div>
						<div class="filter-col col py-2">
							<div class="card">
								<div class="card-header">Hoppiness (IBU)</div>
								<div class="card-body">
									<div
										class="d-flex flex-wrap align-items-center btn-group filter-hoppiness"
										role="group" aria-label="Hoppiness options">
										<a class="btn btn-light" id="all-hoppiness"
											href="GetBeer.do?beer_name=${beer_input}">All</a> <a
											class="btn" id="hoppiness-sm"
											href="GetBeer.do?beer_name=${beer_input}&ibu=weak"><img
											class="filterBtn" src="resources/images/hoppiness-sm.png"
											alt="sm"></a> <a class="btn" id="hoppiness-md"
											href="GetBeer.do?beer_name=${beer_input}&ibu=medium"><img
											class="filterBtn" src="resources/images/hoppiness-md.png"
											alt="md"></a> <a class="btn" id="hoppiness-lg"
											href="GetBeer.do?beer_name=${beer_input}&ibu=strong"><img
											class="filterBtn" src="resources/images/hoppiness-lg.png"
											alt="lg"></a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="px-5 py-3 mb-4 bg-light rounded-0">
				<div class="page-section">
					<p>
						Page: <span>${currentPage}</span>
					</p>
					<div class="pagination">
						<%--For displaying Previous link except for the 1st page --%>
						<c:if test="${currentPage != 1}">
							<a class="page-link"
								href="GetBeer.do?beer_name=${beer_input}&page=${currentPage - 1}">Previous</a>
						</c:if>

						<%--For displaying Next link --%>
						<c:if test="${nextPage}">
							<a class="page-link"
								href="GetBeer.do?beer_name=${beer_input}&page=${currentPage + 1}">Next</a>
						</c:if>
					</div>
				</div>

				<c:choose>
					<c:when test="${!empty beer_info}">
						<c:set var="beers" value="${beer_info}" />
						<div class="my-3">
							<p>
								Showing <b>${fn:length(beers)}</b> beer results for <b>"${beer_input}"</b>
								<c:if test="${not empty abv}">
							and <b>"${abv}"</b> ABV
						</c:if>
								<c:if test="${not empty ibu}">
							and <b>"${ibu}"</b> IBU
						</c:if>
								on this page
							</p>
						</div>
						<div class="row">
							<c:forEach var="beerArr" items="${beer_info}">
								<div class="col-lg-4 mb-3 d-flex align-items-stretch">
									<div class="card" style="width: 20rem;"
										onclick="window.location.href='BeerDetail.do?beer_id=${beerArr.getId()}';">
										<c:choose>
											<c:when test="${empty beerArr.getImageUrl()}">
												<img src="resources/images/default_beer.png"
													alt="${beerArr.getName()}" class="card-img-top">
											</c:when>
											<c:otherwise>
												<img src="${beerArr.getImageUrl()}"
													alt="${beerArr.getName()}" class="card-img-top">
											</c:otherwise>
										</c:choose>
										<div class="card-body">
											<h5 class="card-title">${beerArr.getName()}</h5>
											<p class="card-text">${beerArr.getTagline()}</p>
										</div>
										<ul class="list-group list-group-flush">
											<li class="list-group-item"><span>${beerArr.getAbv()}
													ABV</span></li>
											<li class="list-group-item"><span>${beerArr.getIbu()}
													IBU</span></li>
											<li class="list-group-item"><span>${beerArr.getSrm()}
													SRM</span></li>
										</ul>
									</div>
								</div>
							</c:forEach>
						</div>
					</c:when>
					<c:otherwise>
						<h2>No results were found</h2>
						<p>
							Your search term <b>"${beer_input}"</b>
							<c:if test="${not empty abv}">
							and <b>"${abv}"</b> ABV
						</c:if>
							<c:if test="${not empty ibu}">
							and <b>"${ibu}"</b> IBU
						</c:if>
							returned no results.
						</p>
					</c:otherwise>
				</c:choose>
			</div>
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