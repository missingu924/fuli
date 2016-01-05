package com.t1.obj;

import java.util.LinkedHashMap;

import com.hz.util.SystemConstant;
import com.wuyg.common.dao.BaseDbObj;

public class ListsaledftObj extends BaseDbObj
{
	private Long list_id;// 明细子表id号
	private Long bill_id;// 主表id号
	private Integer stor_id;// 仓库id
	private Long prod_id;// 商品id
	private Long prod_number;// 商品数量
	private Long prod_proddw;// 主计量单位
	private Double prod_price;// 单价
	private Double prod_money;// 金额
	private Double discount;// 折扣
	private Double disprice;// 折扣后价格
	private Double dismoney;// 折扣后金额
	private Double dismoney0;// 折扣金额
	private Double tax;// 税率
	private Double taxprice;// 含税单价
	private Double taxmoney;// 含税金额
	private Double taxmoney0;// 税额
	private String sernumber;// 商品批号
	private String outfactorydate;// 出厂日期
	private Long prod_order;// 库存批次
	private Double pdw_ratio;// 商品单位兑换率
	private Double pdw_num;// 最小单位商品数量
	private Double costmoney;// 成本金额
	private Long inorout;// 2：入，1：出
	private Long prod_ddid;// 商品订货ID
	private Boolean zs_syb;// 赠送标志
	private String promotion;// 特价方式
	private Double retail_price;// 价格明细
	private Long usevipsyb;// 使用VIP系统
	private Long costprice;
	private String dwratio;
	private String prodquantity;
	private String dwratio1;
	private String assistant1;
	private String dwratio2;
	private String assistant2;
	private Long bignum;
	private Long midnum;
	private Long letnum;
	private String endfulllifedate;
	private Long prod_number2;
	private Long lowmoney;
	private Long upintegral;
	private Long baseintegralmoney;
	private Long baseintegral;

	@Override
	public String findKeyColumnName()
	{
		return "list_id";
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
		return SystemConstant.T1_DB + "..listsaledft";
	}

	@Override
	public String getBasePath()
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getCnName()
	{
		// TODO Auto-generated method stub
		return null;
	}

	public LinkedHashMap<String, String> getProperties()
	{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("autoid", "autoid");
		pros.put("list_id", "list_id");
		pros.put("bill_id", "bill_id");
		pros.put("stor_id", "stor_id");
		pros.put("prod_id", "prod_id");
		pros.put("prod_number", "prod_number");
		pros.put("prod_proddw", "prod_proddw");
		pros.put("prod_price", "prod_price");
		pros.put("prod_money", "prod_money");
		pros.put("discount", "discount");
		pros.put("disprice", "disprice");
		pros.put("dismoney", "dismoney");
		pros.put("dismoney0", "dismoney0");
		pros.put("tax", "tax");
		pros.put("taxprice", "taxprice");
		pros.put("taxmoney", "taxmoney");
		pros.put("taxmoney0", "taxmoney0");
		pros.put("remark", "remark");
		pros.put("sernumber", "sernumber");
		pros.put("outfactorydate", "outfactorydate");
		pros.put("dzyh_date", "dzyh_date");
		pros.put("prod_order", "prod_order");
		pros.put("pdw_ratio", "pdw_ratio");
		pros.put("pdw_num", "pdw_num");
		pros.put("costprice", "costprice");
		pros.put("costmoney", "costmoney");
		pros.put("inorout", "inorout");
		pros.put("prod_ddid", "prod_ddid");
		pros.put("tmpsyb", "tmpsyb");
		pros.put("teamno", "teamno");
		pros.put("dzsign", "dzsign");
		pros.put("zs_syb", "zs_syb");
		pros.put("promotion", "promotion");
		pros.put("mutilcode", "mutilcode");
		pros.put("retail_price", "retail_price");
		pros.put("diffmoney", "diffmoney");
		pros.put("jsmoney", "jsmoney");
		pros.put("writejsbill", "writejsbill");
		pros.put("zerosyb", "zerosyb");
		pros.put("usevipsyb", "usevipsyb");
		pros.put("dwratio", "dwratio");
		pros.put("prodquantity", "prodquantity");
		pros.put("dwratio1", "dwratio1");
		pros.put("assistant1", "assistant1");
		pros.put("dwratio2", "dwratio2");
		pros.put("assistant2", "assistant2");
		pros.put("addprod", "addprod");
		pros.put("remark1", "remark1");
		pros.put("remark2", "remark2");
		pros.put("remark3", "remark3");
		pros.put("endfulllifedate", "endfulllifedate");
		pros.put("bignum", "bignum");
		pros.put("midnum", "midnum");
		pros.put("letnum", "letnum");
		pros.put("free1", "free1");
		pros.put("free2", "free2");
		pros.put("ifba", "ifba");
		pros.put("arrivenumber", "arrivenumber");
		pros.put("prod_number2", "prod_number2");
		pros.put("prod_proddw2", "prod_proddw2");
		pros.put("pdw_ratio2", "pdw_ratio2");
		pros.put("groupid", "groupid");
		pros.put("lowmoney", "lowmoney");
		pros.put("upintegral", "upintegral");
		pros.put("integralall", "integralall");
		pros.put("baseintegralmoney", "baseintegralmoney");
		pros.put("baseintegral", "baseintegral");
		pros.put("prod_basenumber", "prod_basenumber");
		pros.put("thnumber_1", "thnumber_1");
		pros.put("mdlist_id", "mdlist_id");
		pros.put("arrivemoney", "arrivemoney");
		pros.put("prod_ddbillid", "prod_ddbillid");
		return pros;
	}

	public Long getCostprice()
	{
		return costprice;
	}

	public void setCostprice(Long costprice)
	{
		this.costprice = costprice;
	}

	public String getDwratio()
	{
		return dwratio;
	}

	public void setDwratio(String dwratio)
	{
		this.dwratio = dwratio;
	}

	public String getProdquantity()
	{
		return prodquantity;
	}

	public void setProdquantity(String prodquantity)
	{
		this.prodquantity = prodquantity;
	}

	public String getDwratio1()
	{
		return dwratio1;
	}

	public void setDwratio1(String dwratio1)
	{
		this.dwratio1 = dwratio1;
	}

	public String getAssistant1()
	{
		return assistant1;
	}

	public void setAssistant1(String assistant1)
	{
		this.assistant1 = assistant1;
	}

	public String getDwratio2()
	{
		return dwratio2;
	}

	public void setDwratio2(String dwratio2)
	{
		this.dwratio2 = dwratio2;
	}

	public String getAssistant2()
	{
		return assistant2;
	}

	public void setAssistant2(String assistant2)
	{
		this.assistant2 = assistant2;
	}

	public Long getBignum()
	{
		return bignum;
	}

	public void setBignum(Long bignum)
	{
		this.bignum = bignum;
	}

	public Long getMidnum()
	{
		return midnum;
	}

	public void setMidnum(Long midnum)
	{
		this.midnum = midnum;
	}

	public Long getLetnum()
	{
		return letnum;
	}

	public void setLetnum(Long letnum)
	{
		this.letnum = letnum;
	}

	public String getEndfulllifedate()
	{
		return endfulllifedate;
	}

	public void setEndfulllifedate(String endfulllifedate)
	{
		this.endfulllifedate = endfulllifedate;
	}

	public Long getProd_number2()
	{
		return prod_number2;
	}

	public void setProd_number2(Long prod_number2)
	{
		this.prod_number2 = prod_number2;
	}

	public Long getLowmoney()
	{
		return lowmoney;
	}

	public void setLowmoney(Long lowmoney)
	{
		this.lowmoney = lowmoney;
	}

	public Long getUpintegral()
	{
		return upintegral;
	}

	public void setUpintegral(Long upintegral)
	{
		this.upintegral = upintegral;
	}

	public Long getBaseintegralmoney()
	{
		return baseintegralmoney;
	}

	public void setBaseintegralmoney(Long baseintegralmoney)
	{
		this.baseintegralmoney = baseintegralmoney;
	}

	public Long getBaseintegral()
	{
		return baseintegral;
	}

	public void setBaseintegral(Long baseintegral)
	{
		this.baseintegral = baseintegral;
	}

	public Long getList_id()
	{
		return list_id;
	}

	public void setList_id(Long list_id)
	{
		this.list_id = list_id;
	}

	public Long getBill_id()
	{
		return bill_id;
	}

	public void setBill_id(Long bill_id)
	{
		this.bill_id = bill_id;
	}

	public Integer getStor_id()
	{
		return stor_id;
	}

	public void setStor_id(Integer stor_id)
	{
		this.stor_id = stor_id;
	}

	public Long getProd_id()
	{
		return prod_id;
	}

	public void setProd_id(Long prod_id)
	{
		this.prod_id = prod_id;
	}

	public Long getProd_number()
	{
		return prod_number;
	}

	public void setProd_number(Long prod_number)
	{
		this.prod_number = prod_number;
	}

	public Long getProd_proddw()
	{
		return prod_proddw;
	}

	public void setProd_proddw(Long prod_proddw)
	{
		this.prod_proddw = prod_proddw;
	}

	public Double getProd_price()
	{
		return prod_price;
	}

	public void setProd_price(Double prod_price)
	{
		this.prod_price = prod_price;
	}

	public Double getProd_money()
	{
		return prod_price * prod_number;
	}

	public void setProd_money(Double prod_money)
	{
		this.prod_money = prod_money;
	}

	public Double getDiscount()
	{
		return discount;
	}

	public void setDiscount(Double discount)
	{
		this.discount = discount;
	}

	public Double getDisprice()
	{
		return prod_price * discount / 100;
	}

	public void setDisprice(Double disprice)
	{
		this.disprice = disprice;
	}

	public Double getDismoney()
	{
		return getDisprice() * prod_number;
	}

	public void setDismoney(Double dismoney)
	{
		this.dismoney = dismoney;
	}

	public Double getDismoney0()
	{
		return getProd_money() - getDismoney();
	}

	public void setDismoney0(Double dismoney0)
	{
		this.dismoney0 = dismoney0;
	}

	public Double getTax()
	{
		return tax;
	}

	public void setTax(Double tax)
	{
		this.tax = tax;
	}

	public Double getTaxprice()
	{
		return (1 + tax) * prod_price;
	}

	public void setTaxprice(Double taxprice)
	{
		this.taxprice = taxprice;
	}

	public Double getTaxmoney()
	{
		return getTaxprice() * prod_number;
	}

	public void setTaxmoney(Double taxmoney)
	{
		this.taxmoney = taxmoney;
	}

	public Double getTaxmoney0()
	{
		return tax * prod_price * prod_number;
	}

	public void setTaxmoney0(Double taxmoney0)
	{
		this.taxmoney0 = taxmoney0;
	}

	public String getSernumber()
	{
		return sernumber;
	}

	public void setSernumber(String sernumber)
	{
		this.sernumber = sernumber;
	}

	public String getOutfactorydate()
	{
		return outfactorydate;
	}

	public void setOutfactorydate(String outfactorydate)
	{
		this.outfactorydate = outfactorydate;
	}

	public Long getProd_order()
	{
		return prod_order;
	}

	public void setProd_order(Long prod_order)
	{
		this.prod_order = prod_order;
	}

	public Double getPdw_ratio()
	{
		return pdw_ratio;
	}

	public void setPdw_ratio(Double pdw_ratio)
	{
		this.pdw_ratio = pdw_ratio;
	}

	public Double getPdw_num()
	{
		return pdw_num;
	}

	public void setPdw_num(Double pdw_num)
	{
		this.pdw_num = pdw_num;
	}

	public Double getCostmoney()
	{
		return costmoney;
	}

	public void setCostmoney(Double costmoney)
	{
		this.costmoney = costmoney;
	}

	public Long getInorout()
	{
		return inorout;
	}

	public void setInorout(Long inorout)
	{
		this.inorout = inorout;
	}

	public Long getProd_ddid()
	{
		return prod_ddid;
	}

	public void setProd_ddid(Long prod_ddid)
	{
		this.prod_ddid = prod_ddid;
	}

	public Boolean getZs_syb()
	{
		return zs_syb;
	}

	public void setZs_syb(Boolean zs_syb)
	{
		this.zs_syb = zs_syb;
	}

	public String getPromotion()
	{
		return promotion;
	}

	public void setPromotion(String promotion)
	{
		this.promotion = promotion;
	}

	public Double getRetail_price()
	{
		return retail_price;
	}

	public void setRetail_price(Double retail_price)
	{
		this.retail_price = retail_price;
	}

	public Long getUsevipsyb()
	{
		return usevipsyb;
	}

	public void setUsevipsyb(Long usevipsyb)
	{
		this.usevipsyb = usevipsyb;
	}

}
