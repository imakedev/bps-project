package th.co.vlink.bps.portlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletPreferences;
import javax.portlet.PortletRequest;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.ByteArrayMultipartFileEditor;
import org.springframework.web.portlet.bind.PortletRequestDataBinder;

import th.co.vlink.bps.form.BpsAdminForm;
import th.co.vlink.bps.service.BpsAdminService;
import th.co.vlink.utils.Pagging;
import th.co.vlink.xstream.BpsAttachFile;
import th.co.vlink.xstream.BpsGroup;
import th.co.vlink.xstream.BpsTerm;
import th.co.vlink.xstream.BpsTermVersion;
import th.co.vlink.xstream.common.VResultMessage;

@Controller
@RequestMapping("VIEW")
@SessionAttributes( { "bpsAdminForm" })
public class BpsAdminController {
	private static Logger logger = Logger.getRootLogger();
	private BpsAdminService bpsAdminService;
	private static ResourceBundle bundle;
	static{
		  //bundle =  ResourceBundle.getBundle( "org/restlet/example/book/restlet/ch8/mailApplication" );
		bundle =  ResourceBundle.getBundle( "config" );				
	}
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
	private List listBpsGroup(){
		VResultMessage resultList = bpsAdminService.searchBpsGroup(new BpsGroup()); 
		return resultList.getResultListObj();
		//return bpsAdminService.searchBpsGroup(bpsGroup);
	} 
	@RequestMapping(params="action=manageBpsGroup")
	public String manageBpsGroup(Model model,@RequestParam(value="pageNo",required = false) String pageNoStr
			,@RequestParam(value="bpgGroupName",required = false) String bpgGroupName
			,@RequestParam(value="orderBy",required = false) String orderBy
			,@RequestParam(value="orderColumn",required = false) String orderColumn)  {
		System.out.println("bpgGroupName bpgGroupName==>"+bpgGroupName);
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
		bpsAdminForm.setBpgGroupName(bpgGroupName);
		bpsGroup.getVcriteria().setOrderBy(orderBy);
		bpsGroup.getVcriteria().setOrderColumn(orderColumn);
		VResultMessage resultList = bpsAdminService.searchBpsGroup(bpsGroup);
		
		model.addAttribute("bpsGroups", resultList);
		model.addAttribute("bpsAdminForm", bpsAdminForm);
		return "manageBpsGroup";
	}
	
	@RequestMapping(params="action=addOrEditBpsGroup")
	public String addOrEditBpsGroup(Model model,
			@RequestParam("bpgId") String bpgId,
			@RequestParam(value="mode") String mode) {
		System.out.println("into addOrEditBpsGroup bpgId="+bpgId+",mode="+mode);
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
		System.out.println("saveBpsGroup="+bpsAdminForm.getMode());
		BpsGroup bpsGroup = bpsAdminForm.getBpsGroup();
		int recordUpdate=0;
		if (bpsAdminForm.getMode().equals("add")) {
			recordUpdate=bpsAdminService.saveBpsGroup(bpsGroup);
		} else {
			recordUpdate=bpsAdminService.updateBpsGroup(bpsGroup);
		}
		System.out.println("recordUpdate=="+recordUpdate);
		response.setRenderParameter("action", "manageBpsGroup");
	}
	
	@RequestMapping(params="action=deleteBpsGroup")
	public void deleteBpsGroup(ActionRequest request, ActionResponse response,
			Model model, @RequestParam(value="bpgId") String bpgId) {
		bpsAdminService.deleteBpsGroup(bpgId);
		response.setRenderParameter("action", "manageBpsGroup");
	}
	
	// BPS Term
	@RequestMapping(params="action=manageBpsTerm")
	public String manageBpsTerm(Model model,@RequestParam(value="pageNo",required = false) String pageNoStr
			,@RequestParam(value="bptTerm",required = false) String bptTerm
			,@RequestParam(value="bpgId",required = false) String bpgId
			,@RequestParam(value="searchBy",required = false) String searchBy
			,@RequestParam(value="orderBy",required = false) String orderBy
			,@RequestParam(value="orderColumn",required = false) String orderColumn)  {
		System.out.println(" into manageBpsTerm=");
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
		/*if(!model.containsAttribute("bpsAdminForm")){
			bpsAdminForm= new BpsAdminForm();
		}else {
			Map map  = model.asMap();
			bpsAdminForm = (BpsAdminForm)map.get("bpsAdminForm");			 
		} */
		bpsAdminForm= new BpsAdminForm();
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
		if(!searchBy.equals("0")){ //1=by term ,2 =by Difinition , 3 all
			if(searchBy.equals("1")){
				//bptTerm
				key="bptTerm";
			}else if(searchBy.equals("2")){
				//bptDefinitionSearch
				key="bptDefinitionSearch";
			}else if(searchBy.equals("3")){
				key="bptAll";
			}
		}
		bpsTerm.getVcriteria().setKey(searchBy);
		bpsAdminForm.setBpgId(bpgId); 
		bpsAdminForm.setSearchBy(searchBy);
		bpsAdminForm.setBptTerm(bptTerm);
		VResultMessage resultList = bpsAdminService.searchBpsTerm(bpsTerm);
		System.out.println("resultList == "+resultList.getResultListObj());
		 
		model.addAttribute("bpsTerms", resultList);
		model.addAttribute("listCates", listBpsGroup());
		model.addAttribute("bpsAdminForm", bpsAdminForm);
		return "manageBpsTerm";
	}
	
	@RequestMapping(params="action=addOrEditBpsTerm")
	public String addOrEditBpsTerm(Model model,
			@RequestParam("bptId") String bptId,
			@RequestParam(value="mode") String mode) {
		BpsAdminForm bpsAdminForm=null; 
		VResultMessage resultList_version=null;
		VResultMessage resultList_files=null;
		if(!model.containsAttribute("bpsAdminForm")){
			bpsAdminForm= new BpsAdminForm();
		}else {
			Map map  = model.asMap();
			bpsAdminForm = (BpsAdminForm)map.get("bpsAdminForm");			 
		} 
		BpsTerm bpsTerm =null; 
		if(!mode.equals("add")){
			bpsTerm = bpsAdminService.findBpsTermById(bptId);
			BpsTermVersion bpsTermVersion= new BpsTermVersion();
			bpsTermVersion.setBpsTerm(bpsTerm);
			resultList_version = bpsAdminService.searchBpsTermVersion(bpsTermVersion);
			BpsAttachFile bpsAttachFile = new BpsAttachFile();
			bpsAttachFile.setBpsTerm(bpsTerm);
			resultList_files = bpsAdminService.searchBpsAttachFile(bpsAttachFile);
		}else{
			bpsTerm=new BpsTerm();
		}
		bpsAdminForm.setMode(mode);
		bpsAdminForm.setBpsTerm(bpsTerm);
		model.addAttribute("bpsAttachFiles", resultList_files); 
		model.addAttribute("bpsTermVersions", resultList_version);
		model.addAttribute("bpsAdminForm", bpsAdminForm);
		model.addAttribute("listCates", listBpsGroup());
		model.addAttribute("mode",mode); 
		 
		return "addOrEditBpsTerm";
	}
	
	@RequestMapping(params = "action=saveBpsTerm")
	public void saveBpsTerm(ActionRequest request, ActionResponse response,
			@ModelAttribute("bpsAdminForm")
			BpsAdminForm bpsAdminForm, BindingResult result, Model model) {
		System.out.println("saveBpsTerm="+bpsAdminForm.getMode());
	try{
		BpsTerm bpsTerm = bpsAdminForm.getBpsTerm();
		int recordUpdate=0; 
		if (bpsAdminForm.getMode().equalsIgnoreCase("add")) {
			recordUpdate=bpsAdminService.saveBpsTerm(bpsTerm);
			bpsTerm.setBptId(Long.parseLong(recordUpdate+"")); 
		} else {
			recordUpdate=bpsAdminService.updateBpsTerm(bpsTerm); 
		}

		//MultipartActionRequest multipartRequest = (MultipartActionRequest) request;
		PortletRequest req = (PortletRequest)request;
		 //  MultipartFile multipartFile = multipartRequest.getFile("file");
		   org.springframework.web.portlet.multipart.DefaultMultipartActionRequest multipartRequest = (org.springframework.web.portlet.multipart.DefaultMultipartActionRequest)req;
		   				  
		   if(multipartRequest!=null){				 
			  Map file_map= multipartRequest.getFileMap();
			  for (Iterator iterator = file_map.keySet().iterator(); iterator.hasNext();) {
				  String key=(String)iterator.next();
				  MultipartFile multipart =multipartRequest.getFile(key);
				  //MultipartFile multipartFile = multipartRequest.getFile("file");
				//org.springframework.web.multipart.MultipartFile 
				if(multipart!=null){
					FileOutputStream fos = null;

					try {
						byte []filesize = multipart.getBytes(); 
						System.out.println(" debug filesize="+filesize.length);
						if(filesize.length>0){									
							long current = System.currentTimeMillis();
						org.joda.time.DateTime    dt1  = new org.joda.time.DateTime (new Date().getTime()); 
							
						  String monthStr= dt1.getMonthOfYear()+"";
						  String yearStr= dt1.getYear()+"";
						  monthStr = monthStr.length()>1?monthStr:"0"+monthStr;
						  //String ndFilePath = "/usr/local/Work/TestDownload/"+yearStr+"_"+monthStr+"";
						  String ndFilePath = bundle.getString("downloadPath")+yearStr+"_"+monthStr+"";
						  String path =ndFilePath;
						  createDirectoryIfNeeded(path);
						  String filename = multipart.getOriginalFilename();
						  String []filenameSplit  =filename.split("\\.");
						  String extension ="";
						  if(filenameSplit!=null && filenameSplit.length>0){
							  extension =filenameSplit[filenameSplit.length-1];
						  }
						 String ndPathFileGen =current+"."+extension; 
						 fos = new FileOutputStream(path+"/"+ndPathFileGen);								
						 fos.write(filesize);
						 //gen url
						 BpsAttachFile bpsAttachFile =new BpsAttachFile();
						 bpsAttachFile.setBpafFileName(filename);
						 bpsAttachFile.setBpafFilePath(path+"/"+ndPathFileGen);
						 bpsAttachFile.setBpafFileSize(filesize.length+"");
						 bpsAttachFile.setBpafHotLink(genToken());
						 bpsAttachFile.setBpsTerm(bpsTerm);
						 bpsAdminService.saveBpsAttachFile(bpsAttachFile);
						 /*ntcDownload.setNdFileName(filename);
						 ntcDownload.setNdFilePath(path+"/"+ndPathFileGen);
						 ntcDownload.setNdFileSize(filesize.length+"");		
						 isSavedFile = true;*/
						}
					} catch (IOException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}finally{
						if(fos!=null)
							try {
								fos.close();
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}	
						 
					} 
				}
				
			}
				/*MultipartFile multipart = multipartRequest.getFile("file");		
				logger.debug("  debug multipart="+multipart);
			*/
		  }
		
		System.out.println("recordUpdate=="+recordUpdate);
		response.setRenderParameter("action", "manageBpsTerm");
		response.setRenderParameter("bptTerm", "");
		response.setRenderParameter("bpgId", "");
		response.setRenderParameter("searchBy", "");
		response.setRenderParameter("orderBy", "");
	}catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	}
	
	@RequestMapping(params="action=deleteBpsTerm")
	public void deleteBpsTerm(ActionRequest request, ActionResponse response,
			Model model, @RequestParam(value="bptId") String bptId) {
		bpsAdminService.deleteBpsTerm(bptId); 
		response.setRenderParameter("action", "manageBpsTerm"); 
	}
	 private void createDirectoryIfNeeded(String directoryName)
	 {
	   File theDir = new File(directoryName);

	   // if the directory does not exist, create it
	   if (!theDir.exists())
	   {
		   boolean cancreate = theDir.mkdir();
	     System.out.println("cancreate dir ="+cancreate);
	   }
	  
	 }
	 private void deleteOldFile(String realPathFile){
		 File f1 = new File(realPathFile);
		 if(f1.exists())				
			 f1.delete();	
	 }
	 private String genToken(){
			StringBuffer sb = new StringBuffer();
		    for (int i = 36; i > 0; i -= 12) {
		      int n = Math.min(12, Math.abs(i));
		      sb.append(org.apache.commons.lang.StringUtils.leftPad(Long.toString(Math.round(Math.random() * Math.pow(36, n)), 36), n, '0'));
		    }
		    return sb.toString();
	 }
}
