//
//  SKBPlayer.h
//  Sewer Bros
//
//  Created by admin on 10/15/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKBAppDelegate.h"
#import "SKBSpriteTextures.h"

#define kPlayerSpawnSoundFileName    @"SpawnPlayer.caf"
#define kPlayerBittenSoundFileName   @"Playerbitten.caf"
#define kPlayerSplashedSoundFileName @"Splash.caf"
#define kPlayerRunSoundFileName      @"Run.caf"
#define kPlayerSkidSoundFileName     @"Skid.caf"
#define kPlayerJumpSoundFileName     @"Jump.caf"

#define kPlayerRunningIncrement      100
#define kPlayerSkiddingIncrement      20
#define kPlayerJumpingIncrement        8
#define kPlayerBittenIncrement         5

typedef enum : int {
    SBPlayerFacingLeft = 0,
    SBPlayerFacingRight,
    SBPlayerRunningLeft,
    SBPlayerRunningRight,
    SBPlayerSkiddingLeft,
    SBPlayerSkiddingRight,
    SBPlayerJumpingLeft,
    SBPlayerJumpingRight,
    SBPlayerJumpingUpFacingLeft,
    SBPlayerJumpingUpFacingRight,
    SBPlayerFalling
} SBPlayerStatus;


@interface SKBPlayer : SKSpriteNode

@property (nonatomic, strong) SKBSpriteTextures *spriteTextures;
@property SBPlayerStatus playerStatus;

@property (nonatomic, strong) SKAction *spawnSound, *bittenSound, *splashSound;
@property (nonatomic, strong) SKAction *runSound, *jumpSound, *skidSound;

+ (SKBPlayer *)initNewPlayer:(SKScene *)whichScene startingPoint:(CGPoint)location;
- (void)spawnedInScene:(SKScene *)whichScene;

- (void)wrapPlayer:(CGPoint)where;
- (void)playerKilled:(SKScene *)whichScene;
- (void)playerHitWater:(SKScene *)whichScene;

- (void)runRight;
- (void)runLeft;
- (void)skidRight;
- (void)skidLeft;
- (void)jump;

@end
