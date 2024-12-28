SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS Recipe;
DROP TABLE IF EXISTS Step;
DROP TABLE IF EXISTS Ingredient;
DROP TABLE IF EXISTS Recipe_Ingredient;
DROP TABLE IF EXISTS Nutrition;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Review;
# ... 
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE Recipe (
    recipe_ID INT auto_increment,
    name VARCHAR(255) NOT NULL,
    description text NOT NULL,
    category ENUM('Breakfast', 'Lunch/Dinner', 'Snack', 'Dessert', 'Drink', 'Appetizer', 'Curry'),
    flavor ENUM('Sweet', 'Sour', 'Salty', 'Bitter', 'Umami', 'Mild', 'Spicy'),
    servings INT NOT NULL,
    prep_time INT,
    cook_time INT NOT NULL,
    preparation text,
    PRIMARY KEY(recipe_ID)
);

CREATE TABLE Step(
    step_ID INT auto_increment PRIMARY KEY,
    recipe_ID INT NOT NULL,
    step_num INT NOT NULL,
    direction VARCHAR(255) NOT NULL,
    FOREIGN KEY (recipe_ID) 
        REFERENCES Recipe(recipe_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Ingredient(
    ingredient_ID INT auto_increment PRIMARY KEY,
    ingredient_name VARCHAR(255) NOT NULL,
    food_grp ENUM('Fruit', 'Vegetable', 'Grain', 'Protein', 'Dairy', 'Sugar', 'Oil', 'Beverage', 'Spice', 'Seed', 'Salt')
);



CREATE TABLE Recipe_Ingredient (
recipe_ID INT NOT NULL, 
ingredient_ID INT NOT NULL,
quantity DECIMAL(4, 2) NOT NULL, 
unit ENUM('Teaspoon', 'Tablespoon', 'Cup', 'Milliliter', 'Liter', 'Gram', 'Kilogram', 'Ounce', 'Pound', 'Piece', 'Whole', 'Slice', 'Pinch', 'Stem', 'Can') NOT NULL, 
PRIMARY KEY (recipe_ID, ingredient_ID), 
FOREIGN KEY (recipe_ID) REFERENCES Recipe(recipe_ID) ON DELETE CASCADE,
FOREIGN KEY (ingredient_ID) REFERENCES Ingredient(ingredient_ID) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Nutrition (
recipe_ID INT NOT NULL,
calories INT NOT NULL, 
fat INT NOT NULL,
cholesterol INT NOT NULL, 
sodium INT NOT NULL, 
carbohydrate INT NOT NULL,
protein INT NOT NULL, 
PRIMARY KEY (recipe_ID),
FOREIGN KEY (recipe_ID) REFERENCES Recipe(recipe_ID) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE User (
user_ID INT AUTO_INCREMENT PRIMARY KEY, 
first_name VARCHAR(255) NOT NULL, 
last_name VARCHAR(255) NOT NULL, 
email VARCHAR(255) NOT NULL UNIQUE, 
user_name VARCHAR(255) NOT NULL UNIQUE,
password VARCHAR(255) NOT NULL,
CHECK (CHAR_LENGTH(password) > 10) 
);

CREATE TABLE Review (
review_ID INT AUTO_INCREMENT PRIMARY KEY,
recipe_ID INT NOT NULL, 
user_ID INT NOT NULL, 
rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5), 
comment VARCHAR(255) NULL, 
FOREIGN KEY (recipe_ID) REFERENCES Recipe(recipe_ID) ON DELETE CASCADE,
FOREIGN KEY (user_ID) REFERENCES User(user_ID) ON DELETE CASCADE
);

-- Recipe Table Data
INSERT INTO Recipe(name, description, category, flavor, servings, prep_time, cook_time, preparation) VALUES ('Egg Curry', 'This aromatic and flavorful Egg Curry combines boiled eggs, tender potatoes, and a rich, spiced coconut milk base. The dish features warm mustard seeds, curry leaves, and classic Indian spices, creating a comforting blend of creamy and spicy flavors. The recipe harmoniously balances earthy turmeric, spicy chili powder, and sweet coconut milk, while dried fenugreek seeds add a distinctive, subtle bitterness.

    This easy-to-prepare dish pairs perfectly with steamed rice, naan, or roti. A garnish of fresh coriander leaves adds both flavor and visual appeal, making it an ideal choice for family dinners or special occasions.', 'Curry', 'Mild', 4, 15, 40, '
    1. Boil the eggs for approximately 10 minutes.
    2. Thinly slice the onion, ginger, and garlic. Then slice the green chili vertically.
    3. Cut the potato into cubes. 
    4. Divide the coconut milk into two bowls. Dilute one bowl of coconut milk with an equal amount of water.');
INSERT INTO Recipe(name, description, category, flavor, servings, prep_time, cook_time, preparation) VALUES ('Tea', 'This classic Homemade Tea is a comforting beverage that tea lovers will cherish. The equal blend of milk and water creates a creamy, smooth texture that perfectly complements the robust tea flavor. You can adjust the sweetness to your preference, striking the ideal balance between richness and sweetness.

    Using just a few simple ingredients, this tea comes together in minutes. The traditional method of pouring between cups aerates the tea, creating a silky smoothness with a lovely frothy top.', 'Drink','Mild', 2, NULL , 5, NULL);
INSERT INTO Recipe(name, description, category, flavor, servings, prep_time, cook_time, preparation) VALUES ('Beetroot Stir-Fry', 'This vibrant and flavorful Beets showcases the natural sweetness and earthy flavor of beets. Aromatic onions, garlic, and green chilis enhance the dish, while chili powder, turmeric, and salt create a perfect balance of heat and spice.

The beets are cooked to a tender-crisp texture, allowing the spices to infuse deeply while maintaining their vibrant color and subtle sweetness. This simple yet nourishing dish complements rice or flatbreads beautifully. It is a quick, healthy, and crowd-pleasing addition to any meal!', 'Lunch/Dinner', 'Sweet', 5, 15, 20, '
    1. Trim the leaves from the beets and peel the skin.
    2. Cut the beets into thin-medium slices, then cut each slice into smaller pieces.
    3. Thinly slice the onion and garlic. Slice the green chilis lengthwise');
INSERT INTO Recipe(name, description, category, flavor, servings, prep_time, cook_time, preparation) VALUES ('Chicken Roast', 'The Chicken Curry is packed with bold flavors, combining tender chicken thighs with a rich blend of spices. The dish is seasoned with a mix of chili powder, turmeric, coriander, and garam masala, creating a fragrant and flavorful curry base.
    The juicy chicken pieces are cooked until tender, and absorbing all the spices. This dish is a perfect accompaniment to rice or naan. This comforting curry will make a satisfying and flavorful meal for any occasion.', 'Lunch/Dinner', 'Mild', 4, 10, 40, '
    1. Thinly slice the onion, ginger, and garlic. Then slice the green chili vertically.
    2. Cut the chicken pieces like each thigh piece in four parts.');
    INSERT INTO Recipe(name, description, category, flavor, servings, prep_time, cook_time, preparation) VALUES ('Hotdog and Egg', 'This quick and savory hotdog stir-fry blends the flavors of spiced masala, tender eggs, and aromatic garlic and ginger. Boiled hotdog pieces are sautéed with onions, green chilies, and a mix of fragrant spices, then combined with eggs for a hearty, flavorful dish. It is a simple yet delicious recipe ideal for a quick meal.', 'Lunch/Dinner', 'Mild', 4, 15, 20, '
    1. Boil the hotdogs in a saucepan for about 10 minutes.
    2. Cut the green chilies vertically and thinly slice the onions and garlic.
    3. Remove the hotdogs from the saucepan. Once cooled, slice them as desired. For this recipe, we diced the hotdogs into small cubes
');
    INSERT INTO Recipe(name, description, category, flavor, servings, prep_time, cook_time, preparation) VALUES ('Chicken Curry', 'This flavorful chicken curry combines tender chicken thighs with aromatic spices, curry leaves, and creamy coconut milk. Slow-cooked to perfection, it features a rich, spicy masala base made with onions, tomatoes, garlic, and ginger. Perfect for a hearty meal, this dish pairs wonderfully with rice or chapati.', 'Curry', 'Mild', 10, 30, 40, '
    1. Thinly slice the onions and ginger, and vertically cut the green chilis.
    2. Smash the ginger and garlic with a mortar and pestle.
cut the chicken as desired into medium pieces.
    3. Cut the tomatoes finely. Make sure they do not break.
');

-- Step Table Data
INSERT INTO Step(step_num, recipe_ID, direction) VALUES 
    (1,1, 'Place the potatoes in a saucepan and cover with water. Boil over medium hear until softened.'); 
INSERT INTO Step(step_num, recipe_ID, direction) VALUES  (2, 1, 'Heat some oil in a separate pan. Once the oil is hot, add the mustard seeds and wait for them to crackle.'); 
INSERT INTO Step(step_num, recipe_ID, direction) VALUES  (3, 1, 'Stir in the onion, ginger, garlic, green chilis, and curry leaves. Sautee them until the onions are translucent.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES  (4, 1, 'Add the chili powder, turmeric powder, coriander powder, and garam masala. Sautee briefly.'); 
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (5, 1, 'Stir in the tomatoes and cook until softened.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES  (6, 1, 'Add the potatoes and the dried fenugreek seeds. Stir well.'); 
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (7, 1, 'Bring the curry to a boil, then stir in the diluted coconut milk and bring back to a boil.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (8, 1, 'Stir in the undiluted coconut milk and wait for the steam to rise. Remove the pan from heat.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (9, 1, 'Peel the boiled eggs and add them to the curry.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (10,1, 'Garnish with coriander leaves.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (11,1, 'Allow the curry to sit for a few minutes to allow the flavors to blend before serving.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES ( 1, 2, 'Combine water and milk in a saucepan.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES ( 2, 2, 'Heat the saucepan over medium-high heat until the mixture begins to bubble around the edges.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES ( 3, 2, 'Stir in the tea powder and allow the milk to boil and rise.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES ( 4, 2, 'Pour the mixture through a fine-mesh strainer to remove the tea powder.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES ( 5, 2, 'Add sugar to taste and stir to dissolve ');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES ( 6, 2, 'Pour the tea into a cup and aerate by pouring it back and forth between two cups a few times.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES ( 7, 2, 'Pour the tea into a mug and enjoy your tea.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (1, 3, 'Heat a pan in medium-high heat.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (2, 3, 'Once the oil is hot, add fennel seeds.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (3, 3, 'After a brief time, stir in the onion, garlic, and green chilis. Sautee until the onions become translucent.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (4, 3, 'Add the chili powder, turmeric powder, and salt. Sautee briefly.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (5, 3, 'Stir the beets into the pan.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (6, 3, 'Cover the pan and cook while stirring in 3-5 minute intervals until the beets are semi-soft.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (7, 3, 'When the beets are almost cooked, remove the lid and cook over high heat for 3-5 minutes, stirring frequently.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (8, 3, 'Once the beets are cooked, remove the pan from the heat and leave the lid slightly open to allow the steam to escape.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (1,4,'Heat some oil in a pan. Once the oil is hot, stir in the onion, green chili, and curry leaves. Sautee them until the onions are translucent.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (2,4,'Smash the ginger and garlic with a mortar and pestle. and add it to the heat');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (3,4,'Add the spices. (Add the chili powder, turmeric powder, coriander powder, and garam masala. Sautee briefly.)');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (4,4,'Stir in the tomatoes and close the pan with a lid. Let it cook until the tomatoes have softened.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (5,4,'Add in the chicken, coat them with the masala, and close the lid. Add 2 more tsp of salt. Stir them in 5-10 minute intervals for 30 minutes in low-medium heat.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (6,4,'Once there is a quite bit of water open the lid and let it cook until the water boils down.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (7,4,'Allow the curry to sit for a few minutes to allow the flavors to blend before serving.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (1,5,'Heat the oil in a pan over medium heat.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (2,5,'When the oil is hot, add the garlic and ginger.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (3,5,'Sautee until the garlic and ginger turn slightly brown. Then add the onions and green chilies, and sautee until fragrant.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (4,5,'In a bowl, beat the eggs until well mixed.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (5,5,'Add the chicken masala, Kashmiri chili powder, coriander, turmeric, and salt to the pan. Sautee until the spices are evenly mixed.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (6,5,'Add the diced hotdogs to the pan and mix well with the masala.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (7,5,'Once the hotdogs are coated with the spices, create a small well in the center of the pan, pushing the hotdogs to the sides. Pour the beaten eggs into the well.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (8,5,'Allow the eggs to cook halfway, then mix everything together thoroughly.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (9,5,'Cook for an additional 2–3 minutes or until the eggs are fully cooked. Remove the pan from the heat and serve');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (1,6,'Heat some oil in a pan. Once the oil is hot, stir in the onion, green chili, and curry leaves. Sautee them until the onions are translucent.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (2,6,'Add the ginger and garlic to heat. Mix well.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (3,6,'Add the spices. (Add the chili powder, turmeric powder, coriander powder, and garam masala. Sautee briefly.)');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (4,6,'Stir in the tomatoes and close the pan with a lid. Let it cook until the tomatoes have softened.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (5,6,'Add in the chicken, coat them with the masala and close the lid. Add 2 more tsp of salt. Stir them in 5-10 minute intervals for 30 minutes in low-medium heat. ');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (6,6,'Once there is a quite bit of water open the lid and let it cook until the water boils down.');
INSERT INTO Step(step_num, recipe_ID, direction) VALUES (7,6,'Allow the curry to sit for a few minutes to allow the flavors to blend before serving.');


-- Ingredient Table Data
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Egg', 'Protein');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Onion', 'Vegetable');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Ginger', 'Vegetable');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Garlic', 'Vegetable');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Green Chili', 'Vegetable');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Potato', 'Vegetable');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Vegetable Oil', 'Oil');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Mustard Seeds', 'Seed');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Curry Leaves', 'Vegetable');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Chili Powder', 'Spice');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Turmeric Powder', 'Spice');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Coriander Powder', 'Spice');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Coconut Milk', 'Dairy');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Garam Masala', 'Fruit');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Dried fenugreek seeds', 'Seed');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Tomatoes', 'Protein');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Coriander Leaves', 'Vegetable');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Milk', 'Dairy');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Water', 'Beverage');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Tea Powder', 'Spice');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Sugar', 'Sugar');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Beets', 'Vegetable');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Salt', 'Salt');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Chicken', 'Protein');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Chicken Masala' ,'Spice');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Hotdog' ,'Protein');
INSERT INTO Ingredient (ingredient_name, food_grp) VALUES ('Kashmiri Chili Powder' ,'Spice');


-- Recipe_Ingredient
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('1', '1', '4', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('1', '2', '1', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('1', '3', '0.5', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('1', '4', '3', 'Piece');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('1', '5', '3', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('1', '6', '2', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('1', '7', '4', 'Tablespoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('1', '8', '1', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('1', '9', '1', 'Stem');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('1', '10', '0.5', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('1', '11', '0.25', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('1', '12', '2', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('1', '13', '0.25', 'Can');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('1', '14', '0.5', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('1', '15', '0.75', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('1', '16', '1', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('1', '17', '5', 'Stem');

INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('2', '18', '1', 'Cup');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('2', '19', '1', 'Cup');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('2', '20', '3', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('2', '21', '2', 'Teaspoon');

INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('3', '22', '3', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('3', '2', '2', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('3', '4', '3', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('3', '5', '3', 'Piece');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('3', '7', '4', 'Tablespoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('3', '10', '1', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('3', '11', '0.25', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('3', '23', '0.25', 'Teaspoon');

INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('4', '24', '1', 'Pound');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('4', '2', '4', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('4', '3', '2', 'Piece');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('4', '4', '11', 'Piece');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('4', '5', '3', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('4', '7', '3', 'Tablespoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('4', '23', '1', 'Pinch');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('4', '9', '1', 'Stem');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('4', '10', '0.75', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('4', '11', '0.5', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('4', '12', '3', 'Tablespoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('4', '25', '0.5', 'Tablespoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('4', '14', '1', 'Tablespoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('4', '16', '1', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('4', '17', '6', 'Stem');

INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('5', '2', '2', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('5', '5', '6', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('5', '26', '8', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('5', '7', '1', 'Tablespoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('5', '1', '2', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('5', '4', '3', 'Piece');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('5', '3', '1', 'Piece');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('5', '25', '1', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('5', '12', '1', 'Tablespoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('5', '11', '0.25', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('5', '23', '1', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('5', '27', '1', 'Teaspoon');

INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('6', '24', '5', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('6', '2', '3', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('6', '3', '2', 'Piece');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('6', '4', '10', 'Piece');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('6', '5', '9', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('6', '7', '5', 'Tablespoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('6', '10', '3', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('6', '9', '2', 'Stem');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('6', '25', '2', 'Tablespoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('6', '14', '1', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('6', '16', '2', 'Whole');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('6', '11', '1', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('6', '12', '7', 'Tablespoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('6', '23', '3', 'Teaspoon');
INSERT INTO Recipe_Ingredient (recipe_ID, ingredient_ID, quantity, unit)
VALUES ('6', '13', '1', 'Can');



-- Nutrition
INSERT INTO Nutrition (recipe_id, calories, fat, cholesterol, sodium, carbohydrate, protein)
VALUES ('1','256', '17', '148', '70', '19', '6');
INSERT INTO Nutrition (recipe_id, calories, fat, cholesterol, sodium, carbohydrate, protein)
VALUES ('2', '50', '1', '5', '30', '8', '2');
INSERT INTO Nutrition (recipe_id, calories, fat, cholesterol, sodium, carbohydrate, protein)
VALUES ('3', '110', '7', '0', '250', '12', '2');
INSERT INTO Nutrition (recipe_id, calories, fat, cholesterol, sodium, carbohydrate, protein)
VALUES ('4', '280', '18', '85', '400', '12', '20');
INSERT INTO Nutrition (recipe_id, calories, fat, cholesterol, sodium, carbohydrate, protein)
VALUES ('5', '190', '12', '85', '700', '6', '9');
INSERT INTO Nutrition (recipe_id, calories, fat, cholesterol, sodium, carbohydrate, protein)
VALUES ('6', '235', '16', '55', '800', '8', '15');

-- User Table
INSERT INTO User(first_name, last_name, email, user_name, password) VALUES ('Megan', 'John', 'johnme@gmail.com', 'Megan_J', SHA2('megan@12434', 512));
INSERT INTO User(first_name, last_name, email, user_name, password) VALUES ('Rachel', 'Green', 'greenra@gmail.com', 'Rachel_G', SHA2('rachel@1039', 512));
INSERT INTO User(first_name, last_name, email, user_name, password) VALUES ('Monica', 'Bing', 'bingmo@gmail.com', 'Monica_B', SHA2('monica@48536', 512));
INSERT INTO User(first_name, last_name, email, user_name, password) VALUES ('Phoebe', 'Buffay', 'buffayph@gmail.com', 'Phoebe_B', SHA2('phoebe@95396', 512));
INSERT INTO User(first_name, last_name, email, user_name, password) VALUES ('Ross', 'Chandler', 'chandlerro@gmail.com', 'Ross_C', SHA2('ross@853784', 512));
INSERT INTO User (first_name, last_name, email, user_name, password) 
VALUES('John', 'Doe', 'johndoe@example.com', 'johnd', SHA2('password1234', 512));
INSERT INTO User (first_name, last_name, email, user_name, password) 
VALUES('Jane', 'Smith', 'janesmith@example.com', 'janes', SHA2('password479',512));
INSERT INTO User (first_name, last_name, email, user_name, password) 
VALUES('Alex', 'Johnson', 'alexjohnson@example.com', 'alexj', SHA2('password380',512));
INSERT INTO User (first_name, last_name, email, user_name, password) 
VALUES('Maria', 'Smith', 'mariasmith@example.com', 'marias', SHA2('password200', 512));
INSERT INTO User (first_name, last_name, email, user_name, password) 
VALUES('David', 'Brown', 'davidbrown@example.com', 'davidb', SHA2('password543',512));

-- Review Table
INSERT INTO Review (recipe_ID, user_ID, rating, comment) VALUES (2, 1, 4,'I followed the recipe exactly, and the balance of tea, milk, and sugar was spot-on!');
INSERT INTO Review (recipe_ID, user_ID, rating, comment) VALUES (4, 5, 3,'The chicken was cooked well, and the recipe was straigtfowars, but the flavors did not quite pop for me. I felt it might need more seasoning.');
INSERT INTO Review (recipe_ID, user_ID, rating, comment) VALUES (1, 4, 5,'The flavors were amazing! I loved the combination of spices');
INSERT INTO Review (recipe_ID, user_ID, rating, comment) VALUES (2, 2, 5,NULL);
INSERT INTO Review (recipe_ID, user_ID, rating, comment) VALUES (2, 3, 4,NULL);
INSERT INTO Review (recipe_ID, user_ID, rating, comment) VALUES (3, 2, 5,'Very tasty, I paired it with some yogurt and chapati for a light lunch.');
INSERT INTO Review (recipe_ID, user_ID, rating, comment) VALUES (1, 3, 3,'Perfect for dinner. The curry paired beautifully with steamed rice. I feel like it could use a touch or more seasoning.');
INSERT INTO Review (recipe_ID, user_ID, rating, comment) VALUES (3, 10, 5,'A delicious dish. The coconut was a delightful addition.');
INSERT INTO Review (recipe_ID, user_ID, rating, comment) 
VALUES(1, 7, 5, 'This recipe was amazing! Very easy to follow and delicious.');
INSERT INTO Review (recipe_ID, user_ID, rating, comment) 
VALUES(1, 8, 4, 'Great recipe, but it was a little too spicy for me.');
INSERT INTO Review (recipe_ID, user_ID, rating, comment) 
VALUES(2, 6, 3, 'It was okay, but the flavor did not match my expectations.');
INSERT INTO Review (recipe_ID, user_ID, rating, comment) 
VALUES(3, 9, 5, 'I love this recipe! Will totally make again!');
INSERT INTO Review (recipe_ID, user_ID, rating, comment) 
VALUES(4, 9, 2, 'Was completely blown away with this new recipe! Will add it to my routine!');
