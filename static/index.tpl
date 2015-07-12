<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NetSuite Tree Manager</title>
<style type="text/css">
table, tr, td, th { 
	border: 1px solid;
	text-align: center;
}
</style>
</head>

<body>
<table>
	<caption>Tree Manager</caption>
	<tr>
		<th style="width: 30px">Depth</th>
		<th>Tree Nodes</th>
	</tr>
	<? body ?>
</table>
<form name="New Pid" action="write" method="POST">
	Add Node to: <input type="text" name="pid" size="10" value="PID"> <strong style="color: red;"> <? error ?></strong>
	<br><input type="submit" value="Add"><br>
	</form>
</body>

</html>
