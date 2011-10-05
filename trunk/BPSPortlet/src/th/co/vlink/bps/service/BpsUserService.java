package th.co.vlink.bps.service;

import th.co.vlink.xstream.BpsAttachFile;
import th.co.vlink.xstream.BpsGroup;
import th.co.vlink.xstream.BpsTerm;
import th.co.vlink.xstream.common.VResultMessage;

public interface BpsUserService {
	// BPS_GROUP
	public VResultMessage searchBpsGroup(BpsGroup bpsGroup);

	// BPS_TERM 
	public BpsTerm findBpsTermById(String bpgId);
	public VResultMessage searchBpsTerm(BpsTerm bpsTerm);
	public int saveBpsTerm(BpsTerm bpsTerm);
	public int updateBpsTerm(BpsTerm bpsTerm);
	// BPS_TERM_VERSION
	 
	// BPS_FILE 
	public BpsAttachFile findBpsAttachFileById(String bpgId);
	public VResultMessage searchBpsAttachFile(BpsAttachFile bpsAttachFile) ;
}
