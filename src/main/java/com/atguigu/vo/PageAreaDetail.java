package com.atguigu.vo;

public class PageAreaDetail {
	
	private Integer PageAreaDetailId;//第几个区域的第几个

    private Integer PageAreaDetailType;//这是个什么类型
    
    private String PageAreaDetaiLinklUrl;//图片url
    
    private String PageAreaDetaiImglUrl;//图片url
    
    private Integer PageAreaDetailIfinto;//是否可点击进入

	public Integer getPageAreaDetailId() {
		return PageAreaDetailId;
	}

	public void setPageAreaDetailId(Integer pageAreaDetailId) {
		PageAreaDetailId = pageAreaDetailId;
	}

	public Integer getPageAreaDetailType() {
		return PageAreaDetailType;
	}

	public void setPageAreaDetailType(Integer pageAreaDetailType) {
		PageAreaDetailType = pageAreaDetailType;
	}

	public String getPageAreaDetaiLinklUrl() {
		return PageAreaDetaiLinklUrl;
	}

	public void setPageAreaDetaiLinklUrl(String pageAreaDetaiLinklUrl) {
		PageAreaDetaiLinklUrl = pageAreaDetaiLinklUrl;
	}

	public String getPageAreaDetaiImglUrl() {
		return PageAreaDetaiImglUrl;
	}

	public void setPageAreaDetaiImglUrl(String pageAreaDetaiImglUrl) {
		PageAreaDetaiImglUrl = pageAreaDetaiImglUrl;
	}

	public Integer getPageAreaDetailIfinto() {
		return PageAreaDetailIfinto;
	}

	public void setPageAreaDetailIfinto(Integer pageAreaDetailIfinto) {
		PageAreaDetailIfinto = pageAreaDetailIfinto;
	}

	public PageAreaDetail() {
		super();
	}

	public PageAreaDetail(Integer pageAreaDetailId, Integer pageAreaDetailType, String pageAreaDetaiLinklUrl,
			String pageAreaDetaiImglUrl, Integer pageAreaDetailIfinto) {
		super();
		PageAreaDetailId = pageAreaDetailId;
		PageAreaDetailType = pageAreaDetailType;
		PageAreaDetaiLinklUrl = pageAreaDetaiLinklUrl;
		PageAreaDetaiImglUrl = pageAreaDetaiImglUrl;
		PageAreaDetailIfinto = pageAreaDetailIfinto;
	}

	@Override
	public String toString() {
		return "PageAreaDetail [PageAreaDetailId=" + PageAreaDetailId + ", PageAreaDetailType=" + PageAreaDetailType
				+ ", PageAreaDetaiLinklUrl=" + PageAreaDetaiLinklUrl + ", PageAreaDetaiImglUrl=" + PageAreaDetaiImglUrl
				+ ", PageAreaDetailIfinto=" + PageAreaDetailIfinto + "]";
	}

}
