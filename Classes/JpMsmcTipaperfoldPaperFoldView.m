//
//  JpMsmcTipaperfoldPaperFoldView.m
//  tipapaerfold
//
//  Created by KATAOKA,Atsushi on 2012/08/11.
//
//

#import "JpMsmcTipaperfoldPaperFoldView.h"
#import "TiUIViewProxy.h"

@implementation JpMsmcTipaperfoldPaperFoldView

- (PaperFoldView *)paperFoldView
{
    if(paperFoldView == nil){
        CGRect r = CGRectMake(0.0,
                              0.0,
                              self.frame.size.width,
                              self.frame.size.height);
        paperFoldView = [[PaperFoldView alloc] initWithFrame:r];
        paperFoldView.delegate = self;
        [self addSubview:paperFoldView];
        NSLog(@"[DEBUG] PaperFoldView allocated. ");
    }
    return paperFoldView;
}

- (void)setLeftView_:(id)args
{
    TiViewProxy *viewProxy = nil;
    
    ENSURE_UI_THREAD_1_ARG(args);

    leftFoldCount = 1;
    leftPullFactor = 1.0;
    
    if([args isKindOfClass:NSClassFromString(@"TiViewProxy")])
    {
        ENSURE_SINGLE_ARG_OR_NIL(args, TiViewProxy);
        viewProxy = args;
    }
    else if([args isKindOfClass:NSClassFromString(@"NSDictionary")])
    {        
        ENSURE_ARG_OR_NIL_FOR_KEY(viewProxy, args, @"view", TiViewProxy);

        NSNumber *foldCount, *pullFactor;

        ENSURE_ARG_OR_NIL_FOR_KEY(foldCount, args, @"foldCount", NSNumber);
        if(foldCount != nil)
        {
            leftFoldCount = [foldCount integerValue];
        }
        
        ENSURE_ARG_OR_NIL_FOR_KEY(pullFactor, args, @"pullFactor", NSNumber);
        if(pullFactor != nil)
        {
            leftPullFactor = [pullFactor floatValue];
        }
    }
    else
    {
        NSLog(@"[ERROR] unsupported type for leftView.");
    }

    RELEASE_TO_NIL(leftView);
    if(viewProxy == nil)
    {
        NSLog(@"[WARN] leftView is nil.");
        return;
    }
    leftView = [[viewProxy view] retain];
    
    [viewProxy windowWillOpen];
    
    NSLog(@"[DEBUG] LeftFoldContentView set.");
}

- (void)setCenterView_:(id)viewProxy
{
    ENSURE_UI_THREAD_1_ARG(viewProxy);
    ENSURE_SINGLE_ARG(viewProxy, TiViewProxy);

    RELEASE_TO_NIL(centerView);
    centerView = [[viewProxy view] retain];

    [viewProxy windowWillOpen];
    NSLog(@"[DEBUG] CenterContentView set.");
}

- (void)setRightView_:(id)dict
{
    ENSURE_UI_THREAD_1_ARG(dict);
    ENSURE_SINGLE_ARG(dict, NSDictionary);

    TiViewProxy *viewProxy = nil;
    ENSURE_ARG_FOR_KEY(viewProxy, dict, @"view", TiViewProxy);

    NSNumber *foldCount;
    ENSURE_ARG_OR_NIL_FOR_KEY(foldCount, dict, @"foldCount", NSNumber);
    rightFoldCount = 3;
    if(foldCount != nil)
    {
        rightFoldCount = [foldCount integerValue];
    }

    NSNumber *pullFactor;
    ENSURE_ARG_OR_NIL_FOR_KEY(pullFactor, dict, @"pullFactor", NSNumber);
    rightPullFactor = 0.9;
    if(pullFactor != nil)
    {
        rightPullFactor = [pullFactor floatValue];
    }
    
    RELEASE_TO_NIL(rightView);
    rightView = [[viewProxy view] retain];
    
    [viewProxy windowWillOpen];
    NSLog(@"[DEBUG] RightFoldContentView set.");
}

- (void)setEnableLeftFoldDragging_:(id)enabled
{
    ENSURE_SINGLE_ARG(enabled, NSNumber);
    
    [[self paperFoldView] setEnableLeftFoldDragging:[enabled boolValue]];
    
    NSLog(@"[DEBUG] setEnableLeftFoldDragging:%d.", [enabled boolValue]);
}

- (void)setEnableRightFoldDragging_:(id)enabled
{
    ENSURE_SINGLE_ARG(enabled, NSNumber);
    
    [[self paperFoldView] setEnableRightFoldDragging:[enabled boolValue]];
    
    NSLog(@"[DEBUG] setEnableRightFoldDragging:%d.", [enabled boolValue]);
}

- (void)setState_:(id)state
{
    ENSURE_SINGLE_ARG(state, NSNumber);
        
    [[self paperFoldView] setPaperFoldState:(PaperFoldState)[state integerValue]];

    NSLog(@"[DEBUG] setState:%d.", [state integerValue]);
}

#pragma mark -
#pragma mark Memory managements

- (void)dealloc
{
    RELEASE_TO_NIL(paperFoldView);
    RELEASE_TO_NIL(leftView);
    RELEASE_TO_NIL(centerView);
    RELEASE_TO_NIL(rightView);
    [super dealloc];
}

#pragma mark -
#pragma mark View lifecycles

- (void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    [[self paperFoldView] setFrame:frame];
        
    if(leftView)
    {
        [leftView setFrame:CGRectMake(0.0, 0.0, leftView.frame.size.width, frame.size.height)];
        [[self paperFoldView] setLeftFoldContentView:leftView
                                           foldCount:leftFoldCount
                                          pullFactor:leftPullFactor];
    }
    
    if(rightView)
    {
        [rightView setFrame:CGRectMake(0.0, 0.0, rightView.frame.size.width, frame.size.height)];
        [[self paperFoldView] setRightFoldContentView:rightView
                                            foldCount:rightFoldCount
                                           pullFactor:rightPullFactor];
    }

    if(centerView)
    {
        [centerView setFrame:frame];
        [[self paperFoldView] setCenterContentView:centerView];
    }
    
    NSLog(@"[DEBUG] frameSizeChanged / origin:(%f,%f) size:(%f,%f)",
          frame.origin.x,
          frame.origin.y,
          frame.size.width,
          frame.size.height);
}

#pragma mark -
#pragma mark PaperFoldViewDelegate

- (void)paperFoldView:(id)paperFoldView
 didFoldAutomatically:(BOOL)automated
              toState:(PaperFoldState)paperFoldState
{
    id args = [NSDictionary dictionaryWithObjectsAndKeys:
               NUMINT(paperFoldState), @"state",
               NUMBOOL(automated), @"auto", nil];

    [self.proxy fireEvent:@"stateChanged" withObject:args];
}
@end
