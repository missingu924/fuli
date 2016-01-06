<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<%@page import="com.wuyg.common.obj.PaginationObj"%>
<%
	PaginationObj pagination = null;

	Object paginationObj = request.getAttribute("domainPagination");
	if (paginationObj != null)
	{
		pagination = (PaginationObj) paginationObj;
	}

	String basePath = request.getParameter("basePath");
%>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td align="right">
			<img src="../images/pagination_icons_save.png" title="导出全部数据" class="image_button" align="absmiddle" onClick="exportData('<%=pagination.getTotalCount()%>','<%=request.getContextPath()%>/<%=basePath%>/Servlet?method=export4this')" />
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input name="pageNo" type="hidden" id="pageNo" value="<%=pagination.getPageNo()%>" size="3" />
			<input name="pageCount" type="hidden" value="<%=pagination.getPageCount()%>" size="3" />
			<%
				if (pagination.isPrevious())
				{
			%>
			<img src="../images/pagination_icons_first.png" title="第一页" align="absmiddle" onClick="toPage(1);" class="image_button" />
			&nbsp;&nbsp;
			<img src="../images/pagination_icons_pre.png" title="上一页" align="absmiddle" onclick="toPage(<%=pagination.getPageNo() - 1%>);" class="image_button" />
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
			<img src="../images/pagination_icons_next.png" title="下一页" align="absmiddle" onclick="toPage(<%=pagination.getPageNo() + 1%>);" class="image_button" />
			&nbsp;&nbsp;
			<img src="../images/pagination_icons_last.png" title="最后页" align="absmiddle" onclick="toPage(<%=pagination.getTotalPage()%>);" class="image_button" />
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
			<img src="../images/pagination_icons_fresh.png"  title="刷新" align="absmiddle" onClick="toPage(1);" class="image_button" />
<font color="#666666">
			第<%=pagination.getPageNo()%>页&nbsp;&nbsp;共<%=pagination.getTotalPage()%>页<%=pagination.getTotalCount()%>条数据</font>
		</td>
	</tr>
</table>

<!-- JS函数 -->
<script>
	// 绑定enter事件
	$('body').keydown(function(){
	   if(event.keyCode == 13)
	   {
		 $("#pageForm").submit();
	   }
	});
</script>