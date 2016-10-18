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

#define kCoinSpawnSoundFileName    @"SpawnCoin.caf"

#define kCoinRunningIncrement      40

typedef enum : int {
    SBCoinRunningLeft = 0,
    SBCoinRunningRight
} SBCoinStatus;


@interface SKBCoin : SKSpriteNode

@property int coinStatus;
@property (nonatomic, strong) SKBSpriteTextures *spriteTextures;

@property (nonatomic, strong) SKAction *spawnSound;

+ (SKBCoin *)initNewCoin:(SKScene *)whichScene startingPoint:(CGPoint)location coinIndex:(int)index;
- (void)spawnedInScene:(SKScene *)whichScene;

- (void)wrapCoin:(CGPoint)where;

- (void)runRight;
- (void)runLeft;
- (void)turnRight;
- (void)turnLeft;

@end
