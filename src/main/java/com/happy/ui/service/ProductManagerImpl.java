package com.happy.ui.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.happy.ui.model.Product;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.JsonNode;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;

@Service("ProductManager")
public class ProductManagerImpl implements ProductManager {
	private int totalCount = 0;
	
	@Autowired
	private Environment env;
	
	@Override
	public List<Product> searchProduct(List<Integer> categoryIdList, double startPriceRange, double endPriceRange, int page) {
		List<Product> productResult = new ArrayList<Product>();
		
		String url = env.getProperty("happy.store.api.url");
		String jsonData = "data";
		
		Map<String, Object> paramsMap = new HashMap<String, Object>();
		if(categoryIdList!=null && !categoryIdList.isEmpty()) {
			paramsMap.put("categories", StringUtils.collectionToDelimitedString(categoryIdList, ","));
		}
		if(startPriceRange>0.0) {
			paramsMap.put("start_range", startPriceRange);
		}
		if(endPriceRange>0.0) {
			paramsMap.put("end_range", endPriceRange);
		}
		
		paramsMap.put("page", page);
		HttpResponse<JsonNode> productResponse = doHttpUrlGetAsJson(url, paramsMap);
		
		try {
			if(productResponse==null) { return productResult; }
			JsonNode jsonProduct = productResponse.getBody();
			
			if(jsonProduct==null) { return productResult; }
			JSONObject productJsonObj = jsonProduct.getObject();
			
			if(!productJsonObj.getString("response").equalsIgnoreCase("success") || !productJsonObj.has(jsonData)) { return productResult; }
			JSONArray jsonArrayObj = productJsonObj.getJSONArray(jsonData);
			this.totalCount = productJsonObj.getInt("total");
			
			for(Object genProductObj : jsonArrayObj) {
				ObjectMapper mapper = new ObjectMapper();
				mapper.enable(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT);
				
				Product prdt = mapper.readValue(((JSONObject) genProductObj).toString(), Product.class);
				if(prdt!=null) { productResult.add(prdt); }
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return productResult;
	}
	
	@Override
	public int getTotalCount() {
		return this.totalCount;
	}

	private <T> HttpResponse<JsonNode> doHttpUrlGetAsJson(String reqUrl, Map<String, Object> paramsMap) {
		try {
			// Uses third party library to call Http GET
			return Unirest.get(reqUrl).queryString(paramsMap).asJson();
		} catch (UnirestException e) {
			e.printStackTrace();
		}
		
		return null;
	}
}
