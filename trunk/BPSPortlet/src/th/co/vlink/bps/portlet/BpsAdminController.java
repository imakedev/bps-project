package th.co.vlink.bps.portlet;

import java.util.ArrayList;
import java.util.List;

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
import org.springframework.web.multipart.support.ByteArrayMultipartFileEditor;
import org.springframework.web.portlet.bind.PortletRequestDataBinder;

import th.co.vlink.bps.form.BpsAdminForm;
import th.co.vlink.bps.service.BpsAdminService;
import th.co.vlink.xstream.BpsGroup;
import th.co.vlink.xstream.common.VResultMessage;

@Controller
@RequestMapping("VIEW")
//@SessionAttributes( { "ntcCalendarForm" })
public class BpsAdminController {
	private static Logger logger = Logger.getRootLogger();
	private BpsAdminService bpsAdminService;
	
	@Autowired
	public BpsAdminController(BpsAdminService bpsAdminService) {
		logger.debug("########################### @Autowired BpsAdminController #######################");
		this.bpsAdminService = bpsAdminService;
	}

	@InitBinder
	public void initBinder(PortletRequestDataBinder binder,
			PortletPreferences preferences) {
		binder.registerCustomEditor(byte[].class,
				new ByteArrayMultipartFileEditor());
		String[] field = { "mode", "bpsGroup.bpgId", "bpsGroup.bpgGroupName"};
		binder.setAllowedFields(field);
	}
	
	@RequestMapping
	public String list(Model model) {
		return "index";
	}
	
	@RequestMapping(params="action=manageBpsGroup")
	public String manageBpsGroup(Model model) {
		BpsGroup bpsGroup = new BpsGroup();
		VResultMessage resultList = bpsAdminService.searchBpsGroup(bpsGroup);
		model.addAttribute("resultList", resultList);
		return "manageBpsGroup";
	}
	
	@RequestMapping(params="action=addOrEditBpsGroup")
	public String addOrEditBpsGroup(Model model, @RequestParam(value="mode") String mode) {
		BpsAdminForm bpsAdminForm = new BpsAdminForm();
		bpsAdminForm.setMode(mode);
		bpsAdminForm.setBpsGroup(new BpsGroup());
		model.addAttribute("bpsAdminForm", bpsAdminForm);
		return "addOrEditBpsGroup";
	}
	
	@RequestMapping(params = "action=saveBpsGroup")
	public void saveBpsGroup(ActionRequest request, ActionResponse response,
			@ModelAttribute("bpsAdminForm")
			BpsAdminForm bpsAdminForm, BindingResult result, Model model) {
		BpsGroup bpsGroup = bpsAdminForm.getBpsGroup();
		if (bpsAdminForm.getMode().equalsIgnoreCase("add")) {
			bpsAdminService.saveBpsGroup(bpsGroup);
		} else {
			bpsAdminService.updateBpsGroup(bpsGroup);
		}
		response.setRenderParameter("action", "manageBpsGroup");
	}
	
	@RequestMapping(params="action=deleteBpsGroup")
	public String deleteBpsGroup(Model model, @RequestParam(value="bpgId") String bpgId) {
		bpsAdminService.deleteBpsGroup(bpgId);
		BpsGroup bpsGroup = new BpsGroup();
		VResultMessage resultList = bpsAdminService.searchBpsGroup(bpsGroup);
		model.addAttribute("resultList", resultList);
		return "manageBpsGroup";
	}
	
}
