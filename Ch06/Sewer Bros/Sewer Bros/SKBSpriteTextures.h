//
//  SKBSpriteTextures.h
//  Sewer Bros
//
//  Created by admin on 10/15/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#define kPlayerRunRight1FileName             @"Player_Right1.png"
#define kPlayerRunRight2FileName             @"Player_Right2.png"
#define kPlayerRunRight3FileName             @"Player_Right3.png"
#define kPlayerRunRight4FileName             @"Player_Right4.png"
#define kPlayerJumpRightFileName             @"Player_RightJump.png"
#define kPlayerSkidRightFileName             @"Player_RightSkid.png"
#define kPlayerStillRightFileName            @"Player_Right_Still.png"

#define kPlayerRunLeft1FileName              @"Player_Left1.png"
#define kPlayerRunLeft2FileName              @"Player_Left2.png"
#define kPlayerRunLeft3FileName              @"Player_Left3.png"
#define kPlayerRunLeft4FileName              @"Player_Left4.png"
#define kPlayerJumpLeftFileName              @"Player_LeftJump.png"
#define kPlayerSkidLeftFileName              @"Player_LeftSkid.png"
#define kPlayerStillLeftFileName             @"Player_Left_Still.png"

#define kRatzRunRight1FileName               @"Ratz_Right1.png"
#define kRatzRunRight2FileName               @"Ratz_Right2.png"
#define kRatzRunRight3FileName               @"Ratz_Right3.png"
#define kRatzRunRight4FileName               @"Ratz_Right4.png"
#define kRatzRunRight5FileName               @"Ratz_Right5.png"

#define kRatzRunLeft1FileName                @"Ratz_Left1.png"
#define kRatzRunLeft2FileName                @"Ratz_Left2.png"
#define kRatzRunLeft3FileName                @"Ratz_Left3.png"
#define kRatzRunLeft4FileName                @"Ratz_Left4.png"
#define kRatzRunLeft5FileName                @"Ratz_Left5.png"

#define kCoin1FileName                       @"Coin1.png"
#define kCoin2FileName                       @"Coin2.png"
#define kCoin3FileName                       @"Coin3.png"


@interface SKBSpriteTextures : NSObject

@property (nonatomic, strong) NSArray *playerRunRightTextures, *playerJumpRightTextures;
@property (nonatomic, strong) NSArray *playerSkiddingRightTextures, *playerStillFacingRightTextures;

@property (nonatomic, strong) NSArray *playerRunLeftTextures, *playerJumpLeftTextures;
@property (nonatomic, strong) NSArray *playerSkiddingLeftTextures, *playerStillFacingLeftTextures;

@property (nonatomic, strong) NSArray *ratzRunLeftTextures, *ratzRunRightTextures;

@property (nonatomic, strong) NSArray *coinTextures;

- (void)createAnimationTextures;

@end
