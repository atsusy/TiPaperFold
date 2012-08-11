/**
 * Copyright (c) 2012 MARSHMALLOW MACHINE.
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "JpMsmcTipaperfoldModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "PaperFoldView.h"

@implementation JpMsmcTipaperfoldModule
@synthesize STATE_DEFAULT;
@synthesize STATE_LEFT_UNFOLDED;
@synthesize STATE_RIGHT_UNFOLDED;

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"01df3307-2905-46ab-9342-d18eb6599ca4";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"jp.msmc.tipaperfold";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Constants

- (id)STATE_DEFAULT
{
    return NUMINT(PaperFoldStateDefault);
}

- (id)STATE_LEFT_UNFOLDED
{
    return NUMINT(PaperFoldStateLeftUnfolded);
}

- (id)STATE_RIGHT_UNFOLDED
{
    return NUMINT(PaperFoldStateRightUnfolded);
}

@end
