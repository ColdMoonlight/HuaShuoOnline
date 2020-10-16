package com.atguigu.bean;

public class EmailPayPalRetuenSuccess {
    private Integer payretuensuccessId;

    private String payretuensuccessEmail;

    public Integer getPayretuensuccessId() {
        return payretuensuccessId;
    }

    public void setPayretuensuccessId(Integer payretuensuccessId) {
        this.payretuensuccessId = payretuensuccessId;
    }

    public String getPayretuensuccessEmail() {
        return payretuensuccessEmail;
    }

    public void setPayretuensuccessEmail(String payretuensuccessEmail) {
        this.payretuensuccessEmail = payretuensuccessEmail == null ? null : payretuensuccessEmail.trim();
    }

	public EmailPayPalRetuenSuccess() {
		super();
	}

	public EmailPayPalRetuenSuccess(Integer payretuensuccessId, String payretuensuccessEmail) {
		super();
		this.payretuensuccessId = payretuensuccessId;
		this.payretuensuccessEmail = payretuensuccessEmail;
	}

	@Override
	public String toString() {
		return "EmailPayPalRetuenSuccess [payretuensuccessId=" + payretuensuccessId + ", payretuensuccessEmail="
				+ payretuensuccessEmail + "]";
	}
    
}