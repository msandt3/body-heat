'use strict'

/**
THIS FUNCTION IS CALLED WHEN THE WEB PAGE LOADS. PLACE YOUR CODE TO LOAD THE 
DATA AND DRAW YOUR VISUALIZATION HERE. THE VIS SHOULD BE DRAWN INTO THE "VIS" 
DIV ON THE PAGE.

This function is passed the variables to initially draw on the x and y axes.
**/

$(document).ready(function(){
	console.log("READY");
	init("Axis1","Axis2");
});


var margin = {top: 20, right: 20, bottom: 30, left: 40},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

var x = d3.time.scale()
    .range([0, width]);

var y = d3.scale.linear()
    .range([height, 0]);

var color = d3.scale.category10();
var size = d3.scale.linear()
	.range([0,1]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");

var tip = d3.tip().attr('class','d3-tip').offset([-10,0])
	.html(function(d){	
		return "<ul><li>Weight: "+d.weight+"</li><li>Reps: "+d.reps+"</li><li>Exercise: "+d.exercise_name+"</li><li>Muscle Group: "+d.muscle_name+"</li></ul>";
	});

var text = function(d){
    d.compactness = parseFloat(d.compactness);
    return d;
};

var data;
var xLabel;
var yLabel;

function draw(data){

    var svg = d3.select("#vis").append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
      .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
    
    svg.call(tip);

    x.domain(d3.extent(data, function(d) { return d.created_on; })).nice(7);
    y.domain(d3.extent(data, function(d) { return d.weight; })).nice();

    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis)
      .append("text")
        .attr("class", "label")
        .attr("x", width)
        .attr("y", -6)
        .style("text-anchor", "end")
        .text("Created On");

    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis)
      .append("text")
        .attr("class", "label")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text("Weight");


    svg.selectAll(".dot")
        .data(data)
      .enter().append("circle")
        .attr("class", "dot")
        .attr("r", function(d){
        	return size(d.reps);
        })
        .attr("cx", function(d){
            return x(d.created_on); 
        })
        .attr("cy", function(d) {
            return y(d.weight); 
        })
        .attr('fill',function(d){
        	return color(d.muscle_name);
        })
        .on('mouseover',tip.show)
        .on('mouseout', tip.hide);
}

function init(xAxis, yAxis){
    xLabel = xAxis;
    yLabel = yAxis;
    
    d3.json('data/activities_full.json',function(error,data){
        
    	console.log(data);
    	var parsed_data = [];
    	for(var key in data){
    		var obj = data[key];
    		if(obj.weight != 0 && obj.reps != 0){
    			parsed_data.push(obj);
    		}

    		obj.created_on = new Date(obj.created_on);
    	}
        

        parsed_data.sort(function(a,b){
        	if(a < b){
        		return -1;
        	}
        	if(a > b){
        		return 1;
        	}
        	return 0;
        });
        console.log(parsed_data);

        draw(parsed_data);
    });
}

/**
## onXAxisChange(value)
This function is called whenever the menu for the variable to display on the
x axis changes. It is passed the variable name that has been selected, such as
"compactness". Populate this function to update the scatterplot accordingly.
**/
function onXAxisChange(value){
    d3.select('svg').remove();

    xLabel = value;
    d3.json("data/activities.json", text, function(error, data) {
        data = data;
        draw(data);
    });
    
    // x.domain(d3.extent(data, function(d) { console.log(d[value]); return d[value]; })).nice();
    
}


/**
## onYAxisChange(value)
This function is called whenever the menu for the variable to display on the
y axis changes. It is passed the variable name that has been selected, such as
"Asymmetry Coefficient". Populate this function to update the scatterplot 
accordingly.
**/
function onYAxisChange(value){

    d3.select('svg').remove();

    yLabel = value;
    d3.json("data/activities.json", text, function(error, data) {
        data = data;
        draw(data);
    });
}

/**
## showDetails(string)
This function will display details in the "details" box on the page. Pass in 
a string and it will be displayed. For example, 
    showDetails("Variety: " + item.variety);
**/
function showDetails(string){
    d3.select('#details').html(string);
}
