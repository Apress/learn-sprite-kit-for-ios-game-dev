//
//  SKBScores.h
//  Sewer Bros
//
//  Created by admin on 11/21/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#define kTextPlayerHeaderFileName           @"Text_PlayerScoreHeader.png"
#define kTextHighHeaderFileName             @"Text_HighScoreHeader.png"

#define kTextNumber0FileName                @"Text_Number_0.png"
#define kTextNumber1FileName                @"Text_Number_1.png"
#define kTextNumber2FileName                @"Text_Number_2.png"
#define kTextNumber3FileName                @"Text_Number_3.png"
#define kTextNumber4FileName                @"Text_Number_4.png"
#define kTextNumber5FileName                @"Text_Number_5.png"
#define kTextNumber6FileName                @"Text_Number_6.png"
#define kTextNumber7FileName                @"Text_Number_7.png"
#define kTextNumber8FileName                @"Text_Number_8.png"
#define kTextNumber9FileName                @"Text_Number_9.png"

#define kScoreDigitCount                    5
#define kScoreNumberSpacing                 16
#define kScorePlayerDistanceFromLeft        10
#define kScoreDistanceFromTop               10


@interface SKBScores : NSObject

@property (nonatomic, strong) NSArray *arrayOfNumberTextures;

- (void)createScoreNode:(SKScene *)whichScene;
- (void)updateScore:(SKScene *)whichScene newScore:(int)playerScore hiScore:(int)highScore;

@end

