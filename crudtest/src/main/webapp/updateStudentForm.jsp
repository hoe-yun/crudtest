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
</head>
<body>
<h1>학생 정보 수정</h1>
		<form action="<%=request.getContextPath() %>/updateStudentAction.jsp">
			<table border="1">
				<tr>
					<td>student_no</td>
					<td>
						<input type="text" name="studentNo" value="<%=(Integer)(map.get("studentNo")) %>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>student_name</td>
					<td>
						<input type="text" name="studentName" value="<%=(String)(map.get("studentName")) %>">
					</td>
				</tr>
				<tr>
					<td>student_birth</td>
					<td>
						<input type="date" name="studentBirth" value="<%=(String)(map.get("studentBirth")) %>">
					</td>
				</tr>
				<tr>
					<td>createdate</td>
					<td><%=(String)(map.get("createdate")) %></td>
				</tr>
				<tr>
					<td>updatedate</td>
					<td><%=(String)(map.get("updatedate")) %></td>
				</tr>
				<tr>
					<td>team</td>
					<td>
						<select name="teamNo">
							<option value="<%=(String)(map.get("teamNo")) %>"><%= (String)(map.get("teamName"))%></option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit">수정</button>
					</td>
				</tr>
				
			</table>
		</form>
</body>
</html>