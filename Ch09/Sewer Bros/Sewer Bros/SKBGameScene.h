//
//  SKBGameScene.h
//  Sewer Bros
//
//  Created by admin on 8/27/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKBAppDelegate.h"
#import "SKBLedge.h"
#import "SKBScores.h"
#import "SKBPlayer.h"
#import "SKBCoin.h"
#import "SKBRatz.h"
#import "SKBGatorz.h"

#define kNumberOfLevelsMax       2

#define kPlayerLivesMax          3
#define kPlayerLivesSpacing      10


@interface SKBGameScene : SKScene <SKPhysicsContactDelegate>

@property (strong, nonatomic) SKBPlayer *playerSprite;
@property (strong, nonatomic) SKBSpriteTextures *spriteTextures;
@property (strong, nonatomic) NSArray *cast_TypeArray, *cast_DelayArray, *cast_StartXindexArray;

@property int frameCounter;
@property int spawnedEnemyCount, activeEnemyCount;
@property BOOL enemyIsSpawningFlag;
@property BOOL playerIsDeadFlag;
@property int playerLivesRemaining;
@property BOOL gameIsOverFlag, gameIsPaused;
@property int currentLevel;

@property (nonatomic, strong) SKBScores *scoreDisplay;
@property int playerScore, highScore;

@end
