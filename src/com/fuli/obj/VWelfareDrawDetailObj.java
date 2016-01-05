package com.fuli.obj;

import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import com.wuyg.common.util.TimeUtil;

import java.util.LinkedHashMap;

;
public class VWelfareDrawDetailObj extends BaseDbObj
{
	private Long id;
	private Long draw_id;
	private String draw_type;
	private Timestamp draw_date;
	private String proxy_villager_name;
	private String draw_comment;
	private String t1_billsn;
	private Long draw_villager_id;
	private String draw_villager_id_card;
	private String draw_villager_name;
	private Long villager_id;
	private String id_card;
	private String villager_name;
	private Long villager_welfare_id;
	private Long welfare_policy_id;
	private String welfare_policy_name;
	private Timestamp welfare_policy_start_time;
	private Timestamp welfare_policy_end_time;
	private Long welfare_policy_detail_id;
	private String product_id;
	private String product_name;
	private String product_spec;
	private Long product_quantity;
	private String product_measuring_unit;
	private Long product_quantity_drawed;
	private Double product_price;
	private String drawed_time_start;// 查询条件，福利领取时间-开始时间，必须用static，以便构造sql
	private String drawed_time_end;// 查询条件，福利领取时间-结束时间，必须用static，以便构造sql

	public static final String DRAW_TYP_SELF = "本人自领";
	public static final String DRAW_TYP_OHTER = "他人代领";

	@Override
	public String findKeyColumnName()
	{
		// TODO Auto-generated method stub
		return "id";
	}

	@Override
	public String findParentKeyColumnName()
	{
		// TODO Auto-generated method stub
		return "draw_id";
	}

	@Override
	public String findTableName()
	{
		return "v_welfare_draw_detail";
	}

	@Override
	public String getBasePath()
	{
		// TODO Auto-generated method stub
		return "VWelfareDrawDetail";
	}

	@Override
	public String getCnName()
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String findDefaultOrderBy()
	{
		return "draw_id desc,id asc";
	}

	public LinkedHashMap<String, String> getProperties()
	{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		// pros.put("id", "编号");
		pros.put("draw_id", "单号");
		pros.put("t1_billsn", "销售系统单号");
		pros.put("villager_name", "福利人");
		pros.put("id_card", "福利人身份证");
		pros.put("welfare_policy_name", "福利政策");
		pros.put("welfare_policy_start_time", "福利生效时间");
		pros.put("welfare_policy_end_time", "福利过期时间");
		pros.put("product_name", "产品名称");
		pros.put("product_measuring_unit", "产品规格");
		pros.put("product_price", "产品单价");
		pros.put("product_quantity", "人均数量");
		pros.put("product_quantity_drawed", "本次领取数量");

		// pros.put("draw_villager_id", "领取人编号");
		pros.put("draw_villager_name", "领取人");
		pros.put("draw_villager_id_card", "领取人身份证");
		pros.put("draw_date_show", "领取时间");
		pros.put("draw_type", "领取方式");
		pros.put("proxy_villager_name", "代领人");
		

		// pros.put("villager_id", "福利人编号");

		// pros.put("welfare_policy_id", "福利政策编号");

		// pros.put("welfare_policy_detail_id", "福利政策明细编号");
		// pros.put("product_id", "产品编号");

		return pros;
	}

	public Double getProduct_price()
	{
		return product_price;
	}

	public void setProduct_price(Double product_price)
	{
		this.product_price = product_price;
	}

	public String getDrawed_time_start()
	{
		return drawed_time_start;
	}

	public void setDrawed_time_start(String drawed_time_start)
	{
		this.drawed_time_start = drawed_time_start;
	}

	public String getDrawed_time_end()
	{
		return drawed_time_end;
	}

	public void setDrawed_time_end(String drawed_time_end)
	{
		this.drawed_time_end = drawed_time_end;
	}

	public String getProduct_spec()
	{
		return product_spec;
	}

	public void setProduct_spec(String product_spec)
	{
		this.product_spec = product_spec;
	}

	public String getProxy_villager_name()
	{
		return proxy_villager_name;
	}

	public void setProxy_villager_name(String proxy_villager_name)
	{
		this.proxy_villager_name = proxy_villager_name;
	}

	public String getDraw_comment()
	{
		return draw_comment;
	}

	public void setDraw_comment(String draw_comment)
	{
		this.draw_comment = draw_comment;
	}

	public Long getVillager_welfare_id()
	{
		return villager_welfare_id;
	}

	public void setVillager_welfare_id(Long villager_welfare_id)
	{
		this.villager_welfare_id = villager_welfare_id;
	}

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}

	public Long getDraw_id()
	{
		return draw_id;
	}

	public void setDraw_id(Long draw_id)
	{
		this.draw_id = draw_id;
	}

	public String getDraw_type()
	{
		return draw_type;
	}

	public void setDraw_type(String draw_type)
	{
		this.draw_type = draw_type;
	}

	public Timestamp getDraw_date()
	{
		return draw_date;
	}

	public String getDraw_date_show()
	{
		return TimeUtil.date2str(draw_date);
	}

	public void setDraw_date(Timestamp draw_date)
	{
		this.draw_date = draw_date;
	}

	public Long getDraw_villager_id()
	{
		return draw_villager_id;
	}

	public void setDraw_villager_id(Long draw_villager_id)
	{
		this.draw_villager_id = draw_villager_id;
	}

	public String getDraw_villager_id_card()
	{
		return draw_villager_id_card;
	}

	public void setDraw_villager_id_card(String draw_villager_id_card)
	{
		this.draw_villager_id_card = draw_villager_id_card;
	}

	public String getDraw_villager_name()
	{
		return draw_villager_name;
	}

	public void setDraw_villager_name(String draw_villager_name)
	{
		this.draw_villager_name = draw_villager_name;
	}

	public Long getVillager_id()
	{
		return villager_id;
	}

	public void setVillager_id(Long villager_id)
	{
		this.villager_id = villager_id;
	}

	public String getId_card()
	{
		return id_card;
	}

	public void setId_card(String id_card)
	{
		this.id_card = id_card;
	}

	public String getVillager_name()
	{
		return villager_name;
	}

	public void setVillager_name(String villager_name)
	{
		this.villager_name = villager_name;
	}

	public Long getWelfare_policy_id()
	{
		return welfare_policy_id;
	}

	public void setWelfare_policy_id(Long welfare_policy_id)
	{
		this.welfare_policy_id = welfare_policy_id;
	}

	public String getWelfare_policy_name()
	{
		return welfare_policy_name;
	}

	public void setWelfare_policy_name(String welfare_policy_name)
	{
		this.welfare_policy_name = welfare_policy_name;
	}

	public Timestamp getWelfare_policy_start_time()
	{
		return welfare_policy_start_time;
	}

	public String getWelfare_policy_start_time_show()
	{
		return TimeUtil.date2str(welfare_policy_start_time, "yyyy-MM-dd");
	}

	public void setWelfare_policy_start_time(Timestamp welfare_policy_start_time)
	{
		this.welfare_policy_start_time = welfare_policy_start_time;
	}

	public Timestamp getWelfare_policy_end_time()
	{
		return welfare_policy_end_time;
	}

	public String getWelfare_policy_end_time_show()
	{
		return TimeUtil.date2str(welfare_policy_end_time, "yyyy-MM-dd");
	}

	public void setWelfare_policy_end_time(Timestamp welfare_policy_end_time)
	{
		this.welfare_policy_end_time = welfare_policy_end_time;
	}

	public Long getWelfare_policy_detail_id()
	{
		return welfare_policy_detail_id;
	}

	public void setWelfare_policy_detail_id(Long welfare_policy_detail_id)
	{
		this.welfare_policy_detail_id = welfare_policy_detail_id;
	}

	public String getProduct_id()
	{
		return product_id;
	}

	public void setProduct_id(String product_id)
	{
		this.product_id = product_id;
	}

	public String getProduct_name()
	{
		return product_name;
	}

	public void setProduct_name(String product_name)
	{
		this.product_name = product_name;
	}

	public Long getProduct_quantity()
	{
		return product_quantity;
	}

	public void setProduct_quantity(Long product_quantity)
	{
		this.product_quantity = product_quantity;
	}

	public String getProduct_measuring_unit()
	{
		return product_measuring_unit;
	}

	public void setProduct_measuring_unit(String product_measuring_unit)
	{
		this.product_measuring_unit = product_measuring_unit;
	}

	public Long getProduct_quantity_drawed()
	{
		return product_quantity_drawed;
	}

	public void setProduct_quantity_drawed(Long product_quantity_drawed)
	{
		this.product_quantity_drawed = product_quantity_drawed;
	}

	public String getT1_billsn()
	{
		return t1_billsn;
	}

	public void setT1_billsn(String t1_billsn)
	{
		this.t1_billsn = t1_billsn;
	}

}
