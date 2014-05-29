//
//  OWMyScene.m
//  ShapeAnimation
//
//  Created by grenlight on 14-5-26.
//  Copyright (c) 2014年 grenlight. All rights reserved.
//

#import "OWMyScene.h"

@implementation OWMyScene

@synthesize spring, accelerate, friction ;
@synthesize initialWith, endWidth, initialMarginTop, endMarginTop, marginLeft;

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {

        bgSprite = [[SKSpriteNode alloc] initWithImageNamed:@"bg"];
        bgSprite.position = CGPointMake(size.width/2.0f, size.height/2.0f);
        [self addChild:bgSprite];
        
        maskSprite = [[SKSpriteNode alloc] init];
        maskSprite.size = size;
        maskSprite.position = CGPointMake(size.width/2.0f, size.height/2.0f);
        maskSprite.color = [SKColor colorWithWhite:0.8 alpha:1];
        maskSprite.alpha = 0;
        [self addChild:maskSprite];
        
        barSprite = [[SKSpriteNode alloc] initWithImageNamed:@"bar"];
        barSprite.position = CGPointMake(size.width/2.0, size.height-barSprite.size.height/2.0);
        barSprite.alpha = 0;
        [self addChild:barSprite];
        
        [self initSearchFrame];
        
    }
    return self;
}

- (void)initSearchFrame
{
    initialWith = 300;
    endWidth = 260;
    marginLeft = 10.0f;
    endMarginTop = 24.0f;
    initialMarginTop = 105.0f;
    margintTopMaxOffset = fabsf(initialMarginTop-endMarginTop);
    height = 32.0f;
    
    //在Sprite Kit内，坐标原点是在屏幕的左下角，而在UIKit中，原点在屏幕的左上角，所以要翻转坐标
    upY = self.size.height - initialMarginTop;
    downY= self.size.height - (initialMarginTop+height);
    targetY = self.size.height-endMarginTop;
    
    //两条三次贝塞尔曲线的连接点的最大值
    maxKnot = CGPointMake(endWidth/2.0f + marginLeft, targetY);
    
    topKnot = CGPointMake(maxKnot.x, upY);
    bottomKnot = CGPointMake(maxKnot.x, downY);
    cpDistanceY = maxKnot.y-topKnot.y;
    cpOffsetY = 40;
    
    /*
     SKShapeNode 的渲染是有硬件加速的，但是硬件加速在模拟器内无效，导致运行帧率下降，
     为方便在模拟器内运行，预先将帧数据计算出来
     */
    
    for (NSInteger i=0; i<80; i++) {
        
    }
    searchFrame = [[SKShapeNode alloc] init];
    searchFrame.strokeColor = [UIColor colorWithRed:0xbb/255.0f green:0x11/255.0f blue:0x00/255.0f alpha:0.7];
    searchFrame.lineWidth = 0.5;
    [self addChild:searchFrame];
    
    [self drawBezier];
}

- (void)startAnimating
{
    SKAction *action = [SKAction fadeAlphaTo:1 duration:0.3];
    
    [maskSprite runAction:action completion:^{
        [bgSprite removeFromParent];
        [maskSprite removeAllActions];
        
        [self searchFrameAnimating];
    }];
    
};

/*
 先将输入框提起
 然后收缩，回弹
 */
- (void)searchFrameAnimating
{
    accelerate = 0;
    spring = 0.05f;
    
    speed = 0;
    friction = 0.88;
    
    //提起动作记数
    __block NSInteger liftUpIndex = 0;
    
    topKnot = CGPointMake(maxKnot.x, upY);
    bottomKnot = CGPointMake(maxKnot.x, downY);
    
    //控制点从起始点到终点之间的距离
    cpDistanceY = maxKnot.y-topKnot.y;
    
    SKAction *action = [SKAction customActionWithDuration:1.3
                                              actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        if (liftUpIndex < 10) {
            topKnot.y += cpDistanceY/10.0f;
            bottomKnot.y += cpDistanceY/10.0f;
            
            cpOffsetY = 40 * (1 - cpDistanceY/10.0f*liftUpIndex / cpDistanceY) + 25 ;
            liftUpIndex ++;
        }
        
        //收起，回弹
        if (liftUpIndex > 6) {
            //当前离目标位置的距离
            float distanceY = targetY - upY;
            accelerate = distanceY * spring;
            speed += accelerate;
            speed *= friction;
            upY += speed;
            downY += speed;
        }
        
        [self drawBezier];
    }];
    
    [searchFrame runAction:action completion:^{
        [searchFrame removeAllActions];
        [self showBg];
        [self hideSearchFrameShape];
    }];
}

- (void)showBg
{
    SKAction *action = [SKAction fadeAlphaTo:1 duration:0.5];
    [barSprite runAction:action completion:^{
        [bgSprite removeAllActions];
    }];
}

- (void)hideSearchFrameShape
{
    SKAction *action = [SKAction fadeAlphaTo:0 duration:0.5];
    [searchFrame runAction:action];
}

- (void)drawBezier
{
    float widthScale =  fabsf(endWidth - initialWith) * (((self.size.height-upY) - endMarginTop) / margintTopMaxOffset);
    upleft = CGPointMake(marginLeft, upY);
    upRight = CGPointMake(marginLeft + endWidth + widthScale, upY);
    
    downLeft = CGPointMake(marginLeft, downY);
    downRight = CGPointMake(marginLeft + endWidth + widthScale, downY);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path moveToPoint:upleft];
    [path addCurveToPoint:topKnot controlPoint1:CGPointMake(upleft.x+cpOffsetY, upleft.y) controlPoint2:CGPointMake(topKnot.x-cpOffsetY, topKnot.y)];
    [path addCurveToPoint:upRight controlPoint1:CGPointMake(topKnot.x+cpOffsetY, topKnot.y) controlPoint2:CGPointMake(upRight.x-cpOffsetY, upRight.y)];
    
    [path addLineToPoint:downRight];
    [path addCurveToPoint:bottomKnot controlPoint1:CGPointMake(downRight.x-cpOffsetY, downRight.y) controlPoint2:CGPointMake(bottomKnot.x+cpOffsetY, bottomKnot.y)];
    [path addCurveToPoint:downLeft controlPoint1:CGPointMake(bottomKnot.x-cpOffsetY, bottomKnot.y) controlPoint2:CGPointMake(downLeft.x+cpOffsetY, downLeft.y)];
    
    [path addLineToPoint:upleft];
    
    searchFrame.path = path.CGPath;
}

@end
