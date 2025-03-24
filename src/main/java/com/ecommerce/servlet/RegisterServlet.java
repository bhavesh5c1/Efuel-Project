package com.ecommerce.servlet;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.ecommerce.dao.UserDaoImp;
import com.ecommerce.pojo.User;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
@MultipartConfig
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    } 

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		HttpSession session=request.getSession();
		String username=request.getParameter("username");
		String useremail=request.getParameter("useremail");
		String userpassword=request.getParameter("userpassword");
		String userphone=request.getParameter("userphone");
		String useraddress=request.getParameter("useraddress");
		Part part=request.getPart("productPic");
		
		String fileName=part.getSubmittedFileName();
		
		//  here in place C:\\admin --> enter your directory path 
		String uploadPath="C:\\Project\\ecommerce-project-master\\src\\main\\webapp\\userProfilePic\\"+fileName;
		
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
		

		User user=new User(username,useremail,userpassword,userphone,fileName,useraddress,"normal");
	    UserDaoImp u=new UserDaoImp();
	    boolean isAlreadyUser=u.isAlreadyUser(useremail);
	    if(isAlreadyUser==true)
	    {
	    	session.setAttribute("message","User is Already registered with this Email..!");
	        response.sendRedirect("register.jsp");
	    }
	    
	    else
	    {
	    	boolean flag=u.addUser(user);
			
		    if(flag==true)
		    {
		    	session.setAttribute("message","Registeration Successfull..!!!");
		        response.sendRedirect("register.jsp");
		    }
		    
		    else
		    {
		    	session.setAttribute("message","Registration Failed..!!!");
		    	response.sendRedirect("register.jsp");
		    }
	    }
	    
		
	}


}
