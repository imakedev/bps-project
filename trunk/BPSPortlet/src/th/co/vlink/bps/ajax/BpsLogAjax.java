package th.co.vlink.bps.ajax;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import th.co.vlink.bps.service.BpsAdminService;
import th.co.vlink.xstream.BpsTermLog;
import th.co.vlink.xstream.common.VResultMessage;

public class BpsLogAjax {
	private BpsAdminService bpsAdminService;

	public BpsLogAjax() {
		WebContext ctx = WebContextFactory.get();
		ServletContext servletContext = ctx.getServletContext();
		WebApplicationContext wac = WebApplicationContextUtils
				.getRequiredWebApplicationContext(servletContext);
		bpsAdminService = (BpsAdminService) wac.getBean("bpsAdminService");

	}
	public int deleteBpsTermLog(String key) {
		return bpsAdminService.deleteBpsTermLog(key); 
	}

	public BpsTermLog findBpsTermLogById(String bptlId) {
		return bpsAdminService.findBpsTermLogById(bptlId);
	}

	public List searchBpsTermLog(BpsTermLog bpsTermLog) {
		 List result =null;
		 VResultMessage vresultMessage = bpsAdminService.searchBpsTermLog(bpsTermLog);
		 if(vresultMessage!=null && vresultMessage.getResultListObj()!=null && vresultMessage.getMaxRow()!=null){
             result = new ArrayList(2);
             result.add(vresultMessage.getResultListObj());
             result.add(vresultMessage.getMaxRow());
     }
     return result;  
	}
}
