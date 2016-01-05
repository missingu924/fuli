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
<%@page import="com.fuli.obj.VWelfareForDrawDetailObj"%>
<!-- 基本信息 -->
<%
	// 当前上下文路径
	String contextPath = request.getContextPath();
	// 当前用户
	AuthUser user = (AuthUser) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);

	// 该功能对象实例
	VWelfareForDrawDetailObj domainInstance = (VWelfareForDrawDetailObj) request.getAttribute("domainInstance");
	// 该功能路径
	String basePath = domainInstance.getBasePath();
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><%=domainInstance.getCnName()%>列表</title>
		<link href="../style.css" rel="stylesheet" type="text/css">
		<link href="../table.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="../js/utils.js"></script>
	</head>

	<body>

		<form name="pageForm" id="pageForm" method="post" action="<%=request.getContextPath()%>/<%=basePath%>/Servlet?method=list">
			<!-- 查询条件 -->
			<table class="search_table" align="center" width="98%">
				<tr>
					<td align="left">
						福利政策
						<%=DictionaryUtil.getSelectHtml(new DictionaryService().getDictItemsByDictName("welfarePolicy", true), "welfare_policy_id", "福利政策", StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_id()), "notEmpty")%>&nbsp; 身份证
						<input name="id_card" type="text" id="id_card" value="<%=StringUtil.getNotEmptyStr(domainInstance.getId_card())%>" size="20">
						&nbsp; 姓名
						<input name="villager_name" type="text" id="villager_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getVillager_name())%>" size="20">
						<!-- 
									<%=DictionaryUtil.getSelectHtml(new DictionaryService().getDictItemsByDictName("allVillager", true), "villager_id", "姓名", StringUtil.getNotEmptyStr(domainInstance.getVillager_id()), "notEmpty")%> -->
						&nbsp; 领取情况
						<%=DictionaryUtil.getSelectHtml(new DictionaryService().getDictItemsByDictName("welfareDrawStatus", true), "welfare_draw_status", "领取情况", StringUtil.getNotEmptyStr(domainInstance.getWelfare_draw_status()), "notEmpty")%>&nbsp;
						<input name="searchButton" type="button" class="blue_button" value=" 查询 " onClick="toPage(1)">
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
					out.print("没有查询到数据。");
				} else
				{
			%>
			<table class="table table-bordered table-striped" align="center" width="98%">
				<thead>
					<tr>
						<th>
							村民姓名
						</th>
						<th>
							身份证号
						</th>
						<th>
							福利政策
						</th>
						<th>
							福利生效时间
						</th>
						<th>
							福利过期时间
						</th>
						<th>
							产品名称
						</th>
						<th>
							产品规格
						</th>
						<th>
							产品单位
						</th>
						<th>
							产品单价
						</th>
						<th>
							领取情况
						</th>
						<th>
							应领数量
						</th>
						<th>
							已领数量
						</th>
						<th>
							未领数量
						</th>
					</tr>
				</thead>
				<%
					for (int i = 0; i < list.size(); i++)
						{
							VWelfareForDrawDetailObj o = (VWelfareForDrawDetailObj) list.get(i);
				%>
				<tr>
					<td>
						<a href="#" onClick="openBigModalDialog('<%=contextPath%>/Villager/Servlet?method=detailVillager&id=<%=o.getVillager_id()%>')"> <%=StringUtil.getNotEmptyStr(o.getVillager_name())%> </a>
					</td>
					<td><%=StringUtil.getNotEmptyStr(o.getId_card())%></td>
					<td>
						<a href="#" onClick="openBigModalDialog('<%=contextPath%>/WelfarePolicy/Servlet?method=detailWelfarePolicy&id=<%=o.getWelfare_policy_id()%>')"> <%=StringUtil.getNotEmptyStr(o.getWelfare_policy_name())%> </a>
					</td>
					<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_start_time_show())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_end_time_show())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_name())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_spec())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_measuring_unit())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_price())%></td>
					<td>
						<%
							String fontColor = "red";
									if (o.WELFARE_DRAW_STATUS_DRAWD_PART.equalsIgnoreCase(o.getWelfare_draw_status()))
									{
										fontColor = "blue";
									} else if (o.WELFARE_DRAW_STATUS_NOT_DRAWD.equalsIgnoreCase(o.getWelfare_draw_status()))
									{
										fontColor = "green";
									}
						%>
						<font color="<%=fontColor%>"> <%=StringUtil.getNotEmptyStr(o.getWelfare_draw_status())%> </font>
					</td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_quantity())%></td>
					<td>
						<%
							if (o.getProduct_quantity_drawed() > 0)
									{
						%>
						<a href="#" onClick="openWindow('<%=contextPath%>/VWelfareDrawDetail/Servlet?method=list&villager_welfare_id=<%=o.getVillager_welfare_id()%>&product_id=<%=o.getProduct_id()%>')"> <%=StringUtil.getNotEmptyStr(o.getProduct_quantity_drawed())%> </a>
						<%
							} else
									{
						%>
						<%=StringUtil.getNotEmptyStr(o.getProduct_quantity_drawed())%>
						<%
							}
						%>
					</td>
					<td>
						<%=StringUtil.getNotEmptyStr(o.getProduct_quantity_remainder())%>
					</td>

				</tr>
				<%
					}
				%>
			</table>

			<!-- 翻页操作栏 -->
			<jsp:include page="../ToolBar/pagination_toolbar.jsp">
				<jsp:param name="basePath" value="<%=basePath%>" />
			</jsp:include>

			<%
				}
			%>
		</form>

	</body>
</html>
