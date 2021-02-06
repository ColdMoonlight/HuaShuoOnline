package com.atguigu.bean;

public class CheckRecover {
	
	/**
	 * SELECT torder.order_id,torder.order_status
,torder.order_createTime
from 
tb_mlfront_order as torder,
tb_mlfront_checkoutview as tbcheckout 
WHERE 
torder.order_id = tbcheckout.checkoutView_order_id 
AND (order_createTime BETWEEN '2020-12-17 18:20:15' and '2021-02-07 18:20:15')
GROUP BY torder.order_id
	 * 
	 * */
	
	private Integer orderId;
	private Integer orderStatus;
	private String orderCreatetime;
	private String startTime;
	private String endTime;
	public Integer getOrderId() {
		return orderId;
	}
	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}
	public Integer getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(Integer orderStatus) {
		this.orderStatus = orderStatus;
	}
	public String getOrderCreatetime() {
		return orderCreatetime;
	}
	public void setOrderCreatetime(String orderCreatetime) {
		this.orderCreatetime = orderCreatetime;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public CheckRecover() {
		super();
	}
	public CheckRecover(Integer orderId, Integer orderStatus, String orderCreatetime,
			String startTime, String endTime) {
		super();
		this.orderId = orderId;
		this.orderStatus = orderStatus;
		this.orderCreatetime = orderCreatetime;
		this.startTime = startTime;
		this.endTime = endTime;
	}
	@Override
	public String toString() {
		return "CheckRecover [orderId=" + orderId + ", orderStatus=" + orderStatus + ", orderCreatetime="
				+ orderCreatetime + ", startTime=" + startTime + ", endTime=" + endTime + "]";
	}

}
