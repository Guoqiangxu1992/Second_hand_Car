package com.xu.manager.bean;

public class ReturnObject {
	private Integer code;
	private String message;
	/**
	 * @param code
	 * @param message
	 */
	public ReturnObject(Integer code, String message) {
		this.code = code;
		this.message = message;
	}
	public ReturnObject(Integer code) {
		this.code = code;
		this.message = null;
	}
	
	public Integer getCode() {
		return code;
	}
	public void setCode(Integer code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

}
