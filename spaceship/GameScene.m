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
static const float BG_VELOCITY = 100.0;
static inline CGPoint CGPointAdd(const CGPoint a, const CGPoint b){
    return CGPointMake(a.x + b.x, a.y + b.y);
}
static inline CGPoint CGPointMultiplyScalar(const CGPoint a, const CGFloat b){
    return CGPointMake(a.x * b, a.y * b);
}

@implementation GameScene{
    SKSpriteNode *ship;
    SKAction *actionMoveUp;
    SKAction *actionMoveDown;
    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _dt;
    NSTimeInterval _lastMissileAdded;
}

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]){
        self.backgroundColor = [SKColor whiteColor];
        [self initializingScrollingBackground];
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

-(void)initializingScrollingBackground{
    for (int i = 0; i < 2; i++) {
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"bg"];
        bg.position = CGPointMake(i * bg.size.width, 0);
        bg.anchorPoint = CGPointZero;
        bg.name = @"bg";
        [self addChild:bg];
    }
}

-(void)moveBg{
    [self enumerateChildNodesWithName:@"bg" usingBlock:^(SKNode *node, BOOL *stop){
        SKSpriteNode *bg = (SKSpriteNode *)node;
        CGPoint bgVelocity = CGPointMake(-BG_VELOCITY, 0);
        CGPoint amtToMove = CGPointMultiplyScalar(bgVelocity, _dt);
        bg.position = CGPointAdd(bg.position, amtToMove);
        
        // Check if bg node is completely scrolled of the screen, if yes then put it at the end of the other node
        if (bg.position.x <= -bg.size.width) {
            bg.position = CGPointMake(bg.position.x + bg.size.width * 2, bg.position.y);
        }
    }];
}

-(void)update:(NSTimeInterval)currentTime{
    if (_lastUpdateTime) {
        _dt = currentTime - _lastUpdateTime;
    } else {
        _dt = 0;
    }
    
    _lastUpdateTime = currentTime;
    
    [self moveBg];
}
@end