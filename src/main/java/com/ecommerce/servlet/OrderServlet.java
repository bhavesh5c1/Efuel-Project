package com.ecommerce.servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.ecommerce.dao.*;
import com.ecommerce.pojo.*;

/**
 * Servlet implementation class OrderServlet
 */
@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String action=request.getParameter("action");
		HttpSession session=request.getSession();
		
		if(action.equals("order"))
		{
			int userId=Integer.parseInt(request.getParameter("userId"));
			LocalDate date=LocalDate.now();
			String orderedDate=String.valueOf(date);
			OrderDaoImp od=new OrderDaoImp();
			CartDaoImp cd=new CartDaoImp();
			Order order=new Order();
			ProductDaoImp pd=new ProductDaoImp();
			
			List<Cart> cart=cd.getCartByUserId(userId);
			int totalBill=0;
		    for(Cart c:cart)
		    {
			    int productId=c.getProductId();
			    Product product=pd.getProductById(productId);
			    int productOldQuantity=product.getProductQuantity();
			    int updatedQuantity=productOldQuantity-c.getQuantity();
			    pd.updateQuantityAfterOrder(productId, updatedQuantity);
		  
			    order.setProdctId(productId);
		    	order.setUserId(userId);
		    	order.setQuantity(c.getQuantity());
		    	order.setPrice(c.getPrice());
		    	order.setOrderesDate(orderedDate);
		    	order.setDeliveryDate("0");
		    	od.addOrder(order);
		    		
		    }
		        cd.deleteCartByUserId(userId);
		        totalBill=od.totalOrderPrice(userId);
				session.setAttribute("message","<span>Selected Products ordered successfully. Your Total Bill is Rs."+totalBill+"</span>");
		        response.sendRedirect("index.jsp");
	       
			
		}
		
		else if(action.equals("addDelivery"))
		{
			int userId=Integer.parseInt(request.getParameter("userId"));
			int productId=Integer.parseInt(request.getParameter("productId"));
			String deliveryDate=request.getParameter("deliveryDate");
			int orderId=Integer.parseInt(request.getParameter("orderId"));
			
			boolean flag=new OrderDaoImp().addDeliveryDate(orderId, userId, productId, deliveryDate);
			if(flag==true)
		    {
		    	session.setAttribute("message","Delivery Date  Added Successfully!");
		        response.sendRedirect("index.jsp");
		    }
		    
		   else
		    {
		    	session.setAttribute("message","Failed to add Delivery Date..!");
		        response.sendRedirect("index.jsp");
		    }  
		}
			
		
	}

}
