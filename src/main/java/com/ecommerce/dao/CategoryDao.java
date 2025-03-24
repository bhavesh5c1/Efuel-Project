package com.ecommerce.dao;

import java.util.List;

import com.ecommerce.pojo.Category;

public interface CategoryDao
{
    boolean addCategory(Category category);
    List<Category> getAllCategory(); 
    int getCategoryIdByProductId(int productId);
    int getTotalCategory();
    String getCategoryNameById(int categoryId);
    boolean deleteCategoryById(int categoryId);
}
