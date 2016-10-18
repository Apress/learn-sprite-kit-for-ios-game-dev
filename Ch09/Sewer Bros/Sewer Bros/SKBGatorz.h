//
//  SKBGatorz.h
//  Sewer Bros
//
//  Created by admin on 10/29/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKBAppDelegate.h"
#import "SKBSpriteTextures.h"

#define kGatorzSpawnSoundFileName        @"SpawnEnemy.caf"
#define kGatorzKOSoundFileName           @"EnemyKO.caf"
#define kGatorzCollectedSoundFileName    @"EnemyCollected.caf"
#define kGatorzSplashedSoundFileName     @"Splash.caf"

#define kGatorzRunningIncrement          30
#define kGatorzKickedIncrement           5
#define kGatorzPointValue                150

typedef enum : int {
    SBGatorzRunningLeft = 0,
    SBGatorzRunningRight,
    SBGatorzKOfacingLeft,
    SBGatorzKOfacingRight,
    SBGatorzKicked
} SBGatorzStatus;


@interface SKBGatorz : SKSpriteNode

@property int gatorzStatus, hitCount;
@property int lastKnownXposition, lastKnownYposition;
@property (nonatomic, strong) NSString *lastKnownContactedLedge;
@property (nonatomic, strong) SKBSpriteTextures *spriteTextures;

@property (nonatomic, strong) SKAction *spawnSound, *koSound, *collectedSound, *splashSound;

+ (SKBGatorz *)initNewGatorz:(SKScene *)whichScene startingPoint:(CGPoint)location gatorzIndex:(int)index;
- (void)spawnedInScene:(SKScene *)whichScene;

- (void)wrapGatorz:(CGPoint)where;
- (void)gatorzHitLeftPipe:(SKScene *)whichScene;
- (void)gatorzHitRightPipe:(SKScene *)whichScene;

- (void)gatorzKnockedOut:(SKScene *)whichScene;
- (void)gatorzCollected:(SKScene *)whichScene;
- (void)gatorzHitWater:(SKScene *)whichScene;

- (void)runRight;
- (void)runLeft;
- (void)turnRight;
- (void)turnLeft;

@end
