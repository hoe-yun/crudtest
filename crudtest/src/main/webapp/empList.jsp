<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.Emp" %>
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
<%
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이브 로딩 성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	System.out.println("DB접속 성공");
	
	String sql = "SELECT emp_no AS empNo, emp_name AS empName, createdate, updatedate FROM emp";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	// <-- 모델 레이어
	// 자원해제? 자원을 뷰에서 사용하는데? 해제전에 ResultSet -> ArrayList로 변형카피 -> 자원해제
	// DB Emp테이블 행의 집합(ResultSet)을 -> JAVA Emp클래스 타입의 집합(ArrayList)으로		
	ArrayList<Emp> list = new ArrayList<Emp>();
	while(rs.next()) {
		Emp e = new Emp(); // 결과행의 수만큼 Emp객체 필요
		e.empNo = rs.getInt("empNo");
		e.empName = rs.getString("empName");
		e.createdate = rs.getString("createdate");
		e.updatedate = rs.getString("updatedate");
		list.add(e);
	}
	
	rs.close();
	stmt.close();
	conn.close();
	// 뷰 레이어
	
%>
<div class="container-fluid">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	  <div class="container-fluid">
	    <a class="navbar-brand" href="<%=request.getContextPath()%>/home.jsp">Home</a>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="collapsibleNavbar">
	      <ul class="navbar-nav">
	        <li class="nav-item">
	          <a class="nav-link" href="<%=request.getContextPath()%>/empList.jsp">Emp</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="<%=request.getContextPath()%>/teamList.jsp">Team</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="<%=request.getContextPath()%>/studentList.jsp">Student</a>
	        </li>   
	        <li class="nav-item">
	          <a class="nav-link" href="<%=request.getContextPath()%>/boardList.jsp">Board</a>
	        </li> 
	      </ul>
	    </div>
	  </div>
	</nav>
	
	<h1 class="text-bg-secondary">직원 리스트</h1>
		<div>
			<a href="<%=request.getContextPath()%>/addEmpForm.jsp" class="btn btn-secondary">직원추가</a>
		</div>
		<table class="table table-bordered table-hover">
			<thead>
				<tr class="table-dark">
					<th>emp_no</th>
					<th>emp_name</th>
					<th>createdate</th>
					<th>updatedate</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Emp e : list) {
				%>
						<tr>
							<td><%=e.empNo%></td>
							<td><%=e.empName%></td>
							<td><%=e.createdate%></td>
							<td><%=e.updatedate%></td>
							<td>
								<a href="<%=request.getContextPath()%>/updateEmpForm.jsp?empNo=<%=e.empNo%>" class="btn btn-secondary">수정</a>
							</td>
							<td>
								<a href="<%=request.getContextPath()%>/deleteEmpAction.jsp?empNo=<%=e.empNo%>" class="btn btn-secondary">삭제</a>
							</td>
						</tr>
				<%		
					}
				%>
			</tbody>
		</table>
</div>
</body>
</html>
