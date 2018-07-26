<?php 
$id = $_GET['id'];
$username= $_POST['username'] ;
$password= $_POST['password'] ;
$mobile_number=$_POST['mobile_number'];
{
	$conn = mysqli_connect("localhost","root","","byzero");
	$sql="UPDATE student SET username = '$username',password = '$password',mobile_number = $mobile_number WHERE id = '$id'";
	$result = mysqli_query($conn,$sql);
	if ($result) {
	 	header("location:select.php");
	}	


}
