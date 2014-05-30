//
//  OWMyScene.h
//  ShapeAnimation
//

//  Copyright (c) 2014年 grenlight. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class OWSpringRectangle;
@interface OWMyScene : SKScene
{
    OWSpringRectangle     *springRectangle;
    SKSpriteNode          *barSprite, *bgSprite, *maskSprite;
}

- (void)startAnimating;

@end
