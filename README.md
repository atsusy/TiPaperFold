TiPaperFold Module for iOS
===========================================
Titanium Mobile module for [PaperFold for iOS](https://github.com/honcheng/PaperFold-for-iOS/ "PaperFold-for-iOS").

INSTALL MODULE
--------------------

1. Run `build.py` which creates your distribution
2. Copy jp.msmc.tipaperfold-0.1.zip into your app project of root directory
3. Build the project

REGISTER MODULE
---------------------

Register your module with your application by editing `tiapp.xml` and adding your module.
Example:

	<modules>
		<module version="0.1">jp.msmc.tipaperfold</module>
	</modules>

When you run your project, the compiler will know automatically compile in your module
dependencies and copy appropriate image assets into the application.

USING MODULE
-------------------------

To use your module in code, you will need to require it. 

For example,

	var module = require('jp.msmc.tipaperfold');
	var window = Ti.UI.createWindow();
	
	var leftView = Ti.UI.createView({
		width:100,
		backgroundColor:'red'
	});
	
	var centerView = Ti.UI.createView({
		backgroundColor:'yellow'
	});
	
	var rightView = Ti.UI.createView({
		width:300,
		backgroundColor:'green'
	})
	
	var paperfoldView = module.createPaperFoldView({
		left:0,
		top:0,
		leftView:leftView,
		centerView:centerView,
		rightView:{
			view:rightView,
			foldCount:3,
			pullFactor:0.9
		}
	});
	
	window.add(paperfoldView);
	window.open();

The module has createPaperView method. 
Call the method with an object which has properties leftView,centerView,rightView.
`leftView` and `centerView` must be an instance of view.
`rightView` must be an object which has properties view,foldCount(option),pullFactor(option).å
	
LICENSE
-------------------------
MIT License

