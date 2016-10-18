//
//  SKBGator.m
//  Sewer Bros
//
//  Created by admin on 10/29/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "SKBGatorz.h"
#import "SKBGameScene.h"

@implementation SKBGatorz



#pragma mark Initialization



+ (SKBGatorz *)initNewGatorz:(SKScene *)whichScene startingPoint:(CGPoint)location gatorzIndex:(int)index
{
    SKTexture *gatorzTexture = [SKTexture textureWithImageNamed:kGatorzRunRight1FileName];
    SKBGatorz *gatorz = [SKBGatorz spriteNodeWithTexture:gatorzTexture];
    gatorz.name = [NSString stringWithFormat:@"gatorz%d", index];
    gatorz.position = location;
    gatorz.xScale = 1.5;
    gatorz.yScale = 1.5;
    gatorz.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:gatorz.size];
    gatorz.physicsBody.categoryBitMask = kGatorzCategory;
    gatorz.physicsBody.contactTestBitMask = kBaseCategory | kWallCategory | kLedgeCategory | kPipeCategory | kGatorzCategory | kRatzCategory | kCoinCategory ;
    gatorz.physicsBody.collisionBitMask = kBaseCategory | kWallCategory | kLedgeCategory | kPlayerCategory | kGatorzCategory | kRatzCategory | kCoinCategory ;
    gatorz.physicsBody.density = 1.0;
    gatorz.physicsBody.linearDamping = 0.1;
    gatorz.physicsBody.restitution = 0.2;
    gatorz.physicsBody.allowsRotation = NO;
    
    [whichScene addChild:gatorz];
    return gatorz;
}

- (void)spawnedInScene:(SKScene *)whichScene
{
    SKBGameScene *theScene = (SKBGameScene *)whichScene;
    _spriteTextures = theScene.spriteTextures;
    
    // Ivar initialization
    _hitCount = 0;
    
    // Sound Effects
    _splashSound = [SKAction playSoundFileNamed:kGatorzSplashedSoundFileName waitForCompletion:NO];
    _koSound = [SKAction playSoundFileNamed:kGatorzKOSoundFileName waitForCompletion:NO];
    _collectedSound = [SKAction playSoundFileNamed:kGatorzCollectedSoundFileName waitForCompletion:NO];
    _spawnSound = [SKAction playSoundFileNamed:kGatorzSpawnSoundFileName waitForCompletion:NO];
    [self runAction:_spawnSound];
    
    // set initial direction and start moving
    if (self.position.x < CGRectGetMidX(whichScene.frame))
        [self runRight];
    else
        [self runLeft];
}



#pragma mark Screen wrap



- (void)wrapGatorz:(CGPoint)where
{
    SKPhysicsBody *storePB = self.physicsBody;
    self.physicsBody = nil;
    self.position = where;
    self.physicsBody = storePB;
}

- (void)gatorzHitLeftPipe:(SKScene *)whichScene
{
    int leftSideX = CGRectGetMinX(whichScene.frame)+kEnemySpawnEdgeBufferX;
    int topSideY = CGRectGetMaxY(whichScene.frame)-kEnemySpawnEdgeBufferY;
    
    SKPhysicsBody *storedPB = self.physicsBody;
    self.physicsBody = nil;
    self.position = CGPointMake(leftSideX, topSideY);
    self.physicsBody = storedPB;
    [self removeAllActions];
    [self runRight];
    
    // Play spawning sound
    [self runAction:self.spawnSound];
}

- (void)gatorzHitRightPipe:(SKScene *)whichScene
{
    int rightSideX = CGRectGetMaxX(whichScene.frame)-kEnemySpawnEdgeBufferX;
    int topSideY = CGRectGetMaxY(whichScene.frame)-kEnemySpawnEdgeBufferY;
    
    SKPhysicsBody *storedPB = self.physicsBody;
    self.physicsBody = nil;
    self.position = CGPointMake(rightSideX, topSideY);
    self.physicsBody = storedPB;
    [self removeAllActions];
    [self runLeft];
    
    // Play spawning sound
    [self runAction:self.spawnSound];
}



#pragma mark Contact



- (void)gatorzKnockedOut:(SKScene *)whichScene
{
    [self removeAllActions];
    
    NSArray *textureArray = nil;
    if (_gatorzStatus == SBGatorzRunningLeft) {
        _gatorzStatus = SBGatorzKOfacingLeft;
        textureArray = [NSArray arrayWithArray:_spriteTextures.gatorzKOfacingLeftTextures];
    } else {
        _gatorzStatus = SBRatzKOfacingRight;
        textureArray = [NSArray arrayWithArray:_spriteTextures.gatorzKOfacingRightTextures];
    }
    
    SKAction *knockedOutAnimation = [SKAction animateWithTextures:textureArray timePerFrame:0.2];
    SKAction *knockedOutForAwhile = [SKAction repeatAction:knockedOutAnimation count:1];
    [self runAction:knockedOutForAwhile completion:^{
        if (_gatorzStatus == SBGatorzKOfacingLeft) {
            [self runLeft];
        } else {
            [self runRight];
        }
    }];
}

- (void)gatorzCollected:(SKScene *)whichScene
{
    NSLog(@"%@ collected", self.name);
    
    // Update status
    _gatorzStatus = SBGatorzKicked;
    
    // Play sound
    [whichScene runAction:_collectedSound];
    
    // show amount of winnings
    SKLabelNode *moneyText = [SKLabelNode labelNodeWithFontNamed:@"Courier-Bold"];
    moneyText.text = [NSString stringWithFormat:@"$%d", kGatorzPointValue];
    moneyText.fontSize = 9;
    moneyText.fontColor = [SKColor whiteColor];
    moneyText.position = CGPointMake(self.position.x-10, self.position.y+28);
    [whichScene addChild:moneyText];
    
    SKAction *fadeAway = [SKAction fadeOutWithDuration:1];
    [moneyText runAction:fadeAway completion:^{ [moneyText removeFromParent]; }];
    
    // upward impulse applied
    [self.physicsBody applyImpulse:CGVectorMake(0, kGatorzKickedIncrement)];
    
    // Make him spin when kicked
    SKAction *rotation = [SKAction rotateByAngle:M_PI duration:0.1];      // 2*pi = 360deg, pi = 180deg
    SKAction *rotateForever = [SKAction repeatActionForever:rotation];
    [self runAction:rotateForever];
    
    // While kicked upwards and spinning, wait for a short spell before altering physicsBody
    SKAction *shortDelay = [SKAction waitForDuration:0.25];
    
    [self runAction:shortDelay completion:^{
        // Make a new physics body that is much, much smaller as to not affect ledges as he falls...
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(1, 1)];
        self.physicsBody.categoryBitMask = kGatorzCategory;
        self.physicsBody.collisionBitMask = kWallCategory;
        self.physicsBody.contactTestBitMask = kWallCategory;
        self.physicsBody.linearDamping = 1.0;
        self.physicsBody.allowsRotation = YES;
    }];
}

- (void)gatorzHitWater:(SKScene *)whichScene
{
    // Play sound
    [whichScene runAction:_splashSound];
    
    // splash eye candy
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"Splashed" ofType:@"sks"];
    SKEmitterNode *splash = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
    splash.position = self.position;
    NSLog(@"splash (%f,%f)", splash.position.x, splash.position.y);
    splash.name = @"gatorzSplash";
    splash.targetNode = whichScene.scene;
    [whichScene addChild:splash];
    
    [self removeFromParent];
}



#pragma mark Movement



- (void)runRight
{
    _gatorzStatus = SBGatorzRunningRight;
    
    SKAction *walkAnimation = [SKAction animateWithTextures:_spriteTextures.gatorzRunRightTextures timePerFrame:0.05];
    if (_hitCount == 1) {
        walkAnimation = [SKAction animateWithTextures:_spriteTextures.gatorzMadRunRightTextures timePerFrame:0.05];
    }
    SKAction *walkForever = [SKAction repeatActionForever:walkAnimation];
    [self runAction:walkForever];
    
    SKAction *moveRight = [SKAction moveByX:kGatorzRunningIncrement y:0 duration:1];
    SKAction *moveForever = [SKAction repeatActionForever:moveRight];
    [self runAction:moveForever];
}

- (void)runLeft
{
    _gatorzStatus = SBGatorzRunningLeft;
    
    SKAction *walkAnimation = [SKAction animateWithTextures:_spriteTextures.gatorzRunLeftTextures timePerFrame:0.05];
    if (_hitCount == 1) {
        walkAnimation = [SKAction animateWithTextures:_spriteTextures.gatorzMadRunLeftTextures timePerFrame:0.05];
    }
    SKAction *walkForever = [SKAction repeatActionForever:walkAnimation];
    [self runAction:walkForever];
    
    SKAction *moveLeft = [SKAction moveByX:-kGatorzRunningIncrement y:0 duration:1];
    SKAction *moveForever = [SKAction repeatActionForever:moveLeft];
    [self runAction:moveForever];
}

- (void)turnRight
{
    _gatorzStatus = SBGatorzRunningRight;
    [self removeAllActions];
    SKAction *moveRight = [SKAction moveByX:5 y:0 duration:0.4];
    [self runAction:moveRight completion:^{[self runRight];}];
}

- (void)turnLeft
{
    _gatorzStatus = SBGatorzRunningLeft;
    [self removeAllActions];
    SKAction *moveLeft = [SKAction moveByX:-5 y:0 duration:0.4];
    [self runAction:moveLeft completion:^{[self runLeft];}];
}

@end
