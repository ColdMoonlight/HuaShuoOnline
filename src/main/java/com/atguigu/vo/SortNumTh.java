package com.atguigu.vo;

public class SortNumTh {
	
	private String SeoString;

    private Integer SeoStringCount;

	public String getSeoString() {
		return SeoString;
	}

	public void setSeoString(String seoString) {
		SeoString = seoString;
	}

	public Integer getSeoStringCount() {
		return SeoStringCount;
	}

	public void setSeoStringCount(Integer seoStringCount) {
		SeoStringCount = seoStringCount;
	}

	public SortNumTh() {
		super();
	}

	public SortNumTh(String seoString, Integer seoStringCount) {
		super();
		SeoString = seoString;
		SeoStringCount = seoStringCount;
	}

	@Override
	public String toString() {
		return "SortNumTh [SeoString=" + SeoString + ", SeoStringCount=" + SeoStringCount + "]";
	}
    
}
