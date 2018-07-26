<?php 
$id = $_GET['id'];

$conn = mysqli_connect("localhost","root","","byzero");
$sql="DELETE FROM student WHERE id = '$id'";
$result = mysqli_query($conn,$sql);
if ($result) {
	header('Location:select.php');
}
else{
	header('Location:select.php');	
}