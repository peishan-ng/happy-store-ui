package com.happy.ui.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.happy.ui.model.Product;
import com.happy.ui.service.ProductManager;

@Controller
public class ProductController {
	private final int VIEW_RESULT_ROW = 4;
	
	@Autowired
	private ProductManager productManager;
	
	@RequestMapping(value = "/products", method = RequestMethod.GET)
	public ModelAndView getProduct(
			@RequestParam(value = "categories", required = false) String categories, 
			@RequestParam(value = "start_price_range", required = false) String startPriceRange, 
			@RequestParam(value = "end_price_range", required = false) String endPriceRange,
			@RequestParam(value = "page_no", required = false) String pageNo) {
		ModelAndView modelAndView = new ModelAndView("products");
		
		List<Integer> categoryList = null;
		if(!StringUtils.isEmpty(categories)) {
			categoryList = new ArrayList<Integer>();
			categoryList.add(Integer.valueOf(categories));
		}
		
		int page = 1;
		double startPrice = 0.0;
		double endPrice = 0.0;
		
		try {
			if(!StringUtils.isEmpty(startPriceRange)) { startPrice = Double.valueOf(startPriceRange); }
			if(!StringUtils.isEmpty(endPriceRange)) { endPrice = Double.valueOf(endPriceRange); }
			if(!StringUtils.isEmpty(pageNo)) { page = Integer.valueOf(pageNo); }
		} catch(NumberFormatException e) {}
		
		List<Product> prdtResultList = productManager.searchProduct(categoryList, startPrice, endPrice, page);
		
		int totalCount = productManager.getTotalCount();
		int pageResultSize = prdtResultList.size();
		int resultRow = 0;
		int remainder = 0;
		
		if(pageResultSize>0) {
			resultRow = pageResultSize / VIEW_RESULT_ROW;
			remainder = pageResultSize % VIEW_RESULT_ROW;
			if(remainder > 0 || (totalCount > pageResultSize)) { resultRow = resultRow + 1; }
		}
		
		modelAndView.addObject("resultProduct", prdtResultList);
		modelAndView.addObject("resultRow", resultRow);
		modelAndView.addObject("remainder", remainder);
		modelAndView.addObject("totalResult", totalCount);
	    
		return modelAndView;
	}
}
