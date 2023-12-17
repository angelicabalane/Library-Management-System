<?php
include 'includes/session.php';

if (isset($_POST['delete'])) {
    $id = $_POST['id'];

    $sql = "CALL DeleteBook(?)";
    $stmt = $conn->prepare($sql);

    if ($stmt) {
        $stmt->bind_param("i", $id);
        $stmt->execute();

        if ($stmt->affected_rows > 0) {
            $_SESSION['success'] = 'Book deleted successfully';
        } else {
            $_SESSION['error'] = 'Error deleting the book';
        }

        $stmt->close();
    } else {
        $_SESSION['error'] = $conn->error;
    }
} else {
    $_SESSION['error'] = 'Select item to delete first';
}

header('location: book.php');
?>