package com.atguigu.bean;

public class MlbackProductAttributeValue {
	
    private Integer productattrvalueId;

    private String productattrvalueName;

    private Integer productattrvaluePattributenameid;

    private Integer productattrvalueSort;

    private Integer productattrvaluePid;

    private Integer productattrvalueStatus;

    private String productattrvalueCreatetime;

    public Integer getProductattrvalueId() {
        return productattrvalueId;
    }

    public void setProductattrvalueId(Integer productattrvalueId) {
        this.productattrvalueId = productattrvalueId;
    }

    public String getProductattrvalueName() {
        return productattrvalueName;
    }

    public void setProductattrvalueName(String productattrvalueName) {
        this.productattrvalueName = productattrvalueName == null ? null : productattrvalueName.trim();
    }

    public Integer getProductattrvaluePattributenameid() {
        return productattrvaluePattributenameid;
    }

    public void setProductattrvaluePattributenameid(Integer productattrvaluePattributenameid) {
        this.productattrvaluePattributenameid = productattrvaluePattributenameid;
    }

    public Integer getProductattrvalueSort() {
        return productattrvalueSort;
    }

    public void setProductattrvalueSort(Integer productattrvalueSort) {
        this.productattrvalueSort = productattrvalueSort;
    }

    public Integer getProductattrvaluePid() {
        return productattrvaluePid;
    }

    public void setProductattrvaluePid(Integer productattrvaluePid) {
        this.productattrvaluePid = productattrvaluePid;
    }

    public Integer getProductattrvalueStatus() {
        return productattrvalueStatus;
    }

    public void setProductattrvalueStatus(Integer productattrvalueStatus) {
        this.productattrvalueStatus = productattrvalueStatus;
    }

    public String getProductattrvalueCreatetime() {
        return productattrvalueCreatetime;
    }

    public void setProductattrvalueCreatetime(String productattrvalueCreatetime) {
        this.productattrvalueCreatetime = productattrvalueCreatetime == null ? null : productattrvalueCreatetime.trim();
    }

	public MlbackProductAttributeValue() {
		super();
	}

	public MlbackProductAttributeValue(Integer productattrvalueId, String productattrvalueName,
			Integer productattrvaluePattributenameid, Integer productattrvalueSort, Integer productattrvaluePid,
			Integer productattrvalueStatus, String productattrvalueCreatetime) {
		super();
		this.productattrvalueId = productattrvalueId;
		this.productattrvalueName = productattrvalueName;
		this.productattrvaluePattributenameid = productattrvaluePattributenameid;
		this.productattrvalueSort = productattrvalueSort;
		this.productattrvaluePid = productattrvaluePid;
		this.productattrvalueStatus = productattrvalueStatus;
		this.productattrvalueCreatetime = productattrvalueCreatetime;
	}

	@Override
	public String toString() {
		return "MlbackProductAttributeValue [productattrvalueId=" + productattrvalueId + ", productattrvalueName="
				+ productattrvalueName + ", productattrvaluePattributenameid=" + productattrvaluePattributenameid
				+ ", productattrvalueSort=" + productattrvalueSort + ", productattrvaluePid=" + productattrvaluePid
				+ ", productattrvalueStatus=" + productattrvalueStatus + ", productattrvalueCreatetime="
				+ productattrvalueCreatetime + "]";
	}
    
}