//
//  SKBGameScene.m
//  Sewer Bros
//
//  Created by admin on 8/27/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "SKBGameScene.h"

@implementation SKBGameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor blackColor];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        if (!_playerSprite) {
            _playerSprite = [SKBPlayer initNewPlayer:self startingPoint:location];
        } else if (location.x <= ( self.frame.size.width / 2 )) {
            // user touched left side of screen
            if (_playerSprite.playerStatus == SBPlayerRunningRight) {
                [_playerSprite skidRight];
            } else if (_playerSprite.playerStatus != SBPlayerRunningLeft) {
                [_playerSprite runLeft];
            }
        } else {
            // user touched right side of screen
            if (_playerSprite.playerStatus == SBPlayerRunningLeft) {
                [_playerSprite skidLeft];
            } else if (_playerSprite.playerStatus != SBPlayerRunningRight) {
                [_playerSprite runRight];
            }
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
