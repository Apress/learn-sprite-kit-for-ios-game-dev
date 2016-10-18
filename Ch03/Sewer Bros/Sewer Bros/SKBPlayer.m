//
//  SKBPlayer.m
//  Sewer Bros
//
//  Created by admin on 10/15/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "SKBPlayer.h"

@implementation SKBPlayer



#pragma mark Initialization



+ (SKBPlayer *)initNewPlayer:(SKScene *)whichScene startingPoint:(CGPoint)location;
{
    // initialize and create our sprite textures
    SKBSpriteTextures *playerTextures = [[SKBSpriteTextures alloc] init];
    [playerTextures createAnimationTextures];
    
    // initial frame
    SKTexture *f1 = [SKTexture textureWithImageNamed: kPlayerRunRight1FileName];
    
    // our player character sprite & starting position in the scene
    SKBPlayer *player = [SKBPlayer spriteNodeWithTexture:f1];
    player.position = location;
    player.spriteTextures = playerTextures;
    
    // add the sprite to the scene
    [whichScene addChild:player];
    return player;
}



#pragma mark Movement



- (void)runRight
{
    NSLog(@"run Right");
    _playerStatus = SBPlayerRunningRight;
    
    SKAction *walkAnimation = [SKAction animateWithTextures:_spriteTextures.playerRunRightTextures timePerFrame:0.05];
    SKAction *walkForever = [SKAction repeatActionForever:walkAnimation];
    [self runAction:walkForever];
    
    SKAction *moveRight = [SKAction moveByX:kPlayerRunningIncrement y:0 duration:1];
    SKAction *moveForever = [SKAction repeatActionForever:moveRight];
    [self runAction:moveForever];
}

- (void)runLeft
{
    NSLog(@"run Left");
    _playerStatus = SBPlayerRunningLeft;
    
    SKAction *walkAnimation = [SKAction animateWithTextures:_spriteTextures.playerRunLeftTextures timePerFrame:0.05];
    SKAction *walkForever = [SKAction repeatActionForever:walkAnimation];
    [self runAction:walkForever];
    
    SKAction *moveLeft = [SKAction moveByX:-kPlayerRunningIncrement y:0 duration:1];
    SKAction *moveForever = [SKAction repeatActionForever:moveLeft];
    [self runAction:moveForever];
}

- (void)skidRight
{
    NSLog(@"skid Right");
    [self removeAllActions];
    _playerStatus = SBPlayerSkiddingRight;
    
    NSArray *playerSkidTextures = _spriteTextures.playerSkiddingRightTextures;
    NSArray *playerStillTextures = _spriteTextures.playerStillFacingRightTextures;
    
    SKAction *skidAnimation = [SKAction animateWithTextures:playerSkidTextures timePerFrame:1];
    SKAction *skidAwhile = [SKAction repeatAction:skidAnimation count:0.2];
    
    SKAction *moveLeft = [SKAction moveByX:kPlayerSkiddingIncrement y:0 duration:0.2];
    SKAction *moveAwhile = [SKAction repeatAction:moveLeft count:1];
    
    SKAction *stillAnimation = [SKAction animateWithTextures:playerStillTextures timePerFrame:1];
    SKAction *stillAwhile = [SKAction repeatAction:stillAnimation count:0.1];
    
    SKAction *sequence = [SKAction sequence:@[skidAwhile, moveAwhile, stillAwhile]];
    [self runAction:sequence completion:^{
        NSLog(@"skid ended, still facing right");
        _playerStatus = SBPlayerFacingRight;
    }];
}

- (void)skidLeft
{
    NSLog(@"skid Left");
    [self removeAllActions];
    _playerStatus = SBPlayerSkiddingLeft;
    
    NSArray *playerSkidTextures = _spriteTextures.playerSkiddingLeftTextures;
    NSArray *playerStillTextures = _spriteTextures.playerStillFacingLeftTextures;
    
    SKAction *skidAnimation = [SKAction animateWithTextures:playerSkidTextures timePerFrame:1];
    SKAction *skidAwhile = [SKAction repeatAction:skidAnimation count:0.2];
    
    SKAction *moveLeft = [SKAction moveByX:-kPlayerSkiddingIncrement y:0 duration:0.2];
    SKAction *moveAwhile = [SKAction repeatAction:moveLeft count:1];
    
    SKAction *stillAnimation = [SKAction animateWithTextures:playerStillTextures timePerFrame:1];
    SKAction *stillAwhile = [SKAction repeatAction:stillAnimation count:0.1];
    
    SKAction *sequence = [SKAction sequence:@[skidAwhile, moveAwhile, stillAwhile]];
    [self runAction:sequence completion:^{
        NSLog(@"skid ended, still facing left");
        _playerStatus = SBPlayerFacingLeft;
    }];
}

@end
