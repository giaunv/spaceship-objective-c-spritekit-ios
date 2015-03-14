//
//  GameOverScene.m
//  spaceship
//
//  Created by giaunv on 3/14/15.
//  Copyright (c) 2015 366. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScene.h"

@implementation GameOverScene
-(id)initWithSize:(CGSize)size score: (NSInteger)player_score{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        NSString *message = @"Game Over";
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text = message;
        label.fontSize = 40;
        label.fontColor = [SKColor blackColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:label];
        
        NSString *retryMessage = @"Replay Game";
        SKLabelNode *retryButton = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        retryButton.text = retryMessage;
        retryButton.fontColor = [SKColor blackColor];
        retryButton.position = CGPointMake(self.size.width/2, 50);
        retryButton.name = @"retry";
        [self addChild:retryButton];
        
        NSString *playerscoreMessage = [NSString stringWithFormat:@"Player Score: %ld", (long)player_score];
        SKLabelNode *playerscore = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        playerscore.text = playerscoreMessage;
        playerscore.fontColor = [SKColor blackColor];
        playerscore.position = CGPointMake(self.size.width/2, 250);
        playerscore.name = @"Player Score";
        [playerscore setScale:0.5];
        
        [self addChild:playerscore];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if([node.name isEqualToString:@"retry"]){
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        GameScene *scene = [GameScene sceneWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition:reveal];
    }
}
@end
