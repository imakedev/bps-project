package th.co.vlink.bps.portlet;

import java.util.Map;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletPreferences;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.support.ByteArrayMultipartFileEditor;
import org.springframework.web.portlet.bind.PortletRequestDataBinder;

import th.co.vlink.bps.form.BpsAdminLogForm;
import th.co.vlink.bps.service.BpsAdminService;

@Controller
@RequestMapping("VIEW")
@SessionAttributes({ "bpsAdminLogForm" })
public class BpsAdminLogController {
	private static Logger logger = Logger.getRootLogger();
	private BpsAdminService bpsAdminService;

	@Autowired
	public BpsAdminLogController(BpsAdminService bpsAdminService) {
		logger.debug("########################### @Autowired BpsAdminLogController #######################");
		this.bpsAdminService = bpsAdminService;
	}

	@InitBinder
	public void initBinder(PortletRequestDataBinder binder,
			PortletPreferences preferences) {
		binder.registerCustomEditor(byte[].class,
				new ByteArrayMultipartFileEditor());
		// String[] field = { "mode", "bpsGroup.bpgId",
		// "bpsGroup.bpgGroupName"};
		// binder.setAllowedFields(field);
	}

	@RequestMapping
	public String list(Model model,
			@RequestParam(value = "id", required = false) String id,@RequestParam(value = "mode", required = false) String mode) {
		logger.info("into log ==> id="+id+",mode="+mode);
		BpsAdminLogForm bpsAdminLogForm;
		if (!model.containsAttribute("bpsAdminLogForm")) {
			bpsAdminLogForm = new BpsAdminLogForm();
		} else {
			Map map = model.asMap();
			bpsAdminLogForm = (BpsAdminLogForm) map.get("bpsAdminLogForm");
		}
		String page="index";
		//String page="formMailBpsTerm";
		/*if(mode!=null && mode.length()>0){
			model.addAttribute("mode", mode);
			page="formMailBpsTerm";
		}*/
		//model.addAllAttributes(arg0)
		model.addAttribute("bpsAdminLogForm", bpsAdminLogForm);
		return page;
	}

	@RequestMapping(params = "action=viewBpsTermLog")
	public String viewBpsTerm(Model model, @RequestParam("bptlId") String bptlId) {
		model.addAttribute("bptlId", bptlId);
		return "viewBpsTermLog";
	}
	@RequestMapping(params = "action=home")
	public String home() {
		//model.addAttribute("bptlId", bptlId);
		return "index";
	}

	@RequestMapping(params = "action=doSubmit")
	public void doSubmit(ActionRequest request, ActionResponse response,
			@ModelAttribute("bpsAdminLogForm") BpsAdminLogForm bpsAdminLogForm,
			BindingResult result, Model model) {
		response.setRenderParameter("bptlId", bpsAdminLogForm.getBptlId() + "");
		response.setRenderParameter("action", "viewBpsTermLog");
	}
}
