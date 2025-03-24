<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
    <%@ page import ="com.ecommerce.pojo.*"%>
    <%@ page import ="com.ecommerce.dao.*"%>
    <%@ page import ="java.sql.*"%>
    <%@ page import ="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home- eFuel</title>
<%@ include file="components/common_cs_js.jsp"%>
</head>
<body>
<%@ include file="components/navbar.jsp"%>
    
    <%
         String searchResult=(String)request.getAttribute("enteredText");
         String cat=request.getParameter("category"); 
         ProductDaoImp pdao=new ProductDaoImp();
         CategoryDaoImp cdao1=new CategoryDaoImp();
         List<Product> l1=null;
         List<Category> cl1=cdao1.getAllCategory();        
        
         if(cat==null)
         {
        	 cat="0";
        	 
        	 if(cat.trim().equals("0"))
             {
              	l1 =pdao.getAllProduct();
             }
         }
         
         else if(cat.equals("0"))
         {
        	 l1 =pdao.getAllProduct();
         }
         
         else
         {
        	
             int categoryId=Integer.parseInt(cat.trim());
             l1=pdao.getProductByCategory(categoryId);	 
              
         }
       
    %>

    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
  <ol class="carousel-indicators">
    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
  </ol>
  <div class="carousel-inner" style="width:100%">
    <div class="carousel-item active">
      <img class="d-block w-100" src="images/ca1.jpg" alt="First slide">
    </div>
    <div class="carousel-item">
      <img class="d-block w-100" src="images/ca2.jpg" alt="Second slide">
    </div>
    <div class="carousel-item">
      <img class="d-block w-100" src="images/ca3.jpg" alt="Third slide">
    </div>
  </div>
  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>


<div class="text-center"><%@ include file="components/message.jsp"%></div>
<div class="container-fluid">

   <!-- show categories -->
   
       <div class="row">
         <div class="col-md-2 " >
             <div class="list-group mt-4">
                 <%
                     int catId=Integer.parseInt(cat);
                 %>
                 <a href="index.jsp?category=0" class="list-group-item list-group-item-action <%if(catId==0){ %> active custom-bg<%} %>" <%if(catId==0){ %> style="border:#ff9800"<%} %> >All Categories</a>
               <%
                    for(Category c: cl1)
                    {    	
               %>      
                         <a href="index.jsp?category=<%=c.getCategoryId() %>" class="list-group-item list-group-item-action <%if(catId==c.getCategoryId()){ %> active custom-bg<%} %>" <%if(catId==c.getCategoryId()){ %> style="border:#ff9800"<%} %>><%=c.getCategoryTitle() %></a>
               <%
                    }
               %>
               </div>
         </div>     
   
   
   
   <!-- ****************************************** -->

   <!-- show products -->
   
   <%
       if(searchResult==null)
       {
   %>
     
     <div class="col-md-10 ">
         
             <div class="row mt-4">
                 <div class="col-md-12 admin">
                     <div class="card-columns hover">
                     
                         <%
                             String stock="Out Of Stock!!!"; 
                             for(Product p:l1)
                             {
                         %>
                        
                         <div class="card">
                              
                             <img src="productImages/<%=p.getProductPhoto() %>" style="max-height:270px;max-width:100%;width:auto;" class="card-img-top rounded mx-auto d-block m-2" alt="img">
                         
                             <div class="card-body">
                                 <h5 class="card-title"><a href="product.jsp?productId=<%=p.getProductId()%>" style="text-decoration: none;color:black;"> <%=p.getProductTitle() %></a></h5>
                                 <p class="card-text"><%=Helper.get10Words(p.getProductDescription()) %></p> 
                             </div>
                             <div class="card-footer text-center">
                                 <p style="font-size:25px"><span class="ml-2"><b>&#8377;<%=Helper.getProductSellingPrice(p.getProductPrice(), p.getProductDiscount()) %>/-</b></span>
                                 <span class="ml-2" style="font-size:20px;color:red"><s>&#8377;<%=p.getProductPrice()%></s></span>
                                  <span class="ml-2" style="font-size:20px;color:green"><%=p.getProductDiscount() %>&#37 off</span>
                                 </p>
                                  <span class="ml-2" style="font-size:20px;">Stock :</span>
                                  <span class="ml-1" style="font-size:20px"><%if(p.getProductQuantity()<1){ %><span style="color:red;"><b><%=stock%></b></span><%} else{ %><%=p.getProductQuantity()%><% } %></span>
                             </div>
                             
                         </div>
                         
                       
                         <%
                             
                             }
                         %>
                     </div>
                 </div>
             </div>
            
         </div>
         
     <%
         } 
   
       else
       {
    	   List<Product> listOfProductFromSearch=new ProductDaoImp().getSearchedProduct(searchResult);
     %>
           <div class="col-md-10">
         
             <div class="row mt-4">
                 <div class="col-md-12">
                     <div class="card-columns">
                     
                         <%
                             String stock="Out Of Stock!!!"; 
                             for(Product p:listOfProductFromSearch)
                             {
                         %>
                         <div class="card p-2"  >
                        
                             <img src="productImages/<%=p.getProductPhoto() %>" style="max-height:270px;max-width:100%;width:auto;" class="card-img-top rounded mx-auto d-block m-2" alt="img">
                         
                             <div class="card-body" >
                                <a href="product.jsp?productId=<%=p.getProductId() %>" style="text-decoration: none;color:black;"> <h5 class="card-title" ><%=p.getProductTitle() %></h5></a>
                                 <p class="card-text"><%=Helper.get10Words(p.getProductDescription()) %></p> 
                             </div>
                             <div class="card-footer text-center">
                                 <p style="font-size:25px"><span class="ml-2"><b>&#8377;<%=Helper.getProductSellingPrice(p.getProductPrice(), p.getProductDiscount()) %>/-</b></span>
                                 <span class="ml-2" style="font-size:20px;color:red"><s>&#8377;<%=p.getProductPrice()%></s></span>
                                  <span class="ml-2" style="font-size:20px;color:green"><%=p.getProductDiscount() %>&#37 off</span>
                                 </p>
                                  <span class="ml-2" style="font-size:20px;">Stock :</span>
                                  <span class="ml-1" style="font-size:20px"><%if(p.getProductQuantity()<1){ %><span style="color:red;"><b><%=stock%></b></span><%} else{ %><%=p.getProductQuantity()%><% } %></span>
                             </div>
                            
                         </div>
                         
                       
                         <%
                             
                             }
                         %>
                     </div>
                 </div>
             </div>
            
         </div>
     <%
       }
     %> 
    
         
      <!-- ******* -->
 
   
         
    </div>
 </div>
</body>
</html>