package com.ecommerce.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.ecommerce.dbUtility.DBUtility;
import com.ecommerce.pojo.Category;

public class CategoryDaoImp implements CategoryDao
{

	@Override
	public boolean addCategory(Category category)
	{
		int row=0;
    	Connection con=DBUtility.getConnection();
    	String query="insert into category(categoryTitle,categoryDescription) values(?,?)";
    	try
    	{
    	    PreparedStatement stmt= con.prepareStatement(query);
    	    stmt.setString(1,category.getCategoryTitle());
    	    stmt.setString(2,category.getCategoryDescription());
    	    row=stmt.executeUpdate();
    	}
    	
    	catch(SQLException e)
    	{
    		System.out.println(e);
    	}
    	
    	if(row>0)
    	   return true;
    	else
    	   return false;
	}

	@Override
	public List<Category> getAllCategory()
	{
		Connection con=DBUtility.getConnection();
		String query="select * from category";
		ResultSet rs;
		Statement stmt;
		Category category;
		List<Category> li=new ArrayList<>();
		
		try
    	{
    	    stmt=con.createStatement();
    	    rs=stmt.executeQuery(query);
    	    
    	    while(rs.next())
    	    {
    	       category=new Category(rs.getString("categoryTitle"), rs.getString("categoryDescription"));
    	       category.setCategoryId(rs.getInt("categoryId"));
    	       li.add(category);
    	    }
    	}
    	
    	catch(SQLException e)
    	{
    		System.out.println(e);
    	}
    	
    	return li;
		
	}

	@Override
	public int getCategoryIdByProductId(int productId)
	{
		Connection con=DBUtility.getConnection();
		String query="select categoryId from product where productId="+productId;
		ResultSet rs;
		Statement stmt;
		int categoryId=0;
		try
    	{
    	    stmt=con.createStatement();
    	    rs=stmt.executeQuery(query);
    	    
    	    while(rs.next())
    	    {
    	    	categoryId=rs.getInt("categoryId");
    	    }
    	}
    	
    	catch(SQLException e)
    	{
    		System.out.println(e);
    	}
    	
    	return categoryId;
	}

	@Override
	public int getTotalCategory() {
		int totalCategory=0;
		   ResultSet rs;
	 	   
	 	   Connection con=DBUtility.getConnection();
	        String query="select count(categoryId) from category";
	        
	 	   try 
	 	   {
	 		Statement stmt=con.createStatement();
	 	    rs=stmt.executeQuery(query);
	 	    while(rs.next())
	 		{
	 	    	  totalCategory=rs.getInt("count(categoryId)");
	 		}
	 	   }
	 	   catch (SQLException e) 
	 	   {
	 		e.printStackTrace();
	 	   }
	 	  
		 
		return totalCategory;  
	}

	@Override
	public String getCategoryNameById(int categoryId)
	{
		   String categoryName=null;
		   ResultSet rs;
	 	   
	 	   Connection con=DBUtility.getConnection();
	        String query="select categoryTitle from category where categoryId="+categoryId;
	        
	 	   try 
	 	   {
	 		Statement stmt=con.createStatement();
	 	    rs=stmt.executeQuery(query);
	 	    while(rs.next())
	 		{
	 	    	categoryName=rs.getString("categoryTitle");
	 		}
	 	   }
	 	   catch (SQLException e) 
	 	   {
	 		e.printStackTrace();
	 	   }
	 	  
		 
		return categoryName; 
	}

	@Override
	public boolean deleteCategoryById(int categoryId)
	{
		int row=0;
    	Connection con=DBUtility.getConnection();
    	String query="delete from category where categoryId=?";
    	try
    	{
    	    PreparedStatement stmt= con.prepareStatement(query);
    	    stmt.setInt(1, categoryId);
    	    row=stmt.executeUpdate();
    	}
    	
    	catch(SQLException e)
    	{
    		System.out.println(e);
    	}
    	
    	if(row>0)
    	   return true;
    	else
    	   return false;
	}
}
