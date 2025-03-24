package com.ecommerce.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ecommerce.dao.UserDaoImp;
import com.ecommerce.pojo.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		HttpSession session=request.getSession();
		session.setAttribute("message","Logged out...");
        response.sendRedirect("login.jsp");
        session.removeAttribute("active-user");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		HttpSession session=request.getSession();
		String action=request.getParameter("action");
		
		if(action==null)
		{
			String userEmail=request.getParameter("email");
			String userPassword=request.getParameter(("password"));
			
			UserDaoImp u=new UserDaoImp();
			boolean isAlreadyUser=u.isAlreadyUser(userEmail);
			
			if(isAlreadyUser==false)
			{
				session.setAttribute("message","This user is not registered..!");
		        response.sendRedirect("login.jsp");
			}
			
			else
			{
				User user=u.login(userEmail, userPassword);
			    
			    if(user!=null)
			    {
			    	
			    		session.setAttribute("active-user",user);
				        
			    	    
				        if(user.getUserType().equals("admin"))
				        {
				        	response.sendRedirect("admin.jsp");	
				        }
				        
				        else if(user.getUserType().equals("normal"))
				        {
				        	response.sendRedirect("index.jsp");	
				        }
			    	
			    	
			    }
			    
			    else
			    {
			    	session.setAttribute("message","Failed to login..!");
			        response.sendRedirect("login.jsp");
			    }
			}
		}
		
		else if(action.equals("changePassword"))
		{
			
		
		String password=request.getParameter("pass");
		User user=(User)session.getAttribute("active-user");
		
		int userId=user.getUserId();
		
		boolean flag=new UserDaoImp().changePassword(userId, password);
		
		if(flag==true)
		{
			session.setAttribute("message","Password Changed Successfully, Login again..!");
	        response.sendRedirect("login.jsp");
	        session.removeAttribute("active-user");
		}
		
		else
		{
			session.setAttribute("message","Failed to change password..!");
	        response.sendRedirect("index.jsp");
		}
	    
	    }
		
		else if(action.equals("forgetPassword"))
		{
			
		
		String password=request.getParameter("pass");
		String email=request.getParameter("email");
		String phone=request.getParameter("phone");
		
		boolean flag=new UserDaoImp().forgetPassword(email, phone, password);
		
		if(flag==true)
		{
			session.setAttribute("message","Password Changed Successfully...!");
	        response.sendRedirect("login.jsp");
	        session.removeAttribute("active-user");
		}
		
		else
		{
			session.setAttribute("message","Failed to change password..!");
	        response.sendRedirect("index.jsp");
		}
	    
	    }
			
	}
		
		

}
