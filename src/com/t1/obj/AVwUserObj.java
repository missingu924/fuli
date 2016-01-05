package com.t1.obj;

import java.sql.Timestamp;

import com.hz.util.SystemConstant;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;

;
public class AVwUserObj extends BaseDbObj
{
	private Integer s_id;
	private Long s_syb;
	private String u_code;
	private Integer emp_id;
	private String password;
	private String ime;
	private String empcode;
	private String empname;
	private String deptname;
	private String sybstat;

	@Override
	public String findKeyColumnName()
	{
		return "u_code";
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
		return SystemConstant.T1_DB + "..a_vw_user";
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

		pros.put("s_id", "s_id");
		pros.put("s_syb", "s_syb");
		pros.put("u_code", "u_code");
		pros.put("emp_id", "emp_id");
		pros.put("password", "password");
		pros.put("ime", "ime");
		pros.put("empcode", "empcode");
		pros.put("empname", "empname");
		pros.put("deptname", "deptname");
		pros.put("sybstat", "sybstat");
		return pros;
	}

	public Integer getS_id()
	{
		return s_id;
	}

	public void setS_id(Integer s_id)
	{
		this.s_id = s_id;
	}

	public Long getS_syb()
	{
		return s_syb;
	}

	public void setS_syb(Long s_syb)
	{
		this.s_syb = s_syb;
	}

	public String getU_code()
	{
		return u_code;
	}

	public void setU_code(String u_code)
	{
		this.u_code = u_code;
	}

	public Integer getEmp_id()
	{
		return emp_id;
	}

	public void setEmp_id(Integer emp_id)
	{
		this.emp_id = emp_id;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public String getIme()
	{
		return ime;
	}

	public void setIme(String ime)
	{
		this.ime = ime;
	}

	public String getEmpcode()
	{
		return empcode;
	}

	public void setEmpcode(String empcode)
	{
		this.empcode = empcode;
	}

	public String getEmpname()
	{
		return empname;
	}

	public void setEmpname(String empname)
	{
		this.empname = empname;
	}

	public String getDeptname()
	{
		return deptname;
	}

	public void setDeptname(String deptname)
	{
		this.deptname = deptname;
	}

	public String getSybstat()
	{
		return sybstat;
	}

	public void setSybstat(String sybstat)
	{
		this.sybstat = sybstat;
	}
}
