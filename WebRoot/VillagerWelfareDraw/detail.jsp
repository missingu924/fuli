<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<%@page import="com.hz.auth.obj.AuthUser"%>
<%@page import="com.hz.util.SystemConstant"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.common.servlet.AbstractBaseServletTemplate"%>

<%@page import="com.fuli.obj.VillagerWelfareDrawObj"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<title>领取福利</title>
		<link href="../style.css" rel="stylesheet" type="text/css" />
	</head>
	<script src="../js/jquery-2.0.3.min.js"></script>
	<script src="../js/utils.js"></script>
	<%
			String basePath="VillagerWelfareDraw";// 每个功能都不同
			VillagerWelfareDrawObj domainInstance = (VillagerWelfareDrawObj)request.getAttribute("domainInstance");

			String contextPath = request.getContextPath();
			AuthUser user = (AuthUser) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);
	%>
	<body>
		<div style="height: 8px;"></div>
		<table width="500" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#3DAEB6">
			<tr>
				<td height="4" bgcolor="#3DAEB6"></td>
			</tr>
			<tr>
				<td height="25" align="center" class="green_font">领取福利</td>
			</tr>
		</table>
		<table width="500" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#3DAEB6">
			<tr>
				<td bgcolor="#FFFFFF">
					<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
						<tr class="list_table_tr0">
							<td width="100" height="30" align="right" class="little_gray_font">编号:</td>
							<td><%=StringUtil.getNotEmptyStr(domainInstance.getId())%></td>
						</tr>
						<tr class="list_table_tr2">
							<td width="100" height="30" align="right" class="little_gray_font">村民编号:</td>
							<td><%=StringUtil.getNotEmptyStr(domainInstance.getVillager_id())%></td>
						</tr>
						<tr class="list_table_tr0">
							<td width="100" height="30" align="right" class="little_gray_font">领取方式:</td>
							<td><%=StringUtil.getNotEmptyStr(domainInstance.getDraw_type())%></td>
						</tr>
						<tr class="list_table_tr2">
							<td width="100" height="30" align="right" class="little_gray_font">代领人编号:</td>
							<td><%=StringUtil.getNotEmptyStr(domainInstance.getProxy_villager_id())%></td>
						</tr>
						<tr class="list_table_tr0">
							<td width="100" height="30" align="right" class="little_gray_font">代领人姓名:</td>
							<td><%=StringUtil.getNotEmptyStr(domainInstance.getProxy_villager_name())%></td>
						</tr>
						<tr class="list_table_tr2">
							<td width="100" height="30" align="right" class="little_gray_font">领取日期:</td>
							<td><%=StringUtil.getNotEmptyStr(domainInstance.getDraw_date())%></td>
						</tr>
						<tr class="list_table_tr0">
							<td width="100" height="30" align="right" class="little_gray_font">备注:</td>
							<td><%=StringUtil.getNotEmptyStr(domainInstance.getDraw_comment())%></td>
						</tr>
						<tr>
						<td height="30" colspan="2" align="center" class="tab_bg">&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>
</html>
