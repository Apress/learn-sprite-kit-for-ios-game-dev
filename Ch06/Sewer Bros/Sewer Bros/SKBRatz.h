//
//  SKBRatz.h
//  Sewer Bros
//
//  Created by admin on 10/29/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKBAppDelegate.h"
#import "SKBSpriteTextures.h"

#define kRatzRunningIncrement      40

typedef enum : int {
    SBRatzRunningLeft = 0,
    SBRatzRunningRight
} SBRatzStatus;


@interface SKBRatz : SKSpriteNode

@property int ratzStatus;
@property (nonatomic, strong) SKBSpriteTextures *spriteTextures;

+ (SKBRatz *)initNewRatz:(SKScene *)whichScene startingPoint:(CGPoint)location ratzIndex:(int)index;
- (void)spawnedInScene:(SKScene *)whichScene;

- (void)wrapRatz:(CGPoint)where;

- (void)runRight;
- (void)runLeft;
- (void)turnRight;
- (void)turnLeft;

@end
