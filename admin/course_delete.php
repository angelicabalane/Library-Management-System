<?php
	include 'includes/session.php';

	if(isset($_POST['delete'])){
		$id = $_POST['id'];

		 $sql = "CALL DeleteCourse(?)";
		 $stmt = $conn->prepare($sql);

		 if ($stmt) {
			$stmt->bind_param("i", $id);
			$stmt->execute();

        if ($stmt->affected_rows > 0) {
            $_SESSION['success'] = 'Course deleted successfully';
        } else {
            $_SESSION['error'] = 'Error deleting the Category';
        }

		  $stmt->close();
		} else {
			$_SESSION['error'] = $conn->error;
		}
	} else {
		$_SESSION['error'] = 'Select item to delete first';
	}

	header('location: course.php');
	
?>