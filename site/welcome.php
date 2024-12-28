<?php
session_start();
// Check if the user is logged in, if not then redirect him to login page
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true) {
    header("location: index.php");
    exit;
}

require_once "config.php"; 
// include('header.php');
include('header.php');

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// Query for recipe names
$sql = 'SELECT name FROM Recipe';

$result = mysqli_query($conn, $sql);

if ($result) {
    $names = mysqli_fetch_all($result, MYSQLI_ASSOC);
    mysqli_free_result($result);
} else {
    echo "Error with the query: " . mysqli_error($conn);
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
</head>
<body>
    <br><h1 class="my-5">Hi, <b style="font-size: 25px"><?php echo htmlspecialchars($_SESSION["user_name"]); ?></b>. Welcome to our site. Click on the top left corner to look through our recipes. </h1>
    <style>
        h1{ font: 25px Georgia; text-align: center; }
        p{text-align: center}
    </style>
    <p>
        <a href="reset-password.php" class="btn btn-warning">Reset Your Password</a>
        <a href="logout.php" class="btn btn-danger ml-3" style="background-color: orange ; color: black">Sign Out of Your Account</a><a href="delete.php?id=<?php echo $_SESSION['user_ID']; ?>"class="btn btn-danger ml-3" style="background-color: red; color: black">Delete Your Account</a>

    </p>
    <?php
    mysqli_close($conn); 
    ?>

</body>
</html>
