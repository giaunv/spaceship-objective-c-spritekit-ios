//
//  GameViewController.m
//  spaceship
//
//  Created by giaunv on 3/13/15.
//  Copyright (c) 2015 366. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    SKView *skView = (SKView *)self.view;
    
    if (!skView.scene) {
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        // Create and configure the scene.
        SKScene *scene = [GameScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene
        [skView presentScene:scene];
    }
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end