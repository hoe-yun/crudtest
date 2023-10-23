<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%@ page import ="java.sql.ResultSet" %>   
<%@ page import ="vo.Emp" %> 
<%
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	String empName = request.getParameter("empName");
	
	Class.forName("org.mariadb.jdbc.Driver");
	String url="jdbc:mariadb://localhost:3306/gdj72";
	String dbuser= "root";
	String dbpw= "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "SELECT emp_no empNo, emp_name empName, createdate, updatedate FROM emp WHERE emp_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, empNo);
	ResultSet rs = stmt.executeQuery();
	
	Emp emp = null;
	if(rs.next()){
		emp= new Emp();
		emp.empNo = rs.getInt("empNo");
		emp.empName = rs.getString("empName");
		emp.createdate = rs.getString("createdate");
		emp.updatedate = rs.getString("updatedate");
	}
	rs.close();
	stmt.close();
	conn.close();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
<div class="container-fluid">
	<h1 class="text-bg-secondary">Emp 수정</h1>
	<form action="<%=request.getContextPath()%>/updateEmpAction.jsp">
		<table class="table table-bordered table-hover">
			<tr>
				<th>emp_no</th>
				<td>
					<input type="text" name="empNo" value="<%=emp.empNo %>" readonly="readonly"> 
				</td>
			</tr>
			<tr>
				<th>emp_name</th>
				<td>
					<input type="text" name="empName" value="<%=emp.empName %>">
				</td>
			</tr>
			<tr>
				<th>createdate</th>
				<td><%=emp.createdate %></td>
			</tr>
			<tr>
				<th>updatedate</th>
				<td><%=emp.updatedate %></td>
			</tr>
		</table>
		<div>
			<button type="submit" class="btn btn-secondary">수정</button>
		</div>
	</form>
</div>
</body>
</html>