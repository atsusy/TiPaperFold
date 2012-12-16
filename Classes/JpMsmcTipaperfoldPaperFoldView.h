//
//  JpMsmcTipaperfoldPaperFoldView.h
//  tipapaerfold
//
//  Created by MARSHMALLOW MACHINE on 2012/08/11.
//
//

#import "TiUIView.h"
#import "PaperFoldView.h"

@interface JpMsmcTipaperfoldPaperFoldView : TiUIView <PaperFoldViewDelegate>
{
    PaperFoldView *paperFoldView;
    
    UIView *leftView;
    int leftFoldCount;
    float leftPullFactor;
    
    UIView *centerView;
    
    UIView *rightView;
    int rightFoldCount;
    float rightPullFactor;
}
@end
