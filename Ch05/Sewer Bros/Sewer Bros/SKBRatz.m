//
//  SKBRatz.m
//  Sewer Bros
//
//  Created by admin on 10/29/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "SKBRatz.h"
#import "SKBGameScene.h"

@implementation SKBRatz



#pragma mark Initialization



+ (SKBRatz *)initNewRatz:(SKScene *)whichScene startingPoint:(CGPoint)location ratzIndex:(int)index
{
    SKTexture *ratzTexture = [SKTexture textureWithImageNamed:kRatzRunRight1FileName];
    SKBRatz *ratz = [SKBRatz spriteNodeWithTexture:ratzTexture];
    ratz.name = [NSString stringWithFormat:@"ratz%d", index];
    ratz.position = location;
    ratz.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ratz.size];
    ratz.physicsBody.categoryBitMask = kRatzCategory;
    ratz.physicsBody.contactTestBitMask = kWallCategory | kRatzCategory | kCoinCategory ;
    ratz.physicsBody.collisionBitMask = kBaseCategory | kWallCategory | kLedgeCategory | kRatzCategory | kCoinCategory ;
    ratz.physicsBody.density = 1.0;
    ratz.physicsBody.linearDamping = 0.1;
    ratz.physicsBody.restitution = 0.2;
    ratz.physicsBody.allowsRotation = NO;
    
    [whichScene addChild:ratz];
    return ratz;
}

- (void)spawnedInScene:(SKScene *)whichScene
{
    SKBGameScene *theScene = (SKBGameScene *)whichScene;
    _spriteTextures = theScene.spriteTextures;
    
    // set initial direction and start moving
    if (self.position.x < CGRectGetMidX(whichScene.frame))
        [self runRight];
    else
        [self runLeft];
}



#pragma mark Screen wrap



- (void)wrapRatz:(CGPoint)where
{
    SKPhysicsBody *storePB = self.physicsBody;
    self.physicsBody = nil;
    self.position = where;
    self.physicsBody = storePB;
}



#pragma mark Movement



- (void)runRight
{
    _ratzStatus = SBRatzRunningRight;
    
    SKAction *walkAnimation = [SKAction animateWithTextures:_spriteTextures.ratzRunRightTextures timePerFrame:0.05];
    SKAction *walkForever = [SKAction repeatActionForever:walkAnimation];
    [self runAction:walkForever];
    
    SKAction *moveRight = [SKAction moveByX:kRatzRunningIncrement y:0 duration:1];
    SKAction *moveForever = [SKAction repeatActionForever:moveRight];
    [self runAction:moveForever];
}

- (void)runLeft
{
    _ratzStatus = SBRatzRunningLeft;
    
    SKAction *walkAnimation = [SKAction animateWithTextures:_spriteTextures.ratzRunLeftTextures timePerFrame:0.05];
    SKAction *walkForever = [SKAction repeatActionForever:walkAnimation];
    [self runAction:walkForever];
    
    SKAction *moveLeft = [SKAction moveByX:-kRatzRunningIncrement y:0 duration:1];
    SKAction *moveForever = [SKAction repeatActionForever:moveLeft];
    [self runAction:moveForever];
}

- (void)turnRight
{
    self.ratzStatus = SBRatzRunningRight;
    [self removeAllActions];
    SKAction *moveRight = [SKAction moveByX:5 y:0 duration:0.4];
    [self runAction:moveRight completion:^{[self runRight];}];
}

- (void)turnLeft
{
    self.ratzStatus = SBRatzRunningLeft;
    [self removeAllActions];
    SKAction *moveLeft = [SKAction moveByX:-5 y:0 duration:0.4];
    [self runAction:moveLeft completion:^{[self runLeft];}];
}

@end
