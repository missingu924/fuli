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
<%@page import="com.fuli.obj.VWelfareDrawStatObj"%>
<%@page import="com.wuyg.common.licence.TimeUtil"%>

<!-- 基本信息 -->
<%
	// 当前上下文路径
	String contextPath = request.getContextPath();
	// 当前用户
	AuthUser user = (AuthUser) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);

	// 该功能路径
	String basePath = "VWelfareDrawStat";
	// 该功能对象实例
	VWelfareDrawStatObj domainInstance = (VWelfareDrawStatObj) request.getAttribute("domainInstance");
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>福利领取统计列表</title>
		<link href="../style.css" rel="stylesheet" type="text/css">
		<link href="../table.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="../js/utils.js"></script>
		<script src="../My97DatePicker/WdatePicker.js"></script>
	</head>
	<body>

		<form name="pageForm" id="pageForm" method="post" action="<%=request.getContextPath()%>/<%=basePath%>/Servlet?method=list4this">

			<!-- 查询条件 -->
			<table class="search_table" align="center" width="98%">
				<tr>
					<td align="left">
						福利领取时间&nbsp;
						<input name="drawed_time_start" type="text" id="drawed_time_start" value="<%=StringUtil.getNotEmptyStr(domainInstance.getDrawed_time_start(), TimeUtil.date2str(TimeUtil.getTheFirstDayOfTheMonth(), "yyyy-MM-dd"))%>"
							onfocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})" />
						至
						<input name="drawed_time_end" type="text" id="drawed_time_end" value="<%=StringUtil.getNotEmptyStr(domainInstance.getDrawed_time_end(), TimeUtil.date2str(TimeUtil.getToday(), "yyyy-MM-dd"))%>"
							onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'drawed_time_start\',{d:1})}'})" />
						&nbsp;
						<input name="searchButton" type="button" class="blue_button" value=" 查询 " onClick="toPage(1)">
					</td>
					<td align="right">

					</td>
				</tr>
			</table>


			<!-- 查询结果 -->
			<%
				// 数据信息
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
							福利政策
						</th>
						<th>
							产品名称
						</th>
						<th>
							产品规格
						</th>
						<th>
							已领取数量
						</th>
					</tr>
				</thead>
				<%
					for (int i = 0; i < list.size(); i++)
						{
							VWelfareDrawStatObj o = (VWelfareDrawStatObj) list.get(i);
				%>
				<tr>
					<td>
						<a href="#" onClick="openBigModalDialog('<%=contextPath%>/WelfarePolicy/Servlet?method=detailWelfarePolicy&id=<%=o.getWelfare_policy_id()%>')"> <%=StringUtil.getNotEmptyStr(o.getWelfare_policy_name())%> </a>
					</td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_name())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_spec())%></td>
					<td>
						<a href="#"
							onClick="openWindow('<%=contextPath%>/VWelfareDrawDetail/Servlet?method=list4this&welfare_policy_id=<%=o.getWelfare_policy_id()%>&product_id=<%=o.getProduct_id()%>&drawed_time_start=<%=StringUtil.getNotEmptyStr(domainInstance.getDrawed_time_start())%>&drawed_time_end=<%=StringUtil.getNotEmptyStr(domainInstance.getDrawed_time_end())%>')">
							<%=StringUtil.getNotEmptyStr(o.getProduct_qunatity_sum())%> </a>
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
	</body>
</html>
