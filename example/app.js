
var module = require('jp.msmc.tipaperfold');

var window = Ti.UI.createWindow({
	backgroundColor:'white'
});

var leftView = Ti.UI.createView({
	left:0,
	width:100,
	backgroundColor:'red'
});

var centerView = Ti.UI.createTableView({
	left:0,
	top:0
});

var rightView = Ti.Map.createView({
	left:0,
	width:200,
    mapType: Ti.Map.STANDARD_TYPE,
    region: {
    	latitude:33.74511, 
    	longitude:-84.38993, 
        latitudeDelta:0.01,
        longitudeDelta:0.01 
    },
    animate:true,
    regionFit:true,
    userLocation:true
});

var addAnnotationButton = Ti.UI.createButton({
	title:"add pin",
	left:2,
	top:2,
	width:96,
	height:32,
});
rightView.add(addAnnotationButton);

var removeAnnotationButton = Ti.UI.createButton({
	title:"remove pin",
	right:2,
	top:2,
	width:96,
	height:32,
});
rightView.add(removeAnnotationButton);

var paperFoldView = module.createPaperFoldView({
	left:0,
	top:0,
	centerView:centerView,
	leftView:{
		view:leftView,
		foldCount:2,
		pullFactor:0.9
	},
	rightView:{
		view:rightView,
		foldCount:3,
		pullFactor:0.9
	},
	enableLeftFoldDragging:true,
	enableRightFoldDragging:true,
});

window.addEventListener("open", function(e){
	//paperFoldView.state = module.STATE_RIGHT_UNFOLDED;
});

paperFoldView.addEventListener("stateChanged", function(e){
	Ti.API.info("state changed to:"+e.state+" automated:"+e.auto);
});

leftView.addEventListener('click', function(e){
	paperFoldView.centerView = Ti.UI.createView({
		backgroundColor:'black'
	});
});

var atlanta = Titanium.Map.createAnnotation({
        latitude:33.74511,
        longitude:-84.38993,
        title:"Atlanta, GA",
        subtitle:'Atlanta Braves Stadium',
        pincolor:Titanium.Map.ANNOTATION_PURPLE,
        animate:true,
        leftButton:'images/atlanta.jpg',
        rightButton: Titanium.UI.iPhone.SystemButton.DISCLOSURE,
        myid:3 // CUSTOM ATTRIBUTE THAT IS PASSED INTO EVENT OBJECTS    
});

addAnnotationButton.addEventListener('click', function(e){
	rightView.addAnnotation(atlanta);
});

removeAnnotationButton.addEventListener('click', function(e){
	rightView.removeAnnotation(atlanta);
});

window.add(paperFoldView);
window.open();


