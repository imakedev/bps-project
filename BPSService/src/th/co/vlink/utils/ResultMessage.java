package th.co.vlink.utils;

import java.io.Serializable;

import th.co.vlink.utils.properties.GlobalProperties;

public class ResultMessage implements Serializable {

	private static final long serialVersionUID = 1L;
	private String msgCode;
	private String msgDesc;
	private Exception exception;
	
	public ResultMessage(){
	}

	public ResultMessage(String msgCode){
		this.setMsgCode(msgCode);
	}

	public ResultMessage(String msgCode, String msgDesc){
		this.msgCode = msgCode;
		this.msgDesc = msgDesc;
	}

	public ResultMessage(String msgCode, Exception exception){
		this.setMsgCode(msgCode);
		this.setException(exception);
	}

	public ResultMessage(String msgCode, String msgDesc, Exception exception){
		this.msgCode = msgCode;
		this.msgDesc = msgDesc;
		this.setException(exception);
	}
	
	public Exception getException() {
		return exception;
	}
	public void setException(Exception exception) {
		this.exception = exception;
	}
	public String getMsgCode() {
		return msgCode;
	}
	public void setMsgCode(String msgCode) {
		this.msgCode = msgCode;
		this.msgDesc = GlobalProperties.getProperty(this.msgCode);
	}
	public String getMsgDesc() {
		return msgDesc;
	}
	public void setMsgDesc(String msgDesc) {
		this.msgDesc = msgDesc;
	}
	
}	
