<?php 
	$id = $_GET['id'];
	$conn = mysqli_connect("localhost","root","","byzero");
	$sql ="SELECT * FROM `student` WHERE id = '$id'";
	$result = mysqli_query($conn,$sql);
	$row = mysqli_fetch_array($result,MYSQLI_ASSOC);
	
?>
<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>

<form action="update.php?id=<?php echo $row['id'] ?>" method="POST" >
User name:<input type="text" value="<?php echo $row['username'] ?>" name="username"><br><br>
Password:<input type="password" value="<?php echo $row['password'] ?>"  name="password"><br><br>
Mobile NO:<input type="number" value="<?php echo $row['mobile_number'] ?>" name="mobile_number"><br><br>
<input type="submit" value="submit">
</form>

</body>
</html>