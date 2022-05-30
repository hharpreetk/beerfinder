package com.example.model;

import java.io.*;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.*;
import java.util.*;

import com.google.gson.*;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Beer {
	@SerializedName("id")
	@Expose
	private Integer id;
	@SerializedName("name")
	@Expose
	private String name;
	@SerializedName("tagline")
	@Expose
	private String tagline;
	@SerializedName("first_brewed")
	@Expose
	private String firstBrewed;
	@SerializedName("description")
	@Expose
	private String description;
	@SerializedName("image_url")
	@Expose
	private String imageUrl;
	@SerializedName("abv")
	@Expose
	private Double abv;
	@SerializedName("ibu")
	@Expose
	private Double ibu;
	@SerializedName("target_fg")
	@Expose
	private Double targetFg;
	@SerializedName("target_og")
	@Expose
	private Double targetOg;
	@SerializedName("ebc")
	@Expose
	private Double ebc;
	@SerializedName("srm")
	@Expose
	private Double srm;
	@SerializedName("ph")
	@Expose
	private Double ph;
	@SerializedName("attenuation_level")
	@Expose
	private Double attenuationLevel;
	@SerializedName("volume")
	@Expose
	private Volume volume;
	@SerializedName("boil_volume")
	@Expose
	private BoilVolume boilVolume;
	@SerializedName("method")
	@Expose
	private Method method;
	@SerializedName("ingredients")
	@Expose
	private Ingredients ingredients;
	@SerializedName("food_pairing")
	@Expose
	private List<String> foodPairing;
	@SerializedName("brewers_tips")
	@Expose
	private String brewersTips;
	@SerializedName("contributed_by")
	@Expose
	private String contributedBy;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTagline() {
		return tagline;
	}

	public void setTagline(String tagline) {
		this.tagline = tagline;
	}

	public String getFirstBrewed() {
		return firstBrewed;
	}

	public void setFirstBrewed(String firstBrewed) {
		this.firstBrewed = firstBrewed;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public Double getAbv() {
		return abv;
	}

	public void setAbv(Double abv) {
		this.abv = abv;
	}

	public Double getIbu() {
		return ibu;
	}

	public void setIbu(Double ibu) {
		this.ibu = ibu;
	}

	public Double getTargetFg() {
		return targetFg;
	}

	public void setTargetFg(Double targetFg) {
		this.targetFg = targetFg;
	}

	public Double getTargetOg() {
		return targetOg;
	}

	public void setTargetOg(Double targetOg) {
		this.targetOg = targetOg;
	}

	public Double getEbc() {
		return ebc;
	}

	public void setEbc(Double ebc) {
		this.ebc = ebc;
	}

	public Double getSrm() {
		return srm;
	}

	public void setSrm(Double srm) {
		this.srm = srm;
	}

	public Double getPh() {
		return ph;
	}

	public void setPh(Double ph) {
		this.ph = ph;
	}

	public Double getAttenuationLevel() {
		return attenuationLevel;
	}

	public void setAttenuationLevel(Double attenuationLevel) {
		this.attenuationLevel = attenuationLevel;
	}

	public Volume getVolume() {
		return volume;
	}

	public void setVolume(Volume volume) {
		this.volume = volume;
	}

	public BoilVolume getBoilVolume() {
		return boilVolume;
	}

	public void setBoilVolume(BoilVolume boilVolume) {
		this.boilVolume = boilVolume;
	}

	public Method getMethod() {
		return method;
	}

	public void setMethod(Method method) {
		this.method = method;
	}

	public Ingredients getIngredients() {
		return ingredients;
	}

	public void setIngredients(Ingredients ingredients) {
		this.ingredients = ingredients;
	}

	public List<String> getFoodPairing() {
		return foodPairing;
	}

	public void setFoodPairing(List<String> foodPairing) {
		this.foodPairing = foodPairing;
	}

	public String getBrewersTips() {
		return brewersTips;
	}

	public void setBrewersTips(String brewersTips) {
		this.brewersTips = brewersTips;
	}

	public String getContributedBy() {
		return contributedBy;
	}

	public void setContributedBy(String contributedBy) {
		this.contributedBy = contributedBy;
	}

	public static Beer[] getRandomBeer() {
		String jsonResult = getBeerJsonStringById("random");
		Beer[] beerInfoObjectArr = toEntity(jsonResult);
		return beerInfoObjectArr;
	}

	public static Beer[] getBeerInfoById(String beerId) {
		String jsonResult = getBeerJsonStringById(beerId);
		Beer[] beerInfoObjectArr = toEntity(jsonResult);
		return beerInfoObjectArr;
	}

	public static Beer[] getBeerInfoByName(String beerName, int page, String optionsABV, String optionsIBU) {
		String jsonResult = getBeerJsonStringByName(beerName, page, optionsABV, optionsIBU);
		Beer[] beerInfoObjectArr = toEntity(jsonResult);
		return beerInfoObjectArr;
	}

	// convert json string to class object
	private static Beer[] toEntity(String jsonResult) {
		try {
			Gson gson = new GsonBuilder().create();
			Beer[] beerInfo = gson.fromJson(jsonResult, Beer[].class);
			return beerInfo;
		} catch (JsonSyntaxException ex) {
			ex.printStackTrace();
			return null;
		}
	}

	private static String getBeerJsonStringByName(String beerName, int page, String optionsABV, String optionsIBU) {
		String response = "";
		String propFile = "/config.properties";

		try {
			// get api end point from config file
			Properties prop = readPropertiesFile(propFile);

			String apiUrl = prop.getProperty("api_endpoint");

			String p = String.format("page=%s", URLEncoder.encode(String.valueOf(page), "UTF-8"));

			String bName = String.format("beer_name=%s", URLEncoder.encode(String.valueOf(beerName), "UTF-8"));

			String abv = getABV(optionsABV);

			String ibu = getIBU(optionsIBU);

			String query = apiUrl + "?" + p + "&" + bName + abv + ibu;

			// create http client
			HttpClient client = HttpClient.newHttpClient();

			// build a http request
			// HttpRequest request = HttpRequest.newBuilder().uri(URI.create(apiUrl + "?" +
			// query)).GET().build();

			HttpRequest request = HttpRequest.newBuilder().uri(URI.create(query)).GET().build();

			// send the request asynchronously
			response = client.send(request, HttpResponse.BodyHandlers.ofString()).body();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return response;
	}

	private static String getIBU(String optionsIBU) {
		String ibu = "";
		int ibu_lt;
		int ibu_gt;
		try {
			if (optionsIBU == null) {
				ibu = "";
			} else {

				switch (optionsIBU) {
				case "weak":
					ibu_lt = 35;
					ibu = String.format("&ibu_lt=%s", URLEncoder.encode(String.valueOf(ibu_lt), "UTF-8"));
					break;
				case "medium":
					ibu_lt = 75;
					ibu_gt = 34;
					ibu = String.format("&ibu_lt=%1$s&ibu_gt=%2$s", URLEncoder.encode(String.valueOf(ibu_lt), "UTF-8"),
							URLEncoder.encode(String.valueOf(ibu_gt), "UTF-8"));
					break;
				case "strong":
					ibu_gt = 74;
					ibu = String.format("&abv_gt=%s", URLEncoder.encode(String.valueOf(ibu_gt), "UTF-8"));
					break;
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ibu;
	}

	private static String getABV(String optionsABV) {
		String abv = "";
		double abv_lt;
		double abv_gt;
		try {
			if (optionsABV == null) {
				abv = "";
			} else {

				switch (optionsABV) {
				case "weak":
					abv_lt = 4.6;
					abv = String.format("&abv_lt=%s", URLEncoder.encode(String.valueOf(abv_lt), "UTF-8"));
					break;
				case "medium":
					abv_lt = 7.6;
					abv_gt = 4.5;
					abv = String.format("&abv_lt=%1$s&abv_gt=%2$s", URLEncoder.encode(String.valueOf(abv_lt), "UTF-8"),
							URLEncoder.encode(String.valueOf(abv_gt), "UTF-8"));
					break;
				case "strong":
					abv_gt = 7.5;
					abv = String.format("&abv_gt=%s", URLEncoder.encode(String.valueOf(abv_gt), "UTF-8"));
					break;
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return abv;
	}

	private static String getBeerJsonStringById(String beerId) {

		String response = "";
		String propFile = "/config.properties";

		try {
			// get api end point from config file
			Properties prop = readPropertiesFile(propFile);

			String apiUrl = prop.getProperty("api_endpoint");

			// create http client
			HttpClient client = HttpClient.newHttpClient();

			// build a http request
			HttpRequest request = HttpRequest.newBuilder().uri(URI.create(apiUrl + "/" + beerId)).GET().build();

			// send the request asynchronously
			response = client.send(request, HttpResponse.BodyHandlers.ofString()).body();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return response;
	}

	// get property file
	private static Properties readPropertiesFile(String file) throws IOException {

		// create properties object
		Properties prop = new Properties();

		try (InputStream inputStream = Beer.class.getClassLoader().getResourceAsStream(file)) {

			if (inputStream != null) {
				prop.load(inputStream);
				inputStream.close();
			} else {
				throw new FileNotFoundException("property file '" + file + "' not found in the classpath");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return prop;
	}
}
