package com.ecommerce.pojo;

public class Cart
{
     private int cartId,userId,productId,quantity,price;
     
     public Cart()
     {
    	 
     }

	public Cart(int userId, int productId, int quantity, int price) {
		super();
		this.userId = userId;
		this.productId = productId;
		this.quantity = quantity;
		this.price = price;
	}

	public Cart(int cartId, int userId, int productId, int quantity, int price) {
		super();
		this.cartId = cartId;
		this.userId = userId;
		this.productId = productId;
		this.quantity = quantity;
		this.price = price;
	}

	public int getCartId() {
		return cartId;
	}

	public void setCartId(int cartId) {
		this.cartId = cartId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}
	
	
     
    
     
}
