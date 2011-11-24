<%@include file="../include.jsp"%>
<%@page contentType="text/html; charset=utf-8"%>
<html>
<head>
<c:url var="url" value="/" />
<link rel="stylesheet" href="${url}css/jquery-ui/jquery-ui-1.8.custom.css" type="text/css">
<link rel="stylesheet" href="${url}css/ui.selectmenu.css" type="text/css">
<script src='${url}js/jquery-1.6.4.min.js' type="text/javascript"></script>
<script src="${url}css/jquery-ui/jquery-ui-1.8.custom.min.js" type="text/javascript"></script>
<script src='${url}js/ui.selectmenu.js' type="text/javascript"></script>
<link rel="stylesheet" type="text/css"
	href="${url}css/style.css" />
<link rel="stylesheet" type="text/css"
	href="${url}css/example.css" />
<link type="text/css" rel="stylesheet"
	href="${url}ckeditor/_samples/sample.css" />
<script type="text/javascript"
	src="${url}ckeditor/ckeditor.js"></script>
<script type="text/javascript"
	src="${url}js/tabber.js"></script>
<script type="text/javascript"
        src="${url}dwr/interface/BpsAdminAjax.js"></script> 
<script type="text/javascript"
        src="${url}dwr/engine.js"></script> 
<script type="text/javascript"
        src="${url}dwr/util.js"></script> 
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>Insert title here</title>
<script>
var editor1;
var imageIdG="";
$(document).ready(function() {
	  // Handler for .ready() called.
	  $("input:button").button();
	//  $("input:submit").button();
	  $("a[id=manageBpsGroup]").button();
	  $('select#bpgId').selectmenu({style:'dropdown'});
});
function initUploadImg(){
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
   	 // 'scriptData'  : {'firstName':'Chatchai','age':30},
   	  'onSelectOnce'   : function(event,data) {
   		//  alert("onSelectOnce")
   		 imageIdG="";
   	      $('#status-message').text(data.filesSelected + ' files have been added to the queue.');
   	    },
   	  'onAllComplete'  : function(event,data) {
   		//  alert("onAllComplete")
   	      $('#status-message').text(data.filesUploaded + ' files uploaded, ' + data.errors + ' errors.');
   	    },
   	   'onComplete'  : function(event, ID, fileObj, response, data) {
   		   var obj = jQuery.parseJSON(response);
   		   imageIdG=obj.id;
   		 	var editor2 = CKEDITOR.instances["bptDefinition"]; //alert(editor2) // [obj]
			var selection = editor2.getSelection();//alert(selection) // [obj]
			var text = selection.getNative();//alert(text) // ""
			var ranges = selection.getRanges();// alert(ranges) //[obj]
			var type = selection.getType();// alert(type) // 2 
		//			alert(imageIdG)
		var	 newElement=CKEDITOR.dom.element.createFromHtml( '<img alt="" src="http://10.2.0.94:10000/BPSDownloadServlet/DownloadServlet?id='+imageIdG+'" />');
      	 ranges[0].deleteContents();
			 ranges[0].insertNode(newElement);
			 ranges[0].selectNodeContents( newElement ); 	
			 $( "#dialog-upload" ).dialog("close");
  			$( "#dialog-upload" ).dialog( "destroy" );
   	      },
   	    'onError'     : function (event,ID,fileObj,errorObj) {
   	    	imageIdG="";
   	        alert(errorObj.type + ' Error: ' + errorObj.info);
   	      }
   	});
}
function popupwnd(url, toolbar, menubar, locationbar, resize, scrollbars, statusbar, left, top, width, height)
{
   var popupwindow = this.open(url, '', 'toolbar=' + toolbar + ',menubar=' + menubar + ',location=' + locationbar + ',scrollbars=' + scrollbars + ',resizable=' + resize + ',status=' + statusbar + ',left=' + left + ',top=' + top + ',width=' + width + ',height=' + height);
}
function <portlet:namespace/>downloadFile(_hotLink){ 
	 //	var src = "http://localhost:8081/BPSDownloadServlet/DownloadServlet?"+_hotLink;
	 	var src = "http://10.2.0.94:10000/BPSDownloadServlet/DownloadServlet?"+_hotLink;
	    var div = document.createElement("div");
	    document.body.appendChild(div);
	    div.innerHTML = "<iframe width='0' height='0' scrolling='no' frameborder='0' src='" + src + "'></iframe>";
		  // Create an IFRAME.
		//var _form =document.getElementById('downloadAdminform');
	 	//_form.submit();
	} 
var _file_index=1;
function manageMoreFile(_id,_mode){
	if(_mode=='add'){
		$("#more_file_element").append("<span id=\"_element_file_"+_file_index+"\"><input type=\"file\" name=\"file"+_file_index+"\"/></span><span id=\"_element_img_"+_file_index+"\"><img src=\"${url}images/delete_file.png\" alt=\"delete file\" style=\"cursor: pointer;\" onclick=\"manageMoreFile('"+_file_index+"','del')\"/><br/></span>");		
		_file_index++;
	}
	else{
		//alert(_id)
		$("#_element_file_"+_id).html("");
		$("#_element_img_"+_id).html("");
	}
}
function setChoice(_id){ 
	BpsAdminAjax.findBpsTermVersionById(_id,{
		callback:function(data){ 
			 if(data!=null){
				// alert(data.bptVersionNumber);
				//alert(data.bptShortDesc)
				 $("#bptDefinitionSearch").val(data.bptDefinitionSearch);
				 $("#bptVersionNumber").val(data.bptVersionNumber);
				 $("#bptSource").val(data.bptSource);
				 $("#bptShortDesc").val(data.bptShortDesc);
				// $("#bptDefinition").val(data.bptDefinition);
	            	editor1.setData(data.bptDefinition);
				 //bpgId bptSource bptShortDesc bptDefinition
			 }
		}
	}); 
}
function test(){
	var editor_data = CKEDITOR.instances.bptDefinition;
	alert(editor_data.getData())
	
	var text = editor_data.document.getBody().getChild( 0 ).getText();
	alert(editor_data.document.getBody().getChildCount())
	//alert(text)
	$("#uu").html(text)
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
function clearFile(spanId){
	//$("#"+elementId).val("");
	$( "#dialog-message" ).html(" Would you like to delete file ? ");
	$( "#dialog-message" ).dialog({
		title:"Delete File",
		modal: true,
		show: 'slide' ,
		//hide: "explode",
		buttons: [
			          {
		              text: "Ok",
		              click: function() {  
		            	  $(this).dialog("close");
		            	  $(this).dialog( "destroy" );
		            	//  agree= true;
		            	  BpsAdminAjax.deleteBpsAttachFile(spanId,{
		          			callback:function(data){ 
		          				 if(data!=null){
		          					 $("#_element_img_"+spanId).html("");
		          					 $("#_element_file_"+spanId).html("");
		          				 }
		          			}
		          		}); 
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
	/*
	var agree = confirm();
	if (agree){
		
	 }
	*/
}
function <portlet:namespace />doAction(_command,_mode){
	var command = document.getElementById("command");
	var mode = document.getElementById("mode");
	command.value=_command;
	var editor_data = CKEDITOR.instances.bptDefinition;
	var child_count=editor_data.document.getBody().getChildCount();
	var str="";
	for(var i=0;i<child_count;i++){
		str=str+editor_data.document.getBody().getChild( i).getText();
	} 
	 $("#bptDefinitionSearch").val(str);
	mode.value=_mode;
	var str_message; 
	
	/*
	var agree ;
	if(_mode == 'edit' || _mode=='updateVersion')
		agree = confirm(" Would you like to edit Term and Definition? ");
	else
		agree = confirm(" Would you like to add Term and Definition? ");
	if (agree){
		return true ;
	}
	else{
		return false ;
	}
	*/
	if(_mode == 'edit' || _mode=='updateVersion')
		str_message=" Would you like to edit Term and Definition? ";
	else
		str_message=" Would you like to add Term and Definition? ";
	var agree=false;
	$( "#dialog-message" ).html(str_message);
	$( "#dialog-message" ).dialog({
		title:"Term and Definition",
		modal: true,
		show: 'slide' ,
		//hide: "explode",
		buttons: [
			          {
		              text: "Ok",
		              click: function() {  
		            	  $(this).dialog("close");
		            	  $(this).dialog( "destroy" );
		            	//  agree= true;
		            	  document.bpsAdminForm.submit();
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
	//alert(agree)
	/* if(agree)
		return true;
	else */
		return false;
	//return agree;
	//	return true;//false;
	}
</script>
</head>
<portlet:renderURL var="backURL">
    <portlet:param name="action" value="manageBpsTerm"/>
</portlet:renderURL>
<portlet:actionURL var="formAction">
    <portlet:param name="action" value="saveBpsTerm"/>
</portlet:actionURL>
<portlet:renderURL var="homeURL">
    <portlet:param name="action" value="list"/>
</portlet:renderURL>
<body>
<div id="dialog-message" title="Message">
	<p>
		 
	</p>
</div>
<div id="dialog-upload" title="Upload Image" style="display: none;">
	<p>
		 
	</p>
</div>
<form:form  name="bpsAdminForm" modelAttribute="bpsAdminForm" method="post" action="${formAction}"  enctype="multipart/form-data">
<form:hidden path="command" id="command"/>
<form:hidden path="bpsTerm.bptDefinitionSearch" id="bptDefinitionSearch"/>
<form:hidden path="mode" id="mode"/>
<form:hidden path="bpsTerm.bptVersionNumber" id="bptVersionNumber"/>
	<table width="100%" align="center" border="0" cellspacing="0"
		cellpadding="0">
		<tr>
			<td><img src="${url}images/term.gif">
			</td>
			<td align="right">&nbsp;</td>
		</tr>
		<tr>
			<td height="30" colspan="2"><span
				style="color: #030; font-size: 12px;"><strong>You
						are in:</strong> <a href="${fn:escapeXml(homeURL)}">Home</a> > <a href="${fn:escapeXml(backURL)}">BPS
						Term and Definition</a> > 
						<c:if test="${mode=='add'}">Add</c:if>
						<c:if test="${mode=='edit'}">Edit</c:if>  
						BPS Term and Definition</span>
						<span id="uu"></span>
			</td>
		</tr>
		
		<tr>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2" valign="top">
				<!--//-->
				<style>
#box-table-a {
	font-size: 12px;
	margin: 0px;
	width: 100%;
	text-align: left;
	border-collapse: collapse;
}

#box-table-a th {
	font-size: 13px;
	font-weight: bold;
	padding: 8px;
	background: #132C00;
	border-top: 4px solid #859D48;
	border-bottom: 1px solid #fff;
	color: #FFF;
}

#box-table-a td {
	padding: 8px;
	background: #e8edff;
	border-bottom: 1px solid #fff;
	color: #000;
	border-top: 1px solid transparent;
	height: 25px;
	border: 1px solid #3DB0B5;
}

#box-table-a tr:hover td {
	background: #d0dafd;
}

table#box-table-a a {
	color: #003399;
	text-decoration: none;
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
}

table#box-table-a a:link,table.links a:visited {
	color: #004a5d;
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
}

table#box-table-a a:hover {
	color: #758D39;
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
	text-decoration: underline;
}
</style> 
					<table width="100%" border="0" cellspacing="5" cellpadding="0">
						<tr>
							<th width="100%" colspan="2" height="25" align="left">Term:</th>
							
						</tr>
						<tr>
							<td width="100%" colspan="2" align="left">
								<form:input path="bpsTerm.bptTerm" size="80"/> 
							</td>
						</tr>
						<tr>
							<th  width="100%" colspan="2" height="25" align="left">Category:</th>
							
						</tr>
						<tr>
							<td width="100%" colspan="2" align="left">
							<table>
							<tr>
							<td><form:select path="bpsTerm.bpsGroup.bpgId" id="bpgId">
	    						<form:option  label="---Select Category--" value="0"/>
	    						<form:options items="${listCates}" itemValue="bpgId"  itemLabel="bpgGroupName"/>
	    					</form:select></td>
							<td>&nbsp; <a id="manageBpsGroup"
								href="<portlet:renderURL><portlet:param name="action" value="manageBpsGroup"/></portlet:renderURL>">Manage Category</a></td>
							</tr>
							</table>
							</td>
						</tr>
						<tr>
							<th height="25" colspan="2" align="left">Source / Reference:</th>							
						</tr>
						<tr>
							<td align="left" colspan="2">
								<form:input path="bpsTerm.bptSource"  id="bptSource" size="80"/>
							</td>
						</tr>
						<tr>
							<th height="25" colspan="2" align="left">Definition:</th>							
						</tr>
						<tr>
							<td align="left" colspan="2">
								<form:textarea  path="bpsTerm.bptShortDesc" id="bptShortDesc" cols="80" rows="3"/>
							</td>
						</tr>
						<tr>							
							<th valign="top" colspan="2" align="left">Details:</th>
						</tr>
						<tr>
							<td align="left" colspan="2" valign="top">
							<form:textarea path="bpsTerm.bptDefinition" id="bptDefinition" rows="10" cols="80"/> 
							<script type="text/javascript">
									//CKEDITOR.replace('bptDefinition');
									var upload_Str=" Would you like to upload image file ? ";
							      
									 editor1=CKEDITOR.replace( 'bptDefinition',
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
													{ name: 'colors', items : [ 'TextColor','BGColor' ,'-','MyButton'] }
													//{ name: 'tools', items : [ 'Maximize', 'ShowBlocks','-','About' ] }
												]
											});
									 editor1.on( 'pluginsLoaded', function( ev )
												{
													// If our custom dialog has not been registered, do that now.
													if ( !CKEDITOR.dialog.exists( 'myDialog' ) )
													{
														//alert("load myDialog")
														// We need to do the following trick to find out the dialog
														// definition file URL path. In the real world, you would simply
														// point to an absolute path directly, like "/mydir/mydialog.js". 
														// Finally, register the dialog.
													//	CKEDITOR.dialog.add( 'myDialog', href );
														CKEDITOR.dialog.add( 'myDialog', function( api )
																{
															//alert("load...")
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
																				 /*
																				type : 'button',
																				label : 'Label Text',
																				title : 'Field description',
																				//className: '...',
																				//style: '...',
																				onClick : function(){  }
																			   */
																			} 
																		]
																	} 
																],
																buttons : [ CKEDITOR.dialog.okButton, CKEDITOR.dialog.cancelButton ],
																onOk : function() { 
																	/*
														            var editor2 = CKEDITOR.instances["bptDefinition"]; 
																var selection = editor2.getSelection();
																var text = selection.getNative();
																var ranges = selection.getRanges(); 
																var type = selection.getType(); 
																var isSave=true;
																var element_Id="";
																if(type==CKEDITOR.SELECTION_TEXT){  
																	var xx=CKEDITOR.dom.selection(editor2.document); 
																	var element = selection.getStartElement();  
																	if(element.is('span')){ 
																		element_Id=element.getId();
																		isSave=false;
																	}
																} 
																*/
																/*
																 * CKEDITOR.SELECTION_NONE (1): No selection. CKEDITOR.SELECTION_TEXT
																 * (2): Text is selected or collapsed selection.
																 * CKEDITOR.SELECTION_ELEMENT (3): A element selection.
																 * 
																 */
																 
																//var data = editor2.getData(); 
																 /*
																		if ( ranges.length == 1  )
																		{ 
																			//var textNode = new CKEDITOR.dom.text( "<div>xxxxxxx</div>", editor2.document );
																			var newElement	; 
																			
																			//var linkSelect = this.getContentElement( 'tab1', 'linkTypeSelect' );
																			 
																			//else{ 
																				newElement=CKEDITOR.dom.element.createFromHtml( text );
																				ranges[0].deleteContents();
																				ranges[0].insertNode(newElement);
																				ranges[0].selectNodeContents( newElement ); 
																			//} 
																			
																		}
																 */
																		uploadImg();
																}
															};
															//initUploadImg();
															return dialogDefinition;
																});
														//initUploadImg();
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
										 //alert("dialog Show")
										// initUploadImg();
									 });
							</script> 
							</td>
						</tr>
						
						<tr valign="top">
							<th height="25" align="left" colspan="2" valign="top">Attachments:</th>
						</tr>
						<tr valign="top">
							
							<td align="left" colspan="2">
							<label><span id="more_file_element">
							<input type="file" name="file0"/>&nbsp; &nbsp;<img	src="${url}images/plus.png" alt="Add more file" style="cursor: pointer;" onclick="manageMoreFile('0','add')" /><br/>
							 </span>
							</label>
							</td>
						</tr>
						<tr>
							<th height="25" align="left">&nbsp;</th>
							<td align="left"><span style="padding-top: 5px;">
							<c:if test="${mode=='add'}">
								<input type="submit"
									name="button_add" id="button_add" value="Save &amp; Publish"  onclick='return <portlet:namespace />doAction("doSave","add")' />
							 
							</c:if>
							<c:if test="${mode=='edit'}">
								<input type="submit"
								name="button_add" id="button_add" value="Save &amp; Publish" onclick='return <portlet:namespace />doAction("doSave","updateVersion")' />
							</c:if>  
							</span>
							 
							</td>
						</tr>

					</table>
					 
					<%--
					<script type="text/javascript">
						/* Optional: Temporarily hide the "tabber" class so it does not "flash"
						 on the page as plain HTML. After tabber runs, the class is changed
						 to "tabberlive" and it will appear. */

						document
								.write('<style type="text/css">.tabber{display:none;}<\/style>');
					</script>
					 --%>
					 <c:if test="${mode=='edit'}">
					<table width="100%" id="box-table-a" border="0" cellspacing="2"
						cellpadding="0" style="border: 1px solid #132C00">
						<tr>
							<th height="25" align="left" bgcolor="#3DB0B5"><span
								style="padding-left: 5px;">&nbsp;</span>
							</th>
						</tr>
						<tr>
							<td width="25%">
								<div class="tabber">


									<div class="tabbertab">
										<h2>Attachments</h2> 
										<c:if test="${!empty bpsAttachFiles}">
											<ul> 
												<c:forEach items="${bpsAttachFiles.resultListObj}" var="bpsAttachFile" varStatus="loop">   
												<c:set value="${bpsAttachFile.bpafFileSize/1024}" var="fileSize"></c:set>
                       		 					<jsp:useBean id="fileSize"  type="java.lang.Double" /> 
												<%float tmp = Math.round(fileSize.doubleValue()*10)/10; %>
													<span id="_element_img_${bpsAttachFile.bpafId}"><li><a id="_element_file_${bpsAttachFile.bpafId}" style="cursor: pointer;" onclick='<portlet:namespace />downloadFile("<c:out value="${bpsAttachFile.bpafHotLink}"/>")'>&nbsp;${bpsAttachFile.bpafFileName}</a> (<%=tmp %>&nbsp;KB) <img src="${url}images/delete_file.png" alt="delete file" style="cursor: pointer;" onclick="clearFile('${bpsAttachFile.bpafId}')" /></li></span>												 
												</c:forEach>
											</ul>
										</c:if>
										</div>



									<div class="tabbertab">
										<h2>version</h2>
										<table width="98%" align="center" border="0" cellspacing="2"
											cellpadding="0">
											<c:if test="${!empty bpsTermVersions}">
											<tr>
												<td width="20%" height="20" align="center"><strong>version</strong>
												</td>
												<td width="40%" align="center"><strong>date</strong>
												</td>
												<td width="40%">&nbsp;</td>
											</tr> 
												<c:forEach items="${bpsTermVersions.resultListObj}" var="bpsTermVersion" varStatus="loop">   
													<tr>
														<td height="20"><form:radiobutton path="version" value="${bpsTermVersion.bptVersionNumber}" onclick='setChoice("${bpsTermVersion.bptvId}")'/> &nbsp;&nbsp;version ${bpsTermVersion.bptVersionNumber}</td>
														<td><fmt:formatDate pattern="dd/MM/yyyy HH:mm:ss a" value="${bpsTermVersion.bptCreateDate}" /></td>
														<td>${bpsTermVersion.bptCreateBy} 
														<c:if test="${bpsTermVersion.bptVersionNumber==bpsAdminForm.bpsTerm.bptVersionNumber}">
														current
														</c:if>
														</td>
													</tr>												 
												</c:forEach>  
											<c:if test="${bpsTermVersions.maxRow!=0}">
											<tr>
												<td height="30"><span style="padding-top: 5px;">
												<input type="submit"
													name="button_add3" id="button_add3" value="Save Version" onclick='return <portlet:namespace />doAction("doSave","edit")' />
														 
												</span>
												</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
											</tr>
											</c:if>
											</c:if> 
										</table>

									</div>

								</div>

								<div style="padding-top: 5px;"></div></td>
						</tr>
					</table>
					</c:if>
				</td>
		</tr>
		<%--
		<tr>
			<td width="50%" height="30"><span
				style="color: #030; font-size: 12px;">< Back to Home</span>
			</td>
			<td width="50%">&nbsp;</td>
		</tr>
		 --%>
	</table>
</form:form>
</body>
</html>