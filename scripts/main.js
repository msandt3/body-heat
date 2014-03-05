'use strict'
window.onload = function(){
	var canvas = document.getElementById('body-canvas');
	var context = canvas.getContext('2d');
	console.log(context);
	console.log(canvas.children[0]);
	// var imageObj = new Image();

	// console.log(canvas);

	// imageObj.onload = function(){
	// 	context.drawImage(imageObj, 0, 0);
	// }

	// imageObj.src = 'images/muscle-groups-front.jpg';


	var config = {
	    "radius": 30,
	    "element": canvas,
	    "visible": true,
	    "opacity": 40,
	    "gradient": { 0.45: "rgb(0,0,255)", 0.55: "rgb(0,255,255)", 0.65: "rgb(0,255,0)", 0.95: "yellow", 1.0: "rgb(255,0,0)" }
	};


	var heatmap = h337.create(config);
	console.log(heatmap);
	canvas.onclick = function(e){
		var mouseX, mouseY;
		if(e.offsetX){
			mouseX = e.offsetX;
			mouseY = e.offsetY;
		}else if(e.layerX){
			mouseX = e.layerX;
			mouseY = e.layerY;
		}

		console.log(mouseX);
		console.log(mouseY);
		heatmap.store.addDataPoint(mouseX, mouseY, 10);
	}
}