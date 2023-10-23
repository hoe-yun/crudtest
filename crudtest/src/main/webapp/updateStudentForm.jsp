<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import ="java.util.HashMap" %> 
<%
	int studentNo = Integer.parseInt(request.getParameter("studentNo"));
	String studentName = request.getParameter("studentName");
	String studentBirth = request.getParameter("studentBirth");
	String createdate = request.getParameter("createdate");
	String updatedate = request.getParameter("updatedate");
	String teamNo = request.getParameter("teamNo");

	Class.forName("org.mariadb.jdbc.Driver");
	String url="jdbc:mariadb://localhost:3306/gdj72";
	String dbuser= "root";
	String dbpw= "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	
	String sql = "SELECT s.student_no studentNo, s.student_name studentName, s.student_birth studentBirth, s.createdate createdate, s.updatedate updatedate, t.team_no teamNo, t.team_name teamName FROM student s INNER JOIN team t ON s.team_no = t.team_no WHERE student_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1,studentNo);
	ResultSet rs = stmt.executeQuery();
	HashMap<String, Object> map = new HashMap<>();

	if(rs.next()){
		map.put("studentNo", rs.getInt("studentNo"));
		map.put("studentName", rs.getString("studentName"));
		map.put("studentBirth", rs.getString("studentBirth"));
		map.put("createdate", rs.getString("createdate"));
		map.put("updatedate", rs.getString("updatedate"));
		map.put("teamNo", rs.getString("teamNo"));
		map.put("teamName", rs.getString("teamName"));
	}
	// DB 자원 해제
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
	<h1 class="text-bg-secondary">학생 정보 수정</h1>
		<form action="<%=request.getContextPath() %>/updateStudentAction.jsp">
			<table class="table table-bordered table-hover">
				<tr>
					<th>student_no</th>
					<td>
						<input type="text" name="studentNo" value="<%=(Integer)(map.get("studentNo")) %>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>student_name</th>
					<td>
						<input type="text" name="studentName" value="<%=(String)(map.get("studentName")) %>">
					</td>
				</tr>
				<tr>
					<th>student_birth</th>
					<td>
						<input type="date" name="studentBirth" value="<%=(String)(map.get("studentBirth")) %>">
					</td>
				</tr>
				<tr>
					<th>createdate</th>
					<td><%=(String)(map.get("createdate")) %></td>
				</tr>
				<tr>
					<th>updatedate</th>
					<td><%=(String)(map.get("updatedate")) %></td>
				</tr>
				<tr>
					<th>team</th>
					<td>
						<select name="teamNo">
							<option value="<%=(String)(map.get("teamNo")) %>"><%= (String)(map.get("teamName"))%></option>
						</select>
					</td>
				</tr>
			</table>
			<div>
				<button type="submit" class="btn btn-secondary">수정</button>
			</div>
		</form>
</div>
</body>
</html>