package com.happy.ui.service;

import java.util.List;

import com.happy.ui.model.Product;

public interface ProductManager {
	public List<Product> searchProduct(List<Integer> categoryIdList, double startPriceRange, double endPriceRange, int page);
	public int getTotalCount();
}
