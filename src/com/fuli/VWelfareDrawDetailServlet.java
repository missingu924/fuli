package com.fuli;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.fuli.obj.VWelfareDrawDetailObj;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.obj.PaginationObj;
import com.wuyg.common.servlet.AbstractBaseServletTemplate;
import com.wuyg.common.util.MyBeanUtils;
import com.wuyg.common.util.RequestUtil;
import com.wuyg.common.util.StringUtil;

public class VWelfareDrawDetailServlet extends AbstractBaseServletTemplate
{
	private Logger logger = Logger.getLogger(getClass());

	@Override
	public String getBasePath()
	{
		return "VWelfareDrawDetail";
	}

	@Override
	public IBaseDAO getDomainDao()
	{
		return new DefaultBaseDAO(getDomainInstanceClz());
	}

	@Override
	public Class getDomainInstanceClz()
	{
		return com.fuli.obj.VWelfareDrawDetailObj.class;
	}

	@Override
	public Class getDomainSearchConditionClz()
	{
		return com.fuli.searchcondition.VWelfareDrawDetailObjSearchCondition.class;
	}

	// ��ѯ
	public void list4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// ��ѯ
		String where = getWhereClause();

		PaginationObj domainPagination = getDomainDao().searchPaginationByClause(domainInstance.getClass(), where, domainInstance.findDefaultOrderBy(),
				domainSearchCondition.getPageNo(), domainSearchCondition.getPageCount());

		request.setAttribute(DOMAIN_INSTANCE, domainInstance);
		request.setAttribute(DOMAIN_PAGINATION, domainPagination);

		// ת��
		if ("true".equalsIgnoreCase(request.getParameter("4m")))
		{
			request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_LIST + "4m.jsp").forward(request, response);
		} else
		{
			request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_LIST + ".jsp").forward(request, response);
		}
	}

	private String getWhereClause() throws Exception
	{
		VWelfareDrawDetailObj statObj = (VWelfareDrawDetailObj) domainInstance;

		String where = " 1=1 ";
		// 1�����ȰѷǿյĻ�������������
		where += MyBeanUtils.getWhereSqlFromBean(domainInstance, getDomainDao().getTableMetaData());

		// 2����������
		if (!StringUtil.isEmpty(statObj.getWelfare_policy_id() + ""))
		{
			where += " and welfare_policy_id='" + statObj.getWelfare_policy_id() + "'";
		}
		if (!StringUtil.isEmpty(statObj.getProduct_id()))
		{
			where += " and product_id='" + statObj.getProduct_id() + "'";
		}
		if (!StringUtil.isEmpty(statObj.getDrawed_time_start()))
		{
			where += " and datediff(s,draw_date,'" + statObj.getDrawed_time_start() + " 00:00:00')<=0";
		}
		if (!StringUtil.isEmpty(statObj.getDrawed_time_end()))
		{
			where += " and datediff(s,draw_date,'" + statObj.getDrawed_time_end() + " 23:59:59')>=0";
		}
		return where;
	}

	// ���ID�Ƿ���¼��ϵͳ
	public void checkId4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.checkId(request, response);
	}

	// ���� or �޸�
	public void addOrModify4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.addOrModify(request, response);
	}

	// �޸�ǰ��ѯ���������Ϣ
	private void preModify4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.preModify(request, response);
	}

	// ����
	public void detail4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.detail(request, response);
	}

	// ɾ��
	protected void delete4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.delete(request, response);
	}

	// ����
	public void export4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// ����ʱ�����������ŵ����ֵ

		String where = getWhereClause();

		PaginationObj domainPagination = getDomainDao().searchPaginationByClause(domainInstance.getClass(), where, domainInstance.findDefaultOrderBy(),
				domainSearchCondition.getPageNo(), domainSearchCondition.getPageCount());

		RequestUtil.downloadFile(this, response, domainPagination.getDataList(), domainInstance.getProperties(), "��ϸ");
	}

}
