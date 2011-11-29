package th.co.vlink.bps.ajax;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import th.co.vlink.bps.service.BpsAdminService;
import th.co.vlink.xstream.BpsGroup;
import th.co.vlink.xstream.BpsTerm;
import th.co.vlink.xstream.BpsTermVersion;
import th.co.vlink.xstream.common.VResultMessage;

public class BpsAdminAjax {
	private BpsAdminService bpsAdminService;

	public BpsAdminAjax() {
		WebContext ctx = WebContextFactory.get();
		ServletContext servletContext = ctx.getServletContext();
		WebApplicationContext wac = WebApplicationContextUtils
				.getRequiredWebApplicationContext(servletContext);
		bpsAdminService = (BpsAdminService) wac.getBean("bpsAdminService");

	}

	public int saveOrUpdateBpsGroup(BpsGroup bpsGroup, String mode) {
		if (mode.equals("save"))
			return bpsAdminService.saveBpsGroup(bpsGroup);
		else
			return bpsAdminService.updateBpsGroup(bpsGroup);
	}

	public BpsGroup getBpsGroup(String bpgId) {
		return bpsAdminService.findBpsGroupById(bpgId);
	}

	public int deleteBpsGroup(String key) {
		return bpsAdminService.deleteBpsGroup(key);
	}

	public int saveBpsGroup(BpsGroup bpsGroup) {
		return bpsAdminService.saveBpsGroup(bpsGroup);
	}

	public int updateBpsGroup(BpsGroup bpsGroup) {
		return bpsAdminService.updateBpsGroup(bpsGroup);
	}

	public List listBpsGroup(BpsGroup bpsGroup) {
		List result = null;
		VResultMessage vresultMessage = bpsAdminService
				.searchBpsGroup(bpsGroup);
		if (vresultMessage != null && vresultMessage.getResultListObj() != null
				&& vresultMessage.getMaxRow() != null) {
			result = new ArrayList(2);
			result.add(vresultMessage.getResultListObj());
			result.add(vresultMessage.getMaxRow());
		}
		return result;
	}

	public int deleteBpsAttachFile(String key) {
		return bpsAdminService.deleteBpsAttachFile(key);
	}

	public BpsTermVersion findBpsTermVersionById(String bpgId) {
		return bpsAdminService.findBpsTermVersionById(bpgId);
	}

	public int checkDuplicateGroup(String groupName) {
		return bpsAdminService.checkDuplicateGroup(groupName);
	}
 
	public List searchBpsTerm(BpsTerm bpsTerm) {
		List result = null;
		VResultMessage vresultMessage = bpsAdminService.searchBpsTerm(bpsTerm);
		if (vresultMessage != null && vresultMessage.getResultListObj() != null
				&& vresultMessage.getMaxRow() != null) {
			result = new ArrayList(2);
			result.add(vresultMessage.getResultListObj());
			result.add(vresultMessage.getMaxRow());
		}
		return result;
	}
	public int deleteBpsTerm(String key) {
		return bpsAdminService.deleteBpsTerm(key); 
	}

	public BpsTerm findBpsTermById(String bptId) {
		return bpsAdminService.findBpsTermById(bptId);
	}
}
