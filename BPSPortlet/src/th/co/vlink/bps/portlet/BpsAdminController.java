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

import th.co.vlink.bps.form.BpsAdminForm;
import th.co.vlink.bps.service.BpsAdminService;
import th.co.vlink.utils.Pagging;
import th.co.vlink.xstream.BpsGroup;
import th.co.vlink.xstream.BpsTerm;
import th.co.vlink.xstream.common.VResultMessage;

@Controller
@RequestMapping("VIEW")
@SessionAttributes( { "bpsAdminForm" })
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
		//String[] field = { "mode", "bpsGroup.bpgId", "bpsGroup.bpgGroupName"};
		//binder.setAllowedFields(field);
	}
	
	@RequestMapping
	public String list(Model model) {
		return "index";
	}
	
	@RequestMapping(params="action=manageBpsGroup")
	public String manageBpsGroup(Model model,@RequestParam(value="pageNo",required = false) String pageNoStr
			,@RequestParam(value="bpgGroupName",required = false) String bpgGroupName
			,@RequestParam(value="orderBy",required = false) String orderBy
			,@RequestParam(value="orderColumn",required = false) String orderColumn)  {
		BpsAdminForm bpsAdminForm=null;
		bpgGroupName=(bpgGroupName!=null&&bpgGroupName.trim().length()>0)?bpgGroupName.trim():"";
		orderBy=(orderBy!=null&&orderBy.trim().length()>0)?orderBy.trim():"";
		orderColumn=(orderColumn!=null&&orderColumn.trim().length()>0)?orderColumn.trim():"";
		int pageNo = 1; 
		if(pageNoStr!=null && !pageNoStr.equals(""))
			pageNo= Integer.parseInt(pageNoStr);
		 
		Pagging page   = new Pagging();
		page.setPageNo(pageNo);
		page.setPageSize(20);
		if(!model.containsAttribute("bpsAdminForm")){
			bpsAdminForm= new BpsAdminForm();
		}else {
			Map map  = model.asMap();
			bpsAdminForm = (BpsAdminForm)map.get("bpsAdminForm");			 
		} 
		//bpsAdminForm.getBpsGroup().setBpgGroupName(bpgGroupName);
		BpsGroup bpsGroup =bpsAdminForm.getBpsGroup();
		bpsGroup.setPagging(page);
		bpsGroup.setBpgGroupName(bpgGroupName);
		bpsGroup.getVcriteria().setOrderBy(orderBy);
		bpsGroup.getVcriteria().setOrderColumn(orderColumn);
		VResultMessage resultList = bpsAdminService.searchBpsGroup(bpsGroup);
		
		model.addAttribute("bpsGroups", resultList.getResultListObj());
		model.addAttribute("bpsAdminForm", bpsAdminForm);
		return "manageBpsGroup";
	}
	
	@RequestMapping(params="action=addOrEditBpsGroup")
	public String addOrEditBpsGroup(Model model,
			@RequestParam("bpgId") String bpgId,
			@RequestParam(value="mode") String mode) {
	try{
		BpsAdminForm bpsAdminForm=null; 
		if(!model.containsAttribute("bpsAdminForm")){
			bpsAdminForm= new BpsAdminForm();
		}else {
			Map map  = model.asMap();
			bpsAdminForm = (BpsAdminForm)map.get("bpsAdminForm");			 
		} 
		BpsGroup bpsGroup =null; 
		if(!mode.equals("add")){
			bpsGroup = bpsAdminService.findBpsGroupById(bpgId);
		}else{
			bpsGroup=new BpsGroup();
		}
		bpsAdminForm.setMode(mode);
		bpsAdminForm.setBpsGroup(bpsGroup);
		 
		model.addAttribute("bpsAdminForm", bpsAdminForm);
		model.addAttribute("mode",mode); 
	}catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
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
	
	// BPS Term
	@RequestMapping(params="action=manageBpsTerm")
	public String manageBpsTerm(Model model,@RequestParam(value="pageNo",required = false) String pageNoStr
			,@RequestParam(value="bptTerm",required = false) String bptTerm
			,@RequestParam(value="bpgId",required = false) String bpgId
			,@RequestParam(value="searchBy",required = false) String searchBy
			,@RequestParam(value="orderBy",required = false) String orderBy
			,@RequestParam(value="orderColumn",required = false) String orderColumn)  {
		BpsAdminForm bpsAdminForm=null;
		bptTerm=(bptTerm!=null&&bptTerm.trim().length()>0)?bptTerm.trim():"";
		bpgId=(bpgId!=null&&bpgId.trim().length()>0)?bpgId.trim():"0";
		searchBy=(searchBy!=null&&searchBy.trim().length()>0)?searchBy.trim():"0";
		orderBy=(orderBy!=null&&orderBy.trim().length()>0)?orderBy.trim():"";
		orderColumn=(orderColumn!=null&&orderColumn.trim().length()>0)?orderColumn.trim():"";
		int pageNo = 1; 
		if(pageNoStr!=null && !pageNoStr.equals(""))
			pageNo= Integer.parseInt(pageNoStr);
		 
		Pagging page   = new Pagging();
		page.setPageNo(pageNo);
		page.setPageSize(20);
		if(!model.containsAttribute("bpsAdminForm")){
			bpsAdminForm= new BpsAdminForm();
		}else {
			Map map  = model.asMap();
			bpsAdminForm = (BpsAdminForm)map.get("bpsAdminForm");			 
		} 
		BpsTerm bpsTerm =bpsAdminForm.getBpsTerm();
		bpsTerm.setPagging(page);
		bpsTerm.setBptTerm(bptTerm);
		bpsTerm.getVcriteria().setValue(bptTerm) ;
		bpsTerm.getVcriteria().setOrderBy(orderBy);
		bpsTerm.getVcriteria().setOrderColumn(orderColumn);
		if(!bpgId.equals("0")){
			BpsGroup group = new BpsGroup();
			group.setBpgId(Long.parseLong(bpgId));
			bpsTerm.setBpsGroup(group);
		}
		String key="";
		if(!searchBy.equals("0")){ //1=by term ,2 =by Difinition
			if(searchBy.equals("1")){
				//bptTerm
				key="bptTerm";
			}else if(searchBy.equals("2")){
				//bptDefinitionSearch
				key="bptDefinitionSearch";
			}
		}
		bpsTerm.getVcriteria().setKey(key);
		bpsAdminForm.setBpgId(bpgId); 
		bpsAdminForm.setSearchBy(searchBy);
		  
		VResultMessage resultList = bpsAdminService.searchBpsTerm(bpsTerm);
		model.addAttribute("resultList", resultList);
		model.addAttribute("bpsAdminForm", bpsAdminForm);
		return "manageBpsTerm";
	}
	
	@RequestMapping(params="action=addOrEditBpsTerm")
	public String addOrEditBpsTerm(Model model,
			@RequestParam("bptId") String bptId,
			@RequestParam(value="mode") String mode) {
		BpsAdminForm bpsAdminForm=null; 
		if(!model.containsAttribute("bpsAdminForm")){
			bpsAdminForm= new BpsAdminForm();
		}else {
			Map map  = model.asMap();
			bpsAdminForm = (BpsAdminForm)map.get("bpsAdminForm");			 
		} 
		BpsTerm bpsTerm =null; 
		if(!mode.equals("add")){
			bpsTerm = bpsAdminService.findBpsTermById(bptId);
		}else{
			bpsTerm=new BpsTerm();
		}
		bpsAdminForm.setMode(mode);
		bpsAdminForm.setBpsTerm(bpsTerm);
		 
		model.addAttribute("bpsAdminForm", bpsAdminForm);
		model.addAttribute("mode",mode); 
		 
		return "addOrEditBpsTerm";
	}
	
	@RequestMapping(params = "action=saveBpsTerm")
	public void saveBpsTerm(ActionRequest request, ActionResponse response,
			@ModelAttribute("bpsAdminForm")
			BpsAdminForm bpsAdminForm, BindingResult result, Model model) {
		BpsTerm bpsTerm = bpsAdminForm.getBpsTerm();
		if (bpsAdminForm.getMode().equalsIgnoreCase("add")) {
			bpsAdminService.saveBpsTerm(bpsTerm);
		} else {
			bpsAdminService.updateBpsTerm(bpsTerm);
		}
		response.setRenderParameter("action", "manageBpsTerm");
	}
	
	@RequestMapping(params="action=deleteBpsTerm")
	public String deleteBpsTerm(Model model, @RequestParam(value="bpgId") String bpgId) {
		bpsAdminService.deleteBpsTerm(bpgId);
		BpsTerm bpsTerm = new BpsTerm();
		VResultMessage resultList = bpsAdminService.searchBpsTerm(bpsTerm);
		model.addAttribute("resultList", resultList);
		return "manageBpsTerm";
	}
}
