<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vo.Team" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이브 로딩 성공");
	String url="jdbc:mariadb://localhost:3306/gdj72";
	String dbuser= "root";
	String dbpw= "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	System.out.println("db 접속 성공");
	
	String sql = "SELECT team_no AS teamNo,team_name AS teamName,team_count AS teamCount,team_begin AS teamBegin,team_end AS teamEnd,createdate,updatedate FROM team";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	
	ArrayList<Team> list = new ArrayList<Team>();	//Team클래스로 변형 후 ArrayList
	while(rs.next()){								//ResultSet의 값을 while 반복문으로 삽입
		Team t = new Team();						
		t.teamNo = rs.getInt("teamNo");
		t.teamName = rs.getString("teamName");
		t.teamCount = rs.getInt("teamCount");
		t.teamBegin = rs.getString("teamBegin");
		t.teamEnd = rs.getString("teamEnd");
		t.createdate = rs.getString("createdate");
		t.updatedate = rs.getString("updatedate");
		list.add(t);
	}
%>
	<ul>		<!-- 상단 홈 메뉴 건들필요 없음 -->
		<li><a href="<%=request.getContextPath()%>/home.jsp">홈으로</a></li>
		<li><a href="<%=request.getContextPath()%>/empList.jsp">직원관리</a></li>
		<li><a href="<%=request.getContextPath()%>/teamList.jsp">팀관리</a></li>
		<li><a href="<%=request.getContextPath()%>/studentList.jsp">학생관리</a></li>
		<li><a href="<%=request.getContextPath()%>/boardList.jsp">게시판관리</a></li>
	</ul>
	
	<h1>팀 리스트</h1>
	<div>
		<a href="<%=request.getContextPath() %>/addTeamForm.jsp">팀 추가</a>	<!-- 팀 추가 링크를 통해 addTeamForm.jsp로 요청을 보냄 -->
	</div>
	<table border="1">
		<thead>
			<tr>
				<th>team_no</th>
				<th>team_name</th>
				<th>team_count</th>
				<th>team_begin</th>
				<th>team_end</th>
				<th>createdate</th>
				<th>updatedate</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Team t : list){
			%>
					<tr>
						<td><%=t.teamNo%></td>
						<td><%=t.teamName%></td>
						<td><%=t.teamCount %></td>
						<td><%=t.teamBegin %></td>
						<td><%=t.teamEnd%></td>
						<td><%=t.createdate%></td>
						<td><%=t.updatedate%></td>
						<td>
							<a href="<%=request.getContextPath()%>/updateTeamForm.jsp?teamNo=<%=t.teamNo%>">수정</a>
						</td>
						<td>
							<a href="<%=request.getContextPath()%>/deleteTeamAction.jsp?teamNo=<%=t.teamNo%>">삭제</a>
						</td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>
</body>
</html>