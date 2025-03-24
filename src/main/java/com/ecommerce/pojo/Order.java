package com.ecommerce.pojo;

public class Order
{
    private int orderId,userId,prodctId,quantity,price;
    private String orderesDate,deliveryDate;
    
	public Order() {
		
	}

	public Order(int userId, int prodctId, int quantity, int price, String orderesDate, String deliveryDate) {
		super();
		this.userId = userId;
		this.prodctId = prodctId;
		this.quantity = quantity;
		this.price = price;
		this.orderesDate = orderesDate;
		this.deliveryDate = deliveryDate;
	}

	public Order(int orderId, int userId, int prodctId, int quantity, int price, String orderesDate,
			String deliveryDate) {
		super();
		this.orderId = orderId;
		this.userId = userId;
		this.prodctId = prodctId;
		this.quantity = quantity;
		this.price = price;
		this.orderesDate = orderesDate;
		this.deliveryDate = deliveryDate;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getProdctId() {
		return prodctId;
	}

	public void setProdctId(int prodctId) {
		this.prodctId = prodctId;
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

	public String getOrderesDate() {
		return orderesDate;
	}

	public void setOrderesDate(String orderesDate) {
		this.orderesDate = orderesDate;
	}

	public String getDeliveryDate() {
		return deliveryDate;
	}

	public void setDeliveryDate(String deliveryDate) {
		this.deliveryDate = deliveryDate;
	}
	
	
    
    
    
}
