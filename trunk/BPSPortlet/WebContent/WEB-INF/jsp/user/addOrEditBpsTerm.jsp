<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="portlet" uri="http://java.sun.com/portlet"%>
<portlet:defineObjects />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet"
	href="<%=request.getContextPath()%>/ckeditor/_samples/sample.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
</head>
<body>
	<c:if test="${mode eq 'add'}">
		<table width="800" border="0" cellspacing="0" cellpadding="0"
			align="center" style="background-color: #FFF;">
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="2" cellpadding="0">
						<tr>
							<td>
								<form action="" method="get">
									<table width="100%" border="0" cellspacing="3" cellpadding="0">
										<tr>
											<td height="30" colspan="2"
												style="background-color: #132C00; font-weight: bold; color: #FFF;">&nbsp;New
												BPS Terms and Definitions</td>
										</tr>
										<tr>
											<td width="19%" height="19" class="h_achieve">To:</td>
											<td width="81%"><label> <input name="COS Staff"
													type="text" id="COS Staff" value="COS Staff" size="50"
													class="readonly" readonly="readonly"> </label>
											</td>
										</tr>
										<tr>
											<td class="h_achieve">From:</td>
											<td><input name="textfield2" type="text"
												class="readonly" id="textfield2" value="name" size="50"
												readonly="readonly">
											</td>
										</tr>
										<tr>
											<td class="h_achieve">Subject:</td>
											<td><input name="textfield3" type="text" id="textfield3"
												size="50">
											</td>
										</tr>
										<tr>
											<td colspan="2"><hr>
											</td>
										</tr>
										<tr>
											<td class="h_achieve">Term:</td>
											<td><input name="textfield4" type="text" id="textfield4"
												size="50">
											</td>
										</tr>
										<tr>
											<td class="h_achieve">Source / Referance:</td>
											<td><input name="textfield5" type="text" id="textfield5"
												size="50">
											</td>
										</tr>
										<tr>
											<td class="h_achieve">Detail:</td>
											<td><textarea cols="50" id="editor1" name="editor1" rows="10"></textarea><script type="text/javascript">
		CKEDITOR.replace('editor1');
	</script>
											</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td><label> <input type="submit" name="button"
													id="button" value="Send mail"> <input type="submit"
													name="button2" id="button2" value="Cancel"> </label>
											</td>
										</tr>
									</table>
								</form>
							</td>

						</tr>
					</table></td>
			</tr>
		</table>
	</c:if>
	<c:if test="${mode eq 'edit'}">
		<table width="800" border="0" cellspacing="0" cellpadding="0"
			align="center" style="background-color: #FFF;">
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="2" cellpadding="0">
						<tr>
							<td>
								<form action="" method="get">
									<table width="100%" border="0" cellspacing="3" cellpadding="0">
										<tr>
											<td height="30" colspan="2"
												style="background-color: #132C00; font-weight: bold; color: #FFF;">&nbsp;Request
												to modify BPS Term and Definition</td>
										</tr>
										<tr>
											<td width="19%" height="19" class="h_achieve">To:</td>
											<td width="81%"><label> <input name="COS Staff"
													type="text" id="COS Staff" value="COS Staff" size="50"
													class="readonly" readonly="readonly"> </label>
											</td>
										</tr>
										<tr>
											<td class="h_achieve">From:</td>
											<td><input name="textfield2" type="text"
												class="readonly" id="textfield2" value="name" size="50"
												readonly="readonly">
											</td>
										</tr>
										<tr>
											<td class="h_achieve">Subject:</td>
											<td><input name="textfield3" type="text" id="textfield3"
												size="50">
											</td>
										</tr>
										<tr>
											<td colspan="2"><hr>
											</td>
										</tr>
										<tr>
											<td class="h_achieve">Term:</td>
											<td><input name="term" type="text" id="term"
												value="${bpsUserForm.bpsTerm.bptTerm}" size="50" class="readonly"
												readonly="readonly">
											</td>
										</tr>
										<tr>
											<td class="h_achieve">Source / Referance:</td>
											<td><input name="textfield5" type="text" id="textfield5"
												size="50">
											</td>
										</tr>
										<tr>
											<td height="25">&nbsp;</td>
											<td class="h_achieve"><a href="#">Proposed change</a> |
												<a href="#">Revised version</a>
											</td>
										</tr>
										<tr>
											<td class="h_achieve">Detail:</td>
											<td><textarea cols="50" id="editor1" name="editor1" rows="10"></textarea><script type="text/javascript">
		CKEDITOR.replace('editor1');
	</script>
											</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td><label> <input type="submit" name="button"
													id="button" value="Send mail"> <input type="submit"
													name="button2" id="button2" value="Cancel"> </label>
											</td>
										</tr>
									</table>
								</form>
							</td>

						</tr>
					</table></td>
			</tr>
		</table>
	</c:if>
</body>
</html>