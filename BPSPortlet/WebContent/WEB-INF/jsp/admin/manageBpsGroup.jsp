<%@include file="../include.jsp"%>
<%@page contentType="text/html; charset=utf-8"%>
<html>
<head>
<c:url var="url" value="/" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${url}css/jquery-ui/jquery-ui-1.8.custom.css" type="text/css">
<script src='${url}js/jquery-1.6.4.min.js' type="text/javascript"></script>
<script src="${url}js/redmond/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
	<script src="${url}js/redmond/ui/jquery.ui.core.js"></script>
	<script src="${url}js/redmond/ui/jquery.ui.widget.js"></script>
	<script src="${url}js/redmond/ui/jquery.ui.position.js"></script>
	<script src="${url}js/redmond/ui/jquery.ui.autocomplete.js"></script>
<%-- 
	<link rel="stylesheet" href="../demos.css">
--%>
<script type="text/javascript"
        src="${url}dwr/interface/BpsAdminAjax.js"></script> 
<script type="text/javascript"
        src="${url}dwr/engine.js"></script> 
<script type="text/javascript"
        src="${url}dwr/util.js"></script>
<link rel="stylesheet" type="text/css" href="${url}css/style_cos.css" />
<title>Insert title here</title>
<style>
	.ui-autocomplete-loading { background: white url('${url}images/ui-anim_basic_16x16.gif') right center no-repeat; }
	#bpgGroupName { width: 25em; }
</style>
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
<script>
var dialogGroup;
var dialog ;
	$(document).ready(function() {
	  // Handler for .ready() called.  
	    //$("input[type=button]").button();
	    $("input:button").button();
	    $("#loading_ajax").hide();
	    $("#bpgGroupName").keypress(function(event) {
	    	  if ( event.which == 13 ) {
	    	     event.preventDefault();
	    	     <portlet:namespace />listBpsGroup();
	    	   }
	    });
	   dialog = $("#dialog_group");
	    <portlet:namespace />listBpsGroup();
	    $("#bpgGroupName" ).autocomplete({
			source: function( request, response ) {
				$.ajax({
					url: "${url}BpsAdminServlet",
					dataType: "json",
					data: {
						featureClass: "P",
						style: "full",
						maxRows: 12,
						name_startsWith: request.term
					},
					success: function( data ) {
						response( $.map( data.bpsGroups, function( item ) {
							return {
								label: item.bpgGroupName,
								value: item.bpgGroupName
							}
						}));
					}
				});
			},
			minLength: 2,
			select: function( event, ui ) { 
				<portlet:namespace />listBpsGroup(); 
			}
			,
			open: function() {
				$( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
			},
			close: function() {
				$( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
			} 
		});
	});
	function <portlet:namespace />listBpsGroup(){
		$("#loading_ajax").show();
		$("#table_effect").slideUp('slow');
		var bpsGroup={bpgGroupName:$("#bpgGroupName").val()};
		BpsAdminAjax.listBpsGroup(bpsGroup,{
			callback:function(data){
			//	alert(data);
				$("#loading_ajax").hide();
				var str="<table width=\"100%\" id=\"box-table-a\" border=\"0\"  cellspacing=\"2\" cellpadding=\"0\">"; 
				if(data!=null && data[1]!='0'){					 
					for(var i=0;i<data[0].length;i++){
						str=str+"	<tr>"+
						"		<td width=\"85%\" align=\"left\"><span>"+data[0][i].bpgGroupName+"</span></td>"+ 
						"		<td width=\"15%\" align=\"center\">"+ 
						"		<span style=\"cursor: pointer;\" onclick='<portlet:namespace/>doAction(\"edit\",\""+data[0][i].bpgId+"\")'>Edit</span> | <span style=\"cursor: pointer;\" onclick='<portlet:namespace/>doAction(\"delete\",\""+data[0][i].bpgId+"\")'>Delete</span>"+
						"		</td>"+
						"	</tr>";
					}
					
				}else{
					str=str+"<tr>"+
					"		<td width=\"100%\" colspan=\"2\" align=\"center\"><span>Data not found</span></td>"+  
					"	</tr>";
				}
				str=str+"</table>";
				$("#table_effect").html(str);
				$("#table_effect").slideDown('slow');
				
			}
		});
	}
	function <portlet:namespace />saveOrUpdate(bpgGroupName,bpgId,_mode){
		$("#table_content").attr("style","display:none");		
		$("#dialog_img_loading").html("<img src=\"${url}images/ui-anim_basic_16x16.gif\"/>&nbsp "+((_mode=='edit')?"Editing...":"Adding..."));						
		$("#table_loading").attr("style","display:block");
		BpsAdminAjax.checkDuplicateGroup(jQuery.trim(bpgGroupName),{
			callback:function(data){
				var strError;
				$(this).dialog( "option", "hide", null ); 
				dialogGroup.dialog("close");
				dialogGroup.dialog( "destroy" );
				if(data!=0){ // have data 
					if(_mode == 'edit'){ 
						strError=" Can't Edit , Duplicate value ";	
					}
					else{ 
						strError=" Can't Add , Duplicate value "; 
					}
					$( "#dialog-message" ).html(strError);
					$( "#dialog-message" ).dialog({
						title:"Error Message",
						modal: true,
						show: 'clip' ,
						//hide: "explode",
						buttons: {
							Ok: function() {
								$( this ).dialog( "close" );
							}
						}
					}); 
				}else{
					var bpsGroup={bpgId:bpgId,bpgGroupName:jQuery.trim(bpgGroupName)};
					if(_mode == 'edit'){ 
						BpsAdminAjax.updateBpsGroup(bpsGroup,{
							callback:function(data){
									if(data!=null){
										<portlet:namespace />listBpsGroup();
										dialogGroup.dialog( "option", "hide", null ); 
										dialogGroup.dialog("close");
									}
								}
							});
					}else{
						BpsAdminAjax.saveBpsGroup(bpsGroup,{
							callback:function(data){
									if(data!=null){										
										dialogGroup.dialog( "option", "hide", null ); 
										dialogGroup.dialog("close");
										<portlet:namespace />listBpsGroup();
									}
								}
							});
					}			
				}
			}
		});
	}
	function <portlet:namespace />doAction(_mode,_id){
		 
		if(_mode=='add'){	 
	    $("#bpgGroupName_dialog").val("");
	    $("#table_loading").attr("style","display:none");
		$("#table_content").attr("style","display:block");
 		dialogGroup=dialog.dialog({ 
					title:"Add Category",
					modal: true ,
					show: 'slide' ,
					//hide: "explode",
					buttons: [
					          {
					              text: "Ok",
					              click: function() { 
					            	  <portlet:namespace />saveOrUpdate($("#bpgGroupName_dialog").val(),'0','add');
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
		}else if(_mode=='edit'){ 
			$("#dialog_img_loading").html("<img src=\"${url}images/ajax_loading.gif\"/>");
			$("#table_loading").attr("style","display:block");
			$("#table_content").attr("style","display:none");
			$("#table_message").attr("style","display:none");
	dialogGroup=dialog.dialog({ 
				title:"Edit Category",
				modal: true ,
				show: 'slide' 
			//	hide: "explode"				
				});
			BpsAdminAjax.getBpsGroup(_id,{
				callback:function(data){
					$("#table_loading").attr("style","display:none");
					$("#table_content").attr("style","display:block");					
					$("#bpgGroupName_dialog").val(data.bpgGroupName);
					$("#bpgId_dialog").val(data.bpgId);
					dialog.dialog( "option", "buttons",  [
					              				          {
					            				              text: "Ok",
					            				              click: function() { 				 
																	<portlet:namespace />saveOrUpdate($("#bpgGroupName_dialog").val(),$("#bpgId_dialog").val(),'edit');       	  
					            				            	  }
					            				          },
					            				          {
					            				              text: "Cancel",
					            				              click: function() { 
					            				            	  
					            				            	  $(this).dialog("close"); 
					            				            	  $(this).dialog( "destroy" );
					            				            	  }
					            				          }
					            				      ] );
				}
			});
		}else if(_mode=='delete'){	 
			$( "#dialog-message" ).html("Would you like to delete ?");
			$( "#dialog-message" ).dialog({
				title:"Delete Category",
				modal: true,
				show: 'slide' ,
				//hide: "explode",
				buttons: [
   				          {
				              text: "Ok",
				              click: function() {  
				            	  $(this).dialog("close");
				            	  $(this).dialog( "destroy" );
				            	  BpsAdminAjax.deleteBpsGroup(_id,{
				      				callback:function(data){ 
						            	<portlet:namespace />listBpsGroup();
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
		}
	}
</script>
</head>
<body>
<portlet:renderURL var="urlAdd">
    	<portlet:param name="action" value="addOrEditBpsGroup"/>
    		<portlet:param name="mode" value="add"/>
    		<portlet:param name="bpgId" value="0"/> 
</portlet:renderURL>
<portlet:renderURL var="formAction">
    <portlet:param name="action" value="manageBpsGroup"/>
</portlet:renderURL> 
<portlet:renderURL var="homeURL">
    <portlet:param name="action" value="list"/>
</portlet:renderURL>
<form:form  modelAttribute="bpsAdminForm" method="post"  action="${formAction}">
<form:hidden path="command" id="command"/>
<div id="dialog_group" title="Basic dialog" style="display: none;">
	<table id="table_loading" width="100%"><tr><td width="100%" colspan="2" align="center"><span id="dialog_img_loading"><img src="${url}images/ajax_loading.gif"/></span></td></tr></table>
	<table id="table_content" width="100%"><tr><td>Category Name:</td><td><input type="hidden" id="bpgId_dialog"/><input type="text" id="bpgGroupName_dialog"/></td></tr></table>
	<table id="table_message" width="100%"><tr><td  width="100%" colspan="2"><span id="dialog_error_msg"></span></td></tr></table>
</div>
<div id="dialog-message" title="Message">
	<p>
		 
	</p>
</div>
	<table width="950" align="center" border="0" cellspacing="0"	cellpadding="0">
		<tr>
			<td height="30" colspan="2"><span
				style="color: #030; font-size: 12px;"><strong>You
						are in:</strong> <a href="${fn:escapeXml(homeURL)}">Home</a> > Banpu Terms and Definitions > Manage Categories</span>
			</td>
		</tr>
		
		<tr>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2"><table width="100%" border="0" cellspacing="2"
					cellpadding="0">
					<tr>
						<td height="20" colspan="3"><strong>Manage Categories for Banpu Terms and Definitions </strong>
						</td>
					</tr>
					<tr valign="bottom">
						<td width="100%" align="left" colspan="3" height="20"><strong>Category :</strong>
							<label>
							<%--
							<form:input path="bpgGroupName" id="bpgGroupName"/>
							 --%>
							<input id="bpgGroupName"/>
							</label> 
							<input type="button" name="button_search" id="button_search" value="Search" onClick="<portlet:namespace />listBpsGroup()"/><img id="loading_ajax" src="${url}images/ui-anim_basic_16x16.gif"/>
						</td> 
					</tr>
					<tr>
						<td height="20">&nbsp;</td>
						<td align="right" height="20" colspan="2">						
						<input type="button"
							name="button_add" id="button_add" value=" Add " onClick="<portlet:namespace />doAction('add','0')"/>
						</td>
					</tr>
				</table>
			</td>
		</tr> 
		<tr>
			<td colspan="2" valign="top">
			<table width="100%" border="0" cellspacing="2" cellpadding="0"
					style="border: 1px solid #132C00;">
					<tr>
						<th height="25" width="100%" align="center" bgcolor="#132C00"><span style="color:#FFF;">Categories</span>
						</th>
					</tr>
					<tr>
						<td valign="top" width="100%">
						   <div id="table_effect" style="display: none;">
							<table width="100%" id="box-table-a" border="0"  cellspacing="2" cellpadding="0">  
								 <c:forEach items="${bpsGroups.resultListObj}" var="bpsGroup" varStatus="loop">  
								  	<tr>  
										<td width="85%" align="left"><span><c:out value="${bpsGroup.bpgGroupName}"/></span></td>
										 	<portlet:actionURL var="urlDelete">
                         						<portlet:param name="action" value="deleteBpsGroup"/>
                         						<portlet:param name="bpgId" value="${bpsGroup.bpgId}"/>                            
                      						</portlet:actionURL>
                      						<portlet:renderURL var="urlEdit">
                         						<portlet:param name="action" value="addOrEditBpsGroup"/>
                         						<portlet:param name="mode" value="edit"/>
                         						<portlet:param name="bpgId" value="${bpsGroup.bpgId}"/>                            
                      						</portlet:renderURL> 
										<td width="15%" align="center">
										<%-- 
										<span style="cursor: pointer;" onclick='<portlet:namespace />doAction("${urlEdit}","edit")'>Edit</span> | <span style="cursor: pointer;" onclick='<portlet:namespace />doAction("${urlDelete}","delete")'>Delete</span>
										 --%>
										 <span style="cursor: pointer;" onclick='<portlet:namespace/>doAction("edit","${bpsGroup.bpgId}")'>Edit</span> | <span style="cursor: pointer;" onclick='<portlet:namespace />doAction("${urlDelete}","delete")'>Delete</span>
										</td>
									</tr>	
								</c:forEach>				 
							</table>
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<%--
		<tr>
			<td colspan="2" valign="top"> 
				<table width="100%" border="0" cellspacing="2" cellpadding="0"
					style="border: 1px solid #132C00">
					<tr>
						<th height="25" align="center" bgcolor="#3DB0B5">Categories
						</th>
					</tr>
					<tr>
						<td valign="top">
							<table width="100%" id="box-table-a" border="0" cellspacing="2"
								cellpadding="0">  
								 <c:forEach items="${bpsGroups.resultListObj}" var="bpsGroup" varStatus="loop">  
								  	<tr>  
										<td width="85%" align="left"><span><c:out value="${bpsGroup.bpgGroupName}"/></span></td>
										 	<portlet:actionURL var="urlDelete">
                         						<portlet:param name="action" value="deleteBpsGroup"/>
                         						<portlet:param name="bpgId" value="${bpsGroup.bpgId}"/>                            
                      						</portlet:actionURL>
                      						<portlet:renderURL var="urlEdit">
                         						<portlet:param name="action" value="addOrEditBpsGroup"/>
                         						<portlet:param name="mode" value="edit"/>
                         						<portlet:param name="bpgId" value="${bpsGroup.bpgId}"/>                            
                      						</portlet:renderURL> 
										<td width="15%" align="center">
										 
										 <span style="cursor: pointer;" onclick='<portlet:namespace/>doAction("edit","${bpsGroup.bpgId}")'>Edit</span> | <span style="cursor: pointer;" onclick='<portlet:namespace />doAction("${urlDelete}","delete")'>Delete</span>
										</td>
									</tr>	
								</c:forEach>				 
							</table></td>
					</tr>
				</table></td>
		</tr>
		 --%>
		<tr> 
			<td width="50%"><div class="pagination">
			<%--
					<ul>
						<li><a href="#" class="prevnext disablelink">« previous</a>
						</li>
						<li><a href="#" class="currentpage">1</a>
						</li>
						<li><a href="#">2</a>
						</li>
						<li><a href="#">3</a>
						</li>
						<li><a href="#">4</a>
						</li>
						<li><a href="#">5</a>
						</li>
						<li><a href="#">6</a>
						</li>
						<li><a href="#">7</a>
						</li>
						<li><a href="#">8</a>
						</li>
						<li><a href="#">9</a>…</li>
						<li><a href="#">15</a>
						</li>
						<li><a href="#">16</a>
						</li>
						<li><a href="#" class="prevnext">next »</a>
						</li>
					</ul>
					 --%>
				</div></td>
		</tr>
	</table>
</form:form>
</body>
</html>