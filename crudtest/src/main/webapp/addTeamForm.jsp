<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<h1 class="text-bg-secondary">팀 추가</h1>
	<form action="<%=request.getContextPath() %>/addTeamAction.jsp"> <!-- 내용을 적고 추가 버튼을 누르면 addTeamAction.jsp로 요청을 보냄 -->
		<table class="table table-bordered table-hover">
			<tr>
				<th>teamName</th>
				<td>
					<input type="text" name="teamName">
				</td>
			</tr>
			<tr>
				<th>teamCount</th>
				<td>
					<input type="text" name="teamCount">
				</td>
			</tr>
			<tr>
				<th>teamBegin</th>
				<td>
					<input type="date" name="teamBegin">
				</td>
			</tr>
			<tr>
				<th>teamEnd</th>
				<td>
					<input type="date" name="teamEnd">
				</td>
			</tr>
		</table>
		<button type="submit" class="btn btn-secondary">추가</button>
	</form>
</div>
</body>
</html>