//
//  OWViewController.m
//  ShapeAnimation
//
//  Created by grenlight on 14-5-26.
//  Copyright (c) 2014年 grenlight. All rights reserved.
//

#import "OWViewController.h"
#import "OWMyScene.h"

@implementation OWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    skView.backgroundColor = [SKColor colorWithWhite:0 alpha:0];
    scene = [OWMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:scene];
    
    skView.hidden = YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)intoSearcher:(id)sender
{
    skView.hidden = NO;
    
    
    [scene startAnimating];

}

@end
