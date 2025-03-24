package com.ecommerce.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ecommerce.dao.CartDaoImp;
import com.ecommerce.dao.Helper;
import com.ecommerce.dao.ProductDaoImp;
import com.ecommerce.pojo.Cart;
import com.ecommerce.pojo.Product;
import com.ecommerce.pojo.User;

/**
 * Servlet implementation class CartServlet
 */
@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String action=request.getParameter("action");
		HttpSession session=request.getSession();
		
		if(action.equals("delete"))
		{
			int cartId=Integer.parseInt(request.getParameter("cartId"));
			boolean flag=false;
			
			flag=new CartDaoImp().deleteCartById(cartId);
			if(flag==true)
			{
				session.setAttribute("message","Product Deleted from Cart Successfully..!");
		        response.sendRedirect("index.jsp"); 	
			}
			
			else
			{
				session.setAttribute("message","Failed to Delete Product from Cart..!");
		        response.sendRedirect("index.jsp"); 
			}
			
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		HttpSession session=request.getSession();
		String action=request.getParameter("action");
		
		if(action.equals("addToCart"))
		{
			User user=(User)session.getAttribute("active-user");
			int userId=user.getUserId();
			int productId=Integer.parseInt(request.getParameter("productId"));
			int quantity=Integer.parseInt(request.getParameter("quantity"));
			Product product=new ProductDaoImp().getProductById(productId);
			int productPrice=product.getProductPrice();
			int productDiscount=product.getProductDiscount();
			int price=Helper.getProductSellingPrice(productPrice, productDiscount);
			int totalPrice=quantity*price;
			int productActualQuantity=product.getProductQuantity();
			
			if(quantity>productActualQuantity)
			{
				session.setAttribute("message","Only "+productActualQuantity+" Item is Available Now :(");
		        response.sendRedirect("index.jsp");
			}
			
			else
			{
				
			boolean check=new CartDaoImp().alreadyAvailableInCart(productId, userId);
			if(check==false)
			{
				Cart cart=new Cart(userId,productId,quantity,totalPrice);
			    boolean flag=new CartDaoImp().addToCart(cart);
			    if(flag==true)
			    {
			    	session.setAttribute("message","Product Added to Cart Successfully..!");
			        response.sendRedirect("index.jsp");
			    }
			    
			   else
			    {
			    	session.setAttribute("message","Failed to add product to cart..!");
			        response.sendRedirect("index.jsp");
			    }  
			}
			
			else
			{
				
				int finalQuantity=new CartDaoImp().getPreviousQuantityFromCart(productId, userId)+quantity;
				Product p=new ProductDaoImp().getProductById(productId);
				int pricee=finalQuantity*p.getProductPrice();
				Cart cart=new Cart(userId,productId,finalQuantity,pricee);
				boolean flag=new CartDaoImp().updateCart(cart);
				
				if(flag==true)
			    {
			    	session.setAttribute("message","Product Added to Cart Successfully..!");
			        response.sendRedirect("index.jsp");
			    }
			    
			   else
			    {
			    	session.setAttribute("message","Failed to add product to cart..!");
			        response.sendRedirect("index.jsp");
			    } 
			}
			
	   	  } 
		}
		
	}

}
