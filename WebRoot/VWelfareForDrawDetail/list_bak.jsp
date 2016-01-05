<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
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
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>福利领取明细列表</title>
		<link href="../style.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="../js/utils.js"></script>
		
		<%
			String basePath="VWelfareForDrawDetail";// 每个功能都不同
			VWelfareForDrawDetailObj domainInstance = (VWelfareForDrawDetailObj)request.getAttribute("domainInstance");

			String contextPath = request.getContextPath();
			AuthUser user = (AuthUser) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);
		%>
	</head>

	<body>

		<form name="pageForm" id="pageForm" method="post" action="<%=request.getContextPath()%>/<%=basePath%>/Servlet?method=list">
			<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td height="9px"></td>
				</tr>
			</table>
			<table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#3DAEB6">
				<tr>
					<td>
						<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
							<tr class="list_table_tr2">
								<td align="left">
								福利政策
									<%=DictionaryUtil.getSelectHtml(new
											DictionaryService().getDictItemsByDictName("welfarePolicy", true),
											"welfare_policy_id", "福利政策",
											StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_id()),
											"notEmpty")%>&nbsp;
									身份证 <input name="id_card" type="text" id="id_card" value="<%=StringUtil.getNotEmptyStr(domainInstance.getId_card())%>" size="20">
									&nbsp;
									姓名 <input name="villager_name" type="text" id="villager_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getVillager_name())%>" size="20">
									<!-- 
									<%=DictionaryUtil.getSelectHtml(new
											DictionaryService().getDictItemsByDictName("allVillager", true), "villager_id",
											"姓名", StringUtil.getNotEmptyStr(domainInstance.getVillager_id()),
											"notEmpty")%> -->
									&nbsp;
									领取情况
									<%=DictionaryUtil.getSelectHtml(new
											DictionaryService().getDictItemsByDictName("welfareDrawStatus", true),
											"welfare_draw_status", "领取情况",
											StringUtil.getNotEmptyStr(domainInstance.getWelfare_draw_status()),
											"notEmpty")%>&nbsp;
									<input name="searchButton" type="button" class="blue_button" value="查询" onClick="toPage(1)">
							  	</td>
							    <td align="right">
							      
							    </td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td height="10px"></td>
				</tr>
			</table>
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
			<table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
				<tr class="list_table_head">
					<td>村民姓名</td>
					<td>身份证号</td>
					<td>福利政策</td>
					<td>福利生效时间</td>
					<td>福利过期时间</td>
					<td>产品名称</td>
					<td>产品规格</td>
					<td>产品单位</td>
					<td>产品单价</td>
					<td>领取情况</td>
					<td>应领数量</td>
					<td>已领数量</td>
					<td>未领数量</td>
				</tr>
				<%
					for (int i = 0; i < list.size(); i++)
						{
							VWelfareForDrawDetailObj o = (VWelfareForDrawDetailObj)list.get(i);
				%>
				<tr class="<%=i % 2 == 0 ? "list_table_tr0" : "list_table_tr1"%>">
					<td>
						<a href="#" onClick="openBigModalDialog('<%=contextPath%>/Villager/Servlet?method=detailVillager&id=<%=o.getVillager_id() %>')">
						<%=StringUtil.getNotEmptyStr(o.getVillager_name())%>
						</a>
					</td>
					<td><%=StringUtil.getNotEmptyStr(o.getId_card())%></td>
					<td>
						<a href="#" onClick="openBigModalDialog('<%=contextPath%>/WelfarePolicy/Servlet?method=detailWelfarePolicy&id=<%=o.getWelfare_policy_id() %>')">
						<%=StringUtil.getNotEmptyStr(o.getWelfare_policy_name())%>
						</a>
					</td>
					<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_start_time_show())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getWelfare_policy_end_time_show())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_name())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_spec())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_measuring_unit())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_price())%></td>
					<td>
						<%String fontColor="red";
						if(o.WELFARE_DRAW_STATUS_DRAWD_PART.equalsIgnoreCase(o.getWelfare_draw_status()))
						{fontColor="blue";}
						else
						if(o.WELFARE_DRAW_STATUS_NOT_DRAWD.equalsIgnoreCase(o.getWelfare_draw_status()))
						{fontColor="green";}
						%>
						<font color="<%=fontColor %>">
						<%=StringUtil.getNotEmptyStr(o.getWelfare_draw_status())%>
						</font>
					</td>
					<td><%=StringUtil.getNotEmptyStr(o.getProduct_quantity())%></td>
					<td>
					<%if(o.getProduct_quantity_drawed()>0){ %>
					<a href="#" onClick="openWindow('<%=contextPath%>/VWelfareDrawDetail/Servlet?method=list&villager_welfare_id=<%=o.getVillager_welfare_id()%>&product_id=<%=o.getProduct_id() %>')">
					<%=StringUtil.getNotEmptyStr(o.getProduct_quantity_drawed()) %>
					</a>
					<%} else { %>
					<%=StringUtil.getNotEmptyStr(o.getProduct_quantity_drawed()) %>
					<%} %>
					</td>
					<td>	
					<%=StringUtil.getNotEmptyStr(o.getProduct_quantity_remainder())%>
					</td>
					
				</tr>
				<%
					}
				%>
				<tr class="list_table_foot">
					<td colspan="13">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center">
							<tr>
								<td align="right">
									<img src="../images/pagination_icons_save.png"  title="导出全部数据"  class="image_button" align="absmiddle" onClick="exportData('<%=pagination.getTotalCount()%>','<%=request.getContextPath()%>/<%=basePath%>/Servlet?method=export')" />
									&nbsp;&nbsp;&nbsp;&nbsp;
									<input name="pageNo" type="hidden" id="pageNo" value="<%=pagination.getPageNo()%>" size="3" />
									<input name="pageCount" type="hidden" value="<%=pagination.getPageCount()%>" size="3" />
									<%
										if (pagination.isPrevious())
											{
									%>
									<img src="../images/pagination_icons_first.png" align="absmiddle" onClick="toPage(1);" />
									&nbsp;&nbsp;
									<img src="../images/pagination_icons_pre.png" align="absmiddle" onclick="toPage(<%=pagination.getPageNo() - 1%>);" />
									&nbsp;&nbsp;
									<%
										} else
											{
									%>
									<img src="../images/pagination_icons_first_gray.png" align="absmiddle" />
									&nbsp;&nbsp;
									<img src="../images/pagination_icons_pre_gray.png" align="absmiddle" />
									&nbsp;&nbsp;
									<%
										}
									%>
									<%
										if (pagination.isNext())
											{
									%>
									<img src="../images/pagination_icons_next.png" align="absmiddle" onclick="toPage(<%=pagination.getPageNo() + 1%>);" />
									&nbsp;&nbsp;
									<img src="../images/pagination_icons_last.png" align="absmiddle" onclick="toPage(<%=pagination.getTotalPage()%>);" />
									&nbsp;&nbsp;
									<%
										} else
											{
									%>
									<img src="../images/pagination_icons_next_gray.png" align="absmiddle" />
									&nbsp;&nbsp;
									<img src="../images/pagination_icons_last_gray.png" align="absmiddle" />
									&nbsp;&nbsp;
									<%
										}
									%>
									<img src="../images/pagination_icons_fresh.png" align="absmiddle" onClick="toPage(1);" />
								</td>
								<td width="180" align="right" valign="middle">
								
								&nbsp;&nbsp;每页<%=pagination.getPageCount()%>条&nbsp;第<%=pagination.getPageNo()%>/<%=pagination.getTotalPage()%>页&nbsp;共<%=pagination.getTotalCount()%>条数据&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<%
				}
			%>
		</form>
		<script>
			// 绑定enter事件
			$('body').keydown(function(){
			   if(event.keyCode == 13)
			   {
				 $("#pageForm").submit();
			   }
			});
		</script>
	</body>
</html>
