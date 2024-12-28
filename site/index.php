<?php 
session_start();
include('config.php'); 
include('header.php');
?>

<!DOCTYPE html>
<html lang="en">
<head>   

</head>
<body>

    <section id="food">
        <div class="card card-food-list">
        <br> <br> <br>
        <h1 class="text-center" style="font-size: 40px; font-weight: bold;">Recipes</h1>
            <div class="mt-4">
                <div class="row">
                    <div class="col-md-2 mr-auto">
                        <!-- <button type="button" class="btn btn-add-food btn-secondary" data-toggle="modal" data-target="#addRecipeModal">Add Recipe</button> -->
                    </div>
                    <div class="col-md-2">
                        <!-- <input class="form-control p-4" type="text" id="searchInput" placeholder="Search..."> -->
                    </div>
                </div>
            </div>

            
            <table id="foodListTable" class="table table-responsive mt-4" style="text-align:center;">
                <thead>
                    <tr>
                    <th scope="col" style="width: 5%;">Food ID</th>
                    <!-- <th scope="col" style="width: 10%;">Recipe Image</th> -->
                    <th scope="col" style="width: 10%;">Recipe Name</th>
                    <th scope="col" style="width: 10%;">Category</th>
                    <th scope="col" style="width: 10%;">Action</th>
                    </tr>
                </thead>
                <tbody>

                    <?php 
                    
                    $stmt = $conn->prepare("
                        SELECT * 
                        FROM 
                            Recipe
                        ");
                    $stmt->execute();

                    $result = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

                    foreach ($result as $row) {
                        $recipeID = $row['recipe_ID'];
                        $name = $row['name'];
                        $categoryName = $row['category'];
                        $recipeProcedure = $row['preparation'];
                        ?>

                        <tr>
                            <th id="recipeID-<?php echo $recipeID ?>"><?php echo $recipeID ?></th>
                            <!-- <td id="recipeImage-<?php echo $recipeID ?>"><img src="http://localhost/my-food-recipe/uploads/<?php echo $recipeImage ?>" class="img-fluid" style="height: 50px; width: 90px" alt="Recipe Image"></td> -->
                            <td id="recipeName-<?php echo $recipeID ?>"><?php echo $name ?></td>
                            <td id="categoryName-<?php echo $recipeID ?>"><?php echo $categoryName ?></td>
                            <td>
                            <form method="GET" action="view.php">
                                <input type="hidden" name="recipe_ID" value="<?php echo $recipeID; ?>">
                                <button type="submit" class="btn btn-primary">View Recipe</button>
                            </form>
                            </td>
                        </tr>


                        <?php
                    }
                    ?>
                    
                </tbody>
            </table>
        </div>

    </section>

</body>
</html>
<?php 
    mysqli_close($conn);
?>