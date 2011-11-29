package th.co.vlink.bps.json;

import java.io.Serializable;


public class BpsGroupJSon implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int totalResultsCount;
	private BpsGroup[] bpsGroups;
	public int getTotalResultsCount() {
		return totalResultsCount;
	}
	public void setTotalResultsCount(int totalResultsCount) {
		this.totalResultsCount = totalResultsCount;
	}
	public BpsGroup[] getBpsGroups() {
		return bpsGroups;
	}
	public void setBpsGroups(BpsGroup[] bpsGroups) {
		this.bpsGroups = bpsGroups;
	}
	
}
