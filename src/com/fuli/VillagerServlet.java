package com.fuli;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.MethodUtils;
import org.apache.log4j.Logger;

import com.fuli.obj.VillagerObj;
import com.fuli.obj.WelfarePolicyObj;
import com.fuli.searchcondition.VillagerObjSearchCondition;
import com.fuli.service.VillagerService;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.obj.PaginationObj;
import com.wuyg.common.servlet.AbstractBaseServletTemplate;
import com.wuyg.common.util.StringUtil;

public class VillagerServlet extends AbstractBaseServletTemplate
{
	private Logger logger = Logger.getLogger(getClass());

	private VillagerService service = new VillagerService();

	@Override
	public String getBasePath()
	{
		return "Villager";
	}

	@Override
	public IBaseDAO getDomainDao()
	{
		return new DefaultBaseDAO(getDomainInstanceClz());
	}

	@Override
	public Class getDomainInstanceClz()
	{
		return VillagerObj.class;
	}

	@Override
	public Class getDomainSearchConditionClz()
	{
		return VillagerObjSearchCondition.class;
	}

	// 检查身份证号是否已录入系统
	public void checkIdCard(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		PaginationObj pagination = getDomainDao().searchPaginationByDomainInstance(domainInstance, null, 0, 1);
		if (pagination.getDataList().size() > 0)
		{
			response.getWriter().write("true");
			response.flushBuffer();
		}
	}

	// 增加或修改村民信息
	public void addOrModifyVillager(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		VillagerObj villagerObj = (VillagerObj) domainInstance;
		villagerObj.setLast_modify_account(currentUser.getAccount());//当前登陆用户
		villagerObj.setLast_modify_time(new Timestamp(System.currentTimeMillis()));//当前时间

		// 福利政策
		List<WelfarePolicyObj> dataList = new ArrayList<WelfarePolicyObj>();

		String[] welfare_policy_ids = request.getParameterValues("welfare_policy_id");
		if (welfare_policy_ids != null)
		{
			for (int i = 0; i < welfare_policy_ids.length; i++)
			{
				WelfarePolicyObj welfarePolicyObj = new WelfarePolicyObj();
				welfarePolicyObj.setId(StringUtil.parseLong(welfare_policy_ids[i]));
				welfarePolicyObj.setLast_modify_account(currentUser.getAccount());
				welfarePolicyObj.setLast_modify_time(new Timestamp(System.currentTimeMillis()));

				dataList.add(welfarePolicyObj);
			}
		}
		villagerObj.setUsedWelfareList(dataList);

		// 保存或修改
		boolean success = service.addOrModifyVillager(villagerObj);
		
		// 声明是新增后转到的详情页面
		request.setAttribute("needRefresh", true);

		// 转向
		if (success)
		{
			detailVillager(request, response);
			// list(request, response);
		} else
		{
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}

	public void detailVillager(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		domainInstance = service.searchVillagerByKey(domainInstance.getKeyValue());

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

	public void preAddOrModifyVillager(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		domainInstance = service.searchVillagerByKey(domainInstance.getKeyValue());

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

	public void deleteVillager(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		boolean success = service.deleteVillager(StringUtil.parseLong(domainInstanceKeyValue));

		// 转向
		if (success)
		{
			list(request, response);
		} else
		{
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}
	
	public void unbind(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		service.unbind(domainInstance.getKeyValue());
		
		list(request, response);
	}
	
	public void export4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.export(request, response);
	}

	public static void main(String[] args)
	{
		try
		{
			VillagerServlet s = new VillagerServlet();

			s.list(null, null);

			MethodUtils.invokeMethod(s, "list", null);
		} catch (Exception e)
		{
			e.printStackTrace();
		}

	}
}
