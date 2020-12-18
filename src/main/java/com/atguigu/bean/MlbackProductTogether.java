package com.atguigu.bean;

public class MlbackProductTogether {
    private Integer producttogetherId;

    private String producttogetherName;

    private Integer producttogetherStatus;

    private String producttogetherProsidStr;

    private String producttogetherProsnameStr;

    private String producttogetherProsseoStr;

    private Integer producttogetherProsimgurlStr;

    private Integer producttogetherSupercateId;

    private String producttogetherSupercateName;

    private String producttogetherCreatetime;

    private String producttogetherMotifytime;

    public Integer getProducttogetherId() {
        return producttogetherId;
    }

    public void setProducttogetherId(Integer producttogetherId) {
        this.producttogetherId = producttogetherId;
    }

    public String getProducttogetherName() {
        return producttogetherName;
    }

    public void setProducttogetherName(String producttogetherName) {
        this.producttogetherName = producttogetherName == null ? null : producttogetherName.trim();
    }

    public Integer getProducttogetherStatus() {
        return producttogetherStatus;
    }

    public void setProducttogetherStatus(Integer producttogetherStatus) {
        this.producttogetherStatus = producttogetherStatus;
    }

    public String getProducttogetherProsidStr() {
        return producttogetherProsidStr;
    }

    public void setProducttogetherProsidStr(String producttogetherProsidStr) {
        this.producttogetherProsidStr = producttogetherProsidStr == null ? null : producttogetherProsidStr.trim();
    }

    public String getProducttogetherProsnameStr() {
        return producttogetherProsnameStr;
    }

    public void setProducttogetherProsnameStr(String producttogetherProsnameStr) {
        this.producttogetherProsnameStr = producttogetherProsnameStr == null ? null : producttogetherProsnameStr.trim();
    }

    public String getProducttogetherProsseoStr() {
        return producttogetherProsseoStr;
    }

    public void setProducttogetherProsseoStr(String producttogetherProsseoStr) {
        this.producttogetherProsseoStr = producttogetherProsseoStr == null ? null : producttogetherProsseoStr.trim();
    }

    public Integer getProducttogetherProsimgurlStr() {
        return producttogetherProsimgurlStr;
    }

    public void setProducttogetherProsimgurlStr(Integer producttogetherProsimgurlStr) {
        this.producttogetherProsimgurlStr = producttogetherProsimgurlStr;
    }

    public Integer getProducttogetherSupercateId() {
        return producttogetherSupercateId;
    }

    public void setProducttogetherSupercateId(Integer producttogetherSupercateId) {
        this.producttogetherSupercateId = producttogetherSupercateId;
    }

    public String getProducttogetherSupercateName() {
        return producttogetherSupercateName;
    }

    public void setProducttogetherSupercateName(String producttogetherSupercateName) {
        this.producttogetherSupercateName = producttogetherSupercateName == null ? null : producttogetherSupercateName.trim();
    }

    public String getProducttogetherCreatetime() {
        return producttogetherCreatetime;
    }

    public void setProducttogetherCreatetime(String producttogetherCreatetime) {
        this.producttogetherCreatetime = producttogetherCreatetime == null ? null : producttogetherCreatetime.trim();
    }

    public String getProducttogetherMotifytime() {
        return producttogetherMotifytime;
    }

    public void setProducttogetherMotifytime(String producttogetherMotifytime) {
        this.producttogetherMotifytime = producttogetherMotifytime == null ? null : producttogetherMotifytime.trim();
    }

	public MlbackProductTogether() {
		super();
	}

	public MlbackProductTogether(Integer producttogetherId, String producttogetherName, Integer producttogetherStatus,
			String producttogetherProsidStr, String producttogetherProsnameStr, String producttogetherProsseoStr,
			Integer producttogetherProsimgurlStr, Integer producttogetherSupercateId,
			String producttogetherSupercateName, String producttogetherCreatetime, String producttogetherMotifytime) {
		super();
		this.producttogetherId = producttogetherId;
		this.producttogetherName = producttogetherName;
		this.producttogetherStatus = producttogetherStatus;
		this.producttogetherProsidStr = producttogetherProsidStr;
		this.producttogetherProsnameStr = producttogetherProsnameStr;
		this.producttogetherProsseoStr = producttogetherProsseoStr;
		this.producttogetherProsimgurlStr = producttogetherProsimgurlStr;
		this.producttogetherSupercateId = producttogetherSupercateId;
		this.producttogetherSupercateName = producttogetherSupercateName;
		this.producttogetherCreatetime = producttogetherCreatetime;
		this.producttogetherMotifytime = producttogetherMotifytime;
	}

	@Override
	public String toString() {
		return "MlbackProductTogether [producttogetherId=" + producttogetherId + ", producttogetherName="
				+ producttogetherName + ", producttogetherStatus=" + producttogetherStatus
				+ ", producttogetherProsidStr=" + producttogetherProsidStr + ", producttogetherProsnameStr="
				+ producttogetherProsnameStr + ", producttogetherProsseoStr=" + producttogetherProsseoStr
				+ ", producttogetherProsimgurlStr=" + producttogetherProsimgurlStr + ", producttogetherSupercateId="
				+ producttogetherSupercateId + ", producttogetherSupercateName=" + producttogetherSupercateName
				+ ", producttogetherCreatetime=" + producttogetherCreatetime + ", producttogetherMotifytime="
				+ producttogetherMotifytime + "]";
	}
    
}