package th.co.vlink.bps.portlet;

import java.util.HashMap;
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

import th.co.vlink.bps.form.BpsAdminForm;
import th.co.vlink.bps.form.BpsUserForm;
import th.co.vlink.bps.service.BpsUserService;
import th.co.vlink.utils.Pagging;
import th.co.vlink.xstream.BpsAttachFile;
import th.co.vlink.xstream.BpsGroup;
import th.co.vlink.xstream.BpsTerm;
import th.co.vlink.xstream.common.VResultMessage;

@Controller
@RequestMapping("VIEW")
@SessionAttributes({ "bpsUserForm" })
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
		// String[] field = { };
		// binder.setAllowedFields(field);
	}

	@RequestMapping
	public String list(
			Model model,
			@RequestParam(value = "pageNo", required = false) String pageNoStr,
			@RequestParam(value = "bptTerm", required = false) String bptTerm,
			@RequestParam(value = "bpgId", required = false) String bpgId,
			@RequestParam(value = "bptIndexChar", required = false) String bptIndexChar,
			@RequestParam(value = "searchBy", required = false) String searchBy,
			@RequestParam(value = "orderBy", required = false) String orderBy,
			@RequestParam(value = "orderColumn", required = false) String orderColumn) {
		BpsUserForm bpsUserForm = null;
		bptTerm = (bptTerm != null && bptTerm.trim().length() > 0) ? bptTerm
				.trim() : "";
		bpgId = (bpgId != null && bpgId.trim().length() > 0) ? bpgId.trim()
				: "0";
		searchBy = (searchBy != null && searchBy.trim().length() > 0) ? searchBy
				.trim() : "0";
		orderBy = (orderBy != null && orderBy.trim().length() > 0) ? orderBy
				.trim() : "";
		orderColumn = (orderColumn != null && orderColumn.trim().length() > 0) ? orderColumn
				.trim() : "";
		bptIndexChar = (bptIndexChar != null && bptIndexChar.trim().length() > 0) ? bptIndexChar
				.trim() : "A";
		int pageNo = 1;
		if (pageNoStr != null && !pageNoStr.equals(""))
			pageNo = Integer.parseInt(pageNoStr);

		Pagging page = new Pagging();
		page.setPageNo(pageNo);
		page.setPageSize(20);
		if (!model.containsAttribute("bpsUserForm")) {
			bpsUserForm = new BpsUserForm();
		} else {
			Map map = model.asMap();
			bpsUserForm = (BpsUserForm) map.get("bpsUserForm");
		}

		BpsTerm bpsTerm = bpsUserForm.getBpsTerm();
		bpsTerm.setPagging(page);
		bpsTerm.setBptTerm(bptTerm);
		bpsTerm.setBptIndexChar(bptIndexChar);
		bpsTerm.getVcriteria().setValue(bptTerm);
		bpsTerm.getVcriteria().setOrderBy(orderBy);
		bpsTerm.getVcriteria().setOrderColumn(orderColumn);
		if (!bpgId.equals("0")) {
			BpsGroup group = new BpsGroup();
			group.setBpgId(Long.parseLong(bpgId));
			bpsTerm.setBpsGroup(group);
		}
		String key = "";
		if (!searchBy.equals("0")) { // 1=by term ,2 =by Difinition
			if (searchBy.equals("1")) {
				// bptTerm
				key = "bptTerm";
			} else if (searchBy.equals("2")) {
				// bptDefinitionSearch
				key = "bptDefinitionSearch";
			}
		}
		bpsTerm.getVcriteria().setKey(key);
		bpsUserForm.setBpgId(bpgId);
		bpsUserForm.setSearchBy(searchBy);
		bpsUserForm.setBpsTerm(bpsTerm);
		VResultMessage resultList = bpsUserService.searchBpsTerm(bpsTerm);
		VResultMessage resultListGroup = bpsUserService
				.searchBpsGroup(new BpsGroup());
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultListGroup", resultListGroup);
		model.addAttribute("bpsUserForm", bpsUserForm);
		return "index";
	}

	@RequestMapping(params = "action=viewBpsTerm")
	public String viewBpsTerm(Model model, @RequestParam("bptId") String bptId,
			@RequestParam(value = "mode") String mode) {
		String pageName = "viewBpsTerm";
		BpsUserForm bpsUserForm = null;
		if (!model.containsAttribute("bpsUserForm")) {
			bpsUserForm = new BpsUserForm();
		} else {
			Map map = model.asMap();
			bpsUserForm = (BpsUserForm) map.get("bpsUserForm");
		}
		BpsTerm bpsTerm = null;
		if (mode.equals("edit")) {
			bpsTerm = bpsUserService.findBpsTermById(bptId);
			pageName = "addOrEditBpsTerm";
		} else if(mode.equals("add")) {
			bpsTerm = new BpsTerm();
			pageName = "addOrEditBpsTerm";
		} else {
			bpsTerm = bpsUserService.findBpsTermById(bptId);
			BpsAttachFile bpsAttachFile = new BpsAttachFile();
			bpsAttachFile.setBpsTerm(bpsTerm);
			VResultMessage resultList = bpsUserService.searchBpsAttachFile(bpsAttachFile);
			model.addAttribute("resultList", resultList);
		}
		bpsUserForm.setMode(mode);
		bpsUserForm.setBpsTerm(bpsTerm);

		model.addAttribute("bpsUserForm", bpsUserForm);
		model.addAttribute("mode", mode);

		return pageName;
	}
	
	@RequestMapping(params = "action=searchBpsTerm")
	public void searchBpsTerm(ActionRequest request, ActionResponse response, Model model) {
		BpsUserForm bpsUserForm = new BpsUserForm();
		String bptTerm = request.getParameter("textfield");
		String bpgId = request.getParameter("select2");
		String searchBy = request.getParameter("select");
		String pageNoStr = request.getParameter("pageNo");
		bptTerm = (bptTerm != null && bptTerm.trim().length() > 0) ? bptTerm
				.trim() : "";
		bpgId = (bpgId != null && bpgId.trim().length() > 0) ? bpgId.trim()
				: "0";
		searchBy = (searchBy != null && searchBy.trim().length() > 0) ? searchBy
				.trim() : "0";
		int pageNo = 1;
		if (pageNoStr != null && !pageNoStr.equals(""))
			pageNo = Integer.parseInt(pageNoStr);

		Pagging page = new Pagging();
		page.setPageNo(pageNo);
		page.setPageSize(20);

		BpsTerm bpsTerm = new BpsTerm();
		bpsTerm.setPagging(page);
		bpsTerm.setBptTerm(bptTerm);
		bpsTerm.getVcriteria().setValue(bptTerm);
		if (!bpgId.equals("0")) {
			BpsGroup group = new BpsGroup();
			group.setBpgId(Long.parseLong(bpgId));
			bpsTerm.setBpsGroup(group);
		}
		String key = "";
		if (!searchBy.equals("0")) { // 1=by term ,2 =by Difinition
			if (searchBy.equals("1")) {
				// bptTerm
				key = "bptTerm";
			} else if (searchBy.equals("2")) {
				// bptDefinitionSearch
				key = "bptDefinitionSearch";
			}
		}
		bpsTerm.getVcriteria().setKey(key);
		VResultMessage resultList = bpsUserService.searchBpsTerm(bpsTerm);
		VResultMessage resultListGroup = bpsUserService
				.searchBpsGroup(new BpsGroup());
		bpsUserForm.setBpsTerm(bpsTerm);
		model.addAttribute("bpsUserForm", bpsUserForm);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultListGroup", resultListGroup);
		response.setRenderParameter("action", "viewSearchResult");
	}
	
	@RequestMapping(params = "action=viewSearchResult")
	public String viewSearchResult(Model models) {
		return "index";
	}
}
