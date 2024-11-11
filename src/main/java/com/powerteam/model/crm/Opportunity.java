package com.powerteam.model.crm;

import java.util.Date;
import java.util.List;

import lombok.Data;

import com.powerteam.model.sys.User;

@Data
public class Opportunity {

	private Integer opportunityId;
	private String name;
	private Integer customerId;
	private Double amount;
	private Date endDate;
	private Float possibility;
	private Boolean budgetConfirmed;
	private Boolean roiConfirmed;
	private Byte phase;
	private Boolean win;
	private Byte lossReason;
	private String description;
	private Date closeDate;
	private Date createDate;
	private Integer createBy;
	private Integer owner;

	private Customer customer;
	private User createUser;
	private User ownerUser;

	private List<ContactsRole> contactsRoleList;

	public Integer getOpportunityId() {
		return opportunityId;
	}

	public void setOpportunityId(Integer opportunityId) {
		this.opportunityId = opportunityId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public Float getPossibility() {
		return possibility;
	}

	public void setPossibility(Float possibility) {
		this.possibility = possibility;
	}

	public Boolean getBudgetConfirmed() {
		return budgetConfirmed;
	}

	public void setBudgetConfirmed(Boolean budgetConfirmed) {
		this.budgetConfirmed = budgetConfirmed;
	}

	public Boolean getRoiConfirmed() {
		return roiConfirmed;
	}

	public void setRoiConfirmed(Boolean roiConfirmed) {
		this.roiConfirmed = roiConfirmed;
	}

	public Byte getPhase() {
		return phase;
	}

	public void setPhase(Byte phase) {
		this.phase = phase;
	}

	public Boolean getWin() {
		return win;
	}

	public void setWin(Boolean win) {
		this.win = win;
	}

	public Byte getLossReason() {
		return lossReason;
	}

	public void setLossReason(Byte lossReason) {
		this.lossReason = lossReason;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getCloseDate() {
		return closeDate;
	}

	public void setCloseDate(Date closeDate) {
		this.closeDate = closeDate;
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

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public User getCreateUser() {
		return createUser;
	}

	public void setCreateUser(User createUser) {
		this.createUser = createUser;
	}

	public User getOwnerUser() {
		return ownerUser;
	}

	public void setOwnerUser(User ownerUser) {
		this.ownerUser = ownerUser;
	}

	public List<ContactsRole> getContactsRoleList() {
		return contactsRoleList;
	}

	public void setContactsRoleList(List<ContactsRole> contactsRoleList) {
		this.contactsRoleList = contactsRoleList;
	}

}
