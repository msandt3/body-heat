'use strict'

/**
THIS FUNCTION IS CALLED WHEN THE WEB PAGE LOADS. PLACE YOUR CODE TO LOAD THE 
DATA AND DRAW YOUR VISUALIZATION HERE. THE VIS SHOULD BE DRAWN INTO THE "VIS" 
DIV ON THE PAGE.

This function is passed the variables to initially draw on the x and y axes.
**/
var margin = {top: 20, right: 20, bottom: 30, left: 40},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

var x = d3.scale.linear()
    .range([0, width]);

var y = d3.scale.linear()
    .range([height, 0]);

var color = d3.scale.category10();

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");

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
    
    
    x.domain(d3.extent(data, function(d) { return d.reps; })).nice();
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
        .text("Reps");

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
    //     .on('mouseover',function(d){
    //         console.log(d);
    //         string = "Asymmetry Coefficient: " + d.asymmetryCoefficient + "<br />" +
    //         "Compactness: " + d.compactness + "<br />" +
    //         "Groove Length: " + d.grooveLength + "<br />" +
    //         "Kernel Length: " + d.kernelLength + "<br />" +
    //         "Kernel Width: " + d.kernelWidth + "<br />" +
    //         "Variety: " + d.variety + "<br />";
    //         showDetails(string);
    //     })
    //     .on('mouseout',function(d){
    //         showDetails('');
    //     })
        .attr("class", "dot")
        .attr("r", 3.5)
        .attr("cx", function(d){
            console.log(x(d.reps));
            return x(d.reps); 
        })
        .attr("cy", function(d) {
            console.log(y(d.weight));
            return y(d.weight); 
        });
        // .style("fill", function(d) { 
        //     return #ff0000; 
        // });

    // var legend = svg.selectAll(".legend")
    //     .data(color.domain())
    //   .enter().append("g")
    //     .attr("class", "legend")
    //     .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });

    // legend.append("rect")
    //     .attr("x", width - 18)
    //     .attr("width", 18)
    //     .attr("height", 18)
    //     .style("fill", color);

    // legend.append("text")
    //     .attr("x", width - 24)
    //     .attr("y", 9)
    //     .attr("dy", ".35em")
    //     .style("text-anchor", "end")
    //     .text(function(d) { return d; });
}

function init(xAxis, yAxis){
    xLabel = xAxis;
    yLabel = yAxis;
    
    d3.json('data/activities.json',function(error,data){
        
        data.sort(function(a,b){
            console.log(new Date(a.created_on));
            console.log(new Date(b.created_on));
            console.log(new Date(a.created_on) - new Date(b.created_on));
        });
        console.log(data);
        draw(data);
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
