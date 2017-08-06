var express = require('express');
var app = express();

var handlebars = require('express-handlebars').create({defaultLayout:'main'});

var request = require('request');
var mysql = require('mysql');
var session = require('express-session');
var bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.use(express.static('public'));
app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');
app.set('port', 8666);

var pool = mysql.createPool({
  connectionLimit: 10,
  host: 'mysql.eecs.oregonstate.edu',
  user: 'cs340_jonest3',
  password: '2302',
  database: 'cs340_jonest3',
});

// ---------- Upload Meal ------------
app.get('/upload', function(req,res,next){
  var context = {};
    res.render('upload', context);
    
});

app.post('/populateIngredients',function(req,res,next){
  var context = {};

    pool.query('SELECT ingredient_id, name FROM ingredients', function(err, rows, fields){
    if(err){
      next(err);
      return;
    }
        
    context.results = JSON.stringify(rows);
    res.type("text/plain");
    res.send(context.results);       
    });
    
});

app.post('/uploadMeal',function(req,res,next){
  var context = {};

    console.log("Insert to `meals` request received: " + req.body.mealName);

    pool.query("INSERT INTO meals (`name`, `description`, `genre`, `prep_time`, `image`, `username_id`, `restaurant_id`) VALUES (?,?,?,?,?,?,?)", [req.body.mealName, req.body.description, req.body.genre, req.body.prepTime, req.body.image, req.body.username_id, req.body.restaurant_id], function(err, result){
    if(err){
        next(err);
        return;
    }
    var mealId = result.insertId;
    pool.query("SELECT * FROM meals WHERE meal_id = ?", [mealId], function (err, rows, fields){
        if(err){
            next(err);
            return;
    }
    context.results = JSON.stringify(rows);
    res.type("text/plain");
    res.send(context.results);   
    });
  }); 
});

app.post('/addIngredient',function(req,res,next){
  var context = {};

    console.log("Insert to `ingredient` request received: " + req.body.name);

    pool.query("INSERT INTO ingredients (`name`, `type`) VALUES (?,?)", [req.body.name, req.body.type], function(err, result){
    if(err){
        next(err);
        return;
    }
    var ingredientId = result.insertId;
    pool.query("SELECT * FROM ingredients WHERE ingredient_id = ?", [ingredientId], function (err, rows, fields){
        if(err){
            next(err);
            return;
    }
    context.results = JSON.stringify(rows);
    res.type("text/plain");
    res.send(context.results);   
    });
  }); 
});

app.post('/connectIngredientsToMeal',function(req,res,next){
  var context = {};

    console.log("Insert to `contains` request received: " + req.body.ingredient_id + " "+ req.body.meal_id);

    pool.query("INSERT INTO contains (`ingredient_id`, `meal_id`) VALUES (?,?)", [req.body.ingredient_id, req.body.meal_id], function(err, result){
    if(err){
        next(err);
        return;
    }

    pool.query("SELECT ingredient_id, meal_id FROM contains", function (err, rows, fields){
        if(err){
            next(err);
            return;
    }
        
    context.results = JSON.stringify(rows);
    res.type("text/plain");
    res.send(context.results);   
    });
  });
    
});

// ---------- Searching Meals ------------
app.get('/searchMeals', function(req,res,next){
   res.render('searchMeals');
});

app.post('/searchMeals', function(req,res,next){
   console.log(req.body);
// name, genre, prep_time
   var context = {};
   if(req.body.name != null  ||  req.body.genre != null  ||  req.body.prep_time != null)
   {
        var queryString = "SELECT meal_id, name, description FROM meals WHERE";
        var queryVars = [];
        if(req.body.name != null)
        {
                queryString += " name LIKE '%"+req.body.name+"%'";
        }

        if(req.body.genre != null)
        {
                if(req.body.name != null)
                        queryString += " AND";
                queryString += " genre LIKE '%"+req.body.genre+"%'";
        }

        if(req.body.prep_time != null)
        {
                if(req.body.genre != null  ||  req.body.name != null)
                         queryString += " AND";
                queryString += " prep_time <="+req.body.prep_time;

        }
     
        console.log(queryVars);
        pool.query(queryString, function(err,rows,fields){
                if(err)
                {
                        next(err);
                        return;
                }
                res.send(JSON.stringify(rows));
        });
   }
   else
        res.send(JSON.stringify(0));
});

// --------- View Meal ------------
app.post('/viewMeal', function(req, res, next){
  var context = {};
  var request = req.body;

  //if request body contains a meal_id value, query all attributes of that meal
    if (request.id) {
        pool.query("SELECT `meal_id`, `name`, `description`, `genre`, `prep_time`, `image`, `username_id`, `restaurant_id` FROM meals WHERE `meal_id` = ?", [request.id], function(err, rows, fields){

            if (err){
              next(err);
              return;
            }

            //save meal information to meal property
            context.meal = rows[0];
            console.log(context.meal);

            pool.query("SELECT `ingredient_id`, `meal_id` FROM contains WHERE `meal_id` = ?", [request.id], function(err, rows, fields){

                if (err) {
                    next(err);
                    return;
                }

                context.activeIngredients = rows;
                //console.log(context.activeIngredients);

                pool.query("SELECT `ingredient_id`, `name`, `type` FROM ingredients", function(err, rows, fields){

                    if (err) {
                        next(err);
                        return;
                    }

                    context.ingredientsTable = rows;
                    //console.log(context.ingredientsTable);
                    context.activeIngredientsName = [];

                    var restaurantInfo = context.meal
                    //console.log(restaurantInfo.restaurant_id);

                    for (x = 0; x < context.activeIngredients.length; x++) {

                        for (y = 0; y < context.ingredientsTable.length; y++) {

                            if (context.activeIngredients[x].ingredient_id == context.ingredientsTable[y].ingredient_id) {

                                context.activeIngredientsName.push(context.ingredientsTable[y].name);
                            }
                        }
                    }

                    console.log(context.activeIngredientsName);

                    if (Number.isInteger(restaurantInfo.restaurant_id)) {
                        pool.query("SELECT `restaurant_id`, `name`, `street_name`, `city`, `state`, `zipcode` FROM restaurants WHERE `restaurant_id` = ?", [restaurantInfo.restaurant_id], function(err, rows, fields){

                            if (err) {
                              next(err);
                              return;
                            }

                            context.restaurant = rows[0];

                            /******************************
                            *ADD LOGIC HERE TO SERVER DIFFERENT
                            *PAGE IF USER IS ORIGINAL MEAL CREATOR (AND SIGNED IN)
                            ******************************/
                            //render view page for user
                            res.render('view_meal_creator', context);

                            //if user is not original recipe creator render page without delete link
                            //res.render('view_meal_browser', context);
                        });
                    } else {

                        //res.type(`text/plain`);
                        //res.send(context);
                        console.log(context);

                        /******************************
                        *ADD LOGIC HERE TO SERVER DIFFERENT
                        *PAGE IF USER IS ORIGINAL MEAL CREATOR (AND SIGNED IN)
                        ******************************/
                        //render view page for user
                        res.render('view_meal_creator', context);

                        //if user is not original recipe creator render page without delete link
                        //res.render('view_meal_browser', context);
                    }
                });
            });
        });
    }
});

// --------- Delete Meal -------------
app.get('/remove/meal', function(req, res, next){
  var context = {};

  var query_params = req.query;

  if (req.query.id) {
    //query the record to be edited, so we can prepopulate the form inputs with the current record attribute values
    pool.query("DELETE FROM meals WHERE `meal_id` = ?", [req.query.id], function(err, rows, fields){

      if (err){
        next(err);
        return;
      }
      //change success to true for evaluation client side
      if (rows.affectedRows == 1) {
          context.delete_success = true;
          //console.log("its true");
      } else {
          context.delete_success = false;
          //console.log("its false");
      }

      //send feedback to the user
      if (context.delete_success == true) {
          res.render('delete_success', context);
      } else {
          res.render('delete_failure', context);
      }
    });
  }
});

// ----- Error Handling ------
app.use(function(req,res){
        res.status(404);
        res.render('404');
});

app.use(function(err, req, res, next){
        console.error(err.stack);
        res.status(500);
        res.render('500');
});

app.listen(app.get('port'), function(){
        console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
});
