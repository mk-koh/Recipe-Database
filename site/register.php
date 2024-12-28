<?php
    require_once "config.php";
    include('header.php');
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link href="style.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #F3EBF6;
        }
        .wrapper {
            width: 500px !important;
            height: 750px !important;
            padding: 20px;
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
            <h2>Sign Up</h2>
            <p>Please fill in the credentials below</p>
            <div class="form-group">
                <label>User name:</label>
                <input type="text" name="user_name" class="form-control" required>
            </div>
            <div class="form-group">
                <label>First name:</label>
                <input type="text" name="first_name" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Last name:</label>
                <input type="text" name="last_name" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Password:</label>
                <input type="password" name="password" class="form-control" minlength="11" required>
            </div>
            <div class="form-group">
                <input type="submit" class="btn btn-primary" value="Register">
            </div>
        </form>
    </div>
</body>
</html>

<?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $user_name = filter_input(INPUT_POST, "user_name", FILTER_SANITIZE_SPECIAL_CHARS);
        $first_name = filter_input(INPUT_POST, "first_name", FILTER_SANITIZE_SPECIAL_CHARS);
        $last_name = filter_input(INPUT_POST, "last_name", FILTER_SANITIZE_SPECIAL_CHARS);
        $email = filter_input(INPUT_POST, "email", FILTER_SANITIZE_SPECIAL_CHARS);
        $password = filter_input(INPUT_POST, "password", FILTER_SANITIZE_SPECIAL_CHARS);

        if (empty($user_name)) {
            echo "Please enter a username.";
        } elseif (empty($first_name)) {
            echo "Please enter your first name.";
        } elseif (empty($last_name)) {
            echo "Please enter your last name.";
        } elseif (empty($email)) {
            echo "Please enter your email.";
        } elseif (empty($password)) {
            echo "Please enter a password.";
        } elseif (strlen($password) < 11) {
            echo "Password must be at least 11 characters long.";
        } else {
            // Check if the username or email already exists
            $sql_check = "SELECT user_name, email FROM User WHERE user_name = ? OR email = ?";
            if ($stmt_check = mysqli_prepare($conn, $sql_check)) {
                mysqli_stmt_bind_param($stmt_check, "ss", $user_name, $email);
                if (mysqli_stmt_execute($stmt_check)) {
                    mysqli_stmt_store_result($stmt_check);
                    if (mysqli_stmt_num_rows($stmt_check) > 0) {
                        echo "<div class='center-message' style='background-color:#FF0000;'>Username or email already exists. Please choose a different one.</div>";
                    } else {
                        $new_hashed_password = hash('sha512', $password);
                        $sql = "INSERT INTO `User`(`first_name`, `last_name`, `email`, `user_name`, `password`) 
                                VALUES ('$first_name','$last_name','$email','$user_name','$new_hashed_password')";

                        if (mysqli_query($conn, $sql)) {
                            echo "<div class='center-message'>You have signed up!</div>";
                        } else {
                            echo "Something went wrong. Please try again.";
                        }
                    }
                }
                mysqli_stmt_close($stmt_check);
            }
        }
    }

    mysqli_close($conn);
?>
