<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="portlet" uri="http://java.sun.com/portlet"%>
<%@ page import="java.util.List" %>
<portlet:defineObjects />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<c:url var="url" value="/" />
<link rel="stylesheet" href="${url}css/jquery-ui/jquery-ui-1.8.custom.css" type="text/css">
<link rel="stylesheet" href="${url}css/ui.selectmenu.css" type="text/css">
<script src='${url}js/jquery-1.6.4.min.js' type="text/javascript"></script>
<script src="${url}css/jquery-ui/jquery-ui-1.8.custom.min.js" type="text/javascript"></script>
<script src='${url}js/ui.selectmenu.js' type="text/javascript"></script>
<link type="text/css" rel="stylesheet"
	href="<%=request.getContextPath()%>/ckeditor/_samples/sample.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<script type="text/javascript"
        src="<%=request.getContextPath()%>/dwr/interface/BpsUserAjax.js"></script> 
<script type="text/javascript"
        src="<%=request.getContextPath()%>/dwr/engine.js"></script> 
<script type="text/javascript"
        src="<%=request.getContextPath()%>/dwr/util.js"></script>	
<script type="text/javascript" src="${url}uploadify/swfobject.js"></script>
<script type="text/javascript" src="${url}uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<link href="${url}uploadify/uploadify.css" type="text/css" rel="stylesheet" />
<style type="text/css">
/*demo styles 
body {font-size: 62.5%; font-family:"Verdana",sans-serif; margin: 70px 10px;}
fieldset { border:0;  margin-bottom: 40px;}	
*/
label,select,.ui-select-menu { float: left; margin-right: 10px; }
select { width: 200px; } 
.ui-widget{font-family: Tahoma;font-size: 12px; }
</style>
<style id="styles" type="text/css">

		.cke_button_myDialogCmd .cke_icon
		{
			display: none !important;
		}

		.cke_button_myDialogCmd .cke_label
		{
			display: inline !important;
		}

	</style>
<style type="text/css">
        #custom-demo .uploadifyQueueItem {
  background-color: #FFFFFF;
  border: none;
  border-bottom: 1px solid #E5E5E5;
  font: 11px Verdana, Geneva, sans-serif;
  height: 50px;
  margin-top: 0;
  padding: 10px;
  width: 350px;
}
#custom-demo .uploadifyError {
  background-color: #FDE5DD !important;
  border: none !important;
  border-bottom: 1px solid #FBCBBC !important;
}
#custom_file_uploadUploader {
	width: 120px;
	height: 30px;
}
#custom-demo .uploadifyQueueItem .cancel {
  float: right;
}
#custom-demo .uploadifyQueue .completed {
  color: #C5C5C5;
}
#custom-demo .uploadifyProgress {
  background-color: #E5E5E5;
  margin-top: 10px;
  width: 100%;
}
#custom-demo .uploadifyProgressBar {
  background-color: #0099FF;
  height: 3px;
  width: 1px;
}
#custom-demo #custom-queue {
  border: 1px solid #E5E5E5;
  height: 213px;
margin-bottom: 10px;
  width: 370px;
}
</style>
<script type="text/javascript">
var imageIdG="";
var indexSelectG="1";
var editor0;
var editor1;
var editor2;
var upload_Str="";
$(document).ready(function() {
	  // Handler for .ready() called.
	  $("input:button").button();
	  //$("input:submit").button(); 
	  $("input:reset").button(); 
	  $('select#bpgGroupId').selectmenu({style:'dropdown'});
});
	String.prototype.trim = function() {
		return this.replace(/^\s+|\s+$/g,"");
	}
	function <portlet:namespace />initUploadImg(){
		 $('#custom_file_upload').uploadify({
	   	  'uploader'       : '${url}uploadify/uploadify.swf',
	   	  'script'         : '${url}upload',
	   	  'cancelImg'      : '${url}uploadify/cancel.png',
	   	  //'folder'         : 'uploads',
	   	  'multi'          : false,
	   	  'auto'           : false,
	   	  'fileExt'        : '*.jpg;*.gif;*.png',
	   	  'fileDesc'       : 'Image Files (.JPG, .GIF, .PNG)',
	   	  'queueID'        : 'custom-queue',
	   	  'queueSizeLimit' : 3,
	   	  'simUploadLimit' : 3,
	   	  'sizeLimit'   : 102400,
	   	  'removeCompleted': true,
	   	  'onSelectOnce'   : function(event,data) {
	   		 imageIdG="";
	   	      $('#status-message').text(data.filesSelected + ' files have been added to the queue.');
	   	    },
	   	  'onAllComplete'  : function(event,data) {
	   	      $('#status-message').text(data.filesUploaded + ' files uploaded, ' + data.errors + ' errors.');
	   	    },
	   	   'onComplete'  : function(event, ID, fileObj, response, data) {
	   		   var obj = jQuery.parseJSON(response);
	   		   imageIdG=obj.id;
	   		var editor_data;
			var editorCheck=document.getElementsByName("editorCheck");
			if(editorCheck!=null && editorCheck.length>0){
				for(var i=0;i<editorCheck.length;i++){
					if(editorCheck[i].checked){
						indexSelectG=editorCheck[i].value;
						break;
					}
				}
			}
			//alert(indexSelectG)
			if(indexSelectG=="1"){
			    editor_data= CKEDITOR.instances.editor1;
			 
			}else{
				editor_data= CKEDITOR.instances.editor2;	
			}
	   		 	//var editor2 = CKEDITOR.instances["bptDefinition"]; //alert(editor2) // [obj]
				var selection = editor_data.getSelection();//alert(selection) // [obj]
				var text = selection.getNative();//alert(text) // ""
				var ranges = selection.getRanges();// alert(ranges) //[obj]
				var type = selection.getType();// alert(type) // 2 
			var	 newElement=CKEDITOR.dom.element.createFromHtml( '<img alt="" src="http://10.2.0.94:10000/BPSDownloadServlet/DownloadServlet?id='+imageIdG+'" />');
	      	 ranges[0].deleteContents();
				 ranges[0].insertNode(newElement);
				 ranges[0].selectNodeContents( newElement ); 
				 CKEDITOR.dialog.getCurrent().hide();
				// $( "#dialog-upload" ).dialog("close");
	  			//$( "#dialog-upload" ).dialog( "destroy" );
	   	      },
	   	    'onError'     : function (event,ID,fileObj,errorObj) {
	   	    	imageIdG="";
	   	        alert(errorObj.type + ' Error: ' + errorObj.info);
	   	      }
	   	});
	}
	function uploadImg(){ 
		
		$( "#dialog-upload" ).html(" <div class=\"demo-box\"><div id=\"status-message\">Select some files to upload:</div><div id=\"custom-queue\"></div><input id=\"custom_file_upload\" type=\"file\" name=\"Filedata\" />"+
				" </div> ");
		$( "#dialog-upload" ).dialog({
			title:"Upload Image",
			modal: true,
			show: 'slide' , 		
			height: 300,
			width: 460,
			buttons: [
				          {
			              text: "Ok",
			              click: function() {  
			            	 $('#custom_file_upload').uploadifyUpload();
			            	  
			            	//  agree= true; 
			              }
			          },
			          {
			              text: "Cancel",
			              click: function() { 
			            	  $(this).dialog("close");
			            	  $(this).dialog( "destroy" );
			            	  
			          	  }
			          }
			      ]
		}); 
		initUploadImg();
	}
	function selectDetail(input) {
		if(input == 'revisedDiv') {
			//indexSelectG="2";
			document.getElementById('proposedDiv').style.display = 'none';
			document.getElementById('revisedDiv').style.display = '';
			document.getElementById('proposedLink').style.color = 'blue';
			document.getElementById('revisedLink').style.color = 'gray';
		} else {
			//indexSelectG="1";
			document.getElementById('revisedDiv').style.display = 'none';
			document.getElementById('proposedDiv').style.display = '';
			document.getElementById('proposedLink').style.color = 'gray';
			document.getElementById('revisedLink').style.color = 'blue';
		}
	}
	
	function saveBtsTerm(_mode) {
		var subjectMail = document.getElementById('mailSubject').value;
		var haveError=false;
		var strError="";
		if(subjectMail.trim().length == 0) {
			haveError=true;
			strError=strError+"Please enter Subject.<br/>";
			/*
			alert("Please enter Subject.");
			return false;
			*/
		}
		var fromMail = "";
		//var fromMail = document.getElementById('mailFrom').value;
		//alert(fromMail);
		var toMail = "";
		/*var textArea = CKEDITOR.instances.editor1.getData();
		var re = /(<([^>]+)>)/gi;
		var textSearch = textArea.replace(re, "");*/
		
		var bpt_term = document.getElementById('term').value;
		if(bpt_term.trim().length == 0) {
			haveError=true;
			strError=strError+"Please enter Term.<br/>";
			/*
			alert("Please enter Term.");
			return false;
			*/
		} 
		
		var shortDesc = document.getElementById('shortDesc').value;
		if(shortDesc.trim().length == 0) {
			haveError=true;
			strError=strError+"Please enter Definition.<br/>";
			/*
			alert("Please enter Definition.");
			return false;
			*/
		} 
		
		var selectGroup = document.getElementById('bpgGroupId');
		var bpgId = selectGroup.options[selectGroup.selectedIndex].value;
		if(bpgId == '0') {
			haveError=true;
			strError=strError+"Please select Category.<br/>";
			/*
			alert("Please select Category.");
			return false;
			*/
		}
		if(haveError){
			$("#dialog_error_content").html(strError);
			$("#dialog_error").dialog({ 
				title:"Error Message",
				modal: true ,
				show: 'slide' ,
				//hide: "explode",
				buttons:  [
     				          {
   				              text: "Ok",
   				              click: function() { 				 
   				            	 	 $(this).dialog("close");
   				            	 	 $(this).dialog( "destroy" );  
   				            	  }
   				          } 
   				      ]  
				});
			return false;
		}
		var str="";
		var editor_data;
		var editorCheck=document.getElementsByName("editorCheck");
		if(editorCheck!=null && editorCheck.length>0){
			for(var i=0;i<editorCheck.length;i++){
				if(editorCheck[i].checked){
					indexSelectG=editorCheck[i].value;
					break;
				}
			}
		}
		//alert(indexSelectG)
		if(indexSelectG=="1"){
		    editor_data= CKEDITOR.instances.editor1;
		 
		}else{
			editor_data= CKEDITOR.instances.editor2;	
		}
		var child_count=editor_data.document.getBody().getChildCount();
		
		for(var i=0;i<child_count;i++){
			str=str+editor_data.document.getBody().getChild( i).getText();
		}
		var textSearch = str;
		var default_value = document.getElementById("bptId_hidden").value;
		
		var bpt_source_ref = document.getElementById('bptSource').value;
		
		var userCreate = document.getElementById('userCreate').value;		 
 
		var bpsTermLog = {
				bptId : default_value,
				//bptStatus : default_value,
				bptTerm : bpt_term,
				bptShortDesc : shortDesc,
				bptDefinition : editor_data.getData(),
				bptDefinitionSearch : textSearch,
				bptSource : bpt_source_ref,
				bptCreateBy : userCreate,
				bpsGroup : {
					bpgId : bpgId
				}
		};
	//	alert("editor_data.getData()="+editor_data.getData());
	//	alert("textSearch="+textSearch); 
	$("#dialog_img_loading").html("<img src=\"${url}images/ui-anim_basic_16x16.gif\"/>&nbsp; Sending...");						
var dialog_sendmail=$("#dialog_sendmail").dialog({ 
		title:"Send Mail",
		modal: true ,
		show: 'slide' 
	//	hide: "explode" 
		});
		BpsUserAjax.saveOrUpdateBpsTermLog(bpsTermLog,subjectMail, _mode, {
			callback:function(data){
				var _sended=(data != null && data > 0)?true:false;
				if(_sended)	
					$("#dialog_img_loading").html("Data has been send.");
				else
					$("#dialog_img_loading").html("Data not send.");
				//alert(data)					
				dialog_sendmail.dialog( "option", "buttons",  [
				              				          {
				            				              text: "Ok",
				            				              click: function() { 				 
				            				            	 	 $(this).dialog("close");
				            				            	 	 $(this).dialog( "destroy" ); 
				            				            	 	 if(_sended)
				            				            	 		window.location.href=document.getElementById("home_url").value;       	  
				            				            	  }
				            				          } 
				            				      ] );
			}
		});
		//handle_Complete);
	}
	
	function handle_Complete(result) {
		if(result != null || result > 0) {
			alert("Data has been send.");
		//	alert("aa="+document.getElementById("home_url").value)
			//window.location.href=document.getElementById("home_url").value;
		}
	}
	function  <portlet:namespace />setupUploader() {
		$('.cke_dialog_ui_vbox_child')
				.html(
						'<div id="status-message">Select some files to upload:</div><div id="custom-queue"></div><input id="custom_file_upload" type="file" name="Filedata" />');
		<portlet:namespace />initUploadImg();

		$('.cke_dialog_ui_hbox_first').children('a').attr("href", "#");

	}
	function  <portlet:namespace />callUploader() {
		$('#custom_file_upload').uploadifyUpload();
	}
</script>
</head>
<body>

<%
/*com.ibm.portal.puma.User user = (com.ibm.portal.puma.User) request.getAttribute("com.ibm.portal.puma.request-user");
String userCreate = "";
String userMail = "";
if(user != null) {
	userCreate = user.get("uid");
	userMail = user.get("mail");
	List list = user.getGroups();
	if(list != null && list.size() > 0) {
		int size = list.size();
		for(int i=0;i<size;i++) {
			com.ibm.wps.puma.Group groupElement = (com.ibm.wps.puma.Group)list.get(i);
			if(groupElement.getName() != null) {
				
			}
		}
	}
}*/
%>
<div id="dialog-upload" title="Upload Image" style="display: none;">
	<p>
		 
	</p>
</div>
<div id="dialog_sendmail" title="Sendmail dialog" style="display: none;">
	 <table id="table_loading" width="100%">
	 	<tr>
	 		<td width="100%" colspan="2" align="center">
	 			<span id="dialog_img_loading"><img src="${url}images/ui-anim_basic_16x16.gif"/>&nbsp; Sending...</span>
	 		</td>
	 	</tr>
	 </table>
</div>
<div id="dialog_error" title="Error dialog" style="display: none;">
	 <table id="table_error" width="100%">
	 	<tr>
	 		<td width="100%" colspan="2" align="left">
	 			<span id="dialog_error_content"></span>
	 		</td>
	 	</tr>
	 </table>
</div>
	<c:if test="${mode eq 'add'}">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="center" style="background-color: #FFF;">
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="2" cellpadding="0">
						<tr>
							<td>
								<form action="" method="get">
								<input type="hidden" id="home_url" value='<portlet:renderURL><portlet:param name="action" value="list"/></portlet:renderURL>'/>
								<input type="hidden" id="bptId_hidden" value='0'/>
									<table width="100%" border="0" cellspacing="3" cellpadding="0">
										<tr>
											<td height="30" colspan="2"  align="left"
												style="background-color: #132C00; font-weight: bold; color: #FFF;">&nbsp;New
												BPS Terms and Definitions</td>
										</tr>
										<tr>
											<td width="19%" height="19" class="h_achieve" align="left">To:</td>
											<td width="81%" align="left"><label> <input name="mailTo"
													type="text" id="mailTo" value="COS Staff" size="50"
													class="readonly" disabled="disabled"> </label>
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">From:</td>
											<td><input name="mailFrom" type="text"  align="left"
												class="readonly" id="mailFrom" value="<%=request.getUserPrincipal().getName() %>" size="50"
												disabled="disabled">
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">Subject:</td>
											<td align="left"><input name="mailSubject" type="text" id="mailSubject"
												size="50">
											</td>
										</tr>
										<tr>
											<td colspan="2"><hr>
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">Term:</td>
											<td align="left"><input name="term" type="text" id="term"
												size="50">
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">Category:</td>
											<td align="left">
											<select name="bpsGroupId" id="bpgGroupId">
											<%--
											<option value="0">---Select Category--</option>
											 --%>
												<c:forEach items="${resultListGroup.resultListObj}" var="groupItem">
													<option value="${groupItem.bpgId}">${groupItem.bpgGroupName}</option>
												</c:forEach>
	    					</select>
											</td>
										</tr>
										<tr valign="top">
											<td class="h_achieve" align="left">Source / Reference:</td>
											<td align="left"><input name="bptSource" type="text" id="bptSource"
												size="50">
											</td>
										</tr>
										<tr valign="top">
											<td class="h_achieve" align="left">Definition:</td>
											<td align="left"><textarea name="shortDesc" id="shortDesc"
												cols="80" rows="3"></textarea>
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left" valign="top">Detail:</td>
											<td align="left"><textarea cols="50" id="editor1" name="editor1" rows="10"></textarea>
											<script type="text/javascript">
												//CKEDITOR.replace('editor1');
												 editor0=CKEDITOR.replace( 'editor1',
														{
															// Defines a simpler toolbar to be used in this sample.
															// Note that we have added out "MyButton" button here.
															//height : 50,
															//Preview - 
															//toolbar : [ [ 'Source', '-', 'Bold', 'Italic', 'Underline', 'Strike','-','Link' ] ]
													toolbar : [
																{ name: 'document', items : [ 'Source','-','Preview','-'] },
																//{ name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
																//{ name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
																//{ name: 'forms', items : [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton','HiddenField' ] },
																//'/',
																{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike',] },
																{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
																{ name: 'links', items : [ 'Link','Unlink'] },
																{ name: 'insert', items : [ 'Image','Table','HorizontalRule','Smiley','SpecialChar','PageBreak' ] },
																'/',
																{ name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] },
																{ name: 'colors', items : [ 'TextColor','BGColor','-','MyButton'] }
																//{ name: 'tools', items : [ 'Maximize', 'ShowBlocks','-','About' ] }
															]
														});
												 editor0.on( 'pluginsLoaded', function( ev )
															{
																// If our custom dialog has not been registered, do that now.
																if ( !CKEDITOR.dialog.exists( 'myDialog' ) )
																{
																	CKEDITOR.dialog.add( 'myDialog', function( api )
																			{
																		var dialogDefinition =
																		{
																			title : 'Upload Img',
																			minWidth : 390,
																			minHeight : 130,
																			contents : [
																				{
																					id : 'tab1',
																					label : 'Upload Image',
																					title : 'Title',
																					expand : true,
																					padding : 0,
																					elements :
																					[
																						{
																							 
																							id:'linkType',
																							type : 'html',
																							html : upload_Str
																						} 
																					]
																				} 
																			],
																			buttons : [ CKEDITOR.dialog.okButton, CKEDITOR.dialog.cancelButton ],
																			onOk : function() { 
																				<portlet:namespace />callUploader();
																				return false;
																			 } 
																		};
																		return dialogDefinition;
																			});
																}
																// Register the command used to open the dialog.
																editor0.addCommand( 'myDialogCmd', new CKEDITOR.dialogCommand( 'myDialog' ) );
																// Add the a custom toolbar buttons, which fires the above
																// command.. 
																var iconPath = '${url}images/icon_upload.gif';
																editor0.ui.addButton( 'MyButton',
																	{
																		label : 'upload Img',
																		command : 'myDialogCmd',
																		icon: iconPath
																	} );
															});
												 editor0.on( 'dialogShow', function( evt ){	
													 if(CKEDITOR.dialog.getCurrent().getName()=='myDialog'){
														 <portlet:namespace />setupUploader();
														}
												 });
											</script>			
										</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td align="left"><label> <input type="button" name="button"
													id="button" value="Send mail" onclick="return saveBtsTerm('request_new')"> <input type="reset"
													name="button2" id="button2" value="Cancel"> </label>
											</td>
										</tr>
									</table>
									<input name="userCreate" type="hidden" id="userCreate" value="<%=request.getUserPrincipal().getName() %>">
								</form>
							</td>

						</tr>
					</table></td>
			</tr>
			<tr>
			<td height="30" align="left"><span
				style="color: #030; font-size: 12px;"><a href='<portlet:renderURL><portlet:param name="action" value="list"/></portlet:renderURL>'>< Back to Home</a></span>
			</td>
		</tr>
		</table>
	</c:if>
	<c:if test="${mode eq 'edit'}">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="center" style="background-color: #FFF;">
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="2" cellpadding="0">
						<tr>
							<td>
								<form action="" method="get">
								<input type="hidden" id="home_url" value='<portlet:renderURL><portlet:param name="action" value="list"/></portlet:renderURL>'/>
								<input type="hidden" id="bptId_hidden" value='${bpsUserForm.bpsTerm.bptId}'/>
									<table width="100%" border="0" cellspacing="3" cellpadding="0">
										<tr>
											<td height="30" colspan="2" align="left"
												style="background-color: #132C00; font-weight: bold; color: #FFF;">&nbsp;Request
												to modify BPS Term and Definition</td>
										</tr>
										<tr>
											<td width="19%" height="19" class="h_achieve" align="left">To:</td>
											<td width="81%"><label> <input name="mailTo"
													type="text" id="mailTo" value="COS Staff" size="50"
													class="readonly" disabled="disabled"> </label>
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">From:</td>
											<td><input name="mailFrom" type="text"
												class="readonly" id="mailFrom" value="<%=request.getUserPrincipal().getName() %>" size="50"
												disabled="disabled">
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">Subject:</td>
											<td><input name="mailSubject" type="text" id="mailSubject"
												size="50">
											</td>
										</tr>
										<tr>
											<td colspan="2"><hr>
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">Term:</td>
											<td align="left"><input name="term" type="text" id="term"
												value="${bpsUserForm.bpsTerm.bptTerm}" size="50" class="readonly"
												disabled="disabled">
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left">Category:</td>
											<td align="left">
											<select name="bpsGroupId" id="bpgGroupId">
											<%--
											<option value="0">---Select Category--</option>
											 --%>
												<c:forEach items="${resultListGroup.resultListObj}" var="groupItem">
													<c:if test="${bpsUserForm.bpsTerm.bpsGroup ne null && bpsUserForm.bpsTerm.bpsGroup.bpgId eq groupItem.bpgId}">
					<option value="${groupItem.bpgId}" selected="selected">${groupItem.bpgGroupName}</option>
				</c:if>
				<c:if test="${bpsUserForm.bpsTerm.bpsGroup ne null && bpsUserForm.bpsTerm.bpsGroup.bpgId ne groupItem.bpgId}">
					<option value="${groupItem.bpgId}">${groupItem.bpgGroupName}</option>
				</c:if>
												</c:forEach>
	    					</select>
											</td>
										</tr>
										<tr valign="top">
											<td class="h_achieve" align="left">Source / Reference:</td>
											<td align="left"><input name="bptSource" type="text" id="bptSource" value="${bpsUserForm.bpsTerm.bptSource}" 
												size="50">
											</td>
										</tr>
										<tr valign="top">
											<td class="h_achieve" align="left">Definition:</td>
											<td align="left"><textarea name="shortDesc" id="shortDesc"
												cols="80" rows="3"><c:out value="${bpsUserForm.bpsTerm.bptShortDesc}" escapeXml="true" /></textarea>
											</td>
										</tr>
										<tr>
											<td height="25">&nbsp;</td>
											<td class="h_achieve" align="left"><input type="radio" name="editorCheck" value="1" checked="checked" onclick="selectDetail('proposedDiv')"><a  id="proposedLink" style="color: gray">Proposed change</a> |
												<input type="radio" name="editorCheck" value="2" onclick="selectDetail('revisedDiv')"> <a  id="revisedLink" style="color: blue">Revised version</a>
											</td>
										</tr>
										<tr>
											<td class="h_achieve" align="left" valign="top">Detail:</td>
											<td align="left"><div id="proposedDiv"><textarea cols="50" id="editor1" name="editor1" rows="10"></textarea><script type="text/javascript">
	 editor1=	CKEDITOR.replace('editor1', {
			// Defines a simpler toolbar to be used in this sample.
			// Note that we have added out "MyButton" button here.
			//height : 50,
			//Preview - 
			//toolbar : [ [ 'Source', '-', 'Bold', 'Italic', 'Underline', 'Strike','-','Link' ] ]
	toolbar : [
				{ name: 'document', items : [ 'Source','-','Preview','-'] },
				//{ name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
				//{ name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
				//{ name: 'forms', items : [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton','HiddenField' ] },
				//'/',
				{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike',] },
				{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
				{ name: 'links', items : [ 'Link','Unlink'] },
				{ name: 'insert', items : [ 'Image','Table','HorizontalRule','Smiley','SpecialChar','PageBreak' ] },
				'/',
				{ name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] },
				{ name: 'colors', items : [ 'TextColor','BGColor' ,'-','MyButton'] }
				//{ name: 'tools', items : [ 'Maximize', 'ShowBlocks','-','About' ] }
			]
		});
	 editor1.on( 'pluginsLoaded', function( ev )
					{
						// If our custom dialog has not been registered, do that now.
						if ( !CKEDITOR.dialog.exists( 'myDialog' ) )
						{
							CKEDITOR.dialog.add( 'myDialog', function( api )
									{
								var dialogDefinition =
								{
									title : 'Upload Img',
									minWidth : 390,
									minHeight : 130,
									contents : [
										{
											id : 'tab1',
											label : 'Upload Image',
											title : 'Title',
											expand : true,
											padding : 0,
											elements :
											[
												{
													 
													id:'linkType',
													type : 'html',
													html : upload_Str
												} 
											]
										} 
									],
									buttons : [ CKEDITOR.dialog.okButton, CKEDITOR.dialog.cancelButton ],
									onOk : function() { 
											uploadImg();
									 } 
								};
								return dialogDefinition;
									});
						}
						// Register the command used to open the dialog.
						editor1.addCommand( 'myDialogCmd', new CKEDITOR.dialogCommand( 'myDialog' ) );
						// Add the a custom toolbar buttons, which fires the above
						// command.. 
						var iconPath = '${url}images/icon_upload.gif';
						editor1.ui.addButton( 'MyButton',
							{
								label : 'upload Img',
								command : 'myDialogCmd',
								icon: iconPath
							} );
					});
	 editor1.on( 'dialogShow', function( evt ){	
		 });
	</script></div><div id="revisedDiv" style="display: none"><textarea cols="50" id="editor2" name="editor2" rows="10"><c:out value="${bpsUserForm.bpsTerm.bptDefinition}" escapeXml="true" /></textarea><script type="text/javascript">
	editor2=	CKEDITOR.replace('editor2', {
			// Defines a simpler toolbar to be used in this sample.
			// Note that we have added out "MyButton" button here.
			//height : 50,
			//Preview - 
			//toolbar : [ [ 'Source', '-', 'Bold', 'Italic', 'Underline', 'Strike','-','Link' ] ]
	toolbar : [
				{ name: 'document', items : [ 'Source','-','Preview','-'] },
				//{ name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
				//{ name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
				//{ name: 'forms', items : [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton','HiddenField' ] },
				//'/',
				{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike',] },
				{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
				{ name: 'links', items : [ 'Link','Unlink'] },
				{ name: 'insert', items : [ 'Image','Table','HorizontalRule','Smiley','SpecialChar','PageBreak' ] },
				'/',
				{ name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] },
				{ name: 'colors', items : [ 'TextColor','BGColor'  ,'-','MyButton'] }
				//{ name: 'tools', items : [ 'Maximize', 'ShowBlocks','-','About' ] }
			]
		});
		editor2.on( 'pluginsLoaded', function( ev )
				{
					// If our custom dialog has not been registered, do that now.
					if ( !CKEDITOR.dialog.exists( 'myDialog' ) )
					{
						CKEDITOR.dialog.add( 'myDialog', function( api )
								{
							var dialogDefinition =
							{
								title : 'Upload Img',
								minWidth : 390,
								minHeight : 130,
								contents : [
									{
										id : 'tab1',
										label : 'Upload Image',
										title : 'Title',
										expand : true,
										padding : 0,
										elements :
										[
											{
												 
												id:'linkType',
												type : 'html',
												html : upload_Str
											} 
										]
									} 
								],
								buttons : [ CKEDITOR.dialog.okButton, CKEDITOR.dialog.cancelButton ],
								onOk : function() { 
										uploadImg();
								 } 
							};
							return dialogDefinition;
								});
					}
					// Register the command used to open the dialog.
					editor2.addCommand( 'myDialogCmd', new CKEDITOR.dialogCommand( 'myDialog' ) );
					// Add the a custom toolbar buttons, which fires the above
					// command.. 
					var iconPath = '${url}images/icon_upload.gif';
					editor2.ui.addButton( 'MyButton',
						{
							label : 'upload Img',
							command : 'myDialogCmd',
							icon: iconPath
						} );
				});
 editor2.on( 'dialogShow', function( evt ){	
	 });
	</script></div>
											</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td align="left"><label> <input type="button" name="button"
													id="button" value="Send mail" onclick="return saveBtsTerm('comment')"> <input type="reset"
													name="button2" id="button2" value="Cancel"> </label>
											</td>
										</tr>
									</table>
									<input name="userCreate" type="hidden" id="userCreate" value="<%=request.getUserPrincipal().getName() %>">
								</form>
							</td>
						</tr>
					</table></td>
			</tr>
			<tr>
			<td height="30"><span
				style="color: #030; font-size: 12px;"><a href='<portlet:renderURL><portlet:param name="action" value="list"/></portlet:renderURL>'>< Back to Home</a></span>
			</td>
		</tr>
		</table>
	</c:if>
</body>
</html>