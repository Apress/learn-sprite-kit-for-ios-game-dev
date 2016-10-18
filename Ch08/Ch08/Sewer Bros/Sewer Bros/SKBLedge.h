//
//  SKBLedge.h
//  Sewer Bros
//
//  Created by admin on 10/28/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "SKBAppDelegate.h"

#define kLedgeBrickFileName         @"LedgeBrick.png"

#define kLedgeBrickSpacing          9
#define kLedgeSideBufferSpacing     4


@interface SKBLedge : NSObject

- (void)createNewSetOfLedgeNodes:(SKScene *)whichScene startingPoint:(CGPoint)leftSide withHowManyBlocks:(int)blockCount startingIndex:(int)indexStart;

@end
