<?php
include 'includes/session.php';

if (isset($_POST['add'])) {
    $isbn = isset($_POST['isbn']) ? $_POST['isbn'] : '';
    $title = isset($_POST['title']) ? $_POST['title'] : '';
    $category_id = isset($_POST['category_id']) ? $_POST['category_id'] : '';
    $author = isset($_POST['author']) ? $_POST['author'] : '';
    $publisher = isset($_POST['publisher']) ? $_POST['publisher'] : '';
    $pub_date = isset($_POST['pub_date']) ? $_POST['pub_date'] : '';
    $status = isset($_POST['status']) ? $_POST['status'] : '';

    if (empty($title)) {
        $_SESSION['error'] = 'Title cannot be null';
        header('location: book.php');
        exit;
    }

    $sql = "CALL InsertNewBook(?, ?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    
    if ($stmt) {
        $stmt->bind_param("ssisssi", $isbn, $title, $category_id, $author, $publisher, $pub_date, $status);
        
        $stmt->execute();

        if ($stmt->errno === 0) {
            $_SESSION['success'] = 'Book added successfully';
        } else {
            $_SESSION['error'] = 'Error adding the book: ' . $stmt->error;
        }

        $stmt->close();
    } else {
        $_SESSION['error'] = $conn->error;
    }
} else {
    $_SESSION['error'] = 'Fill up add form first';
}

header('location: book.php');
?>