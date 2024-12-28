<?php
    require_once "config.php";
    include('header.php');
?> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Password</title>
    <link href="style.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font: 14px sans-serif;
            background-color: #F3EBF6;
        }
        .wrapper {
            width: 500px;
            height: 540px;
            padding: 30px;
            background-color: #fff;
            border-radius: 1px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .center-message {
            position: fixed;
            left: 50%;
            transform: translate(-50%, -50%);
            padding: 20px;
            background-color: #d4edda;
            color: black;
            font-size: 18px;
            border-radius: 5px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
            <h2>Update Password</h2>
            <p>Please enter your username and new password</p>
            <div class="form-group">
                <label>Username:</label>
                <input type="text" class="form-control" name="user_name" required>
            </div>
            <div class="form-group">
                <label>New password:</label>
                <input type="password" class="form-control" name="new_password" minlength="11" required>
            </div>
            <div class="form-group">
                <label>Confirm new password:</label>
                <input type="password" class="form-control" name="confirm_new_password" required>
            </div>
            <div class="form-group">
                <input type="submit" name="submit" class="btn btn-primary" value="Update Password">
            </div>
        </form>
    </div>
</body>
</html>

<?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $user_name = filter_input(INPUT_POST, "user_name", FILTER_SANITIZE_SPECIAL_CHARS);
        $new_password = filter_input(INPUT_POST, "new_password", FILTER_SANITIZE_SPECIAL_CHARS);
        $confirm_new_password = filter_input(INPUT_POST, "confirm_new_password", FILTER_SANITIZE_SPECIAL_CHARS);

        if (empty($user_name)) {
            echo "<div class='center-message'>Please enter a username.</div>";
        } elseif (empty($new_password)) {
            echo "<div class='center-message'>Please enter a new password.</div>";
        } elseif (strlen($new_password) < 11) {
            echo "<div class='center-message' style='background-color:#FF0000;'>Password must be at least 11 characters long.</div>";
        } elseif (empty($confirm_new_password)) {
            echo "<div class='center-message'>Please confirm your new password.</div>";
        } elseif ($new_password !== $confirm_new_password) {
            echo "<div class='center-message' style='background-color:#FF0000;'>New passwords do not match.</div>";
        } else {
            $sql = "SELECT user_name FROM User WHERE user_name = ?";
            if ($stmt = mysqli_prepare($conn, $sql)) {
                mysqli_stmt_bind_param($stmt, "s", $user_name);
                if (mysqli_stmt_execute($stmt)) {
                    mysqli_stmt_store_result($stmt);
                    if (mysqli_stmt_num_rows($stmt) == 1) {
                        $new_hashed_password = hash('sha512', $new_password);

                        $update_sql = "UPDATE User SET password = ? WHERE user_name = ?";
                        if ($update_stmt = mysqli_prepare($conn, $update_sql)) {
                            mysqli_stmt_bind_param($update_stmt, "ss", $new_hashed_password, $user_name);
                            if (mysqli_stmt_execute($update_stmt)) {
                                echo "<div class='center-message'>Your password has been updated successfully!</div>";
                            } else {
                                echo "<div class='center-message' style='background-color:#FF0000;'>Error updating password. Please try again.</div>";
                            }
                        }
                    } else {
                        echo "<div class='center-message' style='background-color:#FF0000;'>Username not found.</div>";
                    }
                }
                mysqli_stmt_close($stmt);
            }
        }
    }
    mysqli_close($conn);
?>
