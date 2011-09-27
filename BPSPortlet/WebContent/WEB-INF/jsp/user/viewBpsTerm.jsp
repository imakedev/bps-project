<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head></head>
<body>
	<table width="950" align="center" border="0" cellspacing="0"
		cellpadding="0">
		<tr>
			<td height="30" colspan="2"><span
				style="color: #030; font-size: 12px;"><strong>You
						are in:</strong> <a href="index.html">Home</a> > <a href="BPSTerm01.html">BPS
						Term and Difinition</a> > ${bpsUserForm.bpsTerm.bptTerm}</span>
			</td>
		</tr>
		<tr height="50">
			<td align="left"><img
				src="<%=request.getContextPath()%>/images/term.gif">
			</td>
			<td align="right"><a href="#"><img
					src="<%=request.getContextPath()%>/images/btn_comment.gif"
					width="128" height="25">
			</a>
			</td>
		</tr>
		<tr>
			<td colspan="2" valign="top">
				<table width="100%" id="box-table-a" border="0" cellspacing="2"
					cellpadding="0" style="border: 1px solid #132C00">
					<tr>
						<th height="25" align="left" bgcolor="#3DB0B5"><span
							style="padding-left: 5px;">${bpsUserForm.bpsTerm.bptTerm}</span>
						</th>
					</tr>
					<tr>
						<td width="25%"><span style="padding: 5px;">${bpsUserForm.bpsTerm.bptDefinition}</span>
						</td>
					</tr>
				</table> <br>
				<table width="100%" id="box-table-a" border="0" cellspacing="2"
					cellpadding="0" style="border: 1px solid #132C00">
					<tr>
						<th height="25" align="left" bgcolor="#3DB0B5"><span
							style="padding-left: 5px;">Attachments</span>
						</th>
					</tr>
					<tr>
						<td width="25%">
							<ul>
								<c:forEach items="${resultList.resultListObj}" var="item">
									<li><a href="${item.bpafFilePath}">&nbsp;${item.bpafFileName}</a></li>
								</c:forEach>
							</ul></td>
					</tr>
				</table></td>
		</tr>
		<tr>
			<td width="50%" height="30"><span
				style="color: #030; font-size: 12px;">< Back to Home</span>
			</td>
			<td width="50%">&nbsp;</td>
		</tr>
	</table>
</body>
</html>