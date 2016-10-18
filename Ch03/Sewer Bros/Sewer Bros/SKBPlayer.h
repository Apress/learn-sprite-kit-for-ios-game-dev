//
//  SKBPlayer.h
//  Sewer Bros
//
//  Created by admin on 10/15/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKBSpriteTextures.h"

#define kPlayerRunningIncrement      100
#define kPlayerSkiddingIncrement      20

typedef enum : int {
    SBPlayerFacingLeft = 0,
    SBPlayerFacingRight,
    SBPlayerRunningLeft,
    SBPlayerRunningRight,
    SBPlayerSkiddingLeft,
    SBPlayerSkiddingRight
} SBPlayerStatus;


@interface SKBPlayer : SKSpriteNode

@property (nonatomic, strong) SKBSpriteTextures *spriteTextures;
@property SBPlayerStatus playerStatus;

+ (SKBPlayer *)initNewPlayer:(SKScene *)whichScene startingPoint:(CGPoint)location;

- (void)runRight;
- (void)runLeft;
- (void)skidRight;
- (void)skidLeft;

@end
