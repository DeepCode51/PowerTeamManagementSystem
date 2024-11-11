package com.powerteam.model.crm;

import com.powerteam.model.masterData.District;
import lombok.Data;

import java.util.Date;

@Data
public class Customer {

	private Integer customerId;
	private String customerName;
	private Byte industryId;
	private Byte categoryId;
	private String website;
	private String tel;
	private Byte star;
	private String address;
	private Integer provinceId;
	private Integer cityId;
	private Integer sourceId;
	private Float lng;
	private Float lat;
	private Boolean potential;
	private Date createDate;
	private Integer createBy;
	private Integer owner;

	private Industry industry;
	private CustomerCategory customerCategory;
	private Source source;

	private District province;
	private District city;

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public Byte getIndustryId() {
		return industryId;
	}

	public void setIndustryId(Byte industryId) {
		this.industryId = industryId;
	}

	public Byte getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Byte categoryId) {
		this.categoryId = categoryId;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public Byte getStar() {
		return star;
	}

	public void setStar(Byte star) {
		this.star = star;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Integer getProvinceId() {
		return provinceId;
	}

	public void setProvinceId(Integer provinceId) {
		this.provinceId = provinceId;
	}

	public Integer getCityId() {
		return cityId;
	}

	public void setCityId(Integer cityId) {
		this.cityId = cityId;
	}

	public Integer getSourceId() {
		return sourceId;
	}

	public void setSourceId(Integer sourceId) {
		this.sourceId = sourceId;
	}

	public Float getLng() {
		return lng;
	}

	public void setLng(Float lng) {
		this.lng = lng;
	}

	public Float getLat() {
		return lat;
	}

	public void setLat(Float lat) {
		this.lat = lat;
	}

	public Boolean getPotential() {
		return potential;
	}

	public void setPotential(Boolean potential) {
		this.potential = potential;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Integer getCreateBy() {
		return createBy;
	}

	public void setCreateBy(Integer createBy) {
		this.createBy = createBy;
	}

	public Integer getOwner() {
		return owner;
	}

	public void setOwner(Integer owner) {
		this.owner = owner;
	}

	public Industry getIndustry() {
		return industry;
	}

	public void setIndustry(Industry industry) {
		this.industry = industry;
	}

	public CustomerCategory getCustomerCategory() {
		return customerCategory;
	}

	public void setCustomerCategory(CustomerCategory customerCategory) {
		this.customerCategory = customerCategory;
	}

	public Source getSource() {
		return source;
	}

	public void setSource(Source source) {
		this.source = source;
	}

	public District getProvince() {
		return province;
	}

	public void setProvince(District province) {
		this.province = province;
	}

	public District getCity() {
		return city;
	}

	public void setCity(District city) {
		this.city = city;
	}

}
