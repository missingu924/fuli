<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<!-- 引入类 -->
<%@page import="com.hz.auth.obj.AuthUser"%>
<%@page import="java.util.List"%>
<%@page import="com.hz.util.SystemConstant"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wuyg.common.obj.PaginationObj"%>
<%@page import="com.inspur.common.dictionary.util.DictionaryUtil"%>
<%@page import="com.hz.dict.service.DictionaryService"%>
<%@page import="com.wuyg.common.servlet.AbstractBaseServletTemplate"%>
<%@page import="com.fuli.obj.VillagerObj"%>
<!-- 基本信息 -->
<%
	// 当前上下文路径
	String contextPath = request.getContextPath();
	// 当前用户
	AuthUser user = (AuthUser) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);

	// 该功能对象实例
	VillagerObj domainInstance = (VillagerObj) request.getAttribute("domainInstance");
	// 该功能路径
	String basePath = domainInstance.getBasePath();
%>
<html>
	<head>
		<base target="_self" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><%=domainInstance.getCnName() %>列表</title>
		<link href="../style.css" rel="stylesheet" type="text/css">
		<link href="../table.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="../js/utils.js"></script>
	</head>
	<body>
		<form name="pageForm" id="pageForm" method="post" action="<%=request.getContextPath()%>/<%=basePath%>/Servlet?method=list4select">
			
			<!-- 查询条件 -->
			<table class="search_table" align="center" width="98%">
				<tr>
					<td align="left">
						<%=domainInstance.getPropertyCnName("id_card") %>
						<input name="id_card" type="text" id="id_card" value="<%=StringUtil.getNotEmptyStr(domainInstance.getId_card())%>" size="20">
						&nbsp; <%=domainInstance.getPropertyCnName("villager_name") %>
						<input name="villager_name" type="text" id="villager_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getVillager_name())%>" size="20">
						&nbsp; <%=domainInstance.getPropertyCnName("villager_group") %>
						<%=DictionaryUtil.getSelectHtml(new DictionaryService().getDictItemsByDictName("villagerGroup", false), "villager_group", "所属组", StringUtil.getNotEmptyStr(domainInstance.getVillager_group()), "notEmpty")%>
						&nbsp;
						<input name="searchButton" type="button" class="button button_search" value="查询" onClick="toPage(1)">
					</td>
					<td  align="left">
						<input name="confirmButton" type="button" class="button button_save" value="确认" title="确认" onClick="confirmSelect()">
					</td>
				</tr>
			</table>

			<!-- 查询结果 -->
			<%
				PaginationObj pagination = null;
				List list = new ArrayList();

				Object paginationObj = request.getAttribute("domainPagination");
				if (paginationObj != null)
				{
					pagination = (PaginationObj) paginationObj;
					list = (List) pagination.getDataList();
				}
				if (paginationObj == null)
				{
					out.print("没有符合条件的数据，请重新设置条件再查询。");
				} else
				{
			%>
			<table class="table table-bordered table-striped" align="center" width="98%">
				<thead>
					<tr>
						<th>选择</th>
						<th><%=domainInstance.getPropertyCnName("id") %></th>
						<th><%=domainInstance.getPropertyCnName("villager_name") %></th>
						<th><%=domainInstance.getPropertyCnName("id_card") %></th>
						<th><%=domainInstance.getPropertyCnName("villager_sex") %></th>
						<th><%=domainInstance.getPropertyCnName("villager_telephone") %></th>
						<th><%=domainInstance.getPropertyCnName("villager_group") %></th>
						<th><%=domainInstance.getPropertyCnName("enable") %></th>
					</tr>
				</thead>
				<%
					for (int i = 0; i < list.size(); i++)
						{
							VillagerObj o = (VillagerObj) list.get(i);
				%>
				<tr>
					<td><input type="radio" name="villager_info" id="villager_info" value="<%=StringUtil.getNotEmptyStr(o.getId())%>,<%=StringUtil.getNotEmptyStr(o.getVillager_name())%>"></td>
					<td><%=StringUtil.getNotEmptyStr(o.getId())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getVillager_name())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getId_card())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getVillager_sex())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getVillager_telephone())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getVillager_group())%></td>
					<td>
						<%
							String fontColor = "停用".equals(o.getEnable()) ? "red" : "black";
						%><font color="<%=fontColor%>">已<%=StringUtil.getNotEmptyStr(o.getEnable())%></font>
					</td>
				</tr>
				<%
					}
				%>
			</table>

			<!-- 翻页操作栏 -->
			<jsp:include page="../ToolBar/pagination_toolbar.jsp">
				<jsp:param name="basePath" value="<%=basePath%>"/>
			</jsp:include>

			<%
				}
			%>
		</form> 
	<script>
	function confirmSelect()
	{		
		var villagerInfo = $("#villager_info:checked").val();
		
		if(villagerInfo)
		{
			window.returnValue = villagerInfo;
			window.close();
		}
		else
		{
			if(confirm("您没有选择任何村民信息，确认关闭吗?"))
			window.close();
		}
	}
	</script>
	</body>
</html>

