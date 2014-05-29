//
//  OWViewController.h
//  ShapeAnimation
//

//  Copyright (c) 2014年 grenlight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@class OWMyScene;
@interface OWViewController : UIViewController
{
    IBOutlet  SKView *skView;
    OWMyScene   *scene;
}

- (IBAction)intoSearcher:(id)sender;
@end
