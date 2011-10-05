package th.co.vlink.bps.service.impl;

import th.co.vlink.bps.service.BpsUserService;
import th.co.vlink.constant.ServiceConstant;
import th.co.vlink.xstream.BpsAttachFile;
import th.co.vlink.xstream.BpsGroup;
import th.co.vlink.xstream.BpsTerm;
import th.co.vlink.xstream.common.VResultMessage;

public class BpsUserServiceImpl extends PostCommon implements BpsUserService {
	// BPS_GROUP
	public VResultMessage searchBpsGroup(BpsGroup bpsGroup) {
		// TODO Auto-generated method stub
		bpsGroup.setServiceName(ServiceConstant.BPS_GROUP_SEARCH);
		return postMessage(bpsGroup,bpsGroup.getClass().getName(),"bpsGroups/",true);
	}

	// BPS_TERM 
	public BpsTerm findBpsTermById(String bpgId) {
		// TODO Auto-generated method stub
		BpsTerm bpsTerm = new BpsTerm();
		bpsTerm.setBptId(new Long(bpgId));
		bpsTerm.setServiceName(ServiceConstant.BPS_TERM_FIND_BY_ID);
		VResultMessage resultMessage = postMessage(bpsTerm,bpsTerm.getClass().getName(),"bpsTerms/",true);
		return (BpsTerm)resultMessage.getResultListObj().get(0);
	}

	public VResultMessage searchBpsTerm(BpsTerm bpsTerm) {
		// TODO Auto-generated method stub
		bpsTerm.setServiceName(ServiceConstant.BPS_TERM_SEARCH);
		return postMessage(bpsTerm,bpsTerm.getClass().getName(),"bpsTerms/",true);
	}
	// BPS_FILE
	public BpsAttachFile findBpsAttachFileById(String bpgId) {
		// TODO Auto-generated method stub
		BpsAttachFile bpsAttachFile = new BpsAttachFile();
		bpsAttachFile.setBpafId(new Long(bpgId));
		bpsAttachFile.setServiceName(ServiceConstant.BPS_ATTACH_FILE_FIND_BY_ID);
		VResultMessage resultMessage = postMessage(bpsAttachFile,bpsAttachFile.getClass().getName(),"bpsAttachFiles/",true);
		return (BpsAttachFile)resultMessage.getResultListObj().get(0);
	}

	public VResultMessage searchBpsAttachFile(BpsAttachFile bpsAttachFile) {
		// TODO Auto-generated method stub
		bpsAttachFile.setServiceName(ServiceConstant.BPS_ATTACH_FILE_SEARCH);
		return postMessage(bpsAttachFile,bpsAttachFile.getClass().getName(),"bpsAttachFiles/",true);
	}
	
	public int saveBpsTerm(BpsTerm bpsTerm) {
		bpsTerm.setServiceName(ServiceConstant.BPS_TERM_SAVE);
		VResultMessage resultMessage=postMessage(bpsTerm,bpsTerm.getClass().getName(),"bpsTerms/",true);
		bpsTerm = (BpsTerm)resultMessage.getResultListObj().get(0);
		return bpsTerm.getUpdateRecord();
	}

	public int updateBpsTerm(BpsTerm bpsTerm) {
		bpsTerm.setServiceName(ServiceConstant.BPS_TERM_UPDATE);
		VResultMessage resultMessage =postMessage(bpsTerm,bpsTerm.getClass().getName(),"bpsTerms/",true);
		bpsTerm = (BpsTerm)resultMessage.getResultListObj().get(0);
		return bpsTerm.getUpdateRecord();
	}

}
