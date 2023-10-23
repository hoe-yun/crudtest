<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vo.Student" %>
<% 
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이브 로딩 성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	System.out.println("DB접속 성공");
	
	String sql = "SELECT student_no studentNo, student_name studentName, student_birth studentBirth, createdate, updatedate, team_no teamNo FROM student";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	ArrayList<Student> list = new ArrayList<Student>();
	while(rs.next()){
		Student s = new Student();
		s.studentNo = rs.getInt("studentNo");
		s.teamNo = rs.getInt("teamNo");
		s.studentName = rs.getString("studentName");
		s.studentBirth = rs.getString("studentBirth");
		s.createdate = rs.getString("createdate");
		s.updatedate = rs.getString("updatedate");
		list.add(s);	
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
		
	<h1 class="text-bg-secondary">학생 리스트</h1>
		<a href="<%=request.getContextPath() %>/addStudentForm.jsp" class="btn btn-secondary">학생 추가</a>
		<table class="table table-bordered table-hover">
			<thead>
				<tr class="table-dark">
					<th>studentNo</th>
					<th>studentName</th>
					<th>studentBirth</th>
					<th>createdate</th>
					<th>updatedate</th>
					<th>teamNo</th>
					<th>상세정보</th>
				</tr>
			</thead>
			<tbody>
			<%
				for(Student s : list){
			%>
					<tr>
						<td><%=s.studentNo %></td>
						<td><%=s.studentName %></td>
						<td><%=s.studentBirth %></td>
						<td><%=s.createdate %></td>
						<td><%=s.updatedate %></td>
						<td><%=s.teamNo %></td>
						<td>
							<a href="<%=request.getContextPath()%>/studentOne.jsp?studentNo=<%=s.studentNo%>" class="btn btn-secondary">상세정보</a>
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