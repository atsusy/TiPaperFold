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

var paperFoldView = module.createPaperFoldView({
	left:0,
	top:0,
	centerView:centerView,
	leftView:leftView,
	rightView:{
		view:rightView,
		foldCount:3,
		pullFactor:0.9
	},
	enableLeftFoldDragging:true,
	enableRightFoldDragging:true,
});

window.addEventListener("open", function(e){
	paperFoldView.state = module.STATE_RIGHT_UNFOLDED;
});

paperFoldView.addEventListener("stateChanged", function(e){
	Ti.API.info("state changed to:"+e.state+" automated:"+e.auto);
});

window.add(paperFoldView);
window.open();


