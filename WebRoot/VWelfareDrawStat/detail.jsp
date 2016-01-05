<%@ page contentType="text/html; charset=GBK" language="java" import="java.sql.*" errorPage=""%>
<%@page import="com.hz.auth.obj.AuthUser"%>
<%@page import="com.hz.util.SystemConstant"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.common.servlet.AbstractBaseServletTemplate"%>

<%@page import="com.fuli.obj.VWelfareDrawStatObj"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<title>福利领取统计</title>
		<link href="../style.css" rel="stylesheet" type="text/css" />
	</head>
	<script src="../js/jquery-2.0.3.min.js"></script>
	<script src="../js/utils.js"></script>
	<%
			String basePath="VWelfareDrawStat";// 每个功能都不同
			VWelfareDrawStatObj domainInstance = (VWelfareDrawStatObj)request.getAttribute("domainInstance");

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
				<td height="25" align="center" class="green_font">福利领取统计</td>
			</tr>
		</table>
		<table width="500" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#3DAEB6">
			<tr>
				<td bgcolor="#FFFFFF">
					<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
						<tr class="list_table_tr0">
							<td width="100" height="30" align="right" class="little_gray_font"><%=domainInstance.getProperties().get("welfare_policy_name")%>:</td>
							<td><%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_name())%></td>
						</tr>
						<tr class="list_table_tr2">
							<td width="100" height="30" align="right" class="little_gray_font"><%=domainInstance.getProperties().get("product_name")%>:</td>
							<td><%=StringUtil.getNotEmptyStr(domainInstance.getProduct_name())%></td>
						</tr>
						<tr class="list_table_tr0">
							<td width="100" height="30" align="right" class="little_gray_font"><%=domainInstance.getProperties().get("product_spec")%>:</td>
							<td><%=StringUtil.getNotEmptyStr(domainInstance.getProduct_spec())%></td>
						</tr>
						<tr class="list_table_tr2">
							<td width="100" height="30" align="right" class="little_gray_font"><%=domainInstance.getProperties().get("product_qunatity_sum")%>:</td>
							<td><%=StringUtil.getNotEmptyStr(domainInstance.getProduct_qunatity_sum())%></td>
						</tr>
						<tr>
						<td height="30" colspan="2" align="center" class="tab_bg">&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<script>
		<%if("true".equalsIgnoreCase(request.getAttribute("needRefresh")+"")){%>
			// 绑定关闭事件
			$(window).unload(function(){
			  	// 父窗口刷新
				var parent = window.dialogArguments; 
				parent.execScript("toPage(1)","javascript"); 
			});
		<%}%>
		</script>
	</body>
</html>
