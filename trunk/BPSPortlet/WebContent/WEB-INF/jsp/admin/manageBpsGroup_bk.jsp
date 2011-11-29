<%@include file="../include.jsp"%>
<%@page contentType="text/html; charset=utf-8"%>
<html>
<head>
<c:url var="url" value="/" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${url}css/jquery-ui/jquery-ui-1.8.custom.css" type="text/css">
<script src='${url}js/jquery-1.6.4.min.js' type="text/javascript"></script>
<script src="${url}js/redmond/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
	<script src=".${url}js/redmond/ui/jquery.ui.core.js"></script>
	<script src=".${url}js/redmond/ui/jquery.ui.widget.js"></script>
	<script src=".${url}js/redmond/ui/jquery.ui.position.js"></script>
	<script src=".${url}js/redmond/ui/jquery.ui.autocomplete.js"></script>
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
	#city { width: 25em; }
</style>
<script>
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
	    <portlet:namespace />listBpsGroup();
	    var availableTags = [
	             			"ActionScript",
	             			"AppleScript",
	             			"Asp",
	             			"BASIC",
	             			"C",
	             			"C++",
	             			"Clojure",
	             			"COBOL",
	             			"ColdFusion",
	             			"Erlang",
	             			"Fortran",
	             			"Groovy",
	             			"Haskell",
	             			"Java",
	             			"JavaScript",
	             			"Lisp",
	             			"Perl",
	             			"PHP",
	             			"Python",
	             			"Ruby",
	             			"Scala",
	             			"Scheme"
	             		];
	             		$( "#tags" ).autocomplete({
	             			source: availableTags
	             		}); 
	    $( "#city" ).autocomplete({
			source: function( request, response ) {
				$.ajax({
					//url: "http://ws.geonames.org/searchJSON",
					url: "${url}BpsAdminServlet",
					dataType: "json",
					data: {
						featureClass: "P",
						style: "full",
						maxRows: 12,
						name_startsWith: request.term
					},
					success: function( data ) {
					//	alert(data)
						response( $.map( data.bpsGroups, function( item ) {
							return {
								label: item.bpgGroupName,// + (item.adminName1 ? ", " + item.adminName1 : "") + ", " + item.countryName,
								value: item.bpgGroupName// + (item.adminName1 ? ", " + item.adminName1 : "") + ", " + item.countryName
								//label:"aa",// + (item.adminName1 ? ", " + item.adminName1 : "") + ", " + item.countryName,
								//value:"aa"// + (item.adminName1 ? ", " + item.adminName1 : "") + ", " + item.countryName
							}
						}));
					}
				});
			},
			minLength: 2,
			select: function( event, ui ) {
				alert( ui.item ?
						"Selected: " + ui.item.label :
						"Nothing selected, input was " + this.value); 
				//alert(ui.item.label) 
				$(this).attr("value",ui.item.label);
				alert($(this).attr("value"));
				<portlet:namespace />listBpsGroup();
				/*
				alert($(this ).val()) 
				alert( ui.item ?
					"Selected: " + ui.item.label :
					"Nothing selected, input was " + this.value); 
				//$(this).val(ui.item.label);
				$("#city").val(ui.item.label);
				*/
			}
			/*
			,
			open: function() {
				$( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
			},
			close: function() {
				$( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
			}
			*/
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
	function <portlet:namespace />doAction(_mode,_id){
		var dialog = $("#dialog_group");
		var str;
		if(_mode=='add'){	
			str="<table width=\"100%\"><tr><td>Category Name:</td><td><input type=\"text\"></td></tr></table>";			
			dialog.html(str);
			dialog.dialog({ 
					title:"Add Category",
					modal: true ,
					show: 'slide' ,
					//hide: "explode",
					buttons: [
					          {
					              text: "Ok",
					              click: function() { $(this).dialog("close"); }
					          },
					          {
					              text: "Cancel",
					              click: function() { $(this).dialog("close"); }
					          }
					      ]
					});
		}else if(_mode=='edit'){	
			str="<table width=\"100%\"><tr><td colspan=\"2\" align=\"center\"><img src=\"${url}images/ajax_loading.gif\"></td></tr></table>";			
			dialog.html(str);
			dialog.dialog({ 
				title:"Edit Category",
				modal: true ,
				show: 'slide' 
				//hide: "explode"				
				});
			BpsAdminAjax.getBpsGroup(_id,{
				callback:function(data){
					str="<table width=\"100%\"><tr><td>Category Name:</td><td><input type=\"text\" value=\""+data.bpgGroupName+"\"></td></tr></table>";
					dialog.dialog( "option", "buttons",  [
					              				          {
					            				              text: "Ok",
					            				              click: function() { 
					            				            	//  $(this).dialog( "option", "hide", null ); 
					            				            	//  $(this).dialog( "option", "buttons",null);
					            				            	  $(this).dialog("close");					            				            	  
					            				            	  }
					            				          },
					            				          {
					            				              text: "Cancel",
					            				              click: function() { $(this).dialog("close");dialog.html(""); }
					            				          }
					            				      ] );
					dialog.html(str);
				}
			});
		}else if(_mode=='delete'){	
			str="<table width=\"100%\"><tr><td colspan=\"2\" align=\"center\"><p>Would you like to delete ?</p></td></tr></table>";			
			dialog.html(str);
			dialog.dialog({ 
				title:"Delete Category",
				modal: true ,
				show: 'slide' ,
				//hide: "explode",
				buttons: [
   				          {
				              text: "Ok",
				              click: function() { 
				            	//  $(this).dialog( "option", "hide", null ); 
				            	//  $(this).dialog( "option", "buttons",null);
				            	  $(this).dialog("close");					            				            	  
				            	  }
				          },
				          {
				              text: "Cancel",
				              click: function() { $(this).dialog("close");dialog.html(""); }
				          }
				      ]
				}); 
		}
		
	}
	function <portlet:namespace />doSearch(){
		var str="<table width=\"100%\" id=\"box-table-a\" border=\"0\"  cellspacing=\"2\" cellpadding=\"0\">"+ 
				"	<tr>"+
				"		<td width=\"85%\" align=\"left\"><span>xxx</span></td>"+ 
				"		<td width=\"15%\" align=\"center\">"+ 
				"		<span style=\"cursor: pointer;\" >Edit</span> | <span style=\"cursor: pointer;\">Delete</span>"+
				"		</td>"+
				"	</tr>"+
				"</table>";
		$("#table_effect").html(str);
		$("#table_effect").slideDown('slow');
	}
	function <portlet:namespace />doSearch2(){
		$("#table_effect").slideUp('slow');
	}
	<%-- 
	function <portlet:namespace />doAction(_url,mode) {		
		if (mode == 'delete') {
			var agree = confirm("Would you like to delete ?");
			if (agree) {
				window.location.href = _url;
			} else {
			}
		} else {
			window.location.href = _url;
		}

	}
	--%> 
	function <portlet:namespace />doDelete(_url) {
			var agree = confirm("Would you like to delete ?");
			if (agree) {
				window.location.href = _url;
			} else {
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
	<p>This is the default dialog which is useful for displaying information. The dialog window can be moved, resized and closed with the 'x' icon.</p>
</div>

	<table width="950" align="center" border="0" cellspacing="0"
		cellpadding="0">
		<tr>
			<td><img src="${url}images/corporatew.gif" width="233" height="22">
			</td>
			<td align="right">&nbsp;</td>
		</tr>
		<tr>
			<td height="30" colspan="2"><span
				style="color: #030; font-size: 12px;"><strong>You
						are in:</strong> <a href="${fn:escapeXml(homeURL)}">Home</a> > Corporate Work Procedure > Manage a Category</span>
			</td>
		</tr>
		
		<tr>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2"><table width="100%" border="0" cellspacing="2"
					cellpadding="0">
					<tr>
						<td height="20" colspan="3"><strong>Manage a Category
								for Corporate Work Procedure</strong>
						</td>
					</tr>
					<tr valign="bottom">
						<td width="100%" align="left" colspan="3" height="20"><strong>Category :</strong>
							<label><form:input path="bpgGroupName" id="bpgGroupName"/></label>
							<input id="city" value="" />
							<input id="tags" value=""/>
							<input type="button" name="button_search" id="button_search" value="Search" onclick="<portlet:namespace />listBpsGroup()"/><img id="loading_ajax" src="${url}images/alw_loading.gif"/>
							<input type="button" name="button_search_ajax" id="button_search_ajax" value="Search ajax" onclick="<portlet:namespace />doSearch()"/>
							<input type="button" name="button_search_ajax2" id="button_search_ajax2" value="Search ajax 2" onclick="<portlet:namespace />doSearch2()"/>
						</td> 
					</tr>
					<tr>
						<td height="20">&nbsp;</td>
						<td align="right" height="20" colspan="2">
						<input type="button" value=" open dialog" onclick="<portlet:namespace />doAction('add','0')"/>
						<input type="button"
							name="button_add" id="button_add" value=" Add " onclick='<portlet:namespace />doAction("${urlAdd}","add")'/>  
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
						<th height="25" width="100%" align="center" bgcolor="#3DB0B5">Categories 2
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