package th.co.vlink.bps.portlet;

import javax.portlet.PortletPreferences;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.support.ByteArrayMultipartFileEditor;
import org.springframework.web.portlet.bind.PortletRequestDataBinder;

import th.co.vlink.bps.service.BpsAdminService;
import th.co.vlink.bps.service.BpsUserService;


@Controller
@RequestMapping("VIEW")
//@SessionAttributes( { "ntcCalendarForm" })
public class BpsUserController {
	private final Logger logger = Logger.getRootLogger();
	private BpsUserService bpsUserService;
	@Autowired
	public BpsUserController(BpsUserService bpsUserService) {
		logger.debug("########################### @Autowired BpsUserController #######################");
		this.bpsUserService = bpsUserService;
	}

	@InitBinder
	public void initBinder(PortletRequestDataBinder binder,
			PortletPreferences preferences) {
		binder.registerCustomEditor(byte[].class,
				new ByteArrayMultipartFileEditor());
//		String[] field = { };
//		binder.setAllowedFields(field);
	}
	
	@RequestMapping
	public String list(Model model) {
		return "index";
	}

}
