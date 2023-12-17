<?php
	include 'includes/session.php';

	if(isset($_POST['delete'])){
		$id = $_POST['id'];

		 $sql = "CALL DeleteStudent(?)";
		 $stmt = $conn->prepare($sql);

		 if ($stmt) {
			$stmt->bind_param("i", $id);
			$stmt->execute();

        if ($stmt->affected_rows > 0) {
            $_SESSION['success'] = 'Student deleted successfully';
        } else {
            $_SESSION['error'] = 'Error deleting the Student';
        }

		  $stmt->close();
		} else {
			$_SESSION['error'] = $conn->error;
		}
	} else {
		$_SESSION['error'] = 'Select item to delete first';
	}

	header('location: student.php');
	
?>