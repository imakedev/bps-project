<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.6.2.min.js"></script>  
<script type="text/javascript"
        src='<%=request.getContextPath() %>/dwr/interface/ExciseLawAjax.js'> 
</script>
<script type="text/javascript"
        src='<%=request.getContextPath() %>/dwr/interface/LinkExciseLawAjax.js'> 
</script>
<script type="text/javascript"
        src='<%=request.getContextPath() %>/dwr/engine.js'> 
</script>
<script type="text/javascript"
        src='<%=request.getContextPath() %>/dwr/util.js'>
</script>
<script language="JavaScript" type="text/JavaScript">
var _path='<%=request.getContextPath()%>';
var localIndex=0;
var localElementArray=[];  
$(document).ready(function() {
	  // Handler for .ready() called.
		callAjax();
	}); 
function deletLinkAndLoad(trId){
	//var tsRelMap={rmId:rmId};
	var tsRel={trId:trId};
	LinkExciseLawAjax.deleteTsRel(tsRel,{
		 callback:function(data_TsRel_FromServer){
			 var str="";
			  if(data_TsRel_FromServer!=null && data_TsRel_FromServer.length>0){
				   str="<table style=\"border:1px solid #ccc;\"><tr><td width=\"390\">Target</td></tr>";
				   for(var i=0;i<data_TsRel_FromServer.length;i++){
					   str=str+"<tr><td>"+(i+1)+". "+data_TsRel_FromServer[i].trTitle+"   <span onclick=\"deletLinkAndLoad('"+data_TsRel_FromServer[i].trId+"')\" style=\"cursor: pointer;color: red;\">x</span></td></tr>";											   
				   } 
				   str=str+"</table>"; 
				  
		 		}
			  $("#linkList").html(str);
	 		}
	});
}
function initLink(rmKey,rmTable){
	 // ST_MATR,ST_STATUTESUB
	if(rmTable=='ST_MATR'){
		initStMart(rmKey);
	}else if(rmTable=='ST_STATUTESUB'){
		initStStatute(rmKey);
	}
		
} 
function initStMart(rkmKey){
	 LinkExciseLawAjax.getStMatr(rkmKey,{
		 callback:function(data_StMatr_FromServer){
			 var statuteId=data_StMatr_FromServer.msStatute.statuteId;
			 $("select[name=linkMsStatueSubSelect]").val("1");
			 $("select[name=linkMsStatueSelect]").val(statuteId);
			 loadLink(rkmKey);	 
		 }
	 });
	
}
function initStStatute(rkmKey){
	 LinkExciseLawAjax.getStStatutesub(rkmKey,{
		 callback:function(data_StStatutesub_FromServer){
			 var statutesubId=data_StStatutesub_FromServer.msStatutesub.statutesubId;
			 var statuteId=data_StStatutesub_FromServer.msStatute.statuteId;
			 $("select[name=linkMsStatueSelect]").val(statuteId);
			 $("select[name=linkMsStatueSubSelect]").val(statutesubId);
			 loadLink(rkmKey);	 
		 }
	 });
	
}
function loadLink(rkmKey){ 
	//$("#linkTableSubElement").html("");
	var linkMsStatueSelectValue= $("select[name=linkMsStatueSelect]").val();
	var linkMsStatueSubSelectValue= $("select[name=linkMsStatueSubSelect]").val();
	//var idSplit=_value;//.split("|");
	//if(idSplit.length>1){
		if(linkMsStatueSubSelectValue=='0'){ 
			$("#linkTableElement").html(""); 
		}else if(linkMsStatueSubSelectValue=='1'){  
			var linkMsStatueSelectValue= $("select[name=linkMsStatueSelect]").val();
			var msStatute={statuteId:linkMsStatueSelectValue};
			 LinkExciseLawAjax.listStMatrByMsStatute(msStatute,{
				 callback:function(data_StMatrByMsStatute_FromServer){
						 var link_selectStr=""+
						"<select name=\"linkTableSelect\" style=\"border:1px solid #dcdcdc;background-color: #FFFFFF;\">"+
						"<option VALUE=\"0\">-- มาตรา --</option>";
						for(var i=0;i<data_StMatrByMsStatute_FromServer.length;i++){
							link_selectStr=link_selectStr+"<option value=\""+data_StMatrByMsStatute_FromServer[i].stMatrId+"\">"+data_StMatrByMsStatute_FromServer[i].matr+"</option>";
						}
						link_selectStr=link_selectStr+"</select>"; 
						$("#linkTableElement").html(link_selectStr);
						if(rkmKey!='0'){
							$("select[name=linkTableSelect]").val(rkmKey);
						}
				 }
			}); 
		}else { 
			var msStatutesub={statutesubId:linkMsStatueSubSelectValue};
			var msStatute={statuteId:linkMsStatueSelectValue};
			 LinkExciseLawAjax.listStStatutesub(msStatute,msStatutesub,{
				 callback:function(data_StStatutesubByMsStatutesub_FromServer){
						 var link_selectStr=""+
						"<select name=\"linkTableSelect\" style=\"border:1px solid #dcdcdc;background-color: #FFFFFF;\">"+
						"<option VALUE=\"0\">-- ข้อมูลกฏหมาย --</option>";
						for(var i=0;i<data_StStatutesubByMsStatutesub_FromServer.length;i++){
							link_selectStr=link_selectStr+"<option value=\""+data_StStatutesubByMsStatutesub_FromServer[i].stStatutesubId+"\">"+data_StStatutesubByMsStatutesub_FromServer[i].article+"</option>";
						}
						link_selectStr=link_selectStr+"</select>"; 
						$("#linkTableElement").html(link_selectStr);
					  if(rkmKey!='0'){
						$("select[name=linkTableSelect]").val(rkmKey);
						}
				 }
			});
		}
	/*  }else{
		$("#linkTableElement").html("");
		$("#linkTableSubElement").html("");
	} */
	
}
function callAjax(){
    LinkExciseLawAjax.listMsStatuteAndMsStatutesub({
		 callback:function(dataFromServer){
             if(dataFromServer!=null && dataFromServer.length>0){ 
				 var link_selectStr=""+
					"<select name=\"linkMsStatueSelect\" style=\"border:1px solid #dcdcdc;background-color: #FFFFFF;\"  onChange=\"loadLink('0')\" >"+
					"<option value=\"0\">-- เลือกพระราชบัญญัติ --</option>";
					for(var i=0;i<dataFromServer[0].length;i++){
						link_selectStr=link_selectStr+"<option value=\""+dataFromServer[0][i].statuteId+"\">"+dataFromServer[0][i].name+"</option>";
					}
					link_selectStr=link_selectStr+"</select><br/>";
					link_selectStr=link_selectStr+""+
					"<select name=\"linkMsStatueSubSelect\" style=\"border:1px solid #dcdcdc;background-color: #FFFFFF;\" onChange=\"loadLink('0')\">"+
					"<option value=\"0\">-- เลือกประเภทกฏหมาย --</option>";
					for(var i=0;i<dataFromServer[1].length;i++){
						link_selectStr=link_selectStr+"<option value=\""+dataFromServer[1][i].statutesubId+"\">"+dataFromServer[1][i].name+"</option>";
					}
					link_selectStr=link_selectStr+"</select>";
				 var editor = CKEDITOR.replace( 'detail', 
						 {
						extraPlugins : 'uicolor',
						toolbar :
						[ ['Source', '-','Cut','Copy','PasteText','PasteFromWord','Preview','-', 'Bold', 'Italic', 'Underline', 'Strike', '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','NumberedList', 'BulletedList','-','Indent','Outdent','-','Link','Unlink', '-','Anchor' ,'-', 'Excise Link'  ] ,'/', 
				 		['Styles','Format','Font','FontSize','-','TextColor','BGColor','Table']
						]
						,height: "90"});
						// Listen for the "pluginsLoaded" event, so we are sure that the
						// "dialog" plugin has been loaded and we are able to do our
						var getSelectedSpan = function( editor )
							{
								try
								{
									var selection = editor.getSelection();
									if ( selection.getType() == CKEDITOR.SELECTION_ELEMENT )
									{
										var selectedElement = selection.getSelectedElement();
										if ( selectedElement.is( 'span' ) )
											return selectedElement;
									}

									var range = selection.getRanges( true )[ 0 ];
									range.shrink( CKEDITOR.SHRINK_TEXT );
									var root = range.getCommonAncestor();
									return root.getAscendant( 'span', true );
								}
								catch( e ) { return null; }
							};	
				 editor.on( 'pluginsLoaded', function( ev )
							{ 
								// If our custom dialog has not been registered, do that now.
								if ( !CKEDITOR.dialog.exists( 'myDialog' ) )
								{
									 
									//CKEDITOR.dialog.add( 'myDialog', href );
									CKEDITOR.dialog.add( 'myDialog', function( api )
											{
												// CKEDITOR.dialog.definition
												var dialogDefinition =
												{
													title : 'ลิ้งค์ Dialog',
													minWidth : 390,
													minHeight : 130,
													contents : [
														{
															id : 'tab1',
															label : 'สร้างลิ้งค์',
															title : 'Title',
															expand : true,
															padding : 0,
															elements :
															[
																{
																	id:'linkType',
																	type : 'html',
																	html : link_selectStr
																},
																{
																	id:'linkTable',
																	type : 'html',
																	html : '<span id="linkTableElement"></span>'
																}
																,
																{
																	type : 'select',
																	id : 'linkTypeSelect',
																	label : 'เลือกการทำลิ้งค์',
																	items : [ [ 'Link' ], [ 'UnLink' ] ],
																	'default' : 'Link',
																	onChange : function( api ) {
																	// this = CKEDITOR.ui.dialog.select
																	//alert( 'Current value: ' + this.getValue() );
																	}
																}
															]
														},
														{
															id : 'tab2',
															label : 'ลิ้งค์ที่แม็ปไว้',
															title : 'Title',
															expand : true,
															padding : 0,
															elements :
															[
																{
																	id:'linkType2',
																	type : 'html',
																	html : '<span id="linkList">aaa</span>'
																} 
															]
														}
													],
													buttons : [ CKEDITOR.dialog.okButton, CKEDITOR.dialog.cancelButton ],
													onOk : function() { 
											            var editor1 = CKEDITOR.instances["detail"]; 
													var selection = editor1.getSelection();
													var text = selection.getNative();
													var ranges = selection.getRanges(); 
													var type = selection.getType(); 
													var isSave=true;
													var element_Id="";
													if(type==CKEDITOR.SELECTION_TEXT){  
														var xx=CKEDITOR.dom.selection(editor1.document); 
														var element = selection.getStartElement();  
														if(element.is('span')){ 
															element_Id=element.getId();
															isSave=false;
														}
													} 
													/*
													 * CKEDITOR.SELECTION_NONE (1): No selection. CKEDITOR.SELECTION_TEXT
													 * (2): Text is selected or collapsed selection.
													 * CKEDITOR.SELECTION_ELEMENT (3): A element selection.
													 * 
													 */
													 
													var data = editor1.getData(); 
															if ( ranges.length == 1  )
															{ 
																//var textNode = new CKEDITOR.dom.text( "<div>xxxxxxx</div>", editor1.document );
																var newElement	; 
																
																var linkSelect = this.getContentElement( 'tab1', 'linkTypeSelect' );
																if(linkSelect.getValue()=='Link'){
																	var id=$("select[name=linkMsStatueSubSelect]").val();
																	//var idSplit=$("select[name=linkSelect]").val().split("|");
																	var tableName="";
																	if(id=="1") {
																		tableName="ST_MATR";
																	}else {
																		tableName="ST_STATUTESUB";
																	}
																	//var relTableMap={rtmId:idSplit[0]};
																//    var relMap={rmKey:$("select[name=linkTableSelect]").val(),rmName:text+"",rmTable:tableName};
																    var isMakeLink=false;																    
																    var trKey; 
																    if ($("select[name=linkTableSelect]").length > 0){
																    	if($("select[name=linkTableSelect]").val()!='0')
																    		isMakeLink=true;
																    }
																   
																 if(isMakeLink){
																	 if(isSave){
																		 //alert("chatchai test")
																		// return ;
																		var relMap={rmName:text+""};
																    	var tsRel={tsRelMap:relMap,trTableName:tableName,trKey:$("select[name=linkTableSelect]").val()};
																		// alert("save="+tableName+",linkTableSelect="+$("select[name=linkTableSelect]").val()+",text="+text);
																		LinkExciseLawAjax.saveTsRel(tsRel,{
																			 callback:function(dataFrom_saveTsRel){
																				 if(dataFrom_saveTsRel!=null){
																	            	 newElement=CKEDITOR.dom.element.createFromHtml( '<span id=\"'+dataFrom_saveTsRel+'\" style="color:orange" class="exciseLawLink">'+text+'</span>' );
																	            	 ranges[0].deleteContents();
																					 ranges[0].insertNode(newElement);
																					 ranges[0].selectNodeContents( newElement ); 	
																	             }
																			 }
																		});
																		/*
																		LinkExciseLawAjax.saveRelMap(relMap,{
																			 callback:function(dataFrom_saveRelKeyMap){
																				 if(dataFrom_saveRelKeyMap!=null){
																	            	 newElement=CKEDITOR.dom.element.createFromHtml( '<span id=\"'+dataFrom_saveRelKeyMap+'\" style="color:orange" class="exciseLawLink">'+text+'</span>' );
																	            	 ranges[0].deleteContents();
																					 ranges[0].insertNode(newElement);
																					 ranges[0].selectNodeContents( newElement ); 	
																	             }
																			 }
																		});
																		*/
																	 }else{ // update
																		// alert("update id="+element_Id) 
																	   //  var relMapUpdate={rmId:element_Id,rmKey:$("select[name=linkTableSelect]").val(),rmName:text+"",rmTable:tableName};
																		 var relMapUpdate={rmId:element_Id,rmName:text+""};
																		 var tsRelUpdate={tsRelMap:relMapUpdate,trTableName:tableName,trKey:$("select[name=linkTableSelect]").val()};
																	     LinkExciseLawAjax.saveTsRel(tsRelUpdate,{
																			 callback:function(dataFrom_saveTsRel){
																				 if(dataFrom_saveTsRel!=null){
																					 newElement=CKEDITOR.dom.element.createFromHtml( '<span id=\"'+element_Id+'\" style="color:orange" class="exciseLawLink">'+text+'</span>' );
																	            	 ranges[0].deleteContents();
																					 ranges[0].insertNode(newElement);
																					 ranges[0].selectNodeContents( newElement ); 	
																	             }
																			 }
																		});	
																	 /*
																	  LinkExciseLawAjax.updateRelMap(relMapUpdate,{
																			 callback:function(dataFrom_updateRelKeyMap){
																				 if(dataFrom_updateRelKeyMap!=null){
																	            	 newElement=CKEDITOR.dom.element.createFromHtml( '<span id=\"'+element_Id+'\" style="color:orange" class="exciseLawLink">'+text+'</span>' );
																	            	 ranges[0].deleteContents();
																					 ranges[0].insertNode(newElement);
																					 ranges[0].selectNodeContents( newElement );  
																	             }
																			 }
																		});
																		*/
																	 }
																  }
																}
																else{
																	 var relKeyMap={rmId:element_Id};
																	LinkExciseLawAjax.deleteRelMap(relKeyMap);
																	newElement=CKEDITOR.dom.element.createFromHtml( text );
																	ranges[0].deleteContents();
																	ranges[0].insertNode(newElement);
																	ranges[0].selectNodeContents( newElement ); 
																} 
																
															}
													}
												};

												return dialogDefinition;
											} );
								}

								// Register the command used to open the dialog.
								editor.addCommand( 'myDialogCmd',new CKEDITOR.dialogCommand( 'myDialog' ) ); 
								editor.ui.addButton( 'Excise Link',
									{
										label : 'สร้างลิ้งค์',//'My Dialog',
										command : 'myDialogCmd'
									} ); 
							}); 
			     editor.on( 'dialogShow', function( evt ){			    	
   		    	     var selectionShow = editor.getSelection();
					 var element = selectionShow.getStartElement();  
						if(!element.is('span')){  
							$("select[name=linkMsStatueSelect]").val("0");
							$("select[name=linkMsStatueSubSelect]").val("0");
							loadLink("0");
						}else{
							var id = element.getId();
							if(id.indexOf("local_")!=-1){
								
							}else{
								$("select[name=linkMsStatueSelect]").val("0");
								$("select[name=linkMsStatueSubSelect]").val("0");
								loadLink("0");
								// load list
								
								LinkExciseLawAjax.listTsRel(id,{
									 callback:function(data_tRelMap_FromServer){
									// alert("data_tRelMap_FromServer="+data_tRelMap_FromServer.length);
									   if(data_tRelMap_FromServer!=null && data_tRelMap_FromServer.length>0){
										   var str="<table style=\"border:1px solid #ccc;\"><tr><td width=\"390\">Target</td></tr>";
										   for(var i=0;i<data_tRelMap_FromServer.length;i++){
											   str=str+"<tr><td>"+(i+1)+". "+data_tRelMap_FromServer[i].trTitle+"   <span onclick=\"deletLinkAndLoad('"+data_tRelMap_FromServer[i].trId+"')\" style=\"cursor: pointer;color: red;\">x</span></td></tr>";											   
										   } 
										   str=str+"</table>";
										//   alert(str);
									$("#linkList").html(str);
							            	// var rmId= data_tRelMap_FromServer.relTableMap.rmId;
							            	// var rmTable =  data_tRelMap_FromServer.rmTable; // ST_MATR,ST_STATUTESUB
							            	 //var rmKey=data_tRelMap_FromServer.rmKey;
							            	// initLink(rmKey,rmTable);
							            	// var linkSelectId=rtmId+((rtmId!=1)?"|"+rtmTableName:"");
							            	// $("select[name=linkSelect]").val(linkSelectId);
							            	// loadLink(linkSelectId,rkmKey+""); 
							             }
								}
							  });
								/*  
								LinkExciseLawAjax.getRelMapById(id,{
										 callback:function(data_tRelMap_FromServer){
										//  alert("data_tRelMap_FromServer="+data_tRelKeyMap_FromServer);
										   if(data_tRelMap_FromServer!=null){
								            	// var rmId= data_tRelMap_FromServer.relTableMap.rmId;
								            	 var rmTable =  data_tRelMap_FromServer.rmTable; // ST_MATR,ST_STATUTESUB
								            	 var rmKey=data_tRelMap_FromServer.rmKey;
								            	 initLink(rmKey,rmTable);
								            	// var linkSelectId=rtmId+((rtmId!=1)?"|"+rtmTableName:"");
								            	// $("select[name=linkSelect]").val(linkSelectId);
								            	// loadLink(linkSelectId,rkmKey+""); 
								             }
									}
								  });
								*/
							}
						}
			     });
				 editor.on( 'doubleclick', function( evt )
							{
								//alert("aoe doubleclick")
								var element =getSelectedSpan( editor ) || evt.data.element; 
								if ( !element.isReadOnly() )
									{
										if ( element.is( 'span' ) ){  
											var id = element.getId(); 
												evt.data.dialog = 'myDialog';	 
										}			 
									}
				    		}); 
             }
		 }
	});  
}
function PopupIMAGE(ano,bno){
	window.open('Scan_Show_Image_Detail.jsp?sys=c1&pathno=2&txtCurr=1&acode='+ano+'&bcode='+bno,'','width=900,height=600,toolbar=no,resizable=no,center=yes,menubar=no,location=no,status=no,scrollbars=yes,titlebar=no');
	//window.open('imgxpressviewimage.jsp?sys=c1&pathno=2&txtCurr=1&acode='+ano+'&bcode='+bno,'','width=900,height=600,toolbar=no,resizable=no,center=yes,menubar=no,location=no,status=no,scrollbars=yes,titlebar=no');
}

function scan(){
	var itemno = document.form1.LEGAL_ID.value;
	var ilegaltype = document.form1.LEGAL_TYPE_ID.value;
	window.open("dynamicscan.jsp?pathno=4&type=l1&no="+itemno+"&legaltype="+ilegaltype);	
}

function inserter(){
	document.form1.action = "insert.jsp?TYPE=LAW";
	document.form1.submit();
}

function deleter(){
	document.form1.action = "delete.jsp?TYPE=LAW";
	document.form1.submit();
}

function F_Search(){
	document.form1.action  = "Lawlist.jsp";
	document.form1.submit();
}

function F_A(){
	window.location="input.jsp","wa";	
}
	
function Attach(FuncType) {  
	var LEGAL_ID = "";
	if(FuncType=='SaveData') {
		if(document.form1.LEGAL_TYPE_ID.value == "NONE"){
			alert("กรุณาเลือกประเภทกฏหมาย");
			document.form1.LEGAL_TYPE_ID.focus();
		}else{
			if(document.form1.LEGAL_ID.value != ""){
				LEGAL_ID = document.form1.LEGAL_ID.value;
			}else{
				LEGAL_ID = document.form1.Mirror_ID.value;
			}
			window.open("Browse_Upload.jsp?LEGAL_ID="+LEGAL_ID+"&LEGAL_TYPE_ID="+document.form1.LEGAL_TYPE_ID.value+"&TYPE=LAW","upload","width=800,height=700,toolbar=no,resizable=no,menubar=no,location=no,status=no");
			alert(LEGAL_ID, LEGAL_TYPE_ID, TYPE);
			return true;
		}
	}
}
   
function TYPESELECT(value){ 
	var type = value.split("/");
	var selectedIndex=document.getElementById("STATUTESUB_ID").selectedIndex;
	if(document.getElementById("STATUTESUB_ID").value !="NONE"){
	var testS=document.getElementById("STATUTESUB_ID").options[selectedIndex].text;
	document.getElementById("textWord").innerHTML=testS;
	}else{
	document.getElementById("textWord").innerHTML="";
	}
}
function setTsStatuteLegalitem(obj){
	var stStatutesubId = document.getElementById('stStatutesub.stStatutesubId'); 
	var action = obj.checked?"check":"uncheck";
	if(stStatutesubId.value!=''){
		ExciseLawAjax.setTsStatutesubLegalitem(obj.value,stStatutesubId.value,action,{
			 callback:function(dataFromServer){
	             if(dataFromServer!=null && dataFromServer.length>0){
	             }
			 }
		});
	} 
}
function setTsRelStatute(obj){
	//var action = document.getElementById('action');
	var stStatutesubId = document.getElementById('stStatutesub.stStatutesubId'); 
	var action = obj.checked?"check":"uncheck"; 
	if(stStatutesubId.value!=''){
		ExciseLawAjax.setTsRelStatute(obj.value,stStatutesubId.value,action,{
			 callback:function(dataFromServer){
	             if(dataFromServer!=null && dataFromServer.length>0){
					 //alert(dataFromServer)
					 //document.getElementById('myDiv').innerHTML=dataFromServer;
	             }
			 }
		});
	} 
}
function clearCheckBox(_name){
	var checkboxes = document.getElementsByName(_name);
	for(var i=0;i<checkboxes.length;i++)
		checkboxes[i].checked=false;
}
function clearRadio(_name){
	var radio = document.getElementsByName(_name);
	for(var i=0;i<radio.length;i++){
		if(radio[i].value=='0'){
			radio[i].checked="checked";
			break;
		}
	}
		
}
function checkall(){
	checkallByElementName(document.getElementsByName('productBoxes'));
	checkallByElementName(document.getElementsByName('serviceBoxes')); 
}
function checkallByElementName(el_collection){
	var selectallValue= document.getElementById("selectall");
	var stStatutesubId = document.getElementById('stStatutesub.stStatutesubId'); 
	var isUpdate = stStatutesubId.value!=''?true:false;
	//if(selectallValue.checked){
		for (var i=0;i<el_collection.length;i++){
			if(isUpdate){
	 			if(el_collection[i].checked !=selectallValue.checked){
	 				//alert("before="+el_collection[i].checked)
	 				el_collection[i].checked=selectallValue.checked;
	 				//alert("affter="+el_collection[i].checked)
	 				setTsStatuteLegalitem(el_collection[i]);
	 				//el_collection[i].checked=selectallValue.checked;
	 			}
	 		}
	 		el_collection[i].checked=selectallValue.checked;
	 		
		}
}  
function callfunc(functype)
{	 
	//document.getElementById("FUNC").value = functype;
	 
	var msg = "";
	if(functype!="doDelete"){
		/*
		if(document.getElementById("statuteId").value == "0")
		{
			msg += "- กรุณาเลือกพระราชบัญญัติ\n";
		}
		if(document.getElementById("submatrId").value == "0")
		{
			msg += "- กรุณาเลือกหมดย่อย\n";
		}
		if(document.getElementById("MATRGROUP_NAME").value  == "" || document.getElementById("MATRGROUP_NAME").value  == " ")
		{
			msg += "- กรุณากรอกหมวด\n";
		}
		*/
		
	}
	if(msg != "")
	{
		alert(msg); 
		return false;
	} 
	document.getElementById("action").value = functype;
	return true;
 
}
</script>

<script language="javascript">
function beginchk(ip,ek) {//เริ่มต้นการรับพารามิเตอร์จากคีย์บอร์ด
	 
	if((ek.keyCode>47&&ek.keyCode<58)||ek.keyCode==8||ek.keyCode==46||ek.keyCode==144||ek.keyCode==111||(ek.keyCode>95&&ek.keyCode<106)||(ek.keyCode>36&&ek.keyCode<41)){//อนุญาตให้พิมพ์ตัวเลข Delete Backspace Left Right Up Down
	
	if(ip.value.match("^([0-9]{2})/([0-9]{2})//$")){
		ip.value=ip.value.substring(0,6);
		return true;
	}else if(ip.value.match("^([0-9]{2})/([0-9]{2})$")&&ek.keyCode!=8){//ตรวจสอบพารามิเตอร์โดยเลือกใช้ Regular Expression
		ip.value=ip.value + "/";
		return true;
	}else if(ip.value.match("^([0-9]{2})//$")&&ek.keyCode!=8){
		ip.value=ip.value.substring(0,3);
		return true;
	}else if(ip.value.match("^([0-9]{2})$")&&ek.keyCode!=8){//ตรวจสอบพารามิเตอร์โดยเลือกใช้ Regular Expression
		ip.value=ip.value + "/";
		return true;
	}else if(ip.value.match("^([0-9]{2})/([0-9]{2})/([0-9]{4})$")){//ตรวจสอบพารามิเตอร์โดยเลือกใช้ Regular Expression
		isDate(ip.value);//ส่งพารามิเตอร์ไปตรวจสอบที่ฟังก์ชั่น isDate ว่ากรอกวันเดือนปีถูกต้องหรือไม่
		return true;
	}else if(ip.value.length>10){//เงื่อนไขนี้ตรวจสอบว่าห้ามกรอกข้อมูลเกินสิบหลักถ้าเกินให้ตัดตัวสุดท้ายทิ้ง
		ip.value=ip.value.substring(0,10);
		isDate(ip.value);
		return true;
	}
	
	}else{//แจ้งเตือนถ้าคีย์ข้อความที่ไม่ใช่ตัวเลข
		ip.value="" ;
		return true;
	}
	}
	
	//เริ่มต้นเช็คค่าวันที่ที่กรอกลงมา
	//Date Validation just copy and paste this cod
	
	var dtCh= "/";
	var minYear=1900;
	var maxYear=2100;
	var minYearA=1900+543;//ค่าตัวแปรที่สองเอาไว้โชว์ค่าพุทธศักราชไทยอะครับ ^^
	var maxYearA=2100+543;//ค่าตัวแปรที่สองเอาไว้โชว์ค่าพุทธศักราชไทยอะครับ ^^
	
	function isInteger(s)//ฟังก์ชั่นเช็คค่าตัวเลข
	{
	var i;
	for (i = 0; i < s.length; i++)
	{ 
	// Check that current character is number.
	var c = s.charAt(i);
	if (((c < "0") || (c > "9")))  return false;
	  }
	// All characters are numbers.
	return true;
	}
	
	function stripCharsInBag(s, bag)//เช็ครูปแบบ
	{
	var i;
	var returnString = "";
	// Search through string's characters one by one.
	// If character is not in bag, append to returnString.
	for (i = 0; i < s.length; i++)
	{ 
	var c = s.charAt(i);
	if (bag.indexOf(c) == -1) returnString += c;
	}
	return returnString;
	}
	
	function daysInFebruary (year)//เช็คค่าวันที่ 29 กุมภาพันธ์ ในแต่ละปี
	{
	// February has 29 days in any year evenly divisible by four,
	// EXCEPT for centurial years which are not also divisible by 400.
	return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
	}
	function DaysArray(n) //เช็ควันสุดท้ายของแต่ละเดือน
	{
	for (var i = 1; i <= n; i++) 
	{
	this[i] = 31;
	if (i==4 || i==6 || i==9 || i==11) {this[i] = 30;}
	if (i==2) {this[i] = 29;}
	} 
	return this;
	}
	
	function isDate(dtStr)//ฟังก์ชั่นหลักในการเช็คค่าวันที่ ถ้ากรอกวันเดือนปีผิดจะแจ้งเตือนผู้ใช้งาน
	{
	var daysInMonth = DaysArray(12);
	var pos1=dtStr.indexOf(dtCh);
	var pos2=dtStr.indexOf(dtCh,pos1+1);
	var strDay=dtStr.substring(0,pos1);
	var strMonth=dtStr.substring(pos1+1,pos2);
	var strYear=dtStr.substring(pos2+1);
	strYr=strYear;
	
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1);//ตัดเลข0
	
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1);//ตัดเลข0
	
	for (var i = 1; i <= 3; i++) {
	
	if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1);//ตัดเลข0
	}
	day=parseInt(strDay);
	month=parseInt(strMonth);
	year=parseInt(strYr);
	year=year-543;
	
	if (pos1==-1 || pos2==-1)
	{
	
	//alert("รูปแบบวันที่ผิด : วัน/เดือน/ปี");
	ip.value="" ;
	return false;
	}
	
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month])
	{
		
	//alert("กรุณาใส่วันที่ให้ถูกต้อง");
	ip.value="" ;
	return false;
	}
	
	if (strMonth.length<1 || month<1 || month>12)
	{
		
	//alert("กรุณาใส่เดือนให้ถูกต้อง");
	ip.value="" ;
	return false;
	}
	
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear)
	{
		ip.value="" ;
	//alert("กรุณาใส่ปีให้ถูกต้อง"+minYearA+" and "+maxYearA);
	ip.value="" ;
	return false;
	}
	
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false)
	{
		ip.value="" ;
	//alert("กรุณาใส่รุปแบบวันที่ให้ถูกต้อง");
	ip.value="" ;
	return false;
	}
	return true;
	}
</script>
<link href="<%=request.getContextPath() %>/css/sura.css" rel="stylesheet" type="text/css">
<title>ข้อมูลกฎหมายสรรพสามิต</title>
<script type="text/javascript" src="<%=request.getContextPath() %>/Calendar/calendarTLE.js"></script> 
<script	type="text/javascript" src="<%=request.getContextPath() %>/Calendar/calendar-setup.js"></script> 
<script	type="text/javascript" src="<%=request.getContextPath() %>/Calendar/lang/calendar-th.js"></script> 
<script	type="text/javascript" src="<%=request.getContextPath() %>/TabContent/tabcontent.js"></script>
<style type="text/css">
		
		@import url("<%=request.getContextPath() %>/Calendar/calendar-win2k-cold-1.css");
		
		</style>
		
<style type="text/css"> 
#example {
    height:30em;
}
 
label { 
    display:block;
    float:left;
    width:45%;
    clear:left;
}
 
.clear {
    clear:both;
}
 
#resp {
    margin:10px;
    padding:5px;
    border:1px solid #ccc;
    background:#fff;
}
 
#resp li {
    font-family:monospace
}
 
.yui-pe .yui-pe-content {
    display:none;
}
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
		<link href="<%=request.getContextPath() %>/style.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath() %>/css/sura.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath() %>/ckeditor/ckeditor.js"></script>
<script src="<%=request.getContextPath() %>/ckeditor/sample.js" type="text/javascript"></script>

<link href="<%=request.getContextPath() %>/ckeditor/sample.css" rel="stylesheet" type="text/css" />

<!-- Sam Skin CSS for TabView -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/js/yui/build/tabview/assets/skins/sam/tabview.css">
 
<!-- JavaScript Dependencies for Tabview: -->
<script src="<%=request.getContextPath() %>/js/yui/build/yahoo-dom-event/yahoo-dom-event.js"></script>
<script src="<%=request.getContextPath() %>/js/yui/build/element/element-min.js"></script>
 
<!-- OPTIONAL: Connection (required for dynamic loading of data) -->
<script src="<%=request.getContextPath() %>/js/yui/build/connection/connection-min.js"></script>
 
<!-- Source file for TabView -->
<script src="<%=request.getContextPath() %>/js/yui/build/tabview/tabview-min.js"></script>

 <!-- Link กฏหมาย -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/js/yui/build/fonts/fonts-min.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/js/yui/build/button/assets/skins/sam/button.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/js/yui/build/container/assets/skins/sam/container.css" />   
<script type="text/javascript" src="<%=request.getContextPath() %>/js/yui/build/button/button-min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/yui/build/dragdrop/dragdrop-min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/yui/build/container/container-min.js"></script>

 <!-- End Link กฏหมาย -->
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" class="yui-skin-sam" style="height: 663px;" >
<script type="text/javascript"> 

var myTabs = new YAHOO.widget.TabView("demo");
/*
myTabs.addTab( new YAHOO.widget.Tab({
    label: 'Tab One Label',
    content: '<p>Tab One Content</p>',
    active: true
}));
 
myTabs.addTab( new YAHOO.widget.Tab({
    label: 'Tab Two Label',
    content: '<p>Tab Two Content</p>'
}));
 
myTabs.addTab( new YAHOO.widget.Tab({
    label: 'Tab Three Label',
    content: '<p>Tab Three Content</p>'
}));
 
myTabs.appendTo(document.body);
*/
</script> 

<!--begin custom header content for this example-->
<script type="text/javascript"> 
document.documentElement.className = "yui-pe";
</script>
 
 
<!--end custom header content for this example-->
  
<spring:url value="/statutesub/input.do" var="formAction">
</spring:url>
<form:form modelAttribute="stStatutesubForm"  id="form1" method="post" action="${fn:escapeXml(formAction)}" >
<form:hidden path="action" id="action"/>
<form:hidden path="stStatutesub.stStatutesubId" /> 
<input type="hidden" name="ST_STATUTESUB_ID" id="ST_STATUTESUB_ID" value="">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="30" class="head2">ข้อมูลกฎหมาย >> 
		<font color="#FF6600">กฎหมายสรรพสามิต</font> >>
		<font color="#000000">รายละเอียดข้อมูล </font></td>
		<td align="right">
			<input type="hidden" name="FUNC" value="" /> 
			<c:if test="${stStatutesubForm.action=='edit' || stStatutesubForm.action=='doEdit'}">
				<INPUT TYPE="submit" value="บันทึกข้อมูล" style="width: 80px" onClick="return callfunc('doEdit')" >		
				<INPUT	TYPE="submit" value="ลบข้อมูล" style="width: 80px" onClick="return callfunc('doDelete')" />
			</c:if>
			<c:if test="${stStatutesubForm.action!='edit' && stStatutesubForm.action!='doEdit'}">
				<INPUT  TYPE="submit" value="บันทึกข้อมูล" style="width: 80px" onClick="return callfunc('doSave')" >						
				<INPUT	TYPE="submit" value="ลบข้อมูล" style="width: 80px" onClick="return callfunc('doDelete')" 
				<c:if test="${stStatutesubForm.stStatutesub.stStatutesubId==null}">
				  disabled="disabled"
				</c:if>
				/>
			</c:if>
			<%--
			<INPUT TYPE="button" value="บันทึกข้อมูล" style="width: 80px" onClick="inserter();" /> 
			<INPUT TYPE="button" value="ลบข้อมูล" style="width: 80px" onClick="deleter();" />
			 --%>
			<input type="button" name="cmdSearch" style="width: 80px" class="button" value="ค้นหาข้อมูล"  onClick="javascript:window.location='<spring:url value="/statutesub/input.do?action=search" htmlEscape="true" />'" >
			<%--
			<input type="button" class="button" value="เคลียร์" style="width: 80px" onClick="F_A();" />
			 --%>
			</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="1">
	<tr>
		<td align='right' valign="middle" class="text">ประเภทพระราชบัญญัติ&nbsp;</td>
		<td height="25" align="left" class="text">
		 <form:select path="stStatutesub.msStatute.statuteId" id="statuteId" cssClass="dropdown"  cssStyle="width: 300px"> 
							     				  <form:option value="0" label="- - - Please Select - - -"/> 
    											  <form:options items="${msStatutes}" itemValue="statuteId" itemLabel="name"/>    												
    							 </form:select>	  <%--
			sql = "SELECT  STATUTE_ID as aFieldCode ,NAME as aFieldDesc";
			sql = sql + " FROM MS_STATUTE ORDER BY STATUTE_ORDER";
			out.println(myObjControl.gIntitialCombo("", "", "", "", "", sql,
					"MAIN_STATUTE_ID", 0, " ", MAIN_STATUTE_ID));
		--%></td>
	</tr>
	<tr>
		<td align='right' valign="middle" class="text">ประเภทกฎหมาย&nbsp;</td>
	  <td height="25" align="left" class="text">
	   <form:select path="stStatutesub.msStatutesub.statutesubId" id="statutesubId" cssClass="dropdown"  cssStyle="width: 300px"> 
							     				  <form:option value="0" label="- - - Please Select - - -"/> 
    											  <form:options items="${msStatutesubs}" itemValue="statutesubId" itemLabel="name"/>    												
    							 </form:select>
	  
	  <%--
			sql = "SELECT  STATUTESUB_ID as aFieldCode,NAME as aFieldDesc";
			sql = sql + " FROM MS_STATUTESUB ORDER BY STATUTESUB_ORDER";
			out.println(myObjControl.gIntitialCombo("", "", "", "", "", sql,
					"STATUTESUB_ID", 0, "TYPESELECT", STATUTESUB_ID));
		--%></td>
	</tr>
	<tr>
		<td width="20%" valign="middle" class="text">
		<div align="right">ลำดับที่&nbsp;</div>	  </td>
		<td width="80%" height="25" align="left" valign="top" class="text">
		<form:input path="stStatutesub.stOrder" cssClass="field-color" size="5"/>
		<%--
		<input name="ST_ORDER"	type="text" class="field-color" id="ST_ORDER" value="" size="5"  />
		 --%>
		</td>
	</tr>
	<tr>
		<td width="20%" valign="middle" class="text">
		<div align="right">สถานะการบังคับใช้&nbsp;</div>	  </td>
		<td width="80%" height="25" align="left" valign="top" class="text">
	  <%--
			String sChk_1 = "";
			String sChk_2 = "";
			if (STATUS.trim().equals("1")) {
				sChk_1 = "checked";
				sChk_2 = "";
			} else {
				sChk_1 = "";
				sChk_2 = "checked";
			}
		--%>	 
		<%--
		 <form:select path="stStatutesub.msStatute.statuteId" id="statuteId" cssClass="dropdown"  cssStyle="width: 300px"> 
							     				  <form:option value="0" label="- - - Please Select - - -"/> 
    											  <form:options items="${msStatutes}" itemValue="statuteId" itemLabel="name"/>    												
    							 </form:select>
    							  --%> 
    	  <c:if test="${stStatutesubForm.stStatutesub.status=='1'}"> 
    	  </c:if>
    	  <%--
    		<form:radiobuttons path="stStatutesub.status" items="${statusList}" itemValue="id" itemLabel="name"/>					
		    <form:radiobuttons path="stStatutesub.status" items="${statusList}" itemValue="id" itemLabel="name"/>
		    --%>
		    <%--
		    &nbsp;มีผลบังคับใช้&nbsp;
		    <form:radiobuttons path="stStatutesub.status" items="${sexOptions}"  itemValue="statutesubId" itemLabel="name"/>
		     --%>
		    <%--
		    
		    <input name="STATUS" type="radio" value="1"
			<%=sChk_1%> />	 
			 --%> 
			 <form:radiobutton path="stStatutesub.status"   value="1"/> &nbsp;มีผลบังคับใช้&nbsp;
			 <form:radiobutton path="stStatutesub.status"  value="0"/>&nbsp;ไม่มีผลบังคับใช้ &nbsp;
			   </td>
	</tr>
	<tr>
		<td width="20%" valign="middle" class="text">
		<div align="right">สถานะการแสดงผล</div>	  </td>
		<td width="80%" height="25" align="left" valign="top" class="text">
	  <%--
			sChk_1 = "";
			sChk_2 = "";
			if (DISPLAY.trim().equals("1")) {
				sChk_1 = "checked";
				sChk_2 = "";
			} else {
				sChk_1 = "";
				sChk_2 = "checked";
			}
		--%> 
		 <%--
		<form:radiobuttons path="stStatutesub.display" items="${displayList}" itemValue="id" itemLabel="name"/>
		
		  <form:radiobutton path="stStatutesub.display"  value="1"/>&nbsp;แสดงผล&nbsp;
		   --%>
		  <%--
		<input name="DISPLAY" type="radio" value="1"
			<%--sChk_1-%> />
			 --%>
			 <%--
		  <form:radiobutton path="stStatutesub.display"  value="0"/>&nbsp;ไม่แสดงผล&nbsp;
		   --%>
		    <form:radiobutton path="stStatutesub.display"  value="1"/>&nbsp;แสดงผล&nbsp;
		    <form:radiobutton path="stStatutesub.display"  value="0"/>&nbsp;ไม่แสดงผล&nbsp;
		 
<div>
<%--
<button id="show22">Show dialog1</button> 
<button id="hide">Hide dialog1</button>
 --%>
</div></td>
	</tr>
	<tr>
		<td valign="middle" class="text">
	  <div align="right">วันที่ประกาศในราชกิจจานุเบกษา&nbsp;</div>	  </td>
		<td height="30" align="left" valign="middle" class="text">
		<form:input path="announceDate" readonly="true" onkeyup="" onkeypress="" size="15" maxlength="10" cssClass="field-color"/>
		<%--
		<input onkeyup="beginchk(this,event)" onkeypress="beginchk(this,event)"
			 name="ANNOUNCE_DATE" id="ANNOUNCE_DATE" type="text" size="15" maxlength="10" class="field-color" value="" />
			  --%>
			   &nbsp;
	  <img id="IMG_GAZETTE_DATEff"  name="IMG_GAZETTE_DATEff" src="<%=request.getContextPath() %>/images/icon_calendar2.gif" width="22" height="17" alt="" />
	  <script type="text/javascript">
					            Calendar.setup({
					              inputField    : "announceDate",
					              button        : "IMG_GAZETTE_DATEff",
								  ifFormat    : "%d/%m/%Y"
					            });
					         </script>
					        
					          &nbsp;เล่มที่&nbsp;
					          <form:input path="stStatutesub.announceBook" cssClass="field-color" size="10"/>
					          <%--
					          <input name="ANNOUNCE_BOOK" type="text" class="field-color" value=""
			size="10" /> 
			--%>
					         &nbsp;ตอนที่&nbsp;
					          <form:input path="stStatutesub.announcePart" cssClass="field-color" size="10"/>
					          <%-- 
					         <input
			name="ANNOUNCE_PART" type="text" class="field-color" id="ANNOUNCE_PART" value="" size="10" />
			--%>
      &nbsp;ฉบับที่&nbsp;
             <form:input path="stStatutesub.announceNo" cssClass="field-color" size="10"/>
      <%--
      <input
			name="ANNOUNCE_NO" type="text" class="field-color" id="ANNOUNCE_NO" value="" size="10" />
			 --%>
	</td>
	</tr>
	
	<tr>
	  <td colspan="2" valign="top" class="text">
	   <div  id="demo" class="yui-navset">
			<ul class="yui-nav">
				<li class="selected"><a href="#tab1"><em>ชื่อเรื่อง</em></a></li>
				<li><a href="#tab2"><em>สาระสำคัญ / คำช่วยค้น </em></a></li>
				<li><a href="#tab3"><em>เนื้อหา / ตารางแนบท้าย</em></a></li>
				<li><a href="#tab4"><em>แนบเอกสาร / สินค้าและบริการที่เกี่ยวข้อง</em></a></li>
			</ul>    
		<div class="yui-content">  
			<div>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
                	<tr>
                     <td height="15" valign="top" class="text">&nbsp;</td>
                     <td height="15" align="left" valign="top">&nbsp;</td>
                    </tr>
                    <tr>
                     <td width="18%" valign="top" class="text">
						<div align="right" valign="top">ชื่อเรื่อง<span id="textWord"> </span> (ภาษาไทย)&nbsp;</div>	  </td>
					 <td width="82%" align="left" valign="top">
						<form:textarea path="stStatutesub.article" cols="60" id="article" rows="3"/> 
		<%--
		<textarea cols="60" id="ARTICLE" name="ARTICLE" rows="3"></textarea>
		 --%>
							<script type="text/javascript">		 
								CKEDITOR.replace( 'article',
									{
										extraPlugins : 'uicolor',
										toolbar :
											[ ['Source', '-','Cut','Copy','PasteText','PasteFromWord','Preview','-', 'Bold', 'Italic', 'Underline', 'Strike', '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','NumberedList', 'BulletedList','-','Indent','Outdent','-','Link','Unlink', '-', 'MyButton' ] ,'/', 
							 				['Styles','Format','Font','FontSize','-','TextColor','BGColor','Table']
											]
										,height: "90"});
							</script>
					 </td>
					</tr>
					<tr>
						<td valign="middle" class="text">
						<div align="right">ฉบับที่&nbsp;</div>	  </td>
	  					<td height="30" align="left" valign="middle" class="text">
	  					<form:input path="stStatutesub.bookNo" cssClass="field-color" size="10"/>
	  <%--
	  <input name="BOOK_NO" type="text" class="field-color" value=""
			size="10" />
			 --%> 
     					 &nbsp;ปี พ.ศ.&nbsp;
      					<form:input path="stStatutesub.bookYear" cssClass="field-color" size="10" maxlength="4"/>
      <%--
      <input
			name="BOOK_YEAR" type="text" class="field-color" id="BOOK_YEAR"
			value="" size="10" maxlength="4" /></td>
			 --%>
					</tr>
					<tr>
						<td valign="top" class="text">
						<table id="t1" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="text">
									<div align="right" valign="top" >ชื่อเรื่อง (Eng)&nbsp;</div>
								</td>
							</tr>
						</table>
						</td>
						<td align="left" valign="top">
						<table id="t2" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<form:textarea path="stStatutesub.articleEng"  cols="60" id="articleEng" rows="3"/>
					<%--
				<textarea cols="60" id="ARTICLE_ENG" name="ARTICLE_ENG" rows="3" ></textarea>
				 --%>
									<script type="text/javascript">		
										CKEDITOR.replace( 'articleEng',
										{
											extraPlugins : 'uicolor',
											toolbar :
											[ ['Source', '-','Cut','Copy','PasteText','PasteFromWord','Preview','-', 'Bold', 'Italic', 'Underline', 'Strike', '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','NumberedList', 'BulletedList','-','Indent','Outdent','-','Link','Unlink', '-', 'MyButton' ] ,'/', 
							 				['Styles','Format','Font','FontSize','-','TextColor','BGColor','Table']
											]
											,height: "90"});
									</script>
								</td>
							</tr>
						</table>
						</td>
                      </tr>
        	</table>
        </div>
        <%--end tab1 --%>
        <%--start tab2 --%>
		<div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
            		<td width="18%" valign="top" class="text">
						<div align="right">กฎหมายที่เกี่ยวข้อง&nbsp;</div>	  
					</td>
					<td width="82%" align="left" valign="top">
		 							<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<c:set value="" var="endCol"/>
											<c:forEach items="${msStatuteBoxList}" var="box" varStatus="loop">  
			 	    							<c:set value="${loop.index mod 2}" var="endCol"/>
				 								<c:choose>
    	 											<c:when test="${loop.index mod 2 == 0}"> 
    	 				   								<tr>
    														<td align="left" class="texthead">
							 									<form:checkbox path="msStatuteBoxes"   value="${box.statuteId}" onclick="setTsRelStatute(this)" />	
																	<c:out value="${box.name}"/>
															</td>				 
    	 											</c:when>
    	 											<c:when test="${loop.index mod 2 == 1}">  
    														<td align="left" class="texthead">
							 									<form:checkbox path="msStatuteBoxes"  value="${box.statuteId}" onclick="setTsRelStatute(this)" />	
																	<c:out value="${box.name}"/>
															</td>					 
						  								</tr>
    	 											</c:when>
    	 											<c:otherwise>
    														<td align="left" class="texthead">
							 									<form:checkbox path="msStatuteBoxes"  value="${box.statuteId}" onclick="setTsRelStatute(this)" />	
																	<c:out value="${box.name}"/> 
							 								</td> 
    	 											</c:otherwise>   
					  							</c:choose>
											</c:forEach>
				 							<c:if test="${endCol!='1'}">
				  										</tr>
				 							</c:if>
				 						</table>
					</td>
					</tr> 
	                <tr>
	                	<td height="15" valign="top" class="text">&nbsp;</td>
	                    <td height="15" align="left" valign="top">&nbsp;</td>
                    </tr>
	                <tr>
						<td valign="top" class="text">
							<div align="right">สาระสำคัญ&nbsp;</div>	  
						</td>
						<td align="left" valign="top">
						<form:textarea path="stStatutesub.hightlight" id="hightlight" cols="60" rows="3"/>
						<%--
						<textarea name="HIGHTLIGHT" cols="60" rows="3" id="HIGHTLIGHT"> </textarea>
						 --%>
		  						<script type="text/javascript">		
									CKEDITOR.replace( 'hightlight',
										{
										extraPlugins : 'uicolor',
										toolbar :
										[ ['Source', '-','Cut','Copy','PasteText','PasteFromWord','Preview','-', 'Bold', 'Italic', 'Underline', 'Strike', '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','NumberedList', 'BulletedList','-','Indent','Outdent','-','Link','Unlink', '-', 'MyButton' ] ,'/', 
							 			['Styles','Format','Font','FontSize','-','TextColor','BGColor','Table']
										]
										,height: "90"});
								</script>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top" class="text"> คำช่วยค้น (Keyword) </td>
	  					<td height="60" align="left" valign="middle">
	  					<form:textarea path="stStatutesub.keyword" cols="90" rows="3" cssStyle="width: 100%"/>
	  					<%--
	  					<TEXTAREA NAME="KEYWORD" COLS="90" ROWS="3" id="KEYWORD" style="width: 100%"> </TEXTAREA>
	  					 --%>
	  					</td>
					</tr>
					<tr>
						<td valign="top" class="text">
							<div align="right">บทนำ</div>		
						</td>
						<td align="left" valign="top">
						
						<form:textarea path="stStatutesub.intro" id="intro" cols="60" rows="3"/>
						<%--
						<textarea cols="60" id="INTRO" name="INTRO" rows="3"> </textarea>
						 --%>
							 <script type="text/javascript">		
								CKEDITOR.replace( 'intro',
									{
									extraPlugins : 'uicolor',
									toolbar :
									[ ['Source', '-','Cut','Copy','PasteText','PasteFromWord','Preview','-', 'Bold', 'Italic', 'Underline', 'Strike', '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','NumberedList', 'BulletedList','-','Indent','Outdent','-','Link','Unlink', '-', 'MyButton' ] ,'/', 
							 		['Styles','Format','Font','FontSize','-','TextColor','BGColor','Table']
									]
									,height: "90"});
							</script>
						</td>
                     </tr>
					 <tr>
						<td valign="top" class="text">&nbsp;</td>
						<td align="left" valign="top" class="text"><input name="cmdLink" type="button"
							class="button" value="เชื่อมโยงข้อมูล"
							onClick="copyit(this.form.LEGAL_DETAIL,this.form.Keepvalue)" />
	  						&nbsp;<INPUT TYPE="button" value='ลบการเชื่อมโยง' onClick="section()" />&nbsp;<INPUT
							TYPE="submit" value="นำเข้าเอกสารจาก Word" />&nbsp;<input
							name="cmdLink" type="button" class="button" value="นำเข้ามาตรา"
							onClick="section();" />
						</td>
					  </tr>
                   </table>
			</div>
		<%--end tab2 --%>
        <%--start tab3 --%>
			<div>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
                	<tr>
						<td height="15" valign="top" class="text">&nbsp;</td>
						<td height="15" align="left" valign="top">&nbsp;</td>
                    </tr>
                    <tr>
                    	<td width="18%" valign="top" class="text">
							<div align="right">เนื้อหา&nbsp;</div>
						</td>
						<td width="82%" align="left" valign="top">
							<form:textarea path="stStatutesub.detail" id="detail" cols="60" rows="3"/>
		<%--
		<textarea cols="60" id="DETAIL" name="DETAIL" rows="3"></textarea>
		 --%>
							
						</td>
					</tr>
					<tr>
						<td valign="top" class="text">
							<div align="right">หมายเหตุ&nbsp;</div>
						</td>
						<td align="left" valign="top">
							<form:textarea path="stStatutesub.remark" cols="80" rows="5" cssStyle="width:100%"/>
				<%--
		<textarea name="REMARK" cols="80"
			rows="5" id="REMARK" style="width:100%"></textarea>	
			 --%>
	     				</td>
					</tr>
					<tr>
						<td valign="top" class="text">
							<table id="t3" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td>
										<div align="right" class="text">ตารางแนบท้าย&nbsp;</div>
									</td>
								</tr>
							</table>
						</td>
						<td align="left" valign="top" class="text">
							<table id="t4" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td>
										<form:textarea path="stStatutesub.tableAttach" id="tableAttach" cols="80" rows="10"/>
										<%--
			 							<textarea name="TABLE_ATTACH" cols="80"	rows="10" id="TABLE_ATTACH"></textarea>
			 							 --%>
										<script type="text/javascript">		
											CKEDITOR.replace( 'tableAttach',
												{
												extraPlugins : 'uicolor',
												toolbar :
												[ ['Source', '-','Cut','Copy','PasteText','PasteFromWord','Preview','-', 'Bold', 'Italic', 'Underline', 'Strike', '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','NumberedList', 'BulletedList','-','Indent','Outdent','-','Link','Unlink', '-', 'MyButton' ] ,'/', 
							 					['Styles','Format','Font','FontSize','-','TextColor','BGColor','Table']
												]
												,height: "90"});
										</script>
									</td>
								</tr>
							</table>
						</td>
                    </tr>
                </table>
			</div>
		<%--end tab3 --%>
        <%--start tab4 --%>
			<div>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
	  					<td height="15" align="right" valign="middle" class="text">&nbsp;</td>
	  					<td height="15" align="left" valign="bottom" class="text">&nbsp;</td>
	  				</tr>
					<tr>
						<td width="18%" height="36" align="right" valign="middle" class="text">แนบเอกสาร&nbsp;</td>
						<td width="82%" height="25" align="left" valign="bottom" class="text"><input type="Button" name="Upload"
							value="แนบไฟล์" onclick="JavaScript:Attach('SaveData')" />
	  						&nbsp;&nbsp;&nbsp;<input type="button" name="cmdscan" id="save"
							value="สแกนเอกสาร" onclick="scan()" /></td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
						<td align="left" valign="top">
							<table id="t9" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td>
										<table width='100%' border='0' cellpadding='1' cellspacing='0'
											bgcolor='#CCCCCC' class='table1'>
											<tr>
												<td align="center" background="<%=request.getContextPath() %>/images/bg_h_table.jpg" class="text"><strong>ชื่อเอกสาร</strong></td>
												<td align="center" background="<%=request.getContextPath() %>/images/bg_h_table.jpg" class="text"><strong>รายละเอียด</strong></td>
												<td align="center" background="<%=request.getContextPath() %>/images/bg_h_table.jpg" class="text"><strong>ลบ</strong></td>
											</tr>
											<tr bgcolor='#F0FFFF'>
											</tr>
											<tr bgcolor='#FFFFFF'>
												<td align='left' class='text'><img src="<%=request.getContextPath() %>/images/MSWord.png" width="26" height="26"></td>
												<td align='center'><a href="attachfile/court.jpg"
													class="menu-sub" target="_new"><img src="<%=request.getContextPath() %>/images/icon_15.gif"
													border="0" />
													</a>
												</td>
												<td align='center'><INPUT TYPE="image"
													src="<%=request.getContextPath() %>/images/icon_del.gif">
												</td>
											</tr>
											<tr bgcolor='#FFFFFF'>
												<td align='left' class='text'><img src="<%=request.getContextPath() %>/images/Acrobat.png" width="26" height="26"></td>
												<td align='center'><a href="attachfile/court.jpg"
													class="menu-sub" target="_new"><img src="<%=request.getContextPath() %>/images/icon_15.gif"
													border="0" /></a>
												</td>
												<td align='center'><INPUT TYPE="image"
													src="<%=request.getContextPath() %>/images/icon_del.gif">
												</td>
											</tr>
											<tr bgcolor='#FFFFFF'>
												<td align='left' class='text'><img src="<%=request.getContextPath() %>/images/ACDsee.png" width="26" height="26"></td>
												<td align='center'><a href="attachfile/court.jpg"
													class="menu-sub" target="_new"><img src="<%=request.getContextPath() %>/images/icon_15.gif"
													border="0" /></a>
												</td>
												<td align='center'><INPUT TYPE="image"
													src="<%=request.getContextPath() %>/images/icon_del.gif">
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
	<%--
		//}
	--%>
					<tr>
						<td class="text" valign='top' align='right'>สินค้าและบริการตามพระราชบัญญัติ&nbsp;</td>
						<td align="left" valign="top">
							<table>
								<tr>
									<td colspan="3" class="text" align="left"><input
										type="checkbox" name="selectall" id="selectall" onClick="checkall()" />เลือกทั้งหมด</td>
										
								</tr>
								<tr>
									<td colspan="3" class="text">สินค้า</td>
								</tr>
								<tr>
									<td width="auto"> 
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<c:set value="" var="endCol"/>
											<c:forEach items="${msLegalitemProducts}" var="box" varStatus="loop">  
			 	    							<c:set value="${loop.index mod 3}" var="endCol"/>
				 								<c:choose>
    	 											<c:when test="${loop.index mod 3 == 0}"> 
    	 				   								<tr>
    														<td align="left" class="texthead">
							 									<form:checkbox path="productBoxes"   value="${box.legalitemId}" onclick="setTsStatuteLegalitem(this)" />	
																	<c:out value="${box.name}"/>
															</td>				 
    	 											</c:when>
    	 											<c:when test="${loop.index mod 3 == 2}">  
    														<td align="left" class="texthead">
							 									<form:checkbox path="productBoxes"  value="${box.legalitemId}" onclick="setTsStatuteLegalitem(this)" />	
																	<c:out value="${box.name}"/>
															</td>					 
						  								</tr>
    	 											</c:when>
    	 											<c:otherwise>
    														<td align="left" class="texthead">
							 									<form:checkbox path="productBoxes"  value="${box.legalitemId}" onclick="setTsStatuteLegalitem(this)" />	
																	<c:out value="${box.name}"/> 
							 								</td> 
    	 											</c:otherwise>   
					  							</c:choose>
											</c:forEach>
				 							<c:if test="${endCol!='2'}">
				  										</tr>
				 							</c:if>
				 						</table>
									</td>
								</tr>
								<tr>
									<td colspan="3" class="text">บริการ</td>
								</tr>
								<tr>
									<td align="left" width="auto"> 
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<c:set value="" var="endCol2"/>
										<c:forEach items="${msLegalitemServices}" var="box" varStatus="loop">  
			 	    						<c:set value="${loop.index mod 3}" var="endCol2"/>
				 							<c:choose>
    	 										<c:when test="${loop.index mod 3 == 0}"> 
    	 				   							<tr>
    													<td align="left" class="texthead">
							 								<form:checkbox path="serviceBoxes"  value="${box.legalitemId}" onclick="setTsStatuteLegalitem(this)" />	
																<c:out value="${box.name}"/>
														</td>				 
    	 										</c:when>
    	 										<c:when test="${loop.index mod 3 == 2}">  
    													<td align="left" class="texthead">
							 								<form:checkbox path="serviceBoxes"  value="${box.legalitemId}" onclick="setTsStatuteLegalitem(this)" />	
																<c:out value="${box.name}"/>			
														</td>				 	
						  							</tr>
    	 										</c:when>
    	 										<c:otherwise>
    													<td align="left" class="texthead">
							 								<form:checkbox path="serviceBoxes"  value="${box.legalitemId}" onclick="setTsStatuteLegalitem(this)" />	
																<c:out value="${box.name}"/> 
							 							</td> 
    	 										</c:otherwise>   
					  						</c:choose>
										</c:forEach>
				 						<c:if test="${endCol2!='2'}">
				  									</tr>
				 						</c:if>
				 					</table>
				 					</td>
								</tr>
							</table>
						</td>
					</tr>
			</table>
		</div>
		<%-- end tab4 --%>
	</div>
 </div>
	<%-- end tab --%>
 </td>
 </tr>
	 
	  

	 
	<tr>
		<td valign="middle" class="text">
	  <div align="right"><font color='#0000CC'>ผู้นำเข้า&nbsp;</font></div>	  </td>
		<td height="25" align="left" valign="middle" class="text">Admin</td>
	</tr>
	<tr>
		<td valign="middle" class="text">
	  <div align="right" ><font color='#0000CC'>วันที่นำเข้า&nbsp;</font></div>	  </td>
		<td height="25" align="left" valign="middle"  class="text"><strong><c:out value="${stStatutesubForm.updateTime}"></c:out></strong><br></td>
	</tr>

</table>
<script>
	function statusMessage(msg,mode){
		alert(msg);
		if(mode=='doSave'){
			//"stStatutesub.status
			///stStatutesub.display
			//msStatuteBoxes
			//productBoxes
			//serviceBoxes
			document.getElementById("stStatutesub.announceBook").value="";		 
			document.getElementById("statuteId").value="0";
			document.getElementById("statutesubId").value="0";
			document.getElementById("announceDate").value="";
			document.getElementById("stStatutesub.announcePart").value="";
			document.getElementById("stStatutesub.announceNo").value="";
			document.getElementById("article").value="";
			document.getElementById("stStatutesub.bookNo").value="";
			document.getElementById("stStatutesub.bookYear").value="";
			document.getElementById("articleEng").value="";
			document.getElementById("hightlight").value="";
			document.getElementById("stStatutesub.keyword").value="";
			document.getElementById("intro").value="";
			document.getElementById("detail").value="";
			document.getElementById("stStatutesub.remark").value="";
			document.getElementById("tableAttach").value="";
			document.getElementById("stStatutesub.stOrder").value="";
			checkall();
			clearCheckBox('msStatuteBoxes')
			clearRadio('stStatutesub.status');
			clearRadio('stStatutesub.display');
		}
		
	}
</script>
<c:if test="${stStatutesubForm.isSusses=='1' && stStatutesubForm.action == 'doSave'}">
<script>
statusMessage("เพิ่มข้อมูลเรียบร้อยแล้ว\n",'doSave');
</script>
</c:if>
<c:if test="${stStatutesubForm.isSusses=='1' && stStatutesubForm.action == 'doEdit'}">
<script>
statusMessage("แก้ใขข้อมูลเรียบร้อยแล้ว\n",'doEdit');
</script>
</c:if>
<c:if test="${stStatutesubForm.isSusses=='1' && stStatutesubForm.action == 'doDelete'}">
<script>
statusMessage("ลบข้อมูลเรียบร้อยแล้ว\n",'doDelete');
</script>
</c:if>
 </form:form>
 <%--
</form>
 --%>
</body>
</html>	 