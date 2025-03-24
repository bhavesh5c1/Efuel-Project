package com.ecommerce.dao;

import java.util.List;

import com.ecommerce.pojo.Product;

public interface ProductDao
{
   boolean addProduct(Product product);
   boolean updateProduct(Product product);
   List<Product> getAllProduct();
   List<Product> getProductByCategory(int categoryId);
   List<Product> getSearchedProduct(String productName);
   Product getProductById(int productId);
   int getTotalProduct();
   boolean deleteProductById(int productId);
   boolean deleteProductByCategoryId(int categoryId);
   int getQuantityByProductId(int productId);
   void updateQuantityAfterOrder(int productId,int productQuantity);
   int getTotalProductOfCategoryById(int categoryId);
}
