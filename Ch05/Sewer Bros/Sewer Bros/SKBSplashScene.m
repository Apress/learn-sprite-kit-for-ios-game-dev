//
//  SKBSplashScene.m
//  Sewer Bros
//
//  Created by admin on 8/26/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "SKBSplashScene.h"
#import "SKBGameScene.h"

@implementation SKBSplashScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor blackColor];
        
        NSString *fileName = @"";
        if (self.frame.size.width == 480) {
            fileName = @"SewerSplash_480";      // iPhone Retina (3.5-inch)
        } else {
            fileName = @"SewerSplash_568";      // iPhone Retina (4-inch)
        }
        SKSpriteNode *splash = [SKSpriteNode spriteNodeWithImageNamed:fileName];
        splash.name = @"splashNode";
        splash.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [self addChild:splash];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        SKNode *splashNode = [self childNodeWithName:@"splashNode"];
        if (splashNode != nil) {
            splashNode.name = nil;
            SKAction *zoom = [SKAction scaleTo: 4.0 duration: 1];
            SKAction *fadeAway = [SKAction fadeOutWithDuration: 1];
            SKAction *grouped = [SKAction group:@[zoom, fadeAway]];
            [splashNode runAction: grouped completion:^{
                SKBGameScene *nextScene  = [[SKBGameScene alloc] initWithSize:self.size];
                SKTransition *doors = [SKTransition doorwayWithDuration:0.5];
                [self.view presentScene:nextScene transition:doors];
            }];
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
