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
	<h1 class="text-bg-secondary">직원추가</h1>
	<form action="<%=request.getContextPath()%>/addEmpAction.jsp">
		<table class="table table-bordered table-hover">
			<tr>
				<th>empName</th>
				<td>
					<input type="text" name="empName">
				</td>
			</tr>
		</table>
		<button type="submit" class="btn btn-secondary">추가</button>
	</form>
</div>
</body>
</html>