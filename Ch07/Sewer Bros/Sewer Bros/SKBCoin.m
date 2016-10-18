//
//  SKBCoin.m
//  Sewer Bros
//
//  Created by admin on 11/18/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "SKBCoin.h"
#import "SKBGameScene.h"

@implementation SKBCoin



#pragma mark Initialization



+ (SKBCoin *)initNewCoin:(SKScene *)whichScene startingPoint:(CGPoint)location coinIndex:(int)index
{
    SKTexture *coinTexture = [SKTexture textureWithImageNamed:kCoin1FileName];
    SKBCoin *coin = [SKBCoin spriteNodeWithTexture:coinTexture];
    coin.name = [NSString stringWithFormat:@"coin%d", index];
    coin.position = location;
    coin.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:coin.size];
    coin.physicsBody.categoryBitMask = kCoinCategory;
    coin.physicsBody.contactTestBitMask = kWallCategory | kCoinCategory | kRatzCategory ;
    coin.physicsBody.collisionBitMask = kBaseCategory | kWallCategory | kLedgeCategory | kCoinCategory | kRatzCategory ;
    coin.physicsBody.density = 1.0;
    coin.physicsBody.linearDamping = 0.1;
    coin.physicsBody.restitution = 0.2;
    coin.physicsBody.allowsRotation = NO;
    
    [whichScene addChild:coin];
    return coin;
}

- (void)spawnedInScene:(SKScene *)whichScene
{
    SKBGameScene *theScene = (SKBGameScene *)whichScene;
    _spriteTextures = theScene.spriteTextures;
    
    // Sound Effects
    _spawnSound = [SKAction playSoundFileNamed:kCoinSpawnSoundFileName waitForCompletion:NO];
    [self runAction:_spawnSound];
    
    // set initial direction and start moving
    if (self.position.x < CGRectGetMidX(whichScene.frame))
        [self runRight];
    else
        [self runLeft];
}



#pragma mark Screen wrap



- (void)wrapCoin:(CGPoint)where
{
    SKPhysicsBody *storePB = self.physicsBody;
    self.physicsBody = nil;
    self.position = where;
    self.physicsBody = storePB;
}



#pragma mark Movement



- (void)runRight
{
    _coinStatus = SBCoinRunningRight;
    
    SKAction *walkAnimation = [SKAction animateWithTextures:_spriteTextures.coinTextures timePerFrame:0.05];
    SKAction *walkForever = [SKAction repeatActionForever:walkAnimation];
    [self runAction:walkForever];
    
    SKAction *moveRight = [SKAction moveByX:kCoinRunningIncrement y:0 duration:1];
    SKAction *moveForever = [SKAction repeatActionForever:moveRight];
    [self runAction:moveForever];
}

- (void)runLeft
{
    _coinStatus = SBCoinRunningLeft;
    
    SKAction *walkAnimation = [SKAction animateWithTextures:_spriteTextures.coinTextures timePerFrame:0.05];
    SKAction *walkForever = [SKAction repeatActionForever:walkAnimation];
    [self runAction:walkForever];
    
    SKAction *moveLeft = [SKAction moveByX:-kCoinRunningIncrement y:0 duration:1];
    SKAction *moveForever = [SKAction repeatActionForever:moveLeft];
    [self runAction:moveForever];
}

- (void)turnRight
{
    self.coinStatus = SBCoinRunningRight;
    [self removeAllActions];
    SKAction *moveRight = [SKAction moveByX:5 y:0 duration:0.4];
    [self runAction:moveRight completion:^{[self runRight];}];
}

- (void)turnLeft
{
    self.coinStatus = SBCoinRunningLeft;
    [self removeAllActions];
    SKAction *moveLeft = [SKAction moveByX:-5 y:0 duration:0.4];
    [self runAction:moveLeft completion:^{[self runLeft];}];
}

@end
