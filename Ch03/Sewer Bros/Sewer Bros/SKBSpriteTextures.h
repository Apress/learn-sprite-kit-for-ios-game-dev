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
#define kPlayerSkidRightFileName             @"Player_RightSkid.png"
#define kPlayerStillRightFileName            @"Player_Right_Still.png"

#define kPlayerRunLeft1FileName              @"Player_Left1.png"
#define kPlayerRunLeft2FileName              @"Player_Left2.png"
#define kPlayerRunLeft3FileName              @"Player_Left3.png"
#define kPlayerRunLeft4FileName              @"Player_Left4.png"
#define kPlayerSkidLeftFileName              @"Player_LeftSkid.png"
#define kPlayerStillLeftFileName             @"Player_Left_Still.png"


@interface SKBSpriteTextures : NSObject

@property (nonatomic, strong) NSArray *playerRunRightTextures, *playerSkiddingRightTextures, *playerStillFacingRightTextures;
@property (nonatomic, strong) NSArray *playerRunLeftTextures, *playerSkiddingLeftTextures, *playerStillFacingLeftTextures;

- (void)createAnimationTextures;

@end
