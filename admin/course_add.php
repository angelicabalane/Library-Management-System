<?php
include 'includes/session.php';

if (isset($_POST['add'])) {
    $code = isset($_POST['code']) ? $_POST['code'] : '';
    $title = isset($_POST['title']) ? $_POST['title'] : '';

    if (empty($title)) {
        $_SESSION['error'] = 'Title cannot be null';
        header('location: course.php');
        exit;
    }

    $sql = "CALL InsertNewCourse(?, ?)";
    $stmt = $conn->prepare($sql);

    if ($stmt) {
        $stmt->bind_param("ss", $code, $title);
        
        if ($stmt->execute()) {
            $_SESSION['success'] = 'Course added successfully';
        } else {
            $_SESSION['error'] = 'Error adding the course: ' . $stmt->error;
        }

        $stmt->close();
    } else {
        $_SESSION['error'] = 'Error preparing statement: ' . $conn->error;
    }
} else {
    $_SESSION['error'] = 'Fill up add form first';
}

header('location: course.php');
?>
