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
<%@page import="com.fuli.obj.VWelfareDrawDetailObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<!-- 基本信息 -->
<%
	// 当前上下文路径
	String contextPath = request.getContextPath();
	// 当前用户
	AuthUser user = (AuthUser) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);

	// 该功能路径
	String basePath = "VWelfareDrawDetail";
	// 该功能对象实例
	VWelfareDrawDetailObj domainInstance = (VWelfareDrawDetailObj) request.getAttribute("domainInstance");
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>福利领取明细</title>
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
					<td width="80" align="right">
						福利政策
					</td>
					<td><%=DictionaryUtil.getSelectHtml(new DictionaryService().getDictItemsByDictName("welfarePolicy", true), "welfare_policy_id", "福利政策", StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_id()), "notEmpty")%></td>
					<td rowspan="3">
						<input name="searchButton" type="button" class="button button_search" value="查询" onClick="toPage(1)">
					</td>
				</tr>
				<tr>
					<td align="right">
						福利领取时间
					</td>
					<td>
						<input name="drawed_time_start" type="text" id="drawed_time_start" value="<%=StringUtil.getNotEmptyStr(domainInstance.getDrawed_time_start())%>" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})" />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input name="drawed_time_end" type="text" id="drawed_time_end" value="<%=StringUtil.getNotEmptyStr(domainInstance.getDrawed_time_end())%>" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'drawed_time_start\',{d:1})}'})" />
					</td>
				</tr>
				<tr>
					<td align="right">
						福利人身份证
					</td>
					<td>
						<input name="id_card" type="text" id="id_card" value="<%=StringUtil.getNotEmptyStr(domainInstance.getId_card())%>" size="20">
						福利人姓名
						<input name="villager_name" type="text" id="vilalger_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getVillager_name())%>" size="20">
						<input name="product_id" type="hidden" id="product_id" value="<%=StringUtil.getNotEmptyStr(domainInstance.getProduct_id())%>">
						<input name="villager_welfare_id" type="hidden" id="villager_welfare_id" value="<%=StringUtil.getNotEmptyStr(domainInstance.getVillager_welfare_id())%>">
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
							单号
						</th>
						<th>
							销售系统单号
						</th>
						<th>
							福利人
						</th>
						<th>
							福利人身份证
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
							人均数量
						</th>
						<th>
							本次领取数量
						</th>
						<th>
							领取人
						</th>
						<th>
							领取人身份证
						</th>
						<th>
							领取时间
						</th>
						<th>
							领取方式
						</th>
						<th>
							代领人
						</th>
					</tr>
				</thead>
				<%
					for (int i = 0; i < list.size(); i++)
						{
							VWelfareDrawDetailObj o = (VWelfareDrawDetailObj) list.get(i);
				%>
				<tr>
					<td><%=StringUtil.getNotEmptyStr(o.getDraw_id())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getT1_billsn())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getVillager_name())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getId_card())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_name())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_start_time_show())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_end_time_show())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_name())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_spec())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_measuring_unit())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_price())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_quantity())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_quantity_drawed())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getDraw_villager_name())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getDraw_villager_id_card())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getDraw_date_show())%></td>
					<td>
						<font color="<%=o.DRAW_TYP_OHTER.equalsIgnoreCase(o.getDraw_type()) ? "blue" : ""%>"> <%=StringUtil.getNotEmptyStr(o.getDraw_type())%> </font>
					</td>
					<td>
						<font color="blue"><%=StringUtil.getNotEmptyStr(o.getProxy_villager_name())%></font>
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
