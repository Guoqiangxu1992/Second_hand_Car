package com.xu.manager.bean;

import java.util.Date;

public class Car {
	private Integer id;
	private String carType;
	private String mileage;
	private double price;
	private String agency;
    private int status;
    private double contractPrice;
    private String imag;
    private int old;
    private String color;
    private String markImag;
    private String submitTime;
    private String damaged;
    
    public String getDamaged() {
		return damaged;
	}
	public void setDamaged(String damaged) {
		this.damaged = damaged;
	}
	public String getSubmitTime() {
		return submitTime;
	}
	public void setSubmitTime(String date) {
		this.submitTime = date;
	}
	private String agencyId;
    public String getAgencyId() {
		return agencyId;
	}
	public void setAgencyId(String agencyId) {
		this.agencyId = agencyId;
	}
	
    
    public String getMarkImag() {
		return markImag;
	}
	public void setMarkImag(String markImag) {
		this.markImag = markImag;
	}
	public String getStartPrice() {
		return startPrice;
	}
	public void setStartPrice(String startPrice) {
		this.startPrice = startPrice;
	}
	public String getEndPrice() {
		return endPrice;
	}
	public void setEndPrice(String endPrice) {
		this.endPrice = endPrice;
	}
	private String startPrice;
    private String endPrice;
    
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public int getOld() {
		return old;
	}
	public void setOld(int old) {
		this.old = old;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCarType() {
		return carType;
	}
	public void setCarType(String carType) {
		this.carType = carType;
	}
	public String getMileage() {
		return mileage;
	}
	public void setMileage(String mileage) {
		this.mileage = mileage;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getAgency() {
		return agency;
	}
	public void setAgency(String agency) {
		this.agency = agency;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public double getContractPrice() {
		return contractPrice;
	}
	public void setContractPrice(double contractPrice) {
		this.contractPrice = contractPrice;
	}
	public String getImag() {
		return imag;
	}
	public void setImag(String imag) {
		this.imag = imag;
	}
	
    
    

}
