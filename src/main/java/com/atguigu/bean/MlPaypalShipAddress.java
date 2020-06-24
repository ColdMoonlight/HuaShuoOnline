package com.atguigu.bean;

public class MlPaypalShipAddress {
	
    private Integer shippingaddressId;

    private String shippingaddressPayinfoid;

    private String shippingaddressPaymentid;

    private String shippingaddressRecipientName;

    private String shippingaddressCountryCode;

    private String shippingaddressCity;

    private String shippingaddressLine1;

    private String shippingaddressLine2;

    private String shippingaddressPostalCode;

    private String shippingaddressEmail;

    private String shippingaddressState;

    private String shippingaddressCreatetime;

    private String shippingaddressMotifytime;

    public Integer getShippingaddressId() {
        return shippingaddressId;
    }

    public void setShippingaddressId(Integer shippingaddressId) {
        this.shippingaddressId = shippingaddressId;
    }

    public String getShippingaddressPayinfoid() {
        return shippingaddressPayinfoid;
    }

    public void setShippingaddressPayinfoid(String shippingaddressPayinfoid) {
        this.shippingaddressPayinfoid = shippingaddressPayinfoid == null ? null : shippingaddressPayinfoid.trim();
    }

    public String getShippingaddressPaymentid() {
        return shippingaddressPaymentid;
    }

    public void setShippingaddressPaymentid(String shippingaddressPaymentid) {
        this.shippingaddressPaymentid = shippingaddressPaymentid == null ? null : shippingaddressPaymentid.trim();
    }

    public String getShippingaddressRecipientName() {
        return shippingaddressRecipientName;
    }

    public void setShippingaddressRecipientName(String shippingaddressRecipientName) {
        this.shippingaddressRecipientName = shippingaddressRecipientName == null ? null : shippingaddressRecipientName.trim();
    }

    public String getShippingaddressCountryCode() {
        return shippingaddressCountryCode;
    }

    public void setShippingaddressCountryCode(String shippingaddressCountryCode) {
        this.shippingaddressCountryCode = shippingaddressCountryCode == null ? null : shippingaddressCountryCode.trim();
    }

    public String getShippingaddressCity() {
        return shippingaddressCity;
    }

    public void setShippingaddressCity(String shippingaddressCity) {
        this.shippingaddressCity = shippingaddressCity == null ? null : shippingaddressCity.trim();
    }

    public String getShippingaddressLine1() {
        return shippingaddressLine1;
    }

    public void setShippingaddressLine1(String shippingaddressLine1) {
        this.shippingaddressLine1 = shippingaddressLine1 == null ? null : shippingaddressLine1.trim();
    }

    public String getShippingaddressLine2() {
        return shippingaddressLine2;
    }

    public void setShippingaddressLine2(String shippingaddressLine2) {
        this.shippingaddressLine2 = shippingaddressLine2 == null ? null : shippingaddressLine2.trim();
    }

    public String getShippingaddressPostalCode() {
        return shippingaddressPostalCode;
    }

    public void setShippingaddressPostalCode(String shippingaddressPostalCode) {
        this.shippingaddressPostalCode = shippingaddressPostalCode == null ? null : shippingaddressPostalCode.trim();
    }

    public String getShippingaddressEmail() {
        return shippingaddressEmail;
    }

    public void setShippingaddressEmail(String shippingaddressEmail) {
        this.shippingaddressEmail = shippingaddressEmail == null ? null : shippingaddressEmail.trim();
    }

    public String getShippingaddressState() {
        return shippingaddressState;
    }

    public void setShippingaddressState(String shippingaddressState) {
        this.shippingaddressState = shippingaddressState == null ? null : shippingaddressState.trim();
    }

    public String getShippingaddressCreatetime() {
        return shippingaddressCreatetime;
    }

    public void setShippingaddressCreatetime(String shippingaddressCreatetime) {
        this.shippingaddressCreatetime = shippingaddressCreatetime == null ? null : shippingaddressCreatetime.trim();
    }

    public String getShippingaddressMotifytime() {
        return shippingaddressMotifytime;
    }

    public void setShippingaddressMotifytime(String shippingaddressMotifytime) {
        this.shippingaddressMotifytime = shippingaddressMotifytime == null ? null : shippingaddressMotifytime.trim();
    }

	public MlPaypalShipAddress() {
		super();
	}

	public MlPaypalShipAddress(Integer shippingaddressId, String shippingaddressPayinfoid,
			String shippingaddressPaymentid, String shippingaddressRecipientName, String shippingaddressCountryCode,
			String shippingaddressCity, String shippingaddressLine1, String shippingaddressLine2,
			String shippingaddressPostalCode, String shippingaddressEmail, String shippingaddressState,
			String shippingaddressCreatetime, String shippingaddressMotifytime) {
		super();
		this.shippingaddressId = shippingaddressId;
		this.shippingaddressPayinfoid = shippingaddressPayinfoid;
		this.shippingaddressPaymentid = shippingaddressPaymentid;
		this.shippingaddressRecipientName = shippingaddressRecipientName;
		this.shippingaddressCountryCode = shippingaddressCountryCode;
		this.shippingaddressCity = shippingaddressCity;
		this.shippingaddressLine1 = shippingaddressLine1;
		this.shippingaddressLine2 = shippingaddressLine2;
		this.shippingaddressPostalCode = shippingaddressPostalCode;
		this.shippingaddressEmail = shippingaddressEmail;
		this.shippingaddressState = shippingaddressState;
		this.shippingaddressCreatetime = shippingaddressCreatetime;
		this.shippingaddressMotifytime = shippingaddressMotifytime;
	}

	@Override
	public String toString() {
		return "MlPaypalShipAddress [shippingaddressId=" + shippingaddressId + ", shippingaddressPayinfoid="
				+ shippingaddressPayinfoid + ", shippingaddressPaymentid=" + shippingaddressPaymentid
				+ ", shippingaddressRecipientName=" + shippingaddressRecipientName + ", shippingaddressCountryCode="
				+ shippingaddressCountryCode + ", shippingaddressCity=" + shippingaddressCity
				+ ", shippingaddressLine1=" + shippingaddressLine1 + ", shippingaddressLine2=" + shippingaddressLine2
				+ ", shippingaddressPostalCode=" + shippingaddressPostalCode + ", shippingaddressEmail="
				+ shippingaddressEmail + ", shippingaddressState=" + shippingaddressState
				+ ", shippingaddressCreatetime=" + shippingaddressCreatetime + ", shippingaddressMotifytime="
				+ shippingaddressMotifytime + "]";
	}
    
}