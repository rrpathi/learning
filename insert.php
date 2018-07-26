<?php 
$username= $_POST['username'] ;
$password= $_POST['password'] ;
$mobile_number=$_POST['mobile_number'];
{
	$conn = mysqli_connect("localhost","root","","byzero");
	$sql="INSERT INTO student (username,password,mobile_number) VALUES ('$username','$password',$mobile_number)";
	$result = mysqli_query($conn,$sql);
	if ($result) {
	 	header("location:select.php");
	}	


}

