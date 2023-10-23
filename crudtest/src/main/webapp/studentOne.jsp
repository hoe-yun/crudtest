<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>

<!-- studentList.jsp 목록 -->
<!-- stydentOne.jsp 한 행의 상세 student join team -->
<!-- 애드폼 애드액션 딜리트액션 업데이트폼 업데이트액션 -->
<%
	/*
	SELECT s.student_no studentNo, 
			s.student_name studentName, 
			s.student_birth studentBirth, 
			s.createdate sCreatedate,
			s.updatedate sUdatedate,
			s.team_no teamNo,
			t.team_name teamName,
			t.team_count teamCount,
			t.team_begin teamBegin,
			t.team_end teamEnd,
			t.createdate tCreatedate,
			t.updatedate tUpdatedate
	FROM student s INNER JOIN team t
	ON s.team_no = t.team_no
	WHERE s.student_no = ?
	*/
	int studentNo = Integer.parseInt(request.getParameter("studentNo"));
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이브 로딩 성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	System.out.println("DB접속 성공");
	
	String sql = "SELECT s.student_no studentNo, s.student_name studentName, s.student_birth studentBirth, s.createdate sCreatedate,s.updatedate sUpdatedate,s.team_no teamNo,t.team_name teamName,t.team_count teamCount,t.team_begin teamBegin,t.team_end teamEnd,t.createdate tCreatedate,t.updatedate tUpdatedate FROM student s INNER JOIN team t ON s.team_no = t.team_no WHERE s.student_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, studentNo);
	ResultSet rs = stmt.executeQuery();
	
	ArrayList<HashMap<String,Object>> list = new ArrayList<>();
	while(rs.next()){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map = new HashMap<String, Object>();
		map.put("studentNo", rs.getInt("studentNo"));
		map.put("studentName", rs.getString("studentName"));
		map.put("studentBirth", rs.getString("studentBirth"));
		map.put("sCreatedate", rs.getString("sCreatedate"));
		map.put("sUpdatedate", rs.getString("sUpdatedate"));
		map.put("teamNo", rs.getInt("teamNo"));
		map.put("teamName", rs.getString("teamName"));
		map.put("teamCount", rs.getInt("teamCount"));
		map.put("teamBegin", rs.getString("teamBegin"));
		map.put("teamEnd", rs.getString("teamEnd"));
		map.put("tCreatedate", rs.getString("tCreatedate"));
		map.put("tUpdatedate", rs.getString("tUpdatedate"));
		list.add(map);
	}
	
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
	<h1 class="text-bg-secondary">학생 상세 정보</h1>
	<table class="table table-bordered table-hover">
<%
				for(HashMap<String, Object> map : list){
%>
		<tr>
			<th>studentNo</th>
			<td><%=(Integer)(map.get("studentNo")) %></td>
		</tr>
		<tr>
			<th>studentName</th>
			<td><%=(String)(map.get("studentName")) %></td>
		</tr>
		<tr>
			<th>studentBirth</th>
			<td><%=(String)(map.get("studentBirth")) %></td>
		</tr>
		<tr>
			<th>sCreatedate</th>
			<td><%=(String)(map.get("sCreatedate")) %></td>
		</tr>
		<tr>
			<th>sUpdatedate</th>
			<td><%=(String)(map.get("sUpdatedate")) %></td>
		</tr>
		<tr>
			<th>teamNo</th>
			<td><%=(Integer)(map.get("teamNo")) %></td>
		</tr>
		<tr>
			<th>teamName</th>
			<td><%=(String)(map.get("teamName")) %></td>
		</tr>
		<tr>
			<th>teamCount</th>
			<td><%=(Integer)(map.get("teamCount")) %></td>
		</tr>
		<tr>
			<th>teamBegin</th>
			<td><%=(String)(map.get("teamBegin")) %></td>
		</tr>
		<tr>
			<th>teamEnd</th>
			<td><%=(String)(map.get("teamEnd")) %></td>
		</tr>
		<tr>
			<th>tCreatedate</th>
			<td><%=(String)(map.get("tCreatedate")) %></td>
		</tr>
		<tr>
			<th>tUpdatedate</th>
			<td><%=(String)(map.get("tUpdatedate")) %></td>
		</tr>
		<% 
				}
			%>
	</table>
	<div>
		<a href="<%=request.getContextPath()%>/updateStudentForm.jsp?studentNo=<%=studentNo %>" class="btn btn-secondary">수정</a>
		<a href="<%=request.getContextPath()%>/deleteStudentAction.jsp?studentNo=<%=studentNo %>" class="btn btn-secondary">삭제</a>
		<a href="<%=request.getContextPath()%>/studentList.jsp" class="btn btn-secondary">뒤로</a>
	</div>
</div>
</body>
</html>