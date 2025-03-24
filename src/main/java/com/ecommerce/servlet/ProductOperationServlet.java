package com.ecommerce.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.ecommerce.dao.CategoryDaoImp;
import com.ecommerce.dao.ProductDaoImp;
import com.ecommerce.pojo.Category;
import com.ecommerce.pojo.Product;

/**
 * Servlet implementation class ProductOperationServlet
 */
@MultipartConfig
@WebServlet("/ProductOperationServlet")
public class ProductOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductOperationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String action=request.getParameter("action");
		HttpSession session=request.getSession();
		
		if(action.equals("delete"))
		{
			int productId=Integer.parseInt(request.getParameter("productId"));
			Product product=new ProductDaoImp().getProductById(productId);
			String productImage=product.getProductPhoto();
			File f=new File("C:\\Project\\ecommerce-project-master\\src\\main\\webapp\\productImages\\"+productImage);
			
			  f.delete();
			 
			
			boolean flag=false;
			
			flag=new ProductDaoImp().deleteProductById(productId);
			if(flag==true)
			{
				session.setAttribute("message","Product Deleted Successfully..!");
		        response.sendRedirect("index.jsp"); 	
			}
			
			else
			{
				session.setAttribute("message","Failed to Delete Product..!");
		        response.sendRedirect("index.jsp"); 
			}
			
		}
		
		else if(action.equals("deleteCategory"))
		{
			int categoryId=Integer.parseInt(request.getParameter("categoryId"));
			int totalProduct=new ProductDaoImp().getTotalProductOfCategoryById(categoryId);
			if(totalProduct>0)
			{
			    List<Product> product=new ProductDaoImp().getProductByCategory(categoryId);
			    for(Product p:product)
			    {
			    	  File f=new File("C:\\Project\\ecommerce-project-master\\src\\main\\webapp\\productImages\\"+p.getProductPhoto());
					
					  f.delete();
					  
			    }
				boolean flag=new ProductDaoImp().deleteProductByCategoryId(categoryId);
				if(flag==true)
				{
					boolean f=new CategoryDaoImp().deleteCategoryById(categoryId);
					if(f==true)
					{
						session.setAttribute("message","Category Deleted Successfully..!");
				        response.sendRedirect("index.jsp"); 	
					}
					
					else
					{
						session.setAttribute("message","Failed to Delete Category..!");
				        response.sendRedirect("index.jsp"); 
					}
				}
				
				else
				{
					session.setAttribute("message","Failed to Delete Category..!");
			        response.sendRedirect("index.jsp"); 
				}
			}
			
			
			
			else
			{
				
				boolean f=new CategoryDaoImp().deleteCategoryById(categoryId);
				if(f==true)
				{
					
					session.setAttribute("message","Category Deleted Successfully..!");
			        response.sendRedirect("index.jsp"); 	
				}
				
				else
				{
					session.setAttribute("message","Failed to Delete Category..!");
			        response.sendRedirect("index.jsp"); 
				} 
			}
		}
		
		
		
		
		
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String action=request.getParameter("action");
		HttpSession session=request.getSession();
		
		if(action.equals("addCategory"))
		{
		    String categoryTitle=request.getParameter("categoryTitle");
		    String categoryDescription=request.getParameter("categoryDescription");
		    
		    Category category=new Category(categoryTitle,categoryDescription);
		    CategoryDaoImp categoryDaoImp=new CategoryDaoImp();
		    boolean flag=categoryDaoImp.addCategory(category);
		    
		    if(flag==true)
		    {
		    	session.setAttribute("message","Category Added Successfully..!");
		        response.sendRedirect("admin.jsp");
		    }
		    
		   else
		    {
		    	session.setAttribute("message","Failed to add category..!");
		        response.sendRedirect("admin.jsp");
		    }
		    
		}
		
		else if(action.equals("addProduct"))
		{
			String productTitle=request.getParameter("productTitle");
			String productDescription=request.getParameter("productDescription");
			int productPrice=Integer.parseInt(request.getParameter("productPrice"));
			int productQuantity=Integer.parseInt(request.getParameter("productQuantity"));
			int productDiscount=Integer.parseInt(request.getParameter("productDiscount"));
			int productCategoryId=Integer.parseInt(request.getParameter("productCategoryId"));
			Part part=request.getPart("productPic");
			
			String fileName=part.getSubmittedFileName();
			
			String uploadPath="C:\\Project\\ecommerce-project-master\\src\\main\\webapp\\productImages\\"+fileName;
			
			try
			{
			FileOutputStream fos=new FileOutputStream(uploadPath);
			InputStream is=part.getInputStream();
			
			byte[] data=new byte[is.available()];
			is.read(data);
			fos.write(data);
			fos.close();
			}
			
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			Product product=new Product(productPrice, productDiscount, productQuantity, productCategoryId, productTitle, productDescription, fileName);
			ProductDaoImp pdao=new ProductDaoImp();
			boolean flag=pdao.addProduct(product);
			
			if(flag==true)
		    {
		    	session.setAttribute("message","Product Added Successfully..!");
		        response.sendRedirect("admin.jsp");
		    }
		    
		   else
		    {
		    	session.setAttribute("message","Failed to add product..!");
		        response.sendRedirect("admin.jsp");
		    }
			
			
		}
		
		else if(action.equals("searchProduct"))
		{
			RequestDispatcher rd;
			String search=request.getParameter("search");
			request.setAttribute("enteredText",search);
			rd=request.getRequestDispatcher("index.jsp");
			rd.forward(request, response);   	
		}
		
		else if(action.equals("updateProduct"))
		{
			boolean flag=false;
			int productId=Integer.parseInt(request.getParameter("productId"));
			String productTitle=request.getParameter("productTitle");
			String productDescription=request.getParameter("productDescription");
			String productPrice=request.getParameter("productPrice");
			String productDiscount=request.getParameter("productDiscount");
			String productQuantity=request.getParameter("productQuantity");
            Part part=request.getPart("productPhoto");
			
			String fileName=part.getSubmittedFileName();
			
			System.out.println(productId);
			System.out.println(productTitle);
			System.out.println(productDescription);
			System.out.println(productPrice);
			System.out.println(productDiscount);
			System.out.println(productQuantity);
			System.out.println(fileName);
			
			
			
			Product preProduct=new ProductDaoImp().getProductById(productId);
			String preImageName=preProduct.getProductPhoto();
			
			File f=new File("C:\\Project\\ecommerce-project-master\\src\\main\\webapp\\productImages\\"+preImageName);
			
			  f.delete();
			 
			
			String uploadPath="C:\\Project\\ecommerce-project-master\\src\\main\\webapp\\productImages\\"+fileName;
			
			try
			{
			FileOutputStream fos=new FileOutputStream(uploadPath);
			InputStream is=part.getInputStream();
			
			byte[] data=new byte[is.available()];
			is.read(data);
			fos.write(data);
			fos.close();
			
			}
			
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			Product product=new Product();
			product.setProductDescription(productDescription);
			product.setProductDiscount(Integer.parseInt(productDiscount));
			product.setProductId(productId);
			product.setProductPrice(Integer.parseInt(productPrice));
			product.setProductQuantity(Integer.parseInt(productQuantity));
			product.setProductTitle(productTitle);
			product.setProductPhoto(fileName);
			
			ProductDaoImp pdao=new ProductDaoImp();
		    flag=pdao.updateProduct(product);
			
		    if(flag==true)
			{
				session.setAttribute("message","Product Updated Successfully..!");
		        response.sendRedirect("index.jsp"); 	
			}
			
			else
			{
				session.setAttribute("message","Failed to Update Product..!");
		        response.sendRedirect("index.jsp"); 
			}
		}
		
		
	}

}
