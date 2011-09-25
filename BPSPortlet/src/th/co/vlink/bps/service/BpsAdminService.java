package th.co.vlink.bps.service;

import th.co.vlink.xstream.BpsAttachFile;
import th.co.vlink.xstream.BpsGroup;
import th.co.vlink.xstream.BpsTerm;
import th.co.vlink.xstream.BpsTermVersion;
import th.co.vlink.xstream.common.VResultMessage;

public interface BpsAdminService {
	// BPS_GROUP
	public void saveBpsGroup(BpsGroup bpsGroup);
	public void updateBpsGroup(BpsGroup bpsGroup);
	public void deleteBpsGroup(String key);
	public BpsGroup findBpsGroupById(String key);
	public VResultMessage searchBpsGroup(BpsGroup bpsGroup);

	// BPS_TERM
	public void saveBpsTerm(BpsTerm bpsTerm);
	public void updateBpsTerm(BpsTerm bpsTerm);
	public void deleteBpsTerm(String key);
	public BpsTerm findBpsTermById(String bpgId);
	public VResultMessage searchBpsTerm(BpsTerm bpsTerm);

	// BPS_TERM_VERSION
	public VResultMessage searchBpsTermVersion(BpsTermVersion bpsTermVersion) ;
	public BpsTermVersion findBpsTermVersionById(String bpgId) ;
	// BPS_FILE
	public void saveBpsAttachFile(BpsAttachFile bpsAttachFile);
	public void deleteBpsAttachFile(String key) ;
	public BpsAttachFile findBpsAttachFileById(String bpgId);
	public VResultMessage searchBpsAttachFile(BpsAttachFile bpsAttachFile) ;
}
