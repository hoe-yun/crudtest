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
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/home.jsp">홈으로</a></li>
		<li><a href="<%=request.getContextPath()%>/empList.jsp">직원관리</a></li>
		<li><a href="<%=request.getContextPath()%>/teamList.jsp">팀관리</a></li>
		<li><a href="<%=request.getContextPath()%>/studentList.jsp">학생관리</a></li>
		<li><a href="<%=request.getContextPath()%>/boardList.jsp">게시판관리</a></li>
	</ul>
	
	<h1>학생 리스트</h1>
	<a href="<%=request.getContextPath() %>/addStudentForm.jsp">학생 추가</a>
	<table border="1">
		<thead>
			<tr>
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
						<a href="<%=request.getContextPath()%>/studentOne.jsp?studentNo=<%=s.studentNo%>">상세정보</a>
					</td>
				</tr>
		<%
			}
		%>
		</tbody>
	</table>
</body>
</html>