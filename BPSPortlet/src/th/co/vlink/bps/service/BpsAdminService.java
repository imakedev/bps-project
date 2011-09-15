package th.co.vlink.bps.service;

import th.co.vlink.xstream.BpsGroup;
import th.co.vlink.xstream.common.VResultMessage;

public interface BpsAdminService {
	public void saveBpsGroup(BpsGroup bpsGroup);
	public void updateBpsGroup(BpsGroup bpsGroup);
	public void deleteBpsGroup(String key);
	public BpsGroup findBpsGroupById(String key);
	public VResultMessage searchBpsGroup(BpsGroup bpsGroup);
}
