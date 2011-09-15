package th.co.vlink.bps.service.impl;

import th.co.vlink.bps.service.BpsAdminService;
import th.co.vlink.constant.ServiceConstant;
import th.co.vlink.xstream.BpsGroup;
import th.co.vlink.xstream.OfficeCalendar;
import th.co.vlink.xstream.common.VResultMessage;

public class BpsAdminServiceImpl extends PostCommon implements BpsAdminService {

	public void saveBpsGroup(BpsGroup bpsGroup) {
		bpsGroup.setServiceName(ServiceConstant.BPS_GROUP_SAVE);
		postMessage(bpsGroup,bpsGroup.getClass().getName(),"bpsGroups/",false);
	}

	public void updateBpsGroup(BpsGroup bpsGroup) {
		bpsGroup.setServiceName(ServiceConstant.BPS_GROUP_UPDATE);
		postMessage(bpsGroup,bpsGroup.getClass().getName(),"bpsGroups/",false);
	}

	public void deleteBpsGroup(String key) {
		OfficeCalendar bpsGroup = new OfficeCalendar();
		bpsGroup.setNcId(key);
		bpsGroup.setServiceName(ServiceConstant.BPS_GROUP_DELETE);
		postMessage(bpsGroup,bpsGroup.getClass().getName(),"bpsGroups/",false);
	}

	public BpsGroup findBpsGroupById(String bpgId) {
		BpsGroup bpsGroup = new BpsGroup();
		bpsGroup.setBpgId(new Long(bpgId));
		bpsGroup.setServiceName(ServiceConstant.BPS_GROUP_FIND_BY_ID);
		VResultMessage resultMessage = postMessage(bpsGroup,bpsGroup.getClass().getName(),"bpsGroups/",true);
		return (BpsGroup)resultMessage.getResultListObj().get(0);

	}

	public VResultMessage searchBpsGroup(BpsGroup bpsGroup) {
		bpsGroup.setServiceName(ServiceConstant.BPS_GROUP_SEARCH);
		return postMessage(bpsGroup,bpsGroup.getClass().getName(),"bpsGroups/",true);

	}

}
