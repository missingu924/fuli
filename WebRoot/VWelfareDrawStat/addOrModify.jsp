<%@ page contentType="text/html; charset=GBK" language="java" import="java.sql.*" errorPage=""%>
<%@page import="com.hz.auth.obj.AuthUser"%>
<%@page import="java.util.List"%>
<%@page import="com.hz.util.SystemConstant"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wuyg.common.obj.PaginationObj"%>
<%@page import="com.inspur.common.dictionary.util.DictionaryUtil"%>
<%@page import="com.hz.dict.service.DictionaryService"%>
<%@page import="com.hz.auth.service.AuthService"%>
<%@page import="com.hz.dict.service.IDictionaryService"%>
<%@page import="java.net.URLEncoder"%>

<%@page import="com.fuli.obj.VWelfareDrawStatObj"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<%
	
		String basePath="VWelfareDrawStat";// ÿ�����ܶ���ͬ
		VWelfareDrawStatObj domainInstance = new VWelfareDrawStatObj();
		
		String contextPath = request.getContextPath();
		
		// �û���Ϣ
		AuthUser user = (AuthUser) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);

		// ������޸ģ����ȡ������Ϣ
		Object domainInstanceObj = request.getAttribute("domainInstance");
		if (domainInstanceObj != null)
		{
			domainInstance = (VWelfareDrawStatObj)domainInstanceObj;
		}

		// �ֵ����
		IDictionaryService dict = new DictionaryService();

		// �Ƿ����޸�
		boolean isModify = domainInstance.getKeyValue()>0;
	%>
	<head>
		<base target="_self" />
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<title><%=isModify ? "�޸ĸ�����ȡͳ��" : "���Ӹ�����ȡͳ��"%></title>
		<link href="../style.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="../js/utils.js"></script>
		<script>
		//  �������޸�
		function addOrModify()
		{	
			// �޸��˺�
			if("true"=="<%=isModify%>")
			{
				submit();
			}
			// �½��˺�
			else
			{
				// ����Ҫ�ļ��
				if(!checkSomething("welfare_policy_id","null")) 
				{
					return false;
				} 
				else 
				{
				// Ȼ����ID�Ƿ��ѱ�ʹ��
					$.get(
					"Servlet?method=checkId&welfare_policy_id="+$("#welfare_policy_id").val(), 
					{Action:"get"}, 
					function (data, textStatus){
						this;
						if(data=="true") 
						{
							alert("��null��¼��ϵͳ"); 
							return false;
						}
						else
						{
							submit();
						}
					});
				};
			}
		}
		
		// �ύ������޸�
		function submit()
		{
						// ����˺ŷ���Ҫ����δ��ʹ�ã�������������
					if(!checkNull("welfare_policy_name","��������")) return false;
					if(!checkNull("product_name","��Ʒ����")) return false;
					if(!checkNull("product_spec","��Ʒ���")) return false;
					if(!checkNull("product_qunatity_sum","����ȡ����")) return false;
						$("#addOrModifyForm").submit();
		}
		</script>
	</head>
	<body>
		<form name="addOrModifyForm" id="addOrModifyForm" action="<%=contextPath%>/<%=basePath %>/Servlet?method=addOrModify" method="post">
		<div style="height:8px;"></div>
        <table width="500" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#3DAEB6">
          <tr>
            <td height="4" bgcolor="#3DAEB6"></td>
          </tr>
          <tr>
            <td height="25" align="center" class="green_font">��Ӹ�����ȡͳ��</td>
          </tr>
        </table>
			<table width="500" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#3DAEB6">
				<tr>
					<td bgcolor="#FFFFFF">
						<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
							<tr class="list_table_tr0">
								<td width="130" height="30" align="right" class="little_gray_font">null:</td>
								<td>
										<input name="welfare_policy_id" type="text" id="welfare_policy_id" value="<%=domainInstance.getKeyValue()%>"
											<%=isModify ? "readonly" : ""%> class="notEmpty">

										<%
											if (isModify)
											{
										%>
										<span class="red_font">(�����޸�)</span>
										<%
											} else
											{
										%>
										<%
											}
										%>
								</td>
							</tr>
							<tr class="list_table_tr2">
								<td width="130" height="30" align="right" class="little_gray_font"><%=domainInstance.getProperties().get("welfare_policy_name")%>:</td>
								<td>
										<input name="welfare_policy_name" type="text" id="welfare_policy_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getWelfare_policy_name())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr0">
								<td width="130" height="30" align="right" class="little_gray_font"><%=domainInstance.getProperties().get("product_name")%>:</td>
								<td>
										<input name="product_name" type="text" id="product_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getProduct_name())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr2">
								<td width="130" height="30" align="right" class="little_gray_font"><%=domainInstance.getProperties().get("product_spec")%>:</td>
								<td>
										<input name="product_spec" type="text" id="product_spec" value="<%=StringUtil.getNotEmptyStr(domainInstance.getProduct_spec())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="list_table_tr0">
								<td width="130" height="30" align="right" class="little_gray_font"><%=domainInstance.getProperties().get("product_qunatity_sum")%>:</td>
								<td>
										<input name="product_qunatity_sum" type="text" id="product_qunatity_sum" value="<%=StringUtil.getNotEmptyStr(domainInstance.getProduct_qunatity_sum())%>" class="notEmpty">
								</td>
							</tr>
							<tr class="tab_bg">
								<td height="30" colspan="2" align="center">
									<input name="Submit" type="button" class="gray_button" value="ȡ��" onClick="javascript:window.close();">
									&nbsp;
									<input name="Submit2" type="button" class="green_button" value="����" onClick="addOrModify()">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<script>
			// ��enter�¼�
			$('body').keydown(function(){
			   if(event.keyCode == 13)
			   {
				 addOrModify();
			   }
			});
		</script>
	</body>
</html>
