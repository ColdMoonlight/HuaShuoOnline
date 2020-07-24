package com.atguigu.bean;

import java.math.BigDecimal;

public class MlbackCoupon {
	
    private Integer couponId;

    private String couponName;//满100减10块   手动输入

    private BigDecimal couponPrice;// 5  手动输入

    private BigDecimal couponPriceoff;// 5  手动输入

    private BigDecimal couponPriceBaseline;//100     使用的底钱，，减前满100.   手动输入

    private Integer couponStatus;//  0不生效,1生效中，，下拉选

    private String couponCode;//优惠码  如  OFF15,,,,OFF15%    手动输入  

    private String couponType;//优惠码类型  0满减的,1百分比折扣的(手动输入)

    private Integer couponLuckdrawType;//优惠码是否支持抽奖  0不支持抽奖,1支持抽奖    手动输入

    private Integer couponLuckdrawWeight;//优惠码抽奖权重 0--100%    手动输入

    private Integer couponTimes;//优惠码已经使用次数  如  999,998次

    private Integer couponAlltimes;//优惠码可以使用总次数  如  999,998次

    private String couponCreatetime;

    private String couponMotifytime;

    private String couponStarttime;//生效时间

    private String couponEndtime;//失效时间
    
    private String couponImgUrl;//优惠券Img

    private Integer couponProductonlyType;//优惠码是否支持单品

    private String couponProductonlyPidstr;//优惠码支持单品的时候,所绑定的产品

    private String couponProductseonamesstronlyPid;//优惠码支持单品的时候,所绑定的产品的seo

    private String couponProductpronamesstronlyPid;//优惠码支持单品的时候,所绑定的产品的proname

    public Integer getCouponId() {
        return couponId;
    }

    public void setCouponId(Integer couponId) {
        this.couponId = couponId;
    }

    public String getCouponName() {
        return couponName;
    }

    public void setCouponName(String couponName) {
        this.couponName = couponName == null ? null : couponName.trim();
    }

    public BigDecimal getCouponPrice() {
        return couponPrice;
    }

    public void setCouponPrice(BigDecimal couponPrice) {
        this.couponPrice = couponPrice;
    }

    public BigDecimal getCouponPriceoff() {
        return couponPriceoff;
    }

    public void setCouponPriceoff(BigDecimal couponPriceoff) {
        this.couponPriceoff = couponPriceoff;
    }

    public BigDecimal getCouponPriceBaseline() {
        return couponPriceBaseline;
    }

    public void setCouponPriceBaseline(BigDecimal couponPriceBaseline) {
        this.couponPriceBaseline = couponPriceBaseline;
    }

    public Integer getCouponStatus() {
        return couponStatus;
    }

    public void setCouponStatus(Integer couponStatus) {
        this.couponStatus = couponStatus;
    }

    public String getCouponCode() {
        return couponCode;
    }

    public void setCouponCode(String couponCode) {
        this.couponCode = couponCode == null ? null : couponCode.trim();
    }

    public String getCouponType() {
        return couponType;
    }

    public void setCouponType(String couponType) {
        this.couponType = couponType == null ? null : couponType.trim();
    }

    public Integer getCouponLuckdrawType() {
        return couponLuckdrawType;
    }

    public void setCouponLuckdrawType(Integer couponLuckdrawType) {
        this.couponLuckdrawType = couponLuckdrawType;
    }

    public Integer getCouponLuckdrawWeight() {
        return couponLuckdrawWeight;
    }

    public void setCouponLuckdrawWeight(Integer couponLuckdrawWeight) {
        this.couponLuckdrawWeight = couponLuckdrawWeight;
    }

    public Integer getCouponTimes() {
        return couponTimes;
    }

    public void setCouponTimes(Integer couponTimes) {
        this.couponTimes = couponTimes;
    }

    public Integer getCouponAlltimes() {
        return couponAlltimes;
    }

    public void setCouponAlltimes(Integer couponAlltimes) {
        this.couponAlltimes = couponAlltimes;
    }

    public String getCouponCreatetime() {
        return couponCreatetime;
    }

    public void setCouponCreatetime(String couponCreatetime) {
        this.couponCreatetime = couponCreatetime == null ? null : couponCreatetime.trim();
    }

    public String getCouponMotifytime() {
        return couponMotifytime;
    }

    public void setCouponMotifytime(String couponMotifytime) {
        this.couponMotifytime = couponMotifytime == null ? null : couponMotifytime.trim();
    }

    public String getCouponStarttime() {
        return couponStarttime;
    }

    public void setCouponStarttime(String couponStarttime) {
        this.couponStarttime = couponStarttime == null ? null : couponStarttime.trim();
    }

    public String getCouponEndtime() {
        return couponEndtime;
    }

    public void setCouponEndtime(String couponEndtime) {
        this.couponEndtime = couponEndtime == null ? null : couponEndtime.trim();
    }
    
    public String getCouponImgUrl() {
		return couponImgUrl;
	}

	public void setCouponImgUrl(String couponImgUrl) {
		this.couponImgUrl = couponImgUrl == null ? null : couponImgUrl.trim();
	}

	public Integer getCouponProductonlyType() {
        return couponProductonlyType;
    }

    public void setCouponProductonlyType(Integer couponProductonlyType) {
        this.couponProductonlyType = couponProductonlyType;
    }

    public String getCouponProductonlyPidstr() {
        return couponProductonlyPidstr;
    }

    public void setCouponProductonlyPidstr(String couponProductonlyPidstr) {
        this.couponProductonlyPidstr = couponProductonlyPidstr == null ? null : couponProductonlyPidstr.trim();
    }

    public String getCouponProductseonamesstronlyPid() {
        return couponProductseonamesstronlyPid;
    }

    public void setCouponProductseonamesstronlyPid(String couponProductseonamesstronlyPid) {
        this.couponProductseonamesstronlyPid = couponProductseonamesstronlyPid == null ? null : couponProductseonamesstronlyPid.trim();
    }

    public String getCouponProductpronamesstronlyPid() {
        return couponProductpronamesstronlyPid;
    }

    public void setCouponProductpronamesstronlyPid(String couponProductpronamesstronlyPid) {
        this.couponProductpronamesstronlyPid = couponProductpronamesstronlyPid == null ? null : couponProductpronamesstronlyPid.trim();
    }

	public MlbackCoupon() {
		super();
	}

	public MlbackCoupon(Integer couponId, String couponName, BigDecimal couponPrice, BigDecimal couponPriceoff,
			BigDecimal couponPriceBaseline, Integer couponStatus, String couponCode, String couponType,
			Integer couponLuckdrawType, Integer couponLuckdrawWeight, Integer couponTimes, Integer couponAlltimes,
			String couponCreatetime, String couponMotifytime, String couponStarttime, String couponEndtime,
			String couponImgUrl, Integer couponProductonlyType, String couponProductonlyPidstr,
			String couponProductseonamesstronlyPid, String couponProductpronamesstronlyPid) {
		super();
		this.couponId = couponId;
		this.couponName = couponName;
		this.couponPrice = couponPrice;
		this.couponPriceoff = couponPriceoff;
		this.couponPriceBaseline = couponPriceBaseline;
		this.couponStatus = couponStatus;
		this.couponCode = couponCode;
		this.couponType = couponType;
		this.couponLuckdrawType = couponLuckdrawType;
		this.couponLuckdrawWeight = couponLuckdrawWeight;
		this.couponTimes = couponTimes;
		this.couponAlltimes = couponAlltimes;
		this.couponCreatetime = couponCreatetime;
		this.couponMotifytime = couponMotifytime;
		this.couponStarttime = couponStarttime;
		this.couponEndtime = couponEndtime;
		this.couponImgUrl = couponImgUrl;
		this.couponProductonlyType = couponProductonlyType;
		this.couponProductonlyPidstr = couponProductonlyPidstr;
		this.couponProductseonamesstronlyPid = couponProductseonamesstronlyPid;
		this.couponProductpronamesstronlyPid = couponProductpronamesstronlyPid;
	}

	@Override
	public String toString() {
		return "MlbackCoupon [couponId=" + couponId + ", couponName=" + couponName + ", couponPrice=" + couponPrice
				+ ", couponPriceoff=" + couponPriceoff + ", couponPriceBaseline=" + couponPriceBaseline
				+ ", couponStatus=" + couponStatus + ", couponCode=" + couponCode + ", couponType=" + couponType
				+ ", couponLuckdrawType=" + couponLuckdrawType + ", couponLuckdrawWeight=" + couponLuckdrawWeight
				+ ", couponTimes=" + couponTimes + ", couponAlltimes=" + couponAlltimes + ", couponCreatetime="
				+ couponCreatetime + ", couponMotifytime=" + couponMotifytime + ", couponStarttime=" + couponStarttime
				+ ", couponEndtime=" + couponEndtime + ", couponImgUrl=" + couponImgUrl + ", couponProductonlyType="
				+ couponProductonlyType + ", couponProductonlyPidstr=" + couponProductonlyPidstr
				+ ", couponProductseonamesstronlyPid=" + couponProductseonamesstronlyPid
				+ ", couponProductpronamesstronlyPid=" + couponProductpronamesstronlyPid + "]";
	}
	
}