<?php 
    session_start();
    include('config.php'); 
    include('header.php');

    if(isset($_GET['recipe_ID'])) {
        $recipe_id = mysqli_real_escape_string($conn, $_GET['recipe_ID']);

        //recipe
        $sql = "SELECT * FROM Recipe WHERE recipe_ID = $recipe_id";
        $result = mysqli_query($conn, $sql);
        
        if ($result) {
            $Recipe = mysqli_fetch_assoc($result);
            mysqli_free_result($result);
        } else {
            echo "Error fetching recipe details: " . mysqli_error($conn);
        }

        //ingredients
        $ingredient_sql = "
            SELECT i.ingredient_name, i.food_grp, ri.quantity, ri.unit 
            FROM Recipe_Ingredient ri
            JOIN Ingredient i ON ri.ingredient_ID = i.ingredient_ID
            WHERE ri.recipe_ID = $recipe_id
        ";
        $ingredient_result = mysqli_query($conn, $ingredient_sql);

        if ($ingredient_result) {
            $Ingredients = mysqli_fetch_all($ingredient_result, MYSQLI_ASSOC);
            mysqli_free_result($ingredient_result);
        } else {
            echo "Error fetching ingredients: " . mysqli_error($conn);
        }

        //steps
        $step_sql = "
            SELECT step_num, direction 
            FROM Step 
            WHERE recipe_ID = $recipe_id
            ORDER BY step_num
        ";
        $step_result = mysqli_query($conn, $step_sql);

        if ($step_result) {
            $Steps = mysqli_fetch_all($step_result, MYSQLI_ASSOC);
            mysqli_free_result($step_result);
        } else {
            echo "Error fetching steps: " . mysqli_error($conn);
        }

        //nutrition
        $nutrition_sql = "
            SELECT * FROM Nutrition WHERE recipe_ID = $recipe_id
        ";
        $nutrition_result = mysqli_query($conn, $nutrition_sql);

        if ($nutrition_result) {
            $Nutrition = mysqli_fetch_all($nutrition_result, MYSQLI_ASSOC);
            mysqli_free_result($nutrition_result);
        } else {
            echo "Error fetching nutrition: " . mysqli_error($conn);
        }

        // Review
        $review_sql = "
            SELECT r.rating, r.comment, u.user_name 
            FROM Review r
            JOIN User u ON r.user_ID = u.user_ID
            WHERE r.recipe_ID = $recipe_id
        ";
        $review_result = mysqli_query($conn, $review_sql);

        if ($review_result) {
            $Review = mysqli_fetch_all($review_result, MYSQLI_ASSOC);
            mysqli_free_result($review_result);
        } else {
            echo "Error fetching reviews: " . mysqli_error($conn);
        }



        mysqli_close($conn);
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <div class="card mt-4" style="background-color: #ffe6f2;">
        <?php if($Recipe): ?>
            <br><br><h4 style="text-align: center; font-weight: bold;"><?php echo htmlspecialchars($Recipe['name']); ?></h4><br>
        <?php endif; ?>
    </div>
</head>

<body>
    <!-- recipe -->
    <?php if($Recipe): ?>
            <div class="card mt-4">
                <div class="card-body">
                    <p><strong>Description:</strong> <?php echo htmlspecialchars($Recipe['description']); ?></p>
                    <p><strong>Category:</strong> <?php echo htmlspecialchars($Recipe['category']); ?></p>
                    <p><strong>Flavor:</strong> <?php echo nl2br(htmlspecialchars($Recipe['flavor'])); ?></p>
                    <p><strong>Servings:</strong> <?php echo nl2br(htmlspecialchars($Recipe['servings'])); ?></p>
                    <p><strong>Prep Time:</strong> <?php echo nl2br(htmlspecialchars($Recipe['prep_time'])); ?></p>
                    <p><strong>Cook Time:</strong> <?php echo nl2br(htmlspecialchars($Recipe['cook_time'])); ?></p>
                    <p><strong>Preparation:</strong> <?php echo nl2br(htmlspecialchars($Recipe['preparation'])); ?></p>
                </div>
            </div>
        <?php endif; ?>

    <!-- \Ingredients\ -->
    <?php if (!empty($Ingredients)): ?>
        <div class="card mt-4">
            <div class="card-body">
                <h4>Ingredients:</h4>
                <ul>
                    <?php foreach($Ingredients as $ingredient): ?>
                        <li>
                            <?php echo htmlspecialchars($ingredient['quantity']); ?>
                            <?php echo htmlspecialchars($ingredient['unit']); ?>
                            of <?php echo htmlspecialchars($ingredient['ingredient_name']); ?> 
                            (<?php echo htmlspecialchars($ingredient['food_grp']); ?>)
                        </li>
                    <?php endforeach; ?>
                </ul>
            </div>
        </div>
    <?php else: ?>
        <!-- <p>No ingredients found for this recipe.</p> -->
    <?php endif; ?>

    <!-- Steps -->
    <?php if (!empty($Steps)): ?>
        <div class="card mt-4">
            <div class="card-body">
                <h4>Steps:</h4>
                <ol>
                    <?php foreach($Steps as $step): ?>
                        <p>
                            Step <?php echo htmlspecialchars($step['step_num']); ?>:
                            <?php echo nl2br(htmlspecialchars($step['direction'])); ?>
                    </p>
                    <?php endforeach; ?>
                </ol>
            </div>
        </div>
    <?php else: ?>
        <!-- <p>No steps found for this recipe.</p> -->
    <?php endif; ?>

    <!-- Nutition -->
    <?php if (!empty($Nutrition)): ?>
        <div class="card mt-4">
            <div class="card-body">
                <h4>Nutrition:</h4>
                <ul>
                    <?php foreach($Nutrition as $nutrition): ?>
                        <p>
                            Calories: <?php echo htmlspecialchars($nutrition['calories']); ?> kcal <br> 
                            Fat: <?php echo htmlspecialchars($nutrition['fat']); ?> g <br>
                            Cholesterol: <?php echo htmlspecialchars($nutrition['cholesterol']); ?> mg <br>
                            Sodium: <?php echo htmlspecialchars($nutrition['sodium']); ?> mg <br>
                            Carbohydrates: <?php echo htmlspecialchars($nutrition['carbohydrate']); ?> g <br>
                            Protein: <?php echo htmlspecialchars($nutrition['protein']); ?> g
                    </p>
                    <?php endforeach; ?>
                    </ul>
            </div>
        </div>
    <?php else: ?>
        <!-- <p>No nutrition found for this recipe.</p> -->
    <?php endif; ?>


    <!-- Review -->
    <div class="card mt-4">
        <div class="card-body">
            <h4>Reviews:</h4>
            <?php if (!empty($Review)): ?>
                        <ol>
                            <?php foreach($Review as $review): ?>
                                <li>
                                    <?php echo htmlspecialchars($review['user_name']); ?><br> 
                                    ---------------------------<br> 
                                    Rating: <?php echo htmlspecialchars($review['rating']); ?><br> 
                                    Comment: <?php echo nl2br(htmlspecialchars($review['comment'])); ?><br><br>
                                </li>
                            <?php endforeach; ?>
                        </ol>
            <?php else: ?>
                <p style="padding:10px">No reviews yet! Be the first to leave a review!</p>
            <?php endif; ?>
        </div>
    </div>
    <div class="card mt-4">
        <div class="card-body">
            <form method='POST' action="">
                <fieldset class="star-rating">
                    <div>
                        <input type="radio" name="rating" value="1" id="rating1" />
                        <label for="rating1"><span>1</span></label>
                        <input type="radio" name="rating" value="2" id="rating2" />
                        <label for="rating2"><span>2</span></label>
                        <input type="radio" name="rating" value="3" id="rating3" />
                        <label for="rating3"><span>3</span></label>
                        <input type="radio" name="rating" value="4" id="rating4" />
                        <label for="rating4"><span>4</span></label>
                        <input type="radio" name="rating" value="5" id="rating5" />
                        <label for="rating5"><span>5</span></label>
                    </div>
                    <textarea name='message'></textarea>
                    <input type="hidden" name="recipe_ID" value="<?php echo htmlspecialchars($Recipe['id']); ?>">
                    <?php if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true): ?>
                    <p>You must <a href="login.php?redirect_to=index.php<?php echo urlencode($_SERVER['REQUEST_URI']); ?>">log in </a>to leave a comment.</p>
                    <?php else: ?>
                    <button name='commentSubmit' type='submit'>Comment</button>
                    <?php endif; ?>
                    </form>
                    <br><a href="index.php" class="btn btn-primary mt-3">Back to Recipes</a>
            </div>
    </div>
</body>
</html>
