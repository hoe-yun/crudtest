<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vo.Board" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	
	Class.forName("org.mariadb.jdbc.Driver");
	String url="jdbc:mariadb://localhost:3306/gdj72";
	String dbuser= "root";
	String dbpw= "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "SELECT board_no boardNo, board_title boardTitle, board_content boardContent, board_writer boardWriter, board_pw boardPW, createdate, updatedate FROM board WHERE board_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, boardNo);
	ResultSet rs = stmt.executeQuery();
	
	ArrayList<Board> list = new ArrayList<Board>();
	while(rs.next()){
		Board b = new Board();
		b.boardNo = rs.getInt("boardNo");
		b.boardTitle = rs.getString("boardTitle");
		b.boardContent = rs.getString("boardContent");
		b.boardWriter = rs.getString("boardWriter");
		b.boardPw = rs.getString("boardPw");
		b.createdate = rs.getString("createdate");
		b.updatedate = rs.getString("updatedate");
		list.add(b);
	}
	//DB 자원 해제 (반납)
	rs.close();
	stmt.close();
	conn.close();
%>
	<h1>Board 상세정보</h1>
	<table border="1">
			<%
				for(Board b : list) {
			%>
					<tr>
						<th>board_no</th>
						<td><%=b.boardNo%></td>
					</tr>
					<tr>
						<th>board_title</th>
						<td><%=b.boardTitle%></td>
					</tr>
					<tr>
						<th>board_content</th>
						<td><textarea rows="8" cols=30 readonly="readonly"><%=b.boardContent%></textarea></td>
						</tr>
					<tr>
						<th>board_writer</th>
						<td><%=b.boardWriter%></td>
					</tr>
					<tr>
						<th>board_pw</th>
						<td><input type="password" name="b.boardPw" value="<%=b.boardPw%>" readonly="readonly"></td> <!-- 리스트에서 pw가 보이지 않도록 password 타입 사용하고 readonly -->
					</tr>
					<tr>
						<th>createdate</th>
						<td><%=b.createdate%></td>
					</tr>
					<tr>
						<th>updatedate</th>
						<td><%=b.updatedate%></td>
					</tr>
					<tr>
						<td colspan="2">
							<a href="<%=request.getContextPath()%>/updateBoardForm.jsp?boardNo=<%=b.boardNo%>">수정</a>
							<a href="<%=request.getContextPath()%>/deleteBoardForm.jsp?boardNo=<%=b.boardNo%>">삭제</a>
						</td>
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
</body>
</html>