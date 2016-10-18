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

#define kRatzKOfacingLeft1FileName           @"Ratz_KO_L_Hit1.png"
#define kRatzKOfacingLeft2FileName           @"Ratz_KO_L_Hit2.png"
#define kRatzKOfacingLeft3FileName           @"Ratz_KO_L_Hit3.png"
#define kRatzKOfacingLeft4FileName           @"Ratz_KO_L_Hit4.png"
#define kRatzKOfacingLeft5FileName           @"Ratz_KO_L_Hit5.png"
#define kRatzKOfacingRight1FileName          @"Ratz_KO_R_Hit1.png"
#define kRatzKOfacingRight2FileName          @"Ratz_KO_R_Hit2.png"
#define kRatzKOfacingRight3FileName          @"Ratz_KO_R_Hit3.png"
#define kRatzKOfacingRight4FileName          @"Ratz_KO_R_Hit4.png"
#define kRatzKOfacingRight5FileName          @"Ratz_KO_R_Hit5.png"

#define kGatorzRunRight1FileName             @"Gatorz_Right_1.png"
#define kGatorzRunRight2FileName             @"Gatorz_Right_2.png"
#define kGatorzRunRight3FileName             @"Gatorz_Right_3.png"
#define kGatorzRunRight4FileName             @"Gatorz_Right_4.png"
#define kGatorzRunRight5FileName             @"Gatorz_Right_5.png"

#define kGatorzRunLeft1FileName              @"Gatorz_Left_1.png"
#define kGatorzRunLeft2FileName              @"Gatorz_Left_2.png"
#define kGatorzRunLeft3FileName              @"Gatorz_Left_3.png"
#define kGatorzRunLeft4FileName              @"Gatorz_Left_4.png"
#define kGatorzRunLeft5FileName              @"Gatorz_Left_5.png"

#define kGatorzMadRunRight1FileName          @"Gatorz_Mad_Right_1.png"
#define kGatorzMadRunRight2FileName          @"Gatorz_Mad_Right_2.png"
#define kGatorzMadRunRight3FileName          @"Gatorz_Mad_Right_3.png"
#define kGatorzMadRunRight4FileName          @"Gatorz_Mad_Right_4.png"
#define kGatorzMadRunRight5FileName          @"Gatorz_Mad_Right_5.png"

#define kGatorzMadRunLeft1FileName           @"Gatorz_Mad_Left_1.png"
#define kGatorzMadRunLeft2FileName           @"Gatorz_Mad_Left_2.png"
#define kGatorzMadRunLeft3FileName           @"Gatorz_Mad_Left_3.png"
#define kGatorzMadRunLeft4FileName           @"Gatorz_Mad_Left_4.png"
#define kGatorzMadRunLeft5FileName           @"Gatorz_Mad_Left_5.png"

#define kGatorzKOfacingLeft1FileName         @"Gatorz_KO_L_Hit1.png"
#define kGatorzKOfacingLeft2FileName         @"Gatorz_KO_L_Hit2.png"
#define kGatorzKOfacingLeft3FileName         @"Gatorz_KO_L_Hit3.png"
#define kGatorzKOfacingLeft4FileName         @"Gatorz_KO_L_Hit4.png"
#define kGatorzKOfacingRight1FileName        @"Gatorz_KO_R_Hit1.png"
#define kGatorzKOfacingRight2FileName        @"Gatorz_KO_R_Hit2.png"
#define kGatorzKOfacingRight3FileName        @"Gatorz_KO_R_Hit3.png"
#define kGatorzKOfacingRight4FileName        @"Gatorz_KO_R_Hit4.png"

#define kCoin1FileName                       @"Coin1.png"
#define kCoin2FileName                       @"Coin2.png"
#define kCoin3FileName                       @"Coin3.png"


@interface SKBSpriteTextures : NSObject

@property (nonatomic, strong) NSArray *playerRunRightTextures, *playerJumpRightTextures;
@property (nonatomic, strong) NSArray *playerSkiddingRightTextures, *playerStillFacingRightTextures;

@property (nonatomic, strong) NSArray *playerRunLeftTextures, *playerJumpLeftTextures;
@property (nonatomic, strong) NSArray *playerSkiddingLeftTextures, *playerStillFacingLeftTextures;

@property (nonatomic, strong) NSArray *ratzRunLeftTextures, *ratzRunRightTextures;
@property (nonatomic, strong) NSArray *ratzKOfacingLeftTextures, *ratzKOfacingRightTextures;

@property (nonatomic, strong) NSArray *gatorzRunLeftTextures, *gatorzRunRightTextures;
@property (nonatomic, strong) NSArray *gatorzMadRunLeftTextures, *gatorzMadRunRightTextures;
@property (nonatomic, strong) NSArray *gatorzKOfacingLeftTextures, *gatorzKOfacingRightTextures;

@property (nonatomic, strong) NSArray *coinTextures;

- (void)createAnimationTextures;

@end
