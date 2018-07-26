<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>
	<table border="1" width="100%">
		<tr>
			<td>username</td>
			<td>Password</td>
			<td>Number</td>
			<td>Action</td>
		</tr>
	
	<?php 
	$conn = mysqli_connect("localhost","root","","byzero");
	$sql ="SELECT * FROM `student`";
	$result = mysqli_query($conn,$sql);
	while ($row = mysqli_fetch_array($result,MYSQLI_ASSOC)) {?>
		<tr>
			<td><?php echo($row['username']);  ?></td>
			<td><?php echo($row['password']);  ?></td>
			<td><?php echo($row['mobile_number']);  ?></td>
			<td><?php 
				echo "<a href='edit.php?id=".$row['id']."'>Edit</a> / ";
				echo "<a href='delete.php?id=".$row['id']."'>delete</a>";
			 ?></td>
		</tr>
	<?php }
 ?>
 </table>
 <a href="index.php">Add more</a>
</body>
</html>