//
//  OWMyScene.h
//  ShapeAnimation
//

//  Copyright (c) 2014年 grenlight. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface OWMyScene : SKScene
{
    float upY, downY, margintTopMaxOffset;
    float height, targetY;
    
    
    //位移速度
    float speed;
    
    CGPoint upleft,  upRight, downLeft,  downRight;
    //上下边框线曲线的连接点
    CGPoint topKnot, bottomKnot;
    CGPoint maxKnot;
    
    //控制点从起始点到终点之间的距离
    float cpDistanceY;
    
    //控制点距离曲线端点的距离。
    float cpOffsetY;
    
    SKShapeNode     *searchFrame;
    SKSpriteNode    *barSprite, *bgSprite, *maskSprite;
    
    NSMutableArray *paths;
}

//弹力
@property (nonatomic, assign) float spring;
//加速度
@property (nonatomic, assign) float accelerate;
//摩擦力
@property (nonatomic, assign) float friction;

@property (nonatomic, assign) float initialWith;
@property (nonatomic, assign) float endWidth;
@property (nonatomic, assign) float marginLeft;
@property (nonatomic, assign) float initialMarginTop;
@property (nonatomic, assign) float endMarginTop;

- (void)startAnimating;

@end
