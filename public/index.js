//htis is for general client side functions. 
//--------------------------------------------------------------------------- rgb to hex converter
//Function to convert hex format to a rgb color
function rgb2hex(rgb){
 rgb = rgb.match(/^rgba?[\s+]?\([\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?/i);
 return (rgb && rgb.length === 4) ? "#" +
  ("0" + parseInt(rgb[1],10).toString(16)).slice(-2) +
  ("0" + parseInt(rgb[2],10).toString(16)).slice(-2) +
  ("0" + parseInt(rgb[3],10).toString(16)).slice(-2) : '';
}

$('button').click(function(){
    var hex = rgb2hex( $('input').val() );
    $('.result').html( hex );
});


//old code, where we were adding "threads"... we are not doing things this way. 
//--------------------------------------------------------------------------- Add Thread
function addThread() {
		
		var title = document.getElementsByName('user')[1].value;
		var description = document.getElementsByName('description')[1].value;

		var tBunArray = document.getElementsByName('TBun')[0]._jscLinkedInstance.rgb[0];
		//var tBun = rgb2hex(rgba(tBunArray[0], tBunArray[1], tBunArray[2], 1));
var tBun;
 //<form method="get">
		/*
		
		var patty = document.getElementsByName('description');
		var BBun = document.getElementsByName('description');
		var Border = document.getElementsByName('description');*/
		console.log(title, " ", description, " ", tBun);
		//alert(title + " " + description + " " + tBun); 
};

//location.href = "http://localhost:10001" + "?number1=" + n1 + "&number2=" + n2;
