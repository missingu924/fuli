package com.wuyg.dbmodel.obj;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.wuyg.common.util.StringUtil;

public class TableObj
{
	private String tableName;
	private List<ColumnObj> columns = new ArrayList<ColumnObj>();

	public String getTableName()
	{
		return tableName;
	}

	public void setTableName(String tableName)
	{
		this.tableName = tableName;
	}

	public List<ColumnObj> getColumns()
	{
		return columns;
	}

	public void setColumns(List<ColumnObj> columns)
	{
		this.columns = columns;
	}

	public void addColumn(ColumnObj columnObj)
	{
		this.columns.add(columnObj);
	}

	public String toJavaSrc(String packagePath)
	{
		StringBuffer src = new StringBuffer();

		src.append("package " + packagePath + ";\n");

		src.append("import java.sql.Timestamp;\n");
		src.append("import com.wuyg.common.dao.BaseDbObj;\n");
		src.append("import java.util.LinkedHashMap;\n");
		src.append("import com.alibaba.fastjson.JSON;\n");

		src.append("public class " + StringUtil.toClassName(tableName) + "Obj extends BaseDbObj\n");
		src.append("{\n");
		for (int i = 0; i < columns.size(); i++)
		{
			ColumnObj col = columns.get(i);
			src.append("private " + col.getColumnType() + " " + col.getColumnName() + ";\n");
		}

		src.append("@Override\n");
		src.append("public String findKeyColumnName()\n");
		src.append("{\n");
		src.append("	// TODO Auto-generated method stub\n");
		src.append("	return null;\n");
		src.append("}\n");

		src.append("@Override\n");
		src.append("public String findParentKeyColumnName()\n");
		src.append("{\n");
		src.append("	// TODO Auto-generated method stub\n");
		src.append("	return null;\n");
		src.append("}\n");

		src.append("@Override\n");
		src.append("public String findTableName()\n");
		src.append("{\n");
		src.append("	return \"" + tableName + "\";\n");
		src.append("}\n");

		src.append("@Override\n");
		src.append("public String getBasePath()\n");
		src.append("{\n");
		src.append("	// TODO Auto-generated method stub\n");
		src.append("	return null;\n");
		src.append("}\n");

		src.append("@Override\n");
		src.append("public String getCnName()\n");
		src.append("{\n");
		src.append("	// TODO Auto-generated method stub\n");
		src.append("	return null;\n");
		src.append("}\n");

		src.append("public LinkedHashMap<String, String> getProperties()\n");
		src.append("{\n");
		src.append("		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();\n");
		src.append("\n");
		for (int i = 0; i < columns.size(); i++)
		{
			ColumnObj col = columns.get(i);
			src.append("		pros.put(\"" + col.getColumnName() + "\", \"" + col.getColumnName() + "\");\n");
		}
		src.append("		return pros;\n");
		src.append("}\n");

		for (int i = 0; i < columns.size(); i++)
		{
			ColumnObj col = columns.get(i);

			String columnType = col.getColumnType();
			String columnName = col.getColumnName();

			String columnNameUpperFirstChar = StringUtil.upperFirstChar(col.getColumnName());

			src.append("public " + columnType + " get" + columnNameUpperFirstChar + "()\n");
			src.append("{\n");
			src.append("	return " + columnName + ";\n");
			src.append("}\n");

			src.append("public void set" + columnNameUpperFirstChar + "(" + columnType + " " + col.getColumnName() + ")\n");
			src.append("{\n");
			src.append("	this." + columnName + " = " + columnName + ";\n");
			src.append("}\n");
		}

		src.append("@Override\n");
		src.append("public String toString()\n");
		src.append("{\n");
		src.append("	return JSON.toJSONString(this);\n");
		src.append("}\n");

		src.append("}\n");

		return src.toString();
	}

}
