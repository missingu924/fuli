<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 --> 
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.common.obj.PaginationObj"%> 
<%@page import="com.inspur.common.dictionary.util.DictionaryUtil"%> 
<%@page import="com.hz.dict.service.DictionaryService"%>
<%@page import="com.fuli.obj.WelfarePolicyObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%> 
<!-- 基本信息 --> 
<% 
	// 当前上下文路径 
	String contextPath = request.getContextPath(); 
 
	// 该功能对象实例 
	WelfarePolicyObj domainInstance = (WelfarePolicyObj) request.getAttribute("domainInstance"); 
	// 该功能路径 
	String basePath = domainInstance.getBasePath(); 
%> 
<html> 
	<head> 
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
		<title><%=domainInstance.getCnName() %>列表</title>
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
						<%=domainInstance.getPropertyCnName("welfare_policy_name") %> 
						<input name="welfare_policy_name" type="text" id="welfare_policy_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_name())%>" size="20" > 
						&nbsp; 
						<input name="searchButton" type="button" class="button button_search" value="查询" onClick="toPage(1)"> 
					</td> 
					<td align="right"> 
						<input name="addButton" type="button" class="button button_add" value="增加" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=preAddOrModifyWelfarePolicy')"> 
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
						<th>
							编号
						</th>
						<th>
							福利政策名称
						</th>
						<th>
							福利年份
						</th>
						<th>
							福利生效时间
						</th>
						<th>
							福利过期时间
						</th>
						<th>
							所有村民都享受
						</th>
						<th>
							福利状态
						</th>
						<th>
							操作
						</th>
					</tr> 
				</thead> 
				<% 
					for (int i = 0; i < list.size(); i++) 
						{ 
							WelfarePolicyObj o = (WelfarePolicyObj) list.get(i); 
				%> 
				
				<tr>
					<td><%=StringUtil.getNotEmptyStr(o.getId())%></td>
					<td>
						<a href="#"
							onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=detailWelfarePolicy&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')"><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_name())%></a>
					</td>
					<td>
					<!-- <%=StringUtil.getNotEmptyStr(o.getYear_lunar())%> -->
					<%=StringUtil.getNotEmptyStr(TimeUtil.date2str(o.getWelfare_policy_start_time(),"yyyy"))%>
					</td>
					<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_start_time_show())%>
						<!--
						&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="little_gray_font">农历<%=StringUtil.getNotEmptyStr(o.getWelfare_policy_start_time_lunar())%></span>
						-->
					</td>
					<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_end_time_show())%>
						<!-- 
						&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="little_gray_font">农历<%=StringUtil.getNotEmptyStr(o.getWelfare_policy_end_time_lunar())%></span>
					 	-->
					</td>
					<td>
						<%
							boolean welfare_policy_for_all = "true".equalsIgnoreCase(o.getWelfare_policy_for_all());
									{
						%>
						<font color="<%=welfare_policy_for_all ? "green" : ""%>"> <%=welfare_policy_for_all ? "是" : "否"%>
						</font>
						<%
							}
						%>
					
					<td>
						<a href="#"
							onclick="openBigModalDialog('<%=contextPath%>/VWelfareForDrawDetail/Servlet?method=list&welfare_policy_id=<%=o.getId()%>')">
							<font color="<%=o.getWelfare_status_color()%>"> <%=StringUtil.getNotEmptyStr(o.getWelfare_policy_status())%>
						</font> </a>
					</td>
					<td width="90" align="center" style="padding: 0; cursor: pointer">
						<%
							if (o.canModify())
									{
						%>
						<input type="button" class="button button_modify" title="修改" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=preAddOrModifyWelfarePolicy&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')" />
						<input type="button" class="button button_delete" title="删除"
							onClick="javascript:
								$('#pageForm').attr('action','<%=contextPath%>/<%=basePath%>/Servlet?method=deleteWelfarePolicy&<%=o.findKeyColumnName()%>_4del=<%=o.getKeyValue()%>');
								$('#pageForm').submit();
								" />
						<%
							} else
									{
						%>
						不允许操作
						<%
							}
						%>
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
		 <br />
		&nbsp;【福利状态说明】
		<br />
		<font color="orange">&nbsp;&nbsp;(1)&nbsp;&nbsp;<%=WelfarePolicyObj.STATUS_NOT_START%>:还没有到该福利政策设置的开始时间
		</font>
		<br />
		<font color="blue">&nbsp;&nbsp;(2)&nbsp;&nbsp;<%=WelfarePolicyObj.STATUS_WAITING_TO_GRANNT%>:已到该福利政策设置的开始时间但还未发放
		</font>
		<br />
		<font color="green">&nbsp;&nbsp;(3)&nbsp;&nbsp;<%=WelfarePolicyObj.STATUS_GRANTING%>:该福利政策正在发放过程中
		</font>
		<br />
		<font color="red">&nbsp;&nbsp;(4)&nbsp;&nbsp;<%=WelfarePolicyObj.STATUS_OVERDUE%>:该福利政策已过期
		</font>
		<br />
	</body> 
</html> 
