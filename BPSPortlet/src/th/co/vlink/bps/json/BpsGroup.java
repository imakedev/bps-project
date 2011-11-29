package th.co.vlink.bps.json;

import java.io.Serializable;

public class BpsGroup implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long bpgId;
	private String bpgGroupName;
	public Long getBpgId() {
		return bpgId;
	}
	public void setBpgId(Long bpgId) {
		this.bpgId = bpgId;
	}
	public String getBpgGroupName() {
		return bpgGroupName;
	}
	public void setBpgGroupName(String bpgGroupName) {
		this.bpgGroupName = bpgGroupName;
	}
	
}
