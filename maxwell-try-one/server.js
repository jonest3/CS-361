var fs = require('fs');
var path = require('path');
var express = require('express');
var exphbs  = require('express-handlebars');
var passport = require('passport');
var Strategy = require('passport-local').Strategy;
var request = require('request');
var mysql = require('mysql');
//already done later down.
//var session = require('express-session');

//local dev. 
var db = require('./db');
var port = process.env.PORT || 3000;

// Configure the local strategy for use by Passport.
//
// The local strategy require a `verify` function which receives the credentials
// (`username` and `password`) submitted by the user.  The function must verify
// that the password is correct and then invoke `cb` with a user object, which
// will be set at `req.user` in route handlers after authentication.
passport.use(new Strategy(
  function(username, password, cb) {
    db.users.findByUsername(username, function(err, user) {
      if (err) { return cb(err); }
      if (!user) { return cb(null, false); }
      if (user.password != password) { return cb(null, false); }
      return cb(null, user);
    });
  }));

// Configure Passport authenticated session persistence.
//
// In order to restore authentication state across HTTP requests, Passport needs
// to serialize users into and deserialize users out of the session.  The
// typical implementation of this is as simple as supplying the user ID when
// serializing, and querying the user record by ID from the database when
// deserializing.
passport.serializeUser(function(user, cb) {
  cb(null, user.id);
});

passport.deserializeUser(function(id, cb) {
  db.users.findById(id, function (err, user) {
    if (err) { return cb(err); }
    cb(null, user);
  });
});




// Create a new Express application.
var app = express();

app.set('port', port);

var hbs = exphbs.create();

app.set('views', __dirname + '/views');

//app.engine('handlebars', hbs.engine);
app.engine('handlebars', exphbs({
     defaultLayout: 'main'
}))

app.set('view engine', 'handlebars');
//this is wrong-ish, okay for now
app.use(express.static(path.join(__dirname, 'public')));

// Use application-level middleware for common functionality, including
// logging, parsing, and session handling.
app.use(require('morgan')('combined'));
//app.use(require('cookie-parser')());
app.use(require('body-parser').urlencoded({ extended: true }));
app.use(require('body-parser').json());
app.use(require('express-session')({ secret: 'keyboard cat', resave: false, saveUninitialized: false }));

// Initialize Passport and restore authentication state, if any, from the
// session.
app.use(passport.initialize());
app.use(passport.session());

//tis NOT GOOD, but lest we continue
var pool = mysql.createPool({
  connectionLimit: 10, 
  host: 'mysql.eecs.oregonstate.edu',
  user: 'cs340_jonest3',
  password: '2302',
  database: 'cs340_jonest3',
});



// Define routes.
//app.get('/',
//  function(req, res) {
//    res.render('home', { user: req.user });
//  });

app.get('/login',
  function(req, res){
    res.render('partials/login');
  });
  
app.post('/login', 
  passport.authenticate('local', { failureRedirect: 'partials/login' }),
  function(req, res) {
    res.redirect('/');
  });
  
app.get('/logout',
  function(req, res){
    req.logout();
    res.redirect('/');
  });

app.get('/profile',
  require('connect-ensure-login').ensureLoggedIn(),
  function(req, res){
    res.render('partials/profile', { user: req.user });
  });

app.get('/', 
    function(req, res) {
      res.render('index-page', { user: req.user });
    });


//view meal stuffs 
app.get('/viewMeal', function(req, res, next){
  var context = {};
  var requestedId = req.query.id;

  //if request body contains a meal_id value, query all attributes of that meal
    if (requestedId) {
        pool.query("SELECT `meal_id`, `name`, `description`, `genre`, `prep_time`, `image`, `username_id`, `restaurant_id` FROM meals WHERE `meal_id` = ?", [requestedId], function(err, rows, fields){

            if (err){
              next(err);
              return;
            }

            //save meal information to meal property
            context.meal = rows[0];
            console.log(context.meal);

            pool.query("SELECT `ingredient_id`, `meal_id` FROM contains WHERE `meal_id` = ?", [requestedId], function(err, rows, fields){

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
                            res.render('partials/view_meal_creator', context);

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
                        res.render('partials/view_meal_creator', context);

                        //if user is not original recipe creator render page without delete link
                        //res.render('view_meal_browser', context);
                    }
                });
            });
        });
    }
});

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
          res.render('partials/delete_success', context);
      } else {
          res.render('partials/elete_failure', context);
      }
    });
  }
});




//upload stuffssss
app.get('/upload', function(req,res,next){
  var context = {};
    res.render('partials/upload', context);

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
