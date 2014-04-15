window.onload = function(){
    // var pjs = Processing.getInstanceById('myCanvas');
    //pjs.showCircleTest();
    //GET THE json data for all the activities
    frequencies = new Array();
    getActivitiesJSON("data/activities_full.json",new Date(2014,0,1),new Date(2014,2,30));
};

//Returns the exercises performed, excludes those that fall outside 
//given range
function getActivitiesJSON(path,start_date,end_date){
    var exercises = new Array();
    $.getJSON(path, function(json) {
        console.log("start_date: "+start_date);
        console.log("end_date: "+end_date);
        for(var i=0; i<json.length; i++){
            var activity = json[i];
            var d = new Date(activity.created_on);
            //Check to make sure that the json data is within the date range
            if(d>=start_date && d<=end_date){
                if(activity.weight>0&&activity.reps>0){
                    var obj = new Object();
                    exercises.push(activity.muscle_name);
                }   
            }
        }
        console.log(exercises);
        exercises.sort();//function(a,b){return a-b});
        console.log(exercises);
        var num = 1;
        var currMuscle = exercises[0];
        for(var i=1; i<exercises.length;i++){
            var obj = new Object();
            if(currMuscle==exercises[i]){
                num++;
            }
            else{
                obj.muscle = currMuscle;
                obj.frequency = num;
                frequencies.push(obj);
                num = 1;
                currMuscle = exercises[i];
            }
        }
        var edgeCase = new Object();
        edgeCase.muscle = currMuscle;
        edgeCase.frequency = num;
        frequencies.push(edgeCase);
        //console.log(frequencies);
        //find the max value of the muscle frequencies
        var max = findMaxFrequency(frequencies);
        //find the in value of the muscle frequencies
        var min = findMinFrequency(frequencies);
        for(var key in frequencies){
            var obj = frequencies[key];
            console.log("DATA OBJ: "+obj.muscle+" : "+obj.frequency);

        }
        encodeValues(frequencies,max,min);
    });
    
}

function findMaxFrequency(array){
    var maxF = 0;
    for(var i=0; i< array.length;i++){
        if(array[i].frequency>maxF) maxF = array[i].frequency;
    }
    return maxF;
}

function findMinFrequency(array){
    var minF = 999999999;
    for(var i=0;i<array.length;i++){
        if(array[i].frequency<minF) minF = array[i].frequency;
    }
    return minF;
}

function encodeValues(array,max,min){
    var muscles = new Array();
    var _m = new Array();
    for(var i=0;i<array.length;i++){
        _m[i]= array[i].muscle;

    }
    console.log(_m);
   
    populateAllMuscles(muscles);
    for(var j=0;j<_m.length;j++){
        var index = muscles.indexOf(_m[j]);
        muscles.splice(index,1);
    }
   
    console.log("muscles: "+muscles);
    
    console.log("LENGTH: "+array.length);

    
    for(var i = 0; i<array.length; i++){
        //compute the frequency mapped to the range .5 -> 2
        var mapping = computeMapping(array[i].frequency,min,max,1,2);
       // console.log(array[i].frequency+" --> "+mapping);
        array[i].frequency = mapping;
        // frequencies.push(mapping);
        // console.log("muscle_type: "+array[i].muscle);
        // muscles.push(array[i].muscle);
    }

    for(var i=0;i<array.length;i++){
        console.log("muscle: "+array[i].muscle);
        console.log("frequency: "+array[i].frequency);
    }
    var xx = createArrayForAddition(muscles);
    array.push.apply(array,xx);

    var pjs = Processing.getInstanceById('myCanvas');
    for(var j=0;j<array.length;j++){
        var muscle_type = array[j].muscle;
        if(muscle_type=="Chest"){
            pjs.scaleChest(array[j].frequency);
        }
        else if(muscle_type=="Calves"){
            pjs.scaleCalves(array[j].frequency);
        }
        else if(muscle_type=="Upper Back"){
            pjs.scaleUpperBack(array[j].frequency);
        }
        else if(muscle_type=="Lower Back"){
            pjs.scaleLowerBack(array[j].frequency);
        }
        else if(muscle_type=="Triceps"){
            pjs.scaleTriceps(array[j].frequency);
        }
        else if(muscle_type=="Glutes"){
            pjs.scaleGlutes(array[j].frequency);
        }
        else if(muscle_type=="Hamstrings"){
            pjs.scaleHammies(array[j].frequency);
        }
        else if(muscle_type=="Forearm"){
            pjs.scaleForearm(array[j].frequency);
        }
        else if(muscle_type=="Shoulder"){
            pjs.scaleShoulders(array[j].frequency);
        }
        else if(muscle_type=="Abdominals"){
            //pjs.scaleAbdominals
        }
        else if(muscle_type=="Biceps"){
            pjs.scaleBiceps(array[j].frequency);
        }
        else if(muscle_type=="Thigh"){
            pjs.scaleQuads(array[j].frequency);
        }
    }
}

    function populateAllMuscles(muscles){
        muscles.push("Chest");
        muscles.push( "Calves");
        muscles.push( "Upper Back");
        muscles.push( "Lower Back");
        muscles.push( "Triceps");
        muscles.push( "Glutes");
        muscles.push( "Hamstrings");
        muscles.push( "Forearm");
        muscles.push( "Shoulder");
        muscles.push( "Abdominals");
        muscles.push( "Biceps");
        muscles.push( "Thigh"); 
    }

    function createArrayForAddition(array){
        var ret = new Array();
        
        for(var i=0;i<array.length;i++){
            ret.push({muscle : array[i], frequency : ".5    "});
        }

        return ret;

    }

    function computeMapping(s,a1,a2,b1,b2){
        return b1 + (((s-a1)*(b2-b1))/(a2-a1));
    }