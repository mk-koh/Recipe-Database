<?php
include_once('config.php');

// Function to handle comment submission
function setComments() {
    global $conn; 

    // Ensure session is started and user is logged in
    session_start();
    if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true) {
        echo "You must be logged in to submit a comment.";
        return;
    }

    // Get the user ID from the session
    $user_ID = $_SESSION["id"]; 

    if (isset($_POST['commentSubmit'])) {
        $recipe_ID = 2; 
        $rating = 3;  
        $message = mysqli_real_escape_string($conn, $_POST['comment']); 

        // Ensure the user ID is numeric and the comment is not empty
        if (!is_numeric($user_ID) || empty($message)) {
            echo "Invalid user ID or comment.";
            return;
        }

        // Check if recipe_ID exists in the Recipe table
        $check_recipe_sql = "SELECT 1 FROM Recipe WHERE recipe_ID = '$recipe_ID'";
        $result = mysqli_query($conn, $check_recipe_sql);
        if (mysqli_num_rows($result) == 0) {
            echo "Error: Invalid recipe_ID.";
            return;
        }

        // Construct the SQL query
        $sql = "INSERT INTO Review (recipe_ID, user_ID, rating, comment) VALUES (2, '$user_ID', '$rating', '$message')";
        echo $sql;

        // Execute the query
        if (mysqli_query($conn, $sql)) {
            echo "Comment submitted successfully!";
        } else {
            // Check for database errors and display them
            echo "Error: " . mysqli_error($conn);
        }
    }
}
?>
