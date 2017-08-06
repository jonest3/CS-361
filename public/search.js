// Queries need to return name, description, & id

var link = "www.yahoo.com";

function showResults(objArr){
   if(objArr.length > 0)
   {
        var resultList = "<ul>";

        for(var i=0; i < objArr.length; i++)
        {
                resultList += "<li>";
                resultList += "<a href='http://" + link + "' id='"+objArr[i].meal_id+"' "    ;
                resultList += "title='"+objArr[i].description+"'>";
                resultList += objArr[i].name;
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

function searchButton(){
   document.getElementById("searchMeals").addEventListener("click", function(event){
        var payload = {name:null, genre:null, prep_time:null};

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
        });
        req.send(JSON.stringify(payload));
        event.preventDefault();
   });
}

document.addEventListener("DOMContentLoaded", searchButton);
