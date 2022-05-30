package com.example.web;

import java.io.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.model.Beer;

/**
 * Servlet implementation class BeerInput
 */
@WebServlet("/BeerInput")
public class BeerInput extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BeerInput() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// int recordsPerPage = 25;

		int cPage;

		boolean nPage;

		String page;

		String optionsABV;
		
		String optionsIBU;

		page = request.getParameter("page");

		optionsABV = request.getParameter("abv");
		
		optionsIBU = request.getParameter("ibu");

		if (page != null) {
			cPage = Integer.parseInt(page);
		} else {
			cPage = 1;
		}

		String beerName = request.getParameter("beer_name");

		Beer[] beerInfo = Beer.getBeerInfoByName(beerName, cPage, optionsABV, optionsIBU);

		if (beerInfo.length < 25) {
			nPage = false;
		} else {
			nPage = true;
		}

		request.setAttribute("beer_input", beerName);

		request.setAttribute("beer_info", beerInfo);

		request.setAttribute("currentPage", cPage);

		request.setAttribute("nextPage", nPage);
		
		request.setAttribute("abv", optionsABV);
		
		request.setAttribute("ibu", optionsIBU);

		// instantiate a request dispatcher for JSP
		RequestDispatcher view = request.getRequestDispatcher("/result.jsp");

		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
