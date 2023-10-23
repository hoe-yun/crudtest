<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vo.Team" %>
<%
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이브 로딩 성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	System.out.println("DB접속 성공");
	String sql = "SELECT team_no teamNo, team_name teamName FROM team";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	ArrayList<Team> list = new ArrayList<Team>();
	while(rs.next()){
		Team t = new Team();
		t.teamNo = rs.getInt("teamNo");
		t.teamName = rs.getString("teamName");
		list.add(t);
	}
	//db 자원 반남
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
	<h1>학생입력</h1>
	<form action="<%=request.getContextPath() %>/addStudentAction.jsp">
		<table border="1">
			<tr>
				<th>studentName</th>
				<td>
					<input type="text" name="studentName">
				</td>
			</tr>
			<tr>
				<th>studentBirth</th>
				<td>
					<input type="date" name="studentBirth">
				</td>
			</tr>
			<tr>
				<th>team</th>
				<td>
					<!-- 팀 목록 중 하나를 선택 (팀 목록이 필요하다) -->
					<select name="teamNo">
						<%
							for(Team t : list){
						%>
								<option value="<%=t.teamNo %>"><%=t.teamName %></option>
						<% 		
							}
						%>
					</select>
				</td>
			</tr>
		</table>
		<button type="submit">추가</button>
	</form>
</body>
</html>