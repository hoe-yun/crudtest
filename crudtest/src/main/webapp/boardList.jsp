<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.Board" %>
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
	//요청 분석(controller)
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage= Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이브 로딩 성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	System.out.println("DB접속 성공");
	String sql1 = "SELECT COUNT(*) FROM board";
	PreparedStatement stmt1 = conn.prepareStatement(sql1);
	ResultSet rs1 = stmt1.executeQuery();
	int totalRow = 0;
	if(rs1.next()){
		totalRow = rs1.getInt("COUNT(*)");
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	
	String sql2 = "SELECT board_no boardNo, board_title boardTitle, createdate, updatedate FROM board ORDER BY createdate DESC LIMIT ?,?";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	int beginRow = (currentPage-1)*rowPerPage;
	stmt2.setInt(1, beginRow);
	stmt2.setInt(2, rowPerPage);
	ResultSet rs2 = stmt2.executeQuery();
	
	ArrayList<Board> list = new ArrayList<Board>();	// 자원을 해제하기 위해 DB Emp테이블 행의 집합(ResultSet)을 -> JAVA Emp클래스 타입의 집합(ArrayList)으로	
	while(rs2.next()){
		Board b = new Board();
		b.boardNo = rs2.getInt("boardNo");
		b.boardTitle = rs2.getString("boardTitle");
		b.createdate = rs2.getString("createdate");
		b.updatedate = rs2.getString("updatedate");
		list.add(b);
	}
	// DB 자원 해제(반납)
	rs1.close();
	rs2.close();
	stmt1.close();
	stmt2.close();
	conn.close();
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
	
	<h1 class="text-bg-secondary">게시판 리스트</h1>
		<div>
			<a href="<%=request.getContextPath()%>/addBoardForm.jsp" class="btn btn-secondary">Board추가</a>
		</div>
		<table class="table table-bordered table-hover">
			<thead>
				<tr class="table-dark">
					<th>board_title</th>
					<th>createdate</th>
					<th>updatedate</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Board b : list) {
				%>
						<tr>
							<td>
								<a href="<%=request.getContextPath()%>/boardOne.jsp?boardNo=<%=b.boardNo%>"><%=b.boardTitle%></a>
							</td>
							<td><%=b.createdate%></td>
							<td><%=b.updatedate%></td>
						</tr>
				<%		
					}
				%>
			</tbody>
		</table>
		<div>
			<ul class="pagination">
			  <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/boardList.jsp?currentPage=1">처음</a></li>
			  <%
			  	if(currentPage>1){
			  %>
			  		<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/boardList.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
			  <% 	
			 	}
			  %>
			  <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/boardList.jsp?currentPage=<%=currentPage %>"><%=currentPage %></a></li>
			  <%
			 	 if(currentPage<lastPage){
			  %> 
			 		<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/boardList.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
			  <%			
			  	}
			  %>
			  <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/boardList.jsp?currentPage=<%=lastPage%>">마지막</a></li>
			</ul>
		</div>
</div>
</body>
</html>