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

- (void)setLeftView_:(id)viewProxy
{
    ENSURE_UI_THREAD_1_ARG(viewProxy);
    ENSURE_SINGLE_ARG(viewProxy, TiViewProxy);
    
    CGRect r = [[viewProxy view] frame];
    
    [[self paperFoldView] setLeftFoldContentView:[viewProxy view]];
    NSLog(@"[DEBUG] LeftFoldContentView set.");
}

- (void)setCenterView_:(id)viewProxy
{
    ENSURE_UI_THREAD_1_ARG(viewProxy);
    ENSURE_SINGLE_ARG(viewProxy, TiViewProxy);

    [[self paperFoldView] setCenterContentView:[viewProxy view]];
    NSLog(@"[DEBUG] CenterContentView set.");
}

- (void)setRightView_:(id)dict
{
    ENSURE_UI_THREAD_1_ARG(dict);
    ENSURE_SINGLE_ARG(dict, NSDictionary);

    TiViewProxy *contentView = nil;
    ENSURE_ARG_FOR_KEY(contentView, dict, @"view", TiViewProxy);

    NSNumber *foldCount;
    ENSURE_ARG_OR_NIL_FOR_KEY(foldCount, dict, @"foldCount", NSNumber);
    if(foldCount == nil)
    {
        foldCount = [NSNumber numberWithInt:3];
    }

    NSNumber *pullFactor;
    ENSURE_ARG_OR_NIL_FOR_KEY(pullFactor, dict, @"pullFactor", NSNumber);
    if(pullFactor == nil)
    {
        pullFactor = [NSNumber numberWithFloat:0.9];
    }
    [[self paperFoldView] setRightFoldContentView:[contentView view]
                               rightViewFoldCount:[foldCount integerValue]
                              rightViewPullFactor:[pullFactor floatValue]];
    
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
    [super dealloc];
}

#pragma mark -
#pragma mark View lifecycles

- (void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    [[self paperFoldView] setFrame:frame];
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
