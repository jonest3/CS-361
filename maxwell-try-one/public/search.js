var link = "www.yahoo.com";

function showResults(objArr){
   if(objArr.length > 0)
   {
        var resultList = "<ul>";

        for(var i=0; i < objArr.length; i++)
        {
                resultList += "<li>";
                resultList += "<a href='http://" + link + "' id='"+objArr[i].meal_id+"' ";
                resultList += "title='"+objArr[i].description+"'>";
                resultList += objArr[i].name + "   [Prep Time: "+ objArr[i].prep_time+" mins]";
                resultList += "</a>";
                resultList += "</li>";
        }

     resultList += "</ul>";
        console.log(resultList);
        document.getElementById("results").innerHTML = resultList;
   }
   else
   {
        document.getElementById("results").textContent = "No Results Found";
   }
}

function createBoxes(objArr){
   if(objArr.length > 0)
   {
        var ingredientOptions = "<label>Ingredient(s):</label><br><br>";

        for(var i = 0; i < objArr.length; i++)
        {
                ingredientOptions += "<input type='checkbox' name='ingredients[]' value='"+objArr[i].ingredient_id+"'/>"+objArr[i].name;
                ingredientOptions += "&nbsp&nbsp&nbsp";
                if(i % 6 === 0  &&  i != 0)
                        ingredientOptions += "<br>";
        }
        if((i - 1) % 6 != 0)
                ingredientOptions += "<br>";

        document.getElementById("checkboxDiv").innerHTML = ingredientOptions;
   }
}

function searchButton(){
   document.getElementById("searchMeals").addEventListener("click", function(event){
        var payload = {name:null, genre:null, prep_time:null, ingredients:null};

        payload.name = document.getElementById("mealName").value;
        document.getElementById("mealName").value = '';
        if(payload.name === '')
                payload.name = null;

        payload.genre = document.getElementById("genre").value;
        document.getElementById("genre").value = '';
        if(payload.genre === '')
                payload.genre = null;

        payload.prep_time = document.getElementById("prep_time").value;
        document.getElementById("prep_time").value = '';
        if(payload.prep_time === '')
                payload.prep_time = null;

        var all_checked = document.getElementsByName("ingredients[]");
        var ingreds = [];

        for(var i = 0; i < all_checked.length; i++)
        {
                if(all_checked[i].checked)
                {
                        ingreds.push(all_checked[i].value);
                        all_checked[i].checked = false;
                }
        }
        console.log("Ingredients: "+ingreds);
        payload.ingredients = ingreds;
        console.log(payload.ingredients);

        var req = new XMLHttpRequest();
        req.open("POST", "/searchMeals", true);
        req.setRequestHeader("Content-type", "application/json");
        req.addEventListener("load", function(){
                if(req.status >= 200  &&  req.status < 400)
                {
                        console.log("Searching");
                        console.log(req.responseText);
                        var response = JSON.parse(req.responseText);
                        console.log(response);
                        showResults(response);
                }
                else
                        console.log("Error in network request: " + req.statusText);
        });
        req.send(JSON.stringify(payload));
        event.preventDefault();
   });
}

document.addEventListener("DOMContentLoaded", searchButton);

function getCheckboxes(){
   var req = new XMLHttpRequest();
   req.open("GET", "/getIngredients", true);
   req.setRequestHeader("Content-type", "application/json");
   req.addEventListener("load", function(){
        if(req.status >= 200  &&  req.status < 400)
        {
                console.log("Getting Ingredients");
                console.log(req.responseText);
                var response = JSON.parse(req.responseText);
                console.log(response);
                createBoxes(response);
        }
        else
                console.log("Error in network request: " + req.statusText);
   });
   req.send();
}

document.addEventListener("DOMContentLoaded", getCheckboxes);
