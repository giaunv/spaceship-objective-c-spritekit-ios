//
//  GameScene.m
//  spaceship
//
//  Created by giaunv on 3/13/15.
//  Copyright (c) 2015 366. All rights reserved.
//

#import "GameScene.h"

static const uint32_t shipCategory = 0x1 << 0;
static const uint32_t obstacleCategory = 0x1 << 1;

@implementation GameScene{
    SKSpriteNode *ship;
    SKAction *actionMoveUp;
    SKAction *actionMoveDown;
}

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]){
        self.backgroundColor = [SKColor whiteColor];
        [self addShip];
        
        // Making self delegate of physics world
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
    }
    
    return self;
}

-(void)addShip{
    // Initializing spaceship node
    //SKSpriteNode *ship = [SKSpriteNode new];
    ship = [SKSpriteNode spriteNodeWithImageNamed:@"SpaceShip"];
    [ship setScale:0.5];
    ship.zRotation = - M_PI / 2;
    
    // Adding SpriteKit physicsBody for collision detection
    ship.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ship.size];
    ship.physicsBody.categoryBitMask = shipCategory;
    ship.physicsBody.dynamic = YES;
    ship.physicsBody.contactTestBitMask = obstacleCategory;
    ship.physicsBody.collisionBitMask = 0;
    ship.name = @"ship";
    ship.position = CGPointMake(120, 160);
    
    [self addChild:ship];
    
    actionMoveUp = [SKAction moveByX:0 y:30 duration:.2];
    actionMoveDown = [SKAction moveByX:0 y:-30 duration:.2];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self.scene];
    if (touchLocation.y > ship.position.y) {
        if (ship.position.y < 270) {
            [ship runAction:actionMoveUp];
        }
    } else{
        if (ship.position.y > 50) {
            [ship runAction:actionMoveDown];
        }
    }
}
@end