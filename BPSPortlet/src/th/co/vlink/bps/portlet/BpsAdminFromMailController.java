package th.co.vlink.bps.portlet;

import javax.portlet.PortletPreferences;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.support.ByteArrayMultipartFileEditor;
import org.springframework.web.portlet.bind.PortletRequestDataBinder;

import th.co.vlink.bps.service.BpsAdminService;

@Controller
@RequestMapping("VIEW")
@SessionAttributes({ "bpsAdminLogForm" })
public class BpsAdminFromMailController {

	private static Logger logger = Logger.getRootLogger();
	private BpsAdminService bpsAdminService;

	@Autowired
	public BpsAdminFromMailController(BpsAdminService bpsAdminService) {
		logger.debug("########################### @Autowired BpsAdminFormMailController #######################");
		this.bpsAdminService = bpsAdminService;
	}

	@InitBinder
	public void initBinder(PortletRequestDataBinder binder,
			PortletPreferences preferences) {
		binder.registerCustomEditor(byte[].class,
				new ByteArrayMultipartFileEditor()); 
	}

	@RequestMapping
	public String list(Model model ){ 
		return "fromMailBpsTerm";
	} 
}
