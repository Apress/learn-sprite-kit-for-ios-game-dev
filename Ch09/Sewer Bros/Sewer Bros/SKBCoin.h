//
//  SKBCoin.h
//  Sewer Bros
//
//  Created by admin on 11/18/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKBAppDelegate.h"
#import "SKBSpriteTextures.h"

#define kCoinSpawnSoundFileName        @"SpawnCoin.caf"
#define kCoinCollectedSoundFileName    @"CoinCollected.caf"

#define kCoinRunningIncrement          40
#define kCoinPointValue                60

typedef enum : int {
    SBCoinRunningLeft = 0,
    SBCoinRunningRight
} SBCoinStatus;


@interface SKBCoin : SKSpriteNode

@property int coinStatus;
@property int lastKnownXposition, lastKnownYposition;
@property (nonatomic, strong) NSString *lastKnownContactedLedge;
@property (nonatomic, strong) SKBSpriteTextures *spriteTextures;

@property (nonatomic, strong) SKAction *spawnSound, *collectedSound;

+ (SKBCoin *)initNewCoin:(SKScene *)whichScene startingPoint:(CGPoint)location coinIndex:(int)index;
- (void)spawnedInScene:(SKScene *)whichScene;

- (void)wrapCoin:(CGPoint)where;

- (void)coinHitPipe;
- (void)coinCollected:(SKScene *)whichScene;

- (void)runRight;
- (void)runLeft;
- (void)turnRight;
- (void)turnLeft;

@end
