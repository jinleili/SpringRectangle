//
//  OWMyScene.m
//  ShapeAnimation
//
//  Created by grenlight on 14-5-26.
//  Copyright (c) 2014年 grenlight. All rights reserved.
//

#import "OWMyScene.h"
#import "OWSpringRectangle.h"

@implementation OWMyScene

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
    springRectangle = [[OWSpringRectangle alloc] init];
    springRectangle.strokeColor = [UIColor colorWithRed:0xbb/255.0f green:0x11/255.0f blue:0x00/255.0f alpha:0.7];
    springRectangle.lineWidth = 0.5;
    [self addChild:springRectangle];
    
    springRectangle.initialWith = 300;
    springRectangle.endWidth = 260;
    springRectangle.marginLeft = 10.0f;
    springRectangle.initialMarginTop = 105.0f;
    springRectangle.endMarginTop = 24.0f;
    
    [springRectangle drawRectangle];
    
}

- (void)startAnimating
{
    SKAction *action = [SKAction fadeAlphaTo:1 duration:0.3];
    
    [maskSprite runAction:action completion:^{
        [bgSprite removeFromParent];
        [maskSprite removeAllActions];
        
        [springRectangle startAnimating:^{
            [self showBg];
        }];
    }];
    
};


- (void)showBg
{
    SKAction *action = [SKAction fadeAlphaTo:1 duration:0.5];
    [barSprite runAction:action completion:^{
        [bgSprite removeAllActions];
    }];
}


@end
