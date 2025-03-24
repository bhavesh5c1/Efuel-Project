<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="com.ecommerce.pojo.*"%>
    <%@ page import ="com.ecommerce.dao.*"%>
    <%@ page import ="java.sql.*"%>
    <%@ page import ="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%=new ProductDaoImp().getProductById(Integer.parseInt(request.getParameter("productId"))).getProductTitle() %></title>
<%@ include file="components/common_cs_js.jsp"%>
<script type="text/javascript">
      function checkUser()
      {
    	  <%
    	      User u=(User)session.getAttribute("active-user"); 
    	      if(u!=null)
    	      {
    	    	  if(u.getUserType().equals("normal"))
    	    	  {
    	  %>
    	             return  true;
    	          <%
    	    	  }
    	    	  
    	    	  else
    	    	  {	  
    	    	  %>
    	    	  alert("Please login as customer to buy the product.");
    	    	  return false;
    	    	  <%
    	    	  }
    	    	  
    	      }
    	      else
    	      {
    	  %>
    	    	  alert("Please login to buy the product.");
    	    	  return false;
    	  <%
    	      }
    	  %>
      }
</script>
</head>
<body>
<%@ include file="components/navbar.jsp"%>
<%@ include file="components/message.jsp"%>

<%
     int productId=Integer.parseInt((String)request.getParameter("productId"));
     Product product=new ProductDaoImp().getProductById(productId);
     int catId=new CategoryDaoImp().getCategoryIdByProductId(productId);
     String stock="Out Of Stock!!!"; 
%>

<div class="container-fluid">
   <div class="row">
         <div class="col-md-2" >
             <div class="list-group mt-4">
                 <a href="index.jsp?category=0" class="list-group-item list-group-item-action">All Categories</a>
               <%
                    for(Category c: cl)
                    {    	
               %>      
                         <a href="index.jsp?category=<%=c.getCategoryId() %>" class="list-group-item list-group-item-action  <%if(catId==c.getCategoryId()){ %> active custom-bg<%} %>" <%if(catId==c.getCategoryId()){ %> style="border:#ff9800"<%} %>><%=c.getCategoryTitle() %></a>
               <%
                    }
               %>
             </div>
        </div> 
        
        <div class="col-sm-3 mt-4 admin">
              <div class="card">
                   <img src="productImages/<%=product.getProductPhoto() %>" style="max-height:500px;max-width:100%;width:auto;" class="card-img-top rounded mx-auto d-block m-2" alt="img">
              </div>
        </div>
        
        <div class="col-sm-6 mt-4 admin">
              <div class="card">
                   <div class="card-header text-center">
                        <h1><%=product.getProductTitle() %></h1>
                   </div>
                    <div class="text-left ml-3 mt-3"><h2>Description :</h2></div>
                        <div class="card-body text-left">     
                                 <h4 class="card-text"><%=product.getProductDescription() %></h4> 
                        </div>
                        <div class="card-footer text-center">
                                 <p style="font-size:35px"><span style="font-size:35px;"><b>Price :</b></span><span class="ml-2"><b>&#8377;<%=Helper.getProductSellingPrice(product.getProductPrice(), product.getProductDiscount()) %>/-</b></span>
                                 <span class="ml-2" style="font-size:30px;color:red"><s>&#8377;<%=product.getProductPrice()%></s></span>
                                  <span class="ml-2" style="font-size:25px;color:green"><%=product.getProductDiscount() %>&#37 off</span>
                                  <span class="ml-5" style="font-size:22px;">Stock :</span>
                                  <span class="ml-1" style="font-size:20px"><%if(product.getProductQuantity()<1){ %><span style="color:red;"><b><%=stock%></b></span><%} else{ %><%=product.getProductQuantity()%><% } %></span>
                                 </p>
                                 <hr>
                                 
                               <%
                                   if(u==null)
                                   {
                               %>
                               
                               <form class="form-inline" onclick="return checkUser()">
                                  <div class="form-group mx-sm-3 mb-2">
                                      <input type="number" class="form-control" id="quan" name="quantity" placeholder="Quantity" required>
                                  </div>
                                  <button type="submit" class="btn custom-bg text-white mb-2">Add To Cart</button>
                               </form>
                              
                              <%
                                   }
                               
                                   else
                                   {
                              %> 
                                       <%
                                           if(u.getUserType().equals("admin"))
                                           {
                                       %>
                                      <a href="ProductOperationServlet?productId=<%=request.getParameter("productId")%>&action=delete"><button type="button" class="btn btn-danger">Delete Product</button></a>
                                      <button type="button" class="btn custom-bg text-light ml-5" data-toggle="modal" data-target="#update-product-modal">Update Product</button>
                                      
                                      <%
                                           }
                                           
                                           else
                                           {
                                      %>
                                               <form class="form-inline" onclick="return checkUser()" action="CartServlet" method="post">
                                                 <input type="hidden" name="action" value="addToCart">
                                                 <input type="hidden" name="productId" value="<%=productId%>">
                                                 <div class="form-group mx-sm-3 mb-2">
                                                   <input type="number" class="form-control" id="quan" name="quantity" placeholder="Quantity" required>
                                                 </div>
                                               <input type="submit" class="btn custom-bg text-white mb-2" value="Add To Cart">
                                               
                                              </form>
                                      <%
                                           }
                                      %>
                              <%
                                   }
                              %>
                        </div>
                   </div>
              </div>
        </div>
    
    <%
          int categoryId=new CategoryDaoImp().getCategoryIdByProductId(Integer.parseInt((String)request.getParameter("productId")));
          List<Product> lp=new ProductDaoImp().getProductByCategory(categoryId);
    %>
    
    
    
     <div class="row">
         <div class="col-md-2" >
             
         </div>    
   
         <div class="col-md-10">
               <div class="mt-4"><span style="font-size:35px;"><b>RELATED PRODUCTS :</b></span></div>
         </div>
   </div>
   
   <!-- ****************************************** -->

   <!-- show products -->
   
    <div class="row">
         <div class="col-md-2" >
             
         </div>  
     
     <div class="col-md-10">
         
             <div class="row mt-4">
                 <div class="col-md-12 admin">
                     <div class="card-columns">
                     
                         <%
                        
                             for(Product p:lp)
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
       
      
   </div>
    <!-- ******* -->
    
    <!-- update product modal -->
    
    <div class="modal fade" id="update-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white">
        <h5 class="modal-title" id="exampleModalLongTitle" >Update Product.</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
          <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
          
          <input type="hidden" name="action" value="updateProduct">
          <input type="hidden" name="productId" value="<%=productId%>">
        
     <div class="container text-center">
                   <img style="max-width:200px" class="img-fluid" src="productImages/<%=product.getProductPhoto() %>" alt="users_pic" >
                   <h3><%=product.getProductPhoto() %></h3>
         </div> 
     
    <div class="form-group">
      <label for="inputEmail4">Product Title</label>
      <input type="text" class="form-control" name="productTitle" value="<%=product.getProductTitle() %>" required>
    </div>
    <div class="form-group">
      <label for="inputEmail4">Product Description</label>
      <textarea class="form-control"rows="4" name="productDescription" required><%=product.getProductDescription() %></textarea>
    </div>
    <div class="form-row">
    <div class="form-group col-md-4">
      <label for="inputEmail4">Product Price</label>
      <input type="number" class="form-control" name="productPrice" value=<%=product.getProductPrice() %> required>
    </div>
    <div class="form-group col-md-4">
      <label for="inputPassword4">Product Discount</label>
      <input type="number" class="form-control" name="productDiscount" value=<%=product.getProductDiscount() %> required>
    </div>
    <div class="form-group col-md-4">
      <label for="inputPassword4">Product Quantity</label>
      <input type="number" class="form-control" name="productQuantity" value=<%=product.getProductQuantity() %> required>
    </div>
   </div>
   
               <div class="form-group">
                   <label>Select Product Pic</label><br>
                   <input type="file" class="form-control" name="productPhoto" required>     
               </div>

   
   <div class="container text-center">
                   <input type="submit" class="btn custom-bg text-white" value="Update Product">
                   <!-- <button type="button" class="btn btn-secondary ml-5" data-dismiss="modal">Close</button> -->
               </div> 
    
</form>   
         
      </div>
    </div>
  </div>
</div>   
    <!-- *********************************** -->
     
</div>
</body>
</html>