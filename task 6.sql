CREATE TABLE Recipes (
    Recipe_ID SERIAL PRIMARY KEY,
    Recipe_Name VARCHAR(255) NOT NULL,
    Servings INTEGER,
    PrepTime INTERVAL,
    CookTime INTERVAL,
    Cuisine VARCHAR(50)
);


INSERT INTO Recipes (Recipe_ID,Recipe_Name, Servings, PrepTime, CookTime, Cuisine)
VALUES (1,'Spaghetti Carbonara', 2, 'PT15M', 'PT20M', 'Italian');

INSERT INTO Recipes (Recipe_ID,Recipe_Name, Servings, PrepTime, CookTime, Cuisine)
VALUES (2,'Chicken Tikka Masala', 4, 'PT30M', 'PT45M', 'Indian');

INSERT INTO Recipes (Recipe_ID,Recipe_Name, Servings, PrepTime, CookTime, Cuisine)
VALUES (3,'Guacamole', 6, 'PT10M', 'PT0S', 'Mexican');

INSERT INTO Recipes (Recipe_ID,Recipe_Name, Servings, PrepTime, CookTime, Cuisine)
VALUES (4,'French Onion Soup', 4, 'PT25M', 'PT50M', 'French');

INSERT INTO Recipes (Recipe_ID,Recipe_Name, Servings, PrepTime, CookTime, Cuisine)
VALUES (5,'Sushi Rolls (California)', 3, 'PT40M', 'PT20M', 'Japanese');


create table Ingredients(
Ingredients_ID SERIAL PRIMARY KEY ,
Ingredients_Name VARCHAR (100)UNIQUE NOT NULL,
unit VARCHAR (20)
);

INSERT INTO Ingredients (Ingredients_ID,Ingredients_Name, Unit)VALUES (1,'Parmesan Cheese', 'grams');
INSERT INTO Ingredients (Ingredients_ID,Ingredients_Name, Unit)VALUES (2,'Chicken Breast', 'grams');
INSERT INTO Ingredients (Ingredients_ID,Ingredients_Name, Unit)VALUES (3,'Yogurt', 'grams');
INSERT INTO Ingredients (Ingredients_ID,Ingredients_Name, Unit)VALUES (4,'Ginger', 'grams');
INSERT INTO Ingredients (Ingredients_ID,Ingredients_Name, Unit)VALUES (5,'Garlic Paste', 'tsp');

select * from ingredients

CREATE TABLE Recipe_Ingredients (
    Recipe_ID INTEGER REFERENCES Recipes(Recipe_ID),
    Quantity DECIMAL(10, 2) NOT NULL,
    Notes VARCHAR(255)
   );

INSERT INTO Recipe_ingredients (Recipe_ID,  Quantity, Notes)
VALUES (1, 2.3 , 'grated');

INSERT INTO Recipe_ingredients (Recipe_ID, Quantity, Notes)
VALUES (2, 3.4  , 'minced');

INSERT INTO Recipe_ingredients (Recipe_ID, Quantity, Notes)
VALUES (3, 3.6 ,'sprigs');

INSERT INTO Recipe_ingredients (Recipe_ID,  Quantity, Notes)
VALUES (4, 1.5 , 'liters');

INSERT INTO Recipe_ingredients (Recipe_ID,  Quantity, Notes)
VALUES (5,  0.5 , 'chhoped');

select * from Recipe_Ingredients

create table Nutritional_information (
recipe_id INTEGER PRIMARY KEY REFERENCES Recipes(Recipe_ID),
Calories DECIMAL (10,2),
Fats DECIMAL (10,2),
Protein DECIMAL (10,2),
Fibre DECIMAL(10,2),
Serving_size VARCHAR (50)
);

INSERT INTO Nutritional_Information (recipe_id, Calories, Fats, Protein, Fibre, Serving_size)
VALUES (1, 450.00, 25.00, 20.00, 3.00 , 'per serving');

INSERT INTO Nutritional_Information (recipe_id, Calories, Fats, Protein, Fibre, Serving_size)
VALUES (2, 350.00, 20.00, 30.00, 5.00 , 'per serving');

INSERT INTO Nutritional_Information (recipe_id, Calories, Fats, Protein, Fibre, Serving_size)
VALUES (3, 150.00, 10.00, 2.00, 4.00 , 'per 1/4 cup');

INSERT INTO Nutritional_Information (recipe_id, Calories, Fats, Protein, Fibre, Serving_size)
VALUES (4, 200.00, 10.00, 8.00, 2.00 , 'per serving');

INSERT INTO Nutritional_Information (recipe_id, Calories, Fats, Protein, Fibre, Serving_size)
VALUES (5, 300.00, 8.00, 10.00, 2.00, 'per roll');

select * from Nutritional_Information

create table Recipe_Rating(
Rating_ID SERIAL PRIMARY KEY ,
Recipe_ID INTEGER REFERENCES Recipes(Recipe_ID),
User_id INTEGER, 
Rating DECIMAL(2, 1) CHECK (Rating >= 1 AND Rating <= 5),
FOREIGN KEY (Recipe_ID) REFERENCES Recipes(Recipe_ID)
);

INSERT INTO Recipe_Rating (Recipe_ID, User_id, Rating)
VALUES (1, 101, 4.5);

INSERT INTO Recipe_Rating (Recipe_ID, User_id, Rating)
VALUES (1, 102, 3.0);

INSERT INTO Recipe_Rating (Recipe_ID, User_id, Rating)
VALUES (2, 101, 5.0);

INSERT INTO Recipe_Rating (Recipe_ID, User_id, Rating)
VALUES (3, 103, 4.0);

INSERT INTO Recipe_Rating (Recipe_ID, User_id, Rating)
VALUES (2, 102, 4.0);

select * from Recipe_Rating

select * from Recipes

select * from ingredients

select * from Recipe_Ingredients

select * from Nutritional_Information

select * from Recipe_Rating

-----joins 
1)
select * from Recipes as r
full join Recipe_Ingredients as ri 
on r.Recipe_ID = ri.Recipe_ID
full join Nutritional_Information as ni
on r.Recipe_ID = ni.Recipe_ID
2)

select * from Recipes as r
left join Recipe_Ingredients as ri 
on r.Recipe_ID = ri.Recipe_ID
left join Nutritional_Information as ni
on r.Recipe_ID = ni.Recipe_ID
3)
select  r.recipe_id , r.recipe_name , r.servings , r.preptime, r.cooktime, r.cuisine , rr.rating_id, rr.recipe_id , rr.user_id,rr.rating,
ri.recipe_id , ri.quantity , ri.notes from recipes as r 
inner join Recipe_Rating as rr
on r.recipe_id = rr.recipe_id
inner join Recipe_Ingredients as ri
on r.recipe_id = ri.recipe_id
4)
select  r.recipe_id , r.recipe_name , r.servings , r.preptime, r.cooktime, r.cuisine , rr.rating_id, rr.recipe_id , rr.user_id,rr.rating,
ni.recipe_id , ni.calories , ni.fats , ni.protein , ni.fibre , ni.serving_size from recipes as r
left join Recipe_Rating as rr
on r.recipe_id = rr.recipe_id
left join  Nutritional_Information as ni
on r.recipe_id = ni.recipe_id
5)
select * from Recipe_Ingredients as ri
right join  Recipe_Rating as rr
on ri.recipe_id = rr.recipe_id
6)
select * from Recipes as r
full join Nutritional_Information as ni
on r.recipe_id = ni.recipe_id
7)
select * from Recipes as r
inner join ingredients as i 
on r.recipe_name = i.ingredients_name
8) 
select  r.recipe_id , r.recipe_name , r.servings , r.preptime, r.cooktime, r.cuisine , rr.rating_id, rr.recipe_id , rr.user_id,rr.rating,
ri.recipe_id , ri.quantity , ri.notes from recipes as r 
left join Recipe_Rating as rr
on r.recipe_id = rr.recipe_id
left join Recipe_Ingredients as ri
on r.recipe_id = ri.recipe_id
9)

select * from Recipes as r
inner join Recipe_Rating as rr
on r.recipe_id= rr.recipe_id
left join Nutritional_Information as ni
on r.recipe_id = ni.recipe_id
10)

select * from Recipe_Ingredients as ri
inner join  Recipe_Rating as rr
on ri.recipe_id = rr.recipe_id

-------10 query which should cover aggergation , having ,group by ,order by

1)
select count (*) from recipes
select sum(recipe_id) from recipes where recipe_id = '3';
select * from Recipes as r
left join  Nutritional_Information as ni
on r.recipe_id = ni.recipe_id
group by  r.recipe_id, r.servings,r.recipe_name 
order by recipe_id asc

2)
select  r.recipe_id , r.recipe_name , r.servings , r.preptime, r.cooktime, r.cuisine , rr.rating_id, rr.recipe_id , rr.user_id,rr.rating,
ri.recipe_id , ri.quantity , ri.notes from recipes as r 
inner join Recipe_Rating as rr
on r.recipe_id = rr.recipe_id
inner join Recipe_Ingredients as ri
on r.recipe_id = ri.recipe_id
where cuisine in ('indian','italian')
group by r.recipe_id, rr.rating_id,ri.quantity
having sum(ri.quantity) > 0.5
order by sum(ri.quantity)

3)
select calories , fats , protein , fibre from Nutritional_Information
group by calories , fats , protein , fibre
order by calories asc

4)
select rating_id , recipe_id , user_id , rating from Recipe_Rating
where user_id = '101'
group by  rating_id , recipe_id , user_id , rating
having sum(rating) > 3.0
order by recipe_id asc;

5)
select r.recipe_id,  r.recipe_name , r.servings , r.preptime, r.cooktime, r.cuisine from  Recipes 
where  r.recipe_id = '4'
group by  r.recipe_id , r.recipe_name , r.servings , r.preptime, r.cooktime, r.cuisine 
having AVG(cooktime)
order by recipe_id desc;

6)
SELECT  Recipe_ID, AVG(Rating) AS AverageRating,
COUNT(*) AS NumberOfRatings
FROM  Recipe_Rating
GROUP BY Recipe_ID
HAVING COUNT(*) > 1  
ORDER BY AVG(Rating) DESC;

7)
select recipe_id, max(quantity) as maxquantity,
count (*) as numberofquantity
from Recipe_Ingredients
group by recipe_id
having count(*) > 1
order by max(quantity) asc;

8)
SELECT   unit, COUNT(*) AS NumberOfIngredients, STRING_AGG(Ingredients_Name, ', ') AS IngredientList
FROM Ingredients
GROUP BY unit
HAVING COUNT(*) > 1  
ORDER BY COUNT(*) DESC;

9)
SELECT  Recipe_ID,
AVG(Rating) AS AverageRating,
COUNT(*) AS NumberOfRatings
FROM Recipe_Rating
GROUP BY  Recipe_ID
HAVING COUNT(*) > 0 
ORDER BY AVG(Rating) DESC;

10)
SELECT  Recipe_ID,
AVG(Rating) AS AverageRating,
COUNT(*) AS NumberOfRatings
FROM Recipe_Rating
GROUP BY  Recipe_ID
HAVING COUNT(*) > 0 
ORDER BY AVG(Rating) asc;