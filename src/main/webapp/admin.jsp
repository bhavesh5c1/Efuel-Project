<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>    
    <%@ page import ="com.ecommerce.pojo.*"%>
    <%@ page import ="com.ecommerce.dao.*"%>
    <%@ page import ="java.sql.*"%>
    <%@ page import ="java.util.*"%>

    <%
         User user2=(User)session.getAttribute("active-user");
         if(user2==null)
         {
        	 session.setAttribute("message","You are not logged in! Login first...");
		     response.sendRedirect("login.jsp");
		     return;
         }
         
         else
         {
             if(user2.getUserType().equals("normal"))
             {
            	 session.setAttribute("message","You are not Admin! Do not Access this...");
                 session.removeAttribute("active-user");
                 response.sendRedirect("login.jsp");
    		     return;
             }     
         }
    %>
    
    <%
        List<Category> li=new CategoryDaoImp().getAllCategory(); 
    %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Page-eFuel</title>
<%@ include file="components/common_cs_js.jsp"%>

</head>
<body>
 <%@ include file="components/navbar.jsp"%>
  
 <div class="container admin mt-2">
     <%@ include file="components/message.jsp"%>
      <div class="row mt-3">
           <div class="col-md-4">
                 <div class="card hover" data-toggle="modal" data-target="#show-users-modal">
                     <div class="card-body text-center">
                         <div class="container">
                             <img style="max-width:120px" class="img-fluid rounded-circle" src="images/user.png" alt="users_pic" >
                         </div>
                         <h1><%=new UserDaoImp().getTotalUser() %></h1>
                         <h2 class="text-uppercase text-muted">Users</h2>
                     </div>
                 </div>
           </div>
           
           <div class="col-md-4">
                  <div class="card hover" data-toggle="modal" data-target="#show-category-modal">
                     <div class="card-body text-center">
                          <div class="container">
                             <img style="max-width:120px" class="img-fluid rounded-circle" src="images/category.png" alt="users_pic" >
                         </div>
                          <h1><%=new CategoryDaoImp().getTotalCategory() %></h1>
                          <h2 class="text-uppercase text-muted">Total Category</h2>
                     </div>
                 </div>
           </div>
           
           <div class="col-md-4">
                  <div class="card hover" data-toggle="modal" data-target="#show-product-modal">
                     <div class="card-body text-center">
                           <div class="container">
                             <img style="max-width:120px" class="img-fluid rounded-circle" src="images/product.png" alt="users_pic" >
                           </div>
                           <h1><%=new ProductDaoImp().getTotalProduct() %></h1>
                           <h2 class="text-uppercase text-muted">Total Products</h2>
                     </div>
                 </div>
           </div>
      </div>
      
      <div class="row mt-3" >
           <div class="col-md-4">
                 <div class="card hover" data-toggle="modal" data-target="#total-order-modal">
                     <div class="card-body text-center">
                         <div class="container">
                             <img style="max-width:120px" class="img-fluid rounded-circle" src="images/check.png" alt="users_pic" >
                         </div>
                         <h1 class="text-lowercase text-muted"><%=new OrderDaoImp().totalOrdersCount() %></h1>
                         <h2 class="text-uppercase text-muted">Total Orders</h2>
                     </div>
                 </div>
           </div>
           
           <div class="col-md-4">
                  <div class="card hover" data-toggle="modal" data-target="#add-category-modal">
                     <div class="card-body text-center">
                          <div class="container md-5">
                             <img style="max-width:120px" class="img-fluid rounded-circle" src="images/addCategory.jpg" alt="users_pic" >
                         </div>
                          <p class="text-lowercase text-muted mt-2 " style="font-size:22px">click to add category</p>
                          <h2 class="text-uppercase text-muted mt-1">Add Category</h2>
                     </div>
                 </div>
           </div>
           
           <div class="col-md-4">
                  <div class="card hover" data-toggle="modal" data-target="#add-product-modal">
                     <div class="card-body text-center">
                          <div class="container">
                             <img style="max-width:120px" class="img-fluid rounded-circle" src="images/addproduct.png" alt="users_pic" >
                         </div>
                          <p class="text-lowercase text-muted mt-2 " style="font-size:22px">click to add product</p>
                          <h2 class="text-uppercase text-muted">Add Product</h2>
                     </div>
                 </div>
           </div>
           
      </div>
      
 </div> 
  
<!-- add category modal -->
     
<div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white">
        <h5 class="modal-title" id="exampleModalLongTitle" >Fill category details.</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <form action="ProductOperationServlet" method="post">
               <input type="hidden" name="action" value="addCategory">
               <div class="form-group">
                   <input type="text" class="form-control" name="categoryTitle" placeholder="Enter Category Title here" required>
               </div>
               
               <div class="form-group">
                   <textarea style="height:250px" class="form-control" name="categoryDescription" placeholder="Enter Category Description here" required></textarea>
               </div>
               
               <div class="container text-center">
                   <button class="btn custom-bg text-white">Add Category</button>
                   <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
               </div>   
          </form>
      </div>
    </div>
  </div>
</div>
      
      
  <!-- end add category modal -->
  
  <!-- add product modal -->
     
<div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white">
        <h5 class="modal-title" id="exampleModalLongTitle" >Add Product details.</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
               <input type="hidden" name="action" value="addProduct">
               <div class="form-group">
                   <input type="text" class="form-control" name="productTitle" placeholder="Enter Product Title here" required>
               </div>
               
               <div class="form-group">
                   <textarea style="height:150px" class="form-control" name="productDescription" placeholder="Enter Product Description here" required></textarea>
               </div>
               
               <div class="form-group">
                   <input type="number" class="form-control" name="productPrice" placeholder="Enter Product Price here" required>
               </div>
               
               <div class="form-group">
                   <input type="text" class="form-control" name="productQuantity" placeholder="Enter Product Quantity here" required>
               </div>
               
               <div class="form-group">
                   <input type="text" class="form-control" name="productDiscount" placeholder="Enter Product Discount in (%)" required>
               </div>
               
               <div class="form-group">
                   <select name="productCategoryId" class="form-control">
                       <option value="">Select Category</option>
                       <%
                           for(Category category:li)
                           {
                       %>
                       <option value="<%=category.getCategoryId()%>"><%=category.getCategoryTitle() %></option>
                       <%
                           }
                       %>
                   </select>
               </div>
               
               <div class="form-group">
                   <label>Select Product Pic</label><br>
                   <input type="file" class="form-control" name="productPic" required>
               </div>
               
               <div class="container text-center">
                   <button class="btn custom-bg text-white">Add Product</button>
                   <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
               </div>   
          </form>
      </div>
    </div>
  </div>
</div>   
   
  <!-- end add product modal -->
  
  <!-- show users modal -->
     
<div class="modal fade" id="show-users-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Total Users</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="table-responsive">
          <table class="table">
  <thead class="custom-bg text-white">
    <tr>
      <th scope="col">User Id</th>
      <th scope="col">Photo</th>
      <th scope="col">Name</th>
      <th scope="col">Email</th>
      <th scope="col">Mobile</th>
      <th scope="col">Address</th>
    </tr>
  </thead>
  <tbody>
   <%
      UserDaoImp udao=new UserDaoImp();
      List<User> l=udao.getAllUser("normal");
   %>
  
   <%
      for(User u:l)
      {
   %>
    <tr>
      <th scope="row" class="mid-align"><%=u.getUserId() %></th>
      <td><img style="max-width:70px" class="img-fluid rounded-circle" src="userProfilePic/<%=u.getUserPic() %>" alt="users_pic" ></td>
      <td class="mid-align"><%=u.getUserName() %></td>
      <td class="mid-align"><%=u.getUserEmail() %></td>
      <td class="mid-align"><%=u.getUserPhone() %></td>
      <td class="mid-align"><%=u.getUserAddress() %></td>
    </tr>
    <%
      }
    %>
  </tbody>
</table>
</div>
      </div>
    </div>
  </div>
</div>
        
<!-- end of show users modal -->

<!-- show category modal -->

<div class="modal fade" id="show-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Total Category</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="table-responsive">
          <table class="table">
  <thead class="custom-bg text-white">
    <tr>
      <th scope="col">Category Id</th>
      <th scope="col">Category Name</th>
      <th scope="col">Category Description</th>
      <th scope="col">Action</th>
    </tr>
  </thead>
  <tbody>
   <%
      CategoryDaoImp cd=new CategoryDaoImp();
      List<Category> lc=cd.getAllCategory();
   %>
  
   <%
      for(Category c:lc)
      {
   %>
    <tr>
      <td class="mid-align"><%=c.getCategoryId() %></td>
      <td class="mid-align"><%=c.getCategoryTitle() %></td>
      <td class="mid-align"><%=c.getCategoryDescription() %></td>
      <td class="mid-align"><a href="ProductOperationServlet?categoryId=<%=c.getCategoryId()%>&action=deleteCategory"><input type="submit" class="btn btn-danger" value="Delete"></a></td>
    </tr>
    <%
      }
    %>
  </tbody>
</table>
</div>
      </div>
    </div>
  </div>
</div>

<!-- ********************* -->

<!-- show Product modal -->

<div class="modal fade" id="show-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Total Product</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="table-responsive">
          <table class="table">
  <thead class="custom-bg text-white">
    <tr>
      <th scope="col">Product Name</th>
      <th scope="col">Product Image</th>
      <th scope="col">Product Description</th>
      <th scope="col">Product Category</th>
      <th scope="col">Product Price</th>
      <th scope="col">Product Discount</th>
      <th scope="col">Product Quantity</th>
    </tr>
  </thead>
  <tbody>
   <%
      ProductDaoImp pd=new ProductDaoImp();
      List<Product> lp=pd.getAllProduct();
      CategoryDaoImp c=new CategoryDaoImp();
   %>
  
   <%
      for(Product p:lp)
      {
   %>
    <tr>
      <td class="mid-align"><%=p.getProductTitle() %></td>
      <td class="mid-align"><img style="max-width:70px" class="img-fluid" src="productImages/<%=p.getProductPhoto() %>" alt="users_pic" ></td>
      <td class="mid-align"><%=p.getProductDescription()%></td>
       <td class="mid-align"><%=c.getCategoryNameById(p.getCategoryId()) %></td>
      <td class="mid-align"><%=p.getProductPrice() %></td>
      <td class="mid-align"><%=p.getProductDiscount() %></td>
      <td class="mid-align"><%=p.getProductQuantity() %></td>
    </tr>
    <%
      }
    %>
  </tbody>
</table>
</div>
      </div>
    </div>
  </div>
</div>

<!-- ********************* -->

<!-- total order modal -->

<div class="modal fade bd-example-modal-lg" id="total-order-modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-size" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >TOTAL ORDERS</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
    
      <div class="modal-body">
        
        <%
            List<Order> lor=new OrderDaoImp().getAllOrder();
            if(lor.isEmpty())
            {
        %>
        <div class="text-center">
        <h1>NO ORDERS MADE BY ANYONE !!</h1>
        <hr>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        <%
            }
        
            else
            {
            	
            	
        %>
        <div class="table-responsive">
          <table class="table">
  <thead class="custom-bg text-white">
    <tr class="text-center">
      <th scope="col">User Id</th>
      <th scope="col">User Name</th>
      <th scope="col">User Email</th>
      <th scope="col">User Phone</th>
      <th scope="col">Product Image</th>
      <th scope="col">Product Title</th>    
      <th scope="col">Qnty</th>
      <th scope="col">Price</th>
      <th scope="col">Ord. date</th>
      <th scope="col">Del. date</th>
      <th scope="col">Set Delivery date</th>
    </tr>
  </thead>
  
 
  
  <tbody>
  
   <%
      for(Order o:lor)
      {
    	  int productId=o.getProdctId();
    	  Product p1=new ProductDaoImp().getProductById(productId);
    	  User us=new UserDaoImp().getUserByUserId(o.getUserId());
   %>
    <tr class="text-center">
      <td class="mid-align"><%=us.getUserId() %></td>
      <td class="mid-align"><%=us.getUserName() %></td>
      <td class="mid-align"><%=us.getUserEmail() %></td>
      <td class="mid-align"><%=us.getUserPhone() %></td>
      <td><img style="max-height:100px;max-width:70px;width:auto;" class="img-fluid mx-auto d-block" src="productImages/<%=p1.getProductPhoto() %>" alt="users_pic" ></td>
      <td class="mid-align"><%=p1.getProductTitle() %></td>
      <td class="mid-align"><%=o.getQuantity() %></td>
      <td class="mid-align"><%=o.getPrice() %></td>
      <td class="mid-align"><%=o.getOrderesDate() %></td>
      <td class="mid-align"><%if(o.getDeliveryDate().equals("0")){ %><span style="color:red;"> <%="NA"%></span>    <%} else { %> <%=o.getDeliveryDate() %><%} %></td>
      <td class="mid-align">
      <form action="OrderServlet" method="post">
          <input type="hidden" name="action" value="addDelivery">
          <input type="hidden" name="userId" value=<%=us.getUserId() %>>
          <input type="hidden" name="productId" value="<%=p1.getProductId()%>">
          <input type="hidden" name="orderId" value="<%=o.getOrderId()%>">
          <div class="form-group mx-sm-3 mb-2">
            <input type="text" class="form-control" name="deliveryDate" placeholder="Delivery Date" size="85" required>
          </div>
          <button type="submit" class="btn custom-bg text-white mb-2">Set</button>
     </form>
     </td>
    </tr>
    <%
      }
    %>
  </tbody>
 
  
</table>
</div>
<hr>

<div class="text-center">
      <button type="button" class="btn btn-secondary ml-5" data-dismiss="modal">Close</button>
</div>
       <%
            }
       %>
         
      </div>
    </div>
  </div>
</div>

<!--  -->
  
</body>
</html>