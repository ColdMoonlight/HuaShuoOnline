package com.atguigu.bean;

public class CustomerWholesale {
	
    private Integer wholesaleId;

    private String wholesaleCustomerName;

    private String wholesaleCustomerEmail;
    
    private String wholesaleCustomerTelephone;

    private String wholesaleCustomerCountry;

    private String wholesaleCustomerWatsapp;

    private String wholesaleCustomerMessage;

    private String wholesaleCreatetime;

    private String wholesaleMotifytime;

    public Integer getWholesaleId() {
        return wholesaleId;
    }

    public void setWholesaleId(Integer wholesaleId) {
        this.wholesaleId = wholesaleId;
    }

    public String getWholesaleCustomerName() {
        return wholesaleCustomerName;
    }

    public void setWholesaleCustomerName(String wholesaleCustomerName) {
        this.wholesaleCustomerName = wholesaleCustomerName == null ? null : wholesaleCustomerName.trim();
    }

    public String getWholesaleCustomerEmail() {
        return wholesaleCustomerEmail;
    }

    public void setWholesaleCustomerEmail(String wholesaleCustomerEmail) {
        this.wholesaleCustomerEmail = wholesaleCustomerEmail == null ? null : wholesaleCustomerEmail.trim();
    }

    public String getWholesaleCustomerTelephone() {
		return wholesaleCustomerTelephone;
	}

	public void setWholesaleCustomerTelephone(String wholesaleCustomerTelephone) {
		this.wholesaleCustomerTelephone = wholesaleCustomerTelephone == null ? null : wholesaleCustomerTelephone.trim();
	}

	public String getWholesaleCustomerCountry() {
        return wholesaleCustomerCountry;
    }

    public void setWholesaleCustomerCountry(String wholesaleCustomerCountry) {
        this.wholesaleCustomerCountry = wholesaleCustomerCountry == null ? null : wholesaleCustomerCountry.trim();
    }

    public String getWholesaleCustomerWatsapp() {
        return wholesaleCustomerWatsapp;
    }

    public void setWholesaleCustomerWatsapp(String wholesaleCustomerWatsapp) {
        this.wholesaleCustomerWatsapp = wholesaleCustomerWatsapp == null ? null : wholesaleCustomerWatsapp.trim();
    }

    public String getWholesaleCustomerMessage() {
        return wholesaleCustomerMessage;
    }

    public void setWholesaleCustomerMessage(String wholesaleCustomerMessage) {
        this.wholesaleCustomerMessage = wholesaleCustomerMessage == null ? null : wholesaleCustomerMessage.trim();
    }

    public String getWholesaleCreatetime() {
        return wholesaleCreatetime;
    }

    public void setWholesaleCreatetime(String wholesaleCreatetime) {
        this.wholesaleCreatetime = wholesaleCreatetime == null ? null : wholesaleCreatetime.trim();
    }

    public String getWholesaleMotifytime() {
        return wholesaleMotifytime;
    }

    public void setWholesaleMotifytime(String wholesaleMotifytime) {
        this.wholesaleMotifytime = wholesaleMotifytime == null ? null : wholesaleMotifytime.trim();
    }

	public CustomerWholesale() {
		super();
	}

	public CustomerWholesale(Integer wholesaleId, String wholesaleCustomerName, String wholesaleCustomerEmail,
			String wholesaleCustomerTelephone, String wholesaleCustomerCountry, String wholesaleCustomerWatsapp,
			String wholesaleCustomerMessage, String wholesaleCreatetime, String wholesaleMotifytime) {
		super();
		this.wholesaleId = wholesaleId;
		this.wholesaleCustomerName = wholesaleCustomerName;
		this.wholesaleCustomerEmail = wholesaleCustomerEmail;
		this.wholesaleCustomerTelephone = wholesaleCustomerTelephone;
		this.wholesaleCustomerCountry = wholesaleCustomerCountry;
		this.wholesaleCustomerWatsapp = wholesaleCustomerWatsapp;
		this.wholesaleCustomerMessage = wholesaleCustomerMessage;
		this.wholesaleCreatetime = wholesaleCreatetime;
		this.wholesaleMotifytime = wholesaleMotifytime;
	}

	@Override
	public String toString() {
		return "CustomerWholesale [wholesaleId=" + wholesaleId + ", wholesaleCustomerName=" + wholesaleCustomerName
				+ ", wholesaleCustomerEmail=" + wholesaleCustomerEmail + ", wholesaleCustomerTelephone="
				+ wholesaleCustomerTelephone + ", wholesaleCustomerCountry=" + wholesaleCustomerCountry
				+ ", wholesaleCustomerWatsapp=" + wholesaleCustomerWatsapp + ", wholesaleCustomerMessage="
				+ wholesaleCustomerMessage + ", wholesaleCreatetime=" + wholesaleCreatetime + ", wholesaleMotifytime="
				+ wholesaleMotifytime + "]";
	}

}