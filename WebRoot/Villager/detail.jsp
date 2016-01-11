<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<%@page import="com.hz.auth.obj.AuthUser"%>
<%@page import="com.hz.util.SystemConstant"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.fuli.obj.VillagerObj"%>
<%@page import="java.util.List"%>
<%@page import="com.fuli.obj.WelfarePolicyObj"%>
<%
	VillagerObj domainInstance = (VillagerObj) request.getAttribute("domainInstance");
	String basePath = domainInstance.getBasePath();

	String contextPath = request.getContextPath();
	AuthUser user = (AuthUser) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);
%>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<title><%=domainInstance.getCnName()%>详情</title>
		<link href="../style.css" rel="stylesheet" type="text/css" />
		<link href="../table.css" rel="stylesheet" type="text/css" />
		<script src="../js/jquery-2.0.3.min.js"></script>
		<script src="../js/utils.js"></script>
	</head>


	<body>
		<!-- 表格标题 -->
		<table width="700" align="center" class="title_table">
			<tr>
				<td>
					<img src="../images/svg/heavy/green/user_list.png" width="18" height="18" align="absmiddle">
					&nbsp;&nbsp;<%=domainInstance.getCnName()%>信息
				</td>
			</tr>
		</table>
		<!-- 详细信息 -->
		<table width="700" align="center" class="detail_table detail_table-bordered detail_table-striped">
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("id_card") %>:
				</td>
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getId_card())%></td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("villager_name") %>:
				</td>
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getVillager_name())%></td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("villager_sex") %>:
				</td>
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getVillager_sex())%></td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("villager_telephone") %>:
				</td>
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getVillager_telephone())%></td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("villager_omment") %>:
				</td>
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getVillager_omment())%></td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("enable") %>:
				</td>
				<td><%
						String fontColor = "停用".equals(domainInstance.getEnable()) ? "red" : "black";
					%><font color="<%=fontColor%>">已<%=StringUtil.getNotEmptyStr(domainInstance.getEnable())%></font></td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("binding_to_villager_name") %>:
				</td>
				<td>
					<%
						if (StringUtil.isEmpty(domainInstance.getBinding_to_villager_name()))
						{
					%>
					没有绑定到其他村民
					<%
						} else
						{
					%>
					<a href="#" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=detailVillager&<%=domainInstance.findKeyColumnName()%>=<%=domainInstance.getBinding_to_id()%>')"> <%=StringUtil.getNotEmptyStr(domainInstance.getBinding_to_villager_name())%> </a>
					<%
						}
					%>
				</td>
			</tr>
		</table>
		<!-- 表格标题 -->
		<table width="700" align="center" class="title_table">
			<tr>
				<td>
					<img src="../images/svg/heavy/green/shop.png" width="18" height="18" align="absmiddle">
					&nbsp;&nbsp;享受的福利
				</td>
			</tr>
		</table>
		<!-- 详细信息 -->
		<%
			WelfarePolicyObj o = new WelfarePolicyObj();
		%>
		<table class="table table-bordered" align="center" width="700">
			<thead>
				<tr>
					<th>
							<%=o.getPropertyCnName("id") %>
						</th>
						<th>
							<%=o.getPropertyCnName("welfare_policy_name") %>
						</th>
						<th>
							<%=o.getPropertyCnName("year_lunar") %>
						</th>
						<th>
							<%=o.getPropertyCnName("welfare_policy_start_time") %>
						</th>
						<th>
							<%=o.getPropertyCnName("welfare_policy_end_time") %>
						</th>
						<th>
							<%=o.getPropertyCnName("welfare_policy_status") %>
						</th>
				</tr>
			</thead>
			<%
				List<WelfarePolicyObj> list = domainInstance.getUsedWelfareList();
				for (int i = 0; i < list.size(); i++)
				{
					o = list.get(i);
			%>
			<tr class="list_table_tr3">
				<td><%=StringUtil.getNotEmptyStr(o.getId())%></td>
				<td>
					<a href="#" onClick="openBigModalDialog('<%=contextPath%>/WelfarePolicy/Servlet?method=detailWelfarePolicy&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')"><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_name())%></a>
				</td>
				<td><%=StringUtil.getNotEmptyStr(o.getYear_lunar())%></td>
				<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_start_time_show())%>
				<!--<br />
					<span class="little_gray_font">农历<%=StringUtil.getNotEmptyStr(o.getWelfare_policy_start_time_lunar())%></span>
				-->
				</td>
				<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_end_time_show())%>
				<!--<br />
					<span class="little_gray_font">农历<%=StringUtil.getNotEmptyStr(o.getWelfare_policy_end_time_lunar())%></span>
				-->
				</td>
				<td>
					<font color="<%=o.getWelfare_status_color()%>"><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_status())%></font>
				</td>
			</tr>
			<%
				}
			%>
		</table>


		<%
			List<VillagerObj> bindlist = domainInstance.getBindingVillagerList();
			if (bindlist.size() > 0)
			{
		%>
		<!-- 表格标题 -->
		<table width="700" align="center" class="title_table">
			<tr>
				<td>
					<img src="../images/svg/heavy/green/user.png" width="18" height="18" align="absmiddle">
					&nbsp;&nbsp;绑定的村民
				</td>
			</tr>
		</table>
		<!-- 详细信息 -->
		<%
			VillagerObj oo = new VillagerObj();
		%>
		<table class="table table-bordered" align="center" width="700">
			<thead>
				<tr>
					<th>
						<%=oo.getPropertyCnName("id") %>
					</th>
					<th>
						<%=oo.getPropertyCnName("villager_name") %>
					</th>
					<th>
						<%=oo.getPropertyCnName("id_card") %>
					</th>
					<th>
						<%=oo.getPropertyCnName("villager_sex") %>
					</th>
					<th>
						<%=oo.getPropertyCnName("villager_telephone") %>
					</th>
					<th>
						<%=oo.getPropertyCnName("enable") %>
					</th>
				</tr>
			</thead>
			<%
				for (int i = 0; i < bindlist.size(); i++)
				{
						oo = bindlist.get(i);
			%>
			<tr>
				<td><%=StringUtil.getNotEmptyStr(o.getId())%></td>
				<td>
					<a href="#" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=detailVillager&<%=oo.findKeyColumnName()%>=<%=oo.getKeyValue()%>')"> <%=StringUtil.getNotEmptyStr(oo.getVillager_name())%> </a>
				</td>
				<td><%=StringUtil.getNotEmptyStr(oo.getId_card())%></td>
				<td><%=StringUtil.getNotEmptyStr(oo.getVillager_sex())%></td>
				<td><%=StringUtil.getNotEmptyStr(oo.getVillager_telephone())%></td>
				<td>
					<%
					fontColor = "停用".equals(oo.getEnable()) ? "red" : "green";
					%><font color="<%=fontColor%>">已<%=StringUtil.getNotEmptyStr(oo.getEnable())%></font>
				</td>
			</tr>
			<%
				}
			%>

		</table>
		<%
			}
		%>
		
		<!-- 工具栏 -->
		<jsp:include page="../ToolBar/detail_toolbar.jsp"/>
	</body>
</html>

