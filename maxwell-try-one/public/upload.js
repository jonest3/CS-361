document.addEventListener('DOMContentLoaded', populateIngredients);
document.addEventListener('DOMContentLoaded', uploadMeal);
document.addEventListener('DOMContentLoaded', addIngredient);

function addIngredient(){
    document.getElementById('submitIngredient').addEventListener('click',function(event){
    var req = new XMLHttpRequest();
        
    var payload = {};

    payload.name = document.getElementById("ingredientName").value;
    payload.type = document.getElementById("ingredientType").value;
    
    req.open("POST", '/addIngredient', true);
    req.setRequestHeader('Content-Type','application/json');
    req.addEventListener('load',function(){
        if(req.status >= 200 && req.status < 400){
            var response = JSON.parse(req.responseText);
            console.log(response);
            populateIngredients();     
        } else {
        console.log("Error in network request: " + req.statusText);
        }});
    req.send(JSON.stringify(payload));
    event.preventDefault();
 });
}
    
function addIngredientsToSelectElement(data){
    //delete all previous option elements, if any
    var ingredientsSelect = document.getElementById('ingredientsSelect');
    while(ingredientsSelect.firstChild){
        ingredientsSelect.removeChild(ingredientsSelect.firstChild);
    }
    //populate ingredients select list with option elements
    var selectElement = document.getElementById("ingredientsSelect");
    for(i = 0; i < data.length; i++){
        var newOption = document.createElement("option");
        newOption.textContent = data[i]["name"];
        newOption.value = data[i]["ingredient_id"];
        newOption.id = "ingredientOption"
        selectElement.appendChild(newOption);
    }
}

function populateIngredients(){
    
    var req = new XMLHttpRequest();

    req.open("POST", '/populateIngredients', true);
        
    req.setRequestHeader('Content-Type','application/json');
    req.addEventListener('load',function(){
        if(req.status >= 200 && req.status < 400){
            var response = JSON.parse(req.responseText);
            console.log(response);
            addIngredientsToSelectElement(response);
        } else {
        console.log("Error in network request: " + req.statusText);
        }});
    req.send(null);
    event.preventDefault();

}

function connectIngredientsToMeal(ingredientId, mealId){
    var req = new XMLHttpRequest();
    var payload = {};
    
    payload.ingredient_id = ingredientId;
    payload.meal_id = mealId;
    
    req.open("POST", '/connectIngredientsToMeal', true);
    req.setRequestHeader('Content-Type','application/json');
    req.addEventListener('load',function(){
        if(req.status >= 200 && req.status < 400)
        {
            var response = JSON.parse(req.responseText);
            console.log(response);
        } else {
        console.log("Error in network request: " + req.statusText);
        }});
    req.send(JSON.stringify(payload));
    event.preventDefault();
}

function uploadMeal(){
document.getElementById('submitNewMeal').addEventListener('click',function(event){
    var req = new XMLHttpRequest();
        
    var payload = {};

    payload.mealName = document.getElementById('mealName').value;
    payload.genre = document.getElementById('genre').value;
    payload.prepTime = document.getElementById('prepTime').value;
    payload.image = document.getElementById('image').value;
    payload.description = document.getElementById('description').value;
    payload.username_id = document.getElementById('username_id').value;
    payload.restaurant_id = document.getElementById('restaurant_id').value;
        
    var ingredients = new Array();  
    var ingredientsSelect = document.getElementById('ingredientsSelect');
        
    for(i = 0; i < ingredientsSelect.length; i++){
        if(ingredientsSelect[i].selected){
            ingredients.push(ingredientsSelect[i].value);
        }    
    }
    req.open("POST", '/uploadMeal', true);
    req.setRequestHeader('Content-Type','application/json');
    req.addEventListener('load',function(){
        if(req.status >= 200 && req.status < 400)
        {
            var response = JSON.parse(req.responseText);
            console.log(response);
            for(i = 0; i < ingredients.length; i++){
                connectIngredientsToMeal(ingredients[i], response[0]["meal_id"]);
                console.log(response[0]["meal_id"]);
            }
            
        } else {
        console.log("Error in network request: " + req.statusText);
        }});
    req.send(JSON.stringify(payload));
    event.preventDefault();
 });
}
  
