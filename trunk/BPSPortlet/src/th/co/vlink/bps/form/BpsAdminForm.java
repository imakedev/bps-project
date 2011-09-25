package th.co.vlink.bps.form;

import java.io.Serializable;

import th.co.vlink.xstream.BpsGroup;
import th.co.vlink.xstream.BpsTerm;

public class BpsAdminForm implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String mode;
	private String command;
	private BpsGroup bpsGroup;
	private BpsTerm bpsTerm;
	private String bpgId;
	private String searchBy;
	public BpsAdminForm(){
		bpsGroup =new BpsGroup();
		bpsTerm =new BpsTerm();
	}
	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public BpsGroup getBpsGroup() {
		return bpsGroup;
	}

	public void setBpsGroup(BpsGroup bpsGroup) {
		this.bpsGroup = bpsGroup;
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

}
