package th.co.vlink.bps.form;

import java.io.Serializable;

import th.co.vlink.xstream.BpsTerm;

public class BpsUserForm implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String mode;
	private String command;
	private BpsTerm bpsTerm;
	private String bpgId;
	private String searchBy;
	 
	private Long bptId;
	 
	private String indexChar;
	private String orderColumn;
	private String orderBy;
	public BpsUserForm(){
		bpsTerm=new BpsTerm();
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getCommand() {
		return command;
	}
	public void setCommand(String command) {
		this.command = command;
	}
	public BpsTerm getBpsTerm() {
		return bpsTerm;
	}
	public void setBpsTerm(BpsTerm bpsTerm) {
		this.bpsTerm = bpsTerm;
	}
	public String getBpgId() {
		return bpgId;
	}
	public void setBpgId(String bpgId) {
		this.bpgId = bpgId;
	}
	public String getSearchBy() {
		return searchBy;
	}
	public void setSearchBy(String searchBy) {
		this.searchBy = searchBy;
	}
	public Long getBptId() {
		return bptId;
	}
	public void setBptId(Long bptId) {
		this.bptId = bptId;
	}
	public String getIndexChar() {
		return indexChar;
	}
	public void setIndexChar(String indexChar) {
		this.indexChar = indexChar;
	}
	public String getOrderColumn() {
		return orderColumn;
	}
	public void setOrderColumn(String orderColumn) {
		this.orderColumn = orderColumn;
	}
	public String getOrderBy() {
		return orderBy;
	}
	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}
	
}
