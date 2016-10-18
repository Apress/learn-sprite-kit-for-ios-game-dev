//
//  SKBPlayer.m
//  Sewer Bros
//
//  Created by admin on 10/15/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "SKBPlayer.h"
#import "SKBGameScene.h"

@implementation SKBPlayer



#pragma mark Initialization



+ (SKBPlayer *)initNewPlayer:(SKScene *)whichScene startingPoint:(CGPoint)location;
{
    // initial frame
    SKTexture *f1 = [SKTexture textureWithImageNamed: kPlayerStillRightFileName];
    
    // our player character sprite & starting position in the scene
    SKBPlayer *player = [SKBPlayer spriteNodeWithTexture:f1];
    player.name = @"player1";
    player.position = location;
    player.playerStatus = SBPlayerFacingRight;
    
    // physics
    player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:player.size];
    player.physicsBody.categoryBitMask = kPlayerCategory;
    player.physicsBody.contactTestBitMask = kWallCategory | kLedgeCategory | kCoinCategory | kRatzCategory;
    player.physicsBody.collisionBitMask = kBaseCategory | kWallCategory | kLedgeCategory | kRatzCategory ;
    player.physicsBody.density = 1.0;
    player.physicsBody.linearDamping = 0.1;
    player.physicsBody.restitution = 0.2;
    player.physicsBody.allowsRotation = NO;
    
    // add the sprite to the scene
    [whichScene addChild:player];
    return player;
}

- (void)spawnedInScene:(SKScene *)whichScene
{
    SKBGameScene *theScene = (SKBGameScene *)whichScene;
    _spriteTextures = theScene.spriteTextures;
    
    // Sounds
    _spawnSound = [SKAction playSoundFileNamed:kPlayerSpawnSoundFileName waitForCompletion:NO];
    _bittenSound = [SKAction playSoundFileNamed:kPlayerBittenSoundFileName waitForCompletion:NO];
    _splashSound = [SKAction playSoundFileNamed:kPlayerSplashedSoundFileName waitForCompletion:NO];
    _runSound = [SKAction playSoundFileNamed:kPlayerRunSoundFileName waitForCompletion:YES];
    _jumpSound = [SKAction playSoundFileNamed:kPlayerJumpSoundFileName waitForCompletion:NO];
    _skidSound = [SKAction playSoundFileNamed:kPlayerSkidSoundFileName waitForCompletion:YES];
    
    // Play sound
    [self runAction:_spawnSound];
}



#pragma mark Screen wrap



- (void)wrapPlayer:(CGPoint)where
{
    SKPhysicsBody *storePB = self.physicsBody;
    self.physicsBody = nil;
    self.position = where;
    self.physicsBody = storePB;
}



#pragma mark Contact



- (void)playerKilled:(SKScene *)whichScene
{
    NSLog(@"Player has died...");
    [self removeAllActions];
    
    // Update status
    _playerStatus = SBPlayerFalling;
    
    // Play sound
    [whichScene runAction:_bittenSound];
    
    // upward impulse applied
    [self.physicsBody applyImpulse:CGVectorMake(0, kPlayerBittenIncrement)];
    
    // While flying upwards, wait for a short spell before altering physicsBody
    SKAction *shortDelay = [SKAction waitForDuration:0.5];
    
    [self runAction:shortDelay completion:^{
        // Make a new physics body that is much, much smaller as to not affect ledges as he falls...
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(1, 1)];
        self.physicsBody.categoryBitMask = kPlayerCategory;
        self.physicsBody.collisionBitMask = kWallCategory;
        self.physicsBody.contactTestBitMask = kWallCategory;
        self.physicsBody.linearDamping = 1.0;
        self.physicsBody.allowsRotation = NO;
    }];
}

- (void)playerHitWater:(SKScene *)whichScene
{
    NSLog(@"Player has fallen and hit the water...");
    
    // Play sound
    [whichScene runAction:_splashSound];
    
    // splash eye candy
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"Splashed" ofType:@"sks"];
    SKEmitterNode *splash = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
    splash.position = self.position;
    //NSLog(@"splash (%f,%f)", splash.position.x, splash.position.y);
    splash.name = @"playerSplash";
    splash.targetNode = whichScene.scene;
    [whichScene addChild:splash];
    
    [self removeFromParent];
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
    
    // Sound effect for running
    SKAction *shortPause = [SKAction waitForDuration:0.01];
    SKAction *sequence = [SKAction sequence:@[_runSound, shortPause]];
    SKAction *soundContinuous = [SKAction repeatActionForever:sequence];
    [self runAction:soundContinuous withKey:@"soundContinuous"];
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
    
    // Sound effect for running
    SKAction *shortPause = [SKAction waitForDuration:0.01];
    SKAction *sequence = [SKAction sequence:@[_runSound, shortPause]];
    SKAction *soundContinuous = [SKAction repeatActionForever:sequence];
    [self runAction:soundContinuous withKey:@"soundContinuous"];
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
    SKAction *group = [SKAction group:@[sequence, _skidSound]];
    
    [self runAction:group completion:^{
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
    SKAction *group = [SKAction group:@[sequence, _skidSound]];
    
    [self runAction:group completion:^{
        NSLog(@"skid ended, still facing left");
        _playerStatus = SBPlayerFacingLeft;
    }];
}

- (void)jump
{
    // Stop running Sound Effects
    [self removeActionForKey:@"soundContinuous"];
    
    NSArray *playerJumpTextures = nil;
    SBPlayerStatus nextPlayerStatus = 0;
    
    // determine direction and next phase
    if (self.playerStatus == SBPlayerRunningLeft || self.playerStatus == SBPlayerSkiddingLeft) {
        NSLog(@"jump left");
        self.playerStatus = SBPlayerJumpingLeft;
        playerJumpTextures = _spriteTextures.playerJumpLeftTextures;
        nextPlayerStatus = SBPlayerRunningLeft;
    } else if (self.playerStatus == SBPlayerRunningRight || self.playerStatus == SBPlayerSkiddingRight) {
        NSLog(@"jump right");
        self.playerStatus = SBPlayerJumpingRight;
        playerJumpTextures = _spriteTextures.playerJumpRightTextures;
        nextPlayerStatus = SBPlayerRunningRight;
    } else if (self.playerStatus == SBPlayerFacingLeft) {
        NSLog(@"jump up, facing left");
        self.playerStatus = SBPlayerJumpingUpFacingLeft;
        playerJumpTextures = _spriteTextures.playerJumpLeftTextures;
        nextPlayerStatus = SBPlayerFacingLeft;
    } else if (self.playerStatus == SBPlayerFacingRight) {
        NSLog(@"jump up, facing right");
        self.playerStatus = SBPlayerJumpingUpFacingRight;
        playerJumpTextures = _spriteTextures.playerJumpRightTextures;
        nextPlayerStatus = SBPlayerFacingRight;
    } else {
        NSLog(@"SKBPlayer::jump encountered invalid value...");
    }
    
    // applicable animation
    SKAction *jumpAnimation = [SKAction animateWithTextures:playerJumpTextures timePerFrame:0.2];
    SKAction *jumpAwhile = [SKAction repeatAction:jumpAnimation count:4.0];
    SKAction *groupedJump = [SKAction group:@[_jumpSound, jumpAwhile]];
    
    // run jump action and when completed handle next phase
    [self runAction:groupedJump completion:^{
        if (nextPlayerStatus == SBPlayerRunningLeft) {
            [self removeAllActions];
            [self runLeft];
        } else if (nextPlayerStatus == SBPlayerRunningRight) {
            [self removeAllActions];
            [self runRight];
        } else if (nextPlayerStatus == SBPlayerFacingLeft) {
            NSArray *playerStillTextures = _spriteTextures.playerStillFacingLeftTextures;
            SKAction *stillAnimation = [SKAction animateWithTextures:playerStillTextures timePerFrame:1];
            SKAction *stillAwhile = [SKAction repeatAction:stillAnimation count:0.1];
            [self runAction:stillAwhile];
            self.playerStatus = SBPlayerFacingLeft;
        } else if (nextPlayerStatus == SBPlayerFacingRight) {
            NSArray *playerStillTextures = _spriteTextures.playerStillFacingRightTextures;
            SKAction *stillAnimation = [SKAction animateWithTextures:playerStillTextures timePerFrame:1];
            SKAction *stillAwhile = [SKAction repeatAction:stillAnimation count:0.1];
            [self runAction:stillAwhile];
            self.playerStatus = SBPlayerFacingRight;
        } else {
            NSLog(@"SKBPlayer::jump completion block encountered invalid value...");
        }
    }];
    
    // jump impulse applied
    [self.physicsBody applyImpulse:CGVectorMake(0, kPlayerJumpingIncrement)];
}

@end
