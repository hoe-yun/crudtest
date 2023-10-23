<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%@ page import ="java.sql.ResultSet" %>   
<%@ page import ="vo.Team" %> 
<%
	int teamNo = Integer.parseInt(request.getParameter("teamNo"));
	String teamName = request.getParameter("teamName");
	String teamCount = request.getParameter("teamCount");
	String teamBegin = request.getParameter("teamBegin");
	String teamEnd = request.getParameter("teamEnd");
	
	Class.forName("org.mariadb.jdbc.Driver");
	String url="jdbc:mariadb://localhost:3306/gdj72";
	String dbuser= "root";
	String dbpw= "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "SELECT team_no teamNo,team_name teamName,team_count teamCount,team_begin teamBegin,team_end teamEnd,createdate,updatedate From team WHERE team_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, teamNo);
	ResultSet rs = stmt.executeQuery();
	
	Team team = null;
	if(rs.next()){
		team = new Team();
		team.teamNo = rs.getInt("teamNo");
		team.teamName = rs.getString("teamName");
		team.teamCount = rs.getInt("teamCount");
		team.teamBegin = rs.getString("teamBegin");
		team.teamEnd = rs.getString("teamEnd");
		team.createdate = rs.getString("createdate");
		team.updatedate = rs.getString("updatedate");
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
</head>
<body>
	<h1>Team 수정</h1>
		<form action="<%=request.getContextPath() %>/updateTeamAction.jsp">
			<table border="1">
				<tr>
					<td>team_no</td>
					<td>
						<input type="text" name="teamNo" value="<%=team.teamNo %>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>team_name</td>
					<td>
						<input type="text" name="teamName" value="<%=team.teamName %>">
					</td>
				</tr>
				<tr>
					<td>team_count</td>
					<td>
						<input type="text" name="teamCount" value="<%=team.teamCount %>">
					</td>
				</tr>
				<tr>
					<td>team_begin</td>
					<td>
						<input type="date" name="teamBegin" value="<%=team.teamBegin %>">
					</td>
				</tr>
				<tr>
					<td>team_end</td>
					<td>
						<input type="date" name="teamEnd" value="<%=team.teamEnd %>">
					</td>
				</tr>
				<tr>
					<td>createdate</td>
					<td><%=team.createdate %></td>
				</tr>
				<tr>
					<td>updatedate</td>
					<td><%=team.updatedate %></td>
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