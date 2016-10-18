//
//  SKBGameScene.h
//  Sewer Bros
//
//  Created by admin on 8/27/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKBAppDelegate.h"
#import "SKBPlayer.h"
#import "SKBLedge.h"

@interface SKBGameScene : SKScene <SKPhysicsContactDelegate>

@property (strong, nonatomic) SKBPlayer *playerSprite;

@end
