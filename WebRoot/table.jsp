<%@ page contentType="text/html; charset=gbk" language="java"
	import="java.sql.*" errorPage=""%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<link href="table.css" rel="stylesheet" type="text/css">
	<link href="style.css" rel="stylesheet" type="text/css">
	<body>
		<table class="table table-bordered table-striped" align="center">
			<thead>
				<tr>
					<th>
						<input type="checkbox" name="ckall" id="ckall" />
					</th>
					<th>
						ID号
					</th>
					<th>
						编码
					</th>
					<th>
						名称
					</th>
					<th>
						用户密码
					</th>
					<th>
						管理员否
					</th>
					<th>
						操作
					</th>
				</tr>
			</thead>
			<tr>
				<td>
					<input type="checkbox" name="c_id" value="a" />
				</td>
				<td>
					1
				</td>
				<td>
					awinlau
				</td>
				<td>
					胡光光
				</td>
				<td>
					awin
				</td>
				<td>
					管理员
				</td>
				<td>
					<a href="#" class="btn btn-mini"><i class="icon-edit"> </i>编辑</a>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" name="c_id" value="a" />
				</td>
				<td>
					2
				</td>
				<td>
					hugge
				</td>
				<td>
					刘若英
				</td>
				<td>
					test
				</td>
				<td>
					管理员
				</td>
				<td>
					<a href="#" class="btn btn-mini"><i class="icon-edit"> </i>编辑</a>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" name="c_id" value="a" />
				</td>
				<td>
					3
				</td>
				<td>
					awinlau
				</td>
				<td>
					胡光光
				</td>
				<td>
					awin
				</td>
				<td>
					管理员
				</td>
				<td>
					<a href="#" class="btn btn-mini"><i class="icon-edit"> </i>编辑</a>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" name="c_id" value="a" />
				</td>
				<td>
					4
				</td>
				<td>
					awinlau
				</td>
				<td>
					胡光光
				</td>
				<td>
					awin
				</td>
				<td>
					管理员
				</td>
				<td>
					<a href="#" class="btn btn-mini"><i class="icon-edit"> </i>编辑</a>
				</td>
			</tr>
		</table>
	</body>
</html>