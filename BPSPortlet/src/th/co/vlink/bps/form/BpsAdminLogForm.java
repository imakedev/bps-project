package th.co.vlink.bps.form;

import java.io.Serializable;

public class BpsAdminLogForm implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String mode;
	private String command;
	private Long bptlId;
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
	public Long getBptlId() {
		return bptlId;
	}
	public void setBptlId(Long bptlId) {
		this.bptlId = bptlId;
	}
	

}
