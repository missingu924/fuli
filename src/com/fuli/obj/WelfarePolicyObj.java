package com.fuli.obj;

import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.util.LunarCalendar;
import com.wuyg.common.util.StringUtil;
import com.wuyg.common.util.TimeUtil;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

public class WelfarePolicyObj extends BaseDbObj
{
	private Long id;
	private String welfare_policy_name;
	private Timestamp welfare_policy_start_time;
	private Timestamp welfare_policy_end_time;
	private Timestamp last_modify_time;
	private String last_modify_account;
	private String welfare_policy_comment;
	private String welfare_policy_for_all;// 所有村民都享受，默认为否

	private List<WelfarePolicyDetailObj> usedDetailList = new ArrayList<WelfarePolicyDetailObj>();
	private List<ProductObj> notUseProductList = new ArrayList<ProductObj>();

	private String welfare_policy_status = null;
	private String welfare_policy_status_color = null;

	public static final String STATUS_OVERDUE = "已过期";
	public static final String STATUS_NOT_START = "未开始";
	public static final String STATUS_GRANTING = "发放中";
	public static final String STATUS_WAITING_TO_GRANNT = "待发放";

	@Override
	public String findKeyColumnName()
	{
		return "id";
	}

	@Override
	public String findParentKeyColumnName()
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String findTableName()
	{
		return "welfare_policy";
	}

	@Override
	public String getBasePath()
	{
		// TODO Auto-generated method stub
		return "WelfarePolicy";
	}

	@Override
	public String getCnName()
	{
		return "福利政策";
	}

	@Override
	public String findDefaultOrderBy()
	{
		return " WELFARE_POLICY_START_TIME desc";
	}

	public String getWelfare_policy_for_all_show()
	{
		return "true".equalsIgnoreCase(welfare_policy_for_all) ? "是" : "否";
	}

	public LinkedHashMap<String, String> getProperties()
	{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("id", "编号");
		pros.put("welfare_policy_name", "福利政策名称");
		pros.put("year_lunar", "福利年份");
		pros.put("welfare_policy_start_time", "福利生效时间");
		pros.put("welfare_policy_end_time", "福利过期时间");
		pros.put("welfare_policy_comment", "备注信息");
		pros.put("welfare_policy_for_all_show", "所有村民都享受");
		pros.put("welfare_policy_status", "福利状态");

		// pros.put("last_modify_time", "last_modify_time");
		// pros.put("last_modify_account", "last_modify_account");
		return pros;
	}

	// 获取福利政策的状态:未发放、发放中、已过期
	public String getWelfare_policy_status()
	{
		if (welfare_policy_status == null && id != null)
		{
			IBaseDAO VWelfareDrawDetailDao = new DefaultBaseDAO(VWelfareDrawDetailObj.class);

			// 已过期：根据福利政策的结束时间判定
			if (System.currentTimeMillis() - welfare_policy_end_time.getTime() > 0)
			{
				welfare_policy_status = STATUS_OVERDUE;
			}
			// 未开始：根据福利政策的开始时间判定
			else if (System.currentTimeMillis() - welfare_policy_start_time.getTime() < 0)
			{
				welfare_policy_status = STATUS_NOT_START;
			}
			// 发放中：未过期且已经有该福利政策的发放记录
			else if (VWelfareDrawDetailDao.searchByClause(VWelfareDrawStatObj.class, "welfare_policy_id='" + id + "'", null, 0, 1).size() > 0)
			{
				welfare_policy_status = STATUS_GRANTING;
			}
			// 未发放：未过期且还没有改福利政策的发放记录
			else
			{
				welfare_policy_status = STATUS_WAITING_TO_GRANNT;
			}

		}

		return welfare_policy_status;
	}

	// 获取福利状态字体颜色
	public String getWelfare_status_color()
	{
		welfare_policy_status = getWelfare_policy_status();

		if (welfare_policy_status_color == null)
		{
			if (WelfarePolicyObj.STATUS_OVERDUE.equalsIgnoreCase(welfare_policy_status))
			{
				welfare_policy_status_color = "red";
			} else if (WelfarePolicyObj.STATUS_NOT_START.equalsIgnoreCase(welfare_policy_status))
			{
				welfare_policy_status_color = "orange";
			} else if (WelfarePolicyObj.STATUS_WAITING_TO_GRANNT.equalsIgnoreCase(welfare_policy_status))
			{
				welfare_policy_status_color = "blue";
			} else if (WelfarePolicyObj.STATUS_GRANTING.equalsIgnoreCase(welfare_policy_status))
			{
				welfare_policy_status_color = "green";
			}
		}

		return welfare_policy_status_color;
	}

	public boolean canModify()
	{
		// 未到开始时间 或者 已到开始时间但是还未发放的 可以修改
		return getWelfare_policy_status().equalsIgnoreCase(STATUS_NOT_START) || getWelfare_policy_status().equalsIgnoreCase(STATUS_WAITING_TO_GRANNT);
	}

	public boolean canUse()
	{
		// 未过期的都可以用
		return !getWelfare_policy_status().equalsIgnoreCase(STATUS_OVERDUE);
	}

	public String getWelfare_policy_for_all()
	{
		return welfare_policy_for_all;
	}

	public void setWelfare_policy_for_all(String welfare_policy_for_all)
	{
		this.welfare_policy_for_all = welfare_policy_for_all;
	}

	public String getWelfare_policy_comment()
	{
		return welfare_policy_comment;
	}

	public void setWelfare_policy_comment(String welfare_policy_comment)
	{
		this.welfare_policy_comment = welfare_policy_comment;
	}

	public List<WelfarePolicyDetailObj> getUsedDetailList()
	{
		return usedDetailList;
	}

	public void setUsedDetailList(List<WelfarePolicyDetailObj> usedDetailList)
	{
		this.usedDetailList = usedDetailList;
	}

	public List<ProductObj> getNotUseProductList()
	{
		return notUseProductList;
	}

	public void setNotUseProductList(List<ProductObj> notUseProductList)
	{
		this.notUseProductList = notUseProductList;
	}

	public String getWelfare_policy_start_time_show()
	{
		return TimeUtil.date2str(this.welfare_policy_start_time, "yyyy-MM-dd");
	}

	public String getWelfare_policy_end_time_show()
	{
		return TimeUtil.date2str(this.welfare_policy_end_time, "yyyy-MM-dd");
	}

	public Timestamp getWelfare_policy_start_time()
	{
		return welfare_policy_start_time;
	}

	// 获取农历
	public String getWelfare_policy_start_time_lunar()
	{
		try
		{
			return LunarCalendar.solarToLunar(this.welfare_policy_start_time);
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return "";
	}

	public void setWelfare_policy_start_time(Timestamp welfare_policy_start_time)
	{
		this.welfare_policy_start_time = welfare_policy_start_time;
	}

	public Timestamp getWelfare_policy_end_time()
	{
		return welfare_policy_end_time;
	}

	// 获取农历
	public String getWelfare_policy_end_time_lunar()
	{
		try
		{
			return LunarCalendar.solarToLunar(this.welfare_policy_end_time);
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return "";
	}

	public void setWelfare_policy_end_time(Timestamp welfare_policy_end_time)
	{
		this.welfare_policy_end_time = welfare_policy_end_time;
	}

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}

	public String getYear_lunar()
	{
		String lunarDay = LunarCalendar.solarToLunar(this.welfare_policy_start_time != null ? this.welfare_policy_start_time : null);

		if (StringUtil.isEmpty(lunarDay))
		{
			return "";
		} else
		{
			return lunarDay.substring(0, 4);// 只要年份
		}
	}

	public String getWelfare_policy_name()
	{
		return welfare_policy_name;
	}

	public void setWelfare_policy_name(String welfare_policy_name)
	{
		this.welfare_policy_name = welfare_policy_name;
	}

	public Timestamp getLast_modify_time()
	{
		return last_modify_time;
	}

	public void setLast_modify_time(Timestamp last_modify_time)
	{
		this.last_modify_time = last_modify_time;
	}

	public String getLast_modify_account()
	{
		return last_modify_account;
	}

	public void setLast_modify_account(String last_modify_account)
	{
		this.last_modify_account = last_modify_account;
	}
}
