<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<%@page import="com.hz.auth.obj.AuthUser"%>
<%@page import="com.hz.util.SystemConstant"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.common.servlet.AbstractBaseServletTemplate"%>

<%@page import="com.fuli.obj.VillagerObj"%>
<%@page import="java.util.List"%>
<%@page import="com.fuli.obj.WelfarePolicyObj"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<title>村民信息</title>
		<link href="../style.css" rel="stylesheet" type="text/css" />
	</head>
	<script src="../js/jquery-2.0.3.min.js"></script>
	<script src="../js/utils.js"></script>
	<%
			String basePath="Villager";// 每个功能都不同
			VillagerObj domainInstance = (VillagerObj)request.getAttribute("domainInstance");

			String contextPath = request.getContextPath();
			AuthUser user = (AuthUser) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);
	%>
	<body>
		<div style="height: 8px;"></div>
		<table width="700" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#3DAEB6">
			<tr>
				<td height="4" bgcolor="#3DAEB6"></td>
			</tr>
			<tr>
				<td height="25" align="center" class="green_font">村民基本信息</td>
			</tr>
		</table>
		<table width="700" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#3DAEB6">
			<tr>
				<td bgcolor="#FFFFFF">
					<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
						<tr class="list_table_tr0">
							<td width="100" align="right" class="little_gray_font">身份证号:</td>
							<td><%=StringUtil.getNotEmptyStr(domainInstance.getId_card())%></td>
						</tr>
						<tr class="list_table_tr2">
							<td width="100" align="right" class="little_gray_font">姓名:</td>
							<td><%=StringUtil.getNotEmptyStr(domainInstance.getVillager_name())%></td>
						</tr>
						<tr class="list_table_tr0">
							<td width="100" align="right" class="little_gray_font">性别:</td>
							<td><%=StringUtil.getNotEmptyStr(domainInstance.getVillager_sex())%></td>
						</tr>
						<tr class="list_table_tr2">
							<td width="100" align="right" class="little_gray_font">电话:</td>
							<td><%=StringUtil.getNotEmptyStr(domainInstance.getVillager_telephone())%></td>
						</tr>
						<tr class="list_table_tr0">
							<td width="100" align="right" class="little_gray_font">备注:</td>
							<td><%=StringUtil.getNotEmptyStr(domainInstance.getVillager_omment())%></td>
						</tr>
						<tr class="list_table_tr2">
							<td width="100" align="right" class="little_gray_font">是否启用:</td>
							<td><%=StringUtil.getNotEmptyStr(domainInstance.getEnable())%></td>
						</tr>
						<tr class="list_table_tr0">
							<td width="100" align="right" class="little_gray_font">已绑定到:</td>
							<td>
							<%if(StringUtil.isEmpty(domainInstance.getBinding_to_villager_name())) {%>
							没有绑定到其他村民
							<%}else{ %>
							<a href="#" onClick="openWindow('<%=contextPath%>/<%=basePath%>/Servlet?method=detailVillager&<%=domainInstance.findKeyColumnName() %>=<%=domainInstance.getBinding_to_id()%>')">
										<%=StringUtil.getNotEmptyStr(domainInstance.getBinding_to_villager_name())%>
										</a>
							<%} %>
							</td>
						</tr>
						<tr>
						<td colspan="2">
							<table width="700" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#3DAEB6">
								<tr>
									<td height="2" bgcolor="#3DAEB6"></td>
								</tr>
								<tr>
									<td height="25" align="center" class="green_font">享受的福利</td>
								</tr>
							</table>
						</td>
						</tr>
						<tr>
							<td colspan="2">
							<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
                                  <tr class="list_table_head">
                                    <td>编号</td>
                                    <td>福利政策名称</td>
                                    <td>福利年份</td>
                                    <td>福利开始日期</td>
                                    <td>福利结束日期</td>
                                    <td>福利状态</td>
                                  </tr>
                                  <% 
                                  List <WelfarePolicyObj> list = domainInstance.getUsedWelfareList();
                                  for(int i=0;i<list.size();i++)
                                  { 
                                  	WelfarePolicyObj o = list.get(i);
                                  %>
                                  <tr class="list_table_tr3">
                                    <td><%=StringUtil.getNotEmptyStr(o.getId()) %></td>
                                    <td><a href="#" onClick="openBigModalDialog('<%=contextPath%>/WelfarePolicy/Servlet?method=detailWelfarePolicy&<%=o.findKeyColumnName() %>=<%=o.getKeyValue()%>')"><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_name()) %></a></td>
                                    <td><%=StringUtil.getNotEmptyStr(o.getYear_lunar()) %></td>
                                  	<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_start_time_show())%><br/><span class="little_gray_font">农历<%=StringUtil.getNotEmptyStr(o.getWelfare_policy_start_time_lunar())%></span></td>
									<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_end_time_show())%><br/><span class="little_gray_font">农历<%=StringUtil.getNotEmptyStr(o.getWelfare_policy_end_time_lunar())%></span></td>
                                  	<td><font color="<%=o.getWelfare_status_color() %>"><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_status()) %></font></td>
                                  </tr>
                                  <%} %>
                                  
                                </table>
							</td>
							</tr>
						<tr>
						<tr>
						
						<% 
                             List <VillagerObj> bindlist = domainInstance.getBindingVillagerList();
                             if(bindlist.size()>0)
                             {
                        %>
						<td colspan="2">
							<table width="700" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#3DAEB6">
								<tr>
									<td height="2" bgcolor="#3DAEB6"></td>
								</tr>
								<tr>
									<td height="25" align="center" class="green_font">绑定的村民</td>
								</tr>
							</table>
						</td>
						</tr>
						<tr>
							<td colspan="2">
							<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
                                  <tr class="list_table_head">
                                    <td>编号</td>
                                    <td>姓名</td>
                                    <td>身份证号</td>
                                    <td>性别</td>
                                    <td>电话</td>
                                    <td>是否启用</td>
                                  </tr>
                                  <% 
                                  
                                  for(int i=0;i<bindlist.size();i++)
                                  { 
                                  	VillagerObj o = bindlist.get(i);
                                  %>
                                  <tr class="list_table_tr0">
                                    <td><%=StringUtil.getNotEmptyStr(o.getId()) %></td>
                                    <td>
                                    	<a href="#" onClick="openWindow('<%=contextPath%>/<%=basePath%>/Servlet?method=detailVillager&<%=o.findKeyColumnName() %>=<%=o.getKeyValue()%>')">
										<%=StringUtil.getNotEmptyStr(o.getVillager_name())%>
										</a>
									</td>
                                    <td><%=StringUtil.getNotEmptyStr(o.getId_card()) %></td>
                                  	<td><%=StringUtil.getNotEmptyStr(o.getVillager_sex())%></td>
									<td><%=StringUtil.getNotEmptyStr(o.getVillager_telephone())%></td>
									<td><%String fontColor="停用".equals(o.getEnable())?"red":"green";%><font color="<%=fontColor %>">已<%=StringUtil.getNotEmptyStr(o.getEnable())%></font></td>
                                  </tr>
                                  <%} %>
                                  
                                </table>
							</td>
							</tr>
						<tr>
						<%} %>
						<td colspan="2" align="center" class="tab_bg">
							<input name="closeButton" type="button" class="gray_button" value="关闭" onClick="javascript:window.close();"/>
							
						</td>
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

