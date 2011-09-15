package th.co.vlink.bps.form;

import th.co.vlink.xstream.BpsGroup;

public class BpsAdminForm {
	private String mode;
	private BpsGroup bpsGroup = new BpsGroup();

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

}
