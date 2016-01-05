package com.fuli;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fuli.dao.WelfarePolicyDAO;
import com.fuli.obj.WelfarePolicyDetailObj;
import com.fuli.obj.WelfarePolicyObj;
import com.fuli.searchcondition.WelfareObjSearchCondition;
import com.fuli.service.WelfarePolicyService;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.servlet.AbstractBaseServletTemplate;
import com.wuyg.common.util.StringUtil;

public class WelfarePolicyServlet extends AbstractBaseServletTemplate
{
	private IBaseDAO welfareDetailDAO = new DefaultBaseDAO(WelfarePolicyDetailObj.class);
	private WelfarePolicyService service = new WelfarePolicyService();

	@Override
	public String getBasePath()
	{
		return "WelfarePolicy";
	}

	@Override
	public IBaseDAO getDomainDao()
	{
		return new WelfarePolicyDAO(getDomainInstanceClz());
	}

	@Override
	public Class getDomainInstanceClz()
	{
		return WelfarePolicyObj.class;
	}

	@Override
	public Class getDomainSearchConditionClz()
	{
		return WelfareObjSearchCondition.class;
	}

	// 增加或修改福利政策
	public void addOrModifyWelfarePolicy(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		WelfarePolicyObj welfarePolicyObj = (WelfarePolicyObj) domainInstance;
		welfarePolicyObj.setLast_modify_account(currentUser.getAccount());
		welfarePolicyObj.setLast_modify_time(new Timestamp(System.currentTimeMillis()));
		
		if (!"true".equalsIgnoreCase(welfarePolicyObj.getWelfare_policy_for_all()))
		{
			welfarePolicyObj.setWelfare_policy_for_all("false");
		}

		// 福利明细
		List<WelfarePolicyDetailObj> dataList = new ArrayList<WelfarePolicyDetailObj>();
		for (int i = 0; i < 1000; i++)
		{
			String product_id = request.getParameter("product_id_" + i);
			
			if (StringUtil.isEmpty(product_id))
			{
				break;
			}
			
			long detail_id = Long.parseLong(StringUtil.getNotEmptyStr(request.getParameter("detail_id_" + i), "-1"));
			String product_name = request.getParameter("product_name_" + i);
			long product_quantity = Long.parseLong(StringUtil.getNotEmptyStr(request.getParameter("product_quantity_" + i), "-1"));
			String product_measuring_unit = request.getParameter("product_measuring_unit_" + i);
			double product_price = StringUtil.parseDouble(request.getParameter("product_price_" + i));
			String product_u_code = request.getParameter("product_u_code_" + i);
			String product_spec = request.getParameter("product_spec_" + i);

			WelfarePolicyDetailObj detailObj = new WelfarePolicyDetailObj();
			detailObj.setId(detail_id);
			detailObj.setProduct_name(product_name);
			detailObj.setWelfare_policy_id(welfarePolicyObj.getId());
			detailObj.setProduct_id(product_id);
			detailObj.setProduct_quantity(product_quantity);
			detailObj.setProduct_measuring_unit(product_measuring_unit);
			detailObj.setProduct_u_code(product_u_code);
			detailObj.setProduct_spec(product_spec);
			detailObj.setProduct_price(product_price);
			detailObj.setLast_modify_account(currentUser.getAccount());
			detailObj.setLast_modify_time(new Timestamp(System.currentTimeMillis()));

			dataList.add(detailObj);
		}
		welfarePolicyObj.setUsedDetailList(dataList);

		// 保存或修改
		boolean success = service.addOrModifyWelfarePolicy(welfarePolicyObj);
		
		// 声明是新增后转到的详情页面
		request.setAttribute("needRefresh", true);

		// 转向
		if (success)
		{
			detailWelfarePolicy(request, response);
			// list(request, response);
		} else
		{
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}

	public void detailWelfarePolicy(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		domainInstance = service.searchWealfarePolicyByKey(domainInstance.getKeyValue());

		request.setAttribute(DOMAIN_INSTANCE, domainInstance);

		// 转向
		if ("true".equalsIgnoreCase(request.getParameter("4m")))
		{
			request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_DETAIL + "4m.jsp").forward(request, response);
		} else
		{
			request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_DETAIL + ".jsp").forward(request, response);
		}
	}

	public void preAddOrModifyWelfarePolicy(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		domainInstance = service.searchWealfarePolicyByKey(domainInstance.getKeyValue());

		request.setAttribute(DOMAIN_INSTANCE, domainInstance);

		// 转向
		if ("true".equalsIgnoreCase(request.getParameter("4m")))
		{
			request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_ADD_OR_MODIFY + "4m.jsp").forward(request, response);
		} else
		{
			request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_ADD_OR_MODIFY + ".jsp").forward(request, response);
		}
	}

	public void deleteWelfarePolicy(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		boolean success = service.deleteWelfarePolicy(StringUtil.parseLong(domainInstanceKeyValue));

		// 转向
		if (success)
		{
			list(request, response);
		} else
		{
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}
	
	public void export4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// TODO Auto-generated method stub
		super.export(request, response);
	}
}
