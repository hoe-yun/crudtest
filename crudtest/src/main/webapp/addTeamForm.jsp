<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>팀 추가</h1>
	<form action="<%=request.getContextPath() %>/addTeamAction.jsp"> <!-- 내용을 적고 추가 버튼을 누르면 addTeamAction.jsp로 요청을 보냄 -->
		<table border="1">
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="teamName">
				</td>
			</tr>
			<tr>
				<th>인원 수</th>
				<td>
					<input type="text" name="teamCount">
				</td>
			</tr>
			<tr>
				<th>시작일</th>
				<td>
					<input type="date" name="teamBegin">
				</td>
			</tr>
			<tr>
				<th>수료일</th>
				<td>
					<input type="date" name="teamEnd">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button>추가</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>