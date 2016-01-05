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

	// 查询
	public void list4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 查询
		String where = getWhereClause();

		PaginationObj domainPagination = getDomainDao().searchPaginationByClause(domainInstance.getClass(), where, domainInstance.findDefaultOrderBy(),
				domainSearchCondition.getPageNo(), domainSearchCondition.getPageCount());

		request.setAttribute(DOMAIN_INSTANCE, domainInstance);
		request.setAttribute(DOMAIN_PAGINATION, domainPagination);

		// 转向
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
		// 1、首先把非空的基本条件设置上
		where += MyBeanUtils.getWhereSqlFromBean(domainInstance, getDomainDao().getTableMetaData());

		// 2、复杂条件
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

	// 检查ID是否已录入系统
	public void checkId4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.checkId(request, response);
	}

	// 增加 or 修改
	public void addOrModify4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.addOrModify(request, response);
	}

	// 修改前查询领域对象信息
	private void preModify4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.preModify(request, response);
	}

	// 详情
	public void detail4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.detail(request, response);
	}

	// 删除
	protected void delete4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.delete(request, response);
	}

	// 导出
	public void export4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 导出时不限条数，放到最大值

		String where = getWhereClause();

		PaginationObj domainPagination = getDomainDao().searchPaginationByClause(domainInstance.getClass(), where, domainInstance.findDefaultOrderBy(),
				domainSearchCondition.getPageNo(), domainSearchCondition.getPageCount());

		RequestUtil.downloadFile(this, response, domainPagination.getDataList(), domainInstance.getProperties(), "明细");
	}

}
