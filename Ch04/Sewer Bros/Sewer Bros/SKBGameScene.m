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
        
        CGRect edgeRect = CGRectMake(0.0, 0.0, 568.0, 420.0);
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:edgeRect];
        self.physicsBody.categoryBitMask = kWallCategory;
        self.physicsWorld.contactDelegate = self;
        
        NSString *fileName = @"";
        if (self.frame.size.width == 480) {
            fileName = @"Backdrop_480";      // iPhone Retina (3.5-inch)
        } else {
            fileName = @"Backdrop_568";      // iPhone Retina (4-inch)
        }
        SKSpriteNode *backdrop = [SKSpriteNode spriteNodeWithImageNamed:fileName];
        backdrop.name = @"backdropNode";
        backdrop.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [self addChild:backdrop];
        
        // brick base
        SKSpriteNode *brickBase = [SKSpriteNode spriteNodeWithImageNamed:@"Base_600"];
        brickBase.name = @"brickBaseNode";
        brickBase.position = CGPointMake(CGRectGetMidX(self.frame), brickBase.size.height/2);
        brickBase.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:brickBase.size];
        brickBase.physicsBody.categoryBitMask = kBaseCategory;
        brickBase.physicsBody.dynamic = NO;
        
        [self addChild:brickBase];
        
        // Ledges
        SKBLedge *sceneLedge = [[SKBLedge alloc] init];
        int ledgeIndex = 0;
        
        // ledge, bottom left
        int howMany = 0;
        if (CGRectGetMaxX(self.frame) < 500)
            howMany = 18;
        else
            howMany = 23;
        [sceneLedge createNewSetOfLedgeNodes:self startingPoint:CGPointMake(kLedgeSideBufferSpacing, brickBase.position.y+80) withHowManyBlocks:howMany startingIndex:ledgeIndex];
        ledgeIndex = ledgeIndex + howMany;
        
        // ledge, bottom right
        if (CGRectGetMaxX(self.frame) < 500)
            howMany = 18;
        else
            howMany = 23;
        [sceneLedge createNewSetOfLedgeNodes:self startingPoint:CGPointMake(CGRectGetMaxX(self.frame)-kLedgeSideBufferSpacing-((howMany-1)*kLedgeBrickSpacing), brickBase.position.y+80) withHowManyBlocks:howMany startingIndex:ledgeIndex];
        ledgeIndex = ledgeIndex + howMany;
        
        // ledge, middle left
        if (CGRectGetMaxX(self.frame) < 500)
            howMany = 6;
        else
            howMany = 8;
        [sceneLedge createNewSetOfLedgeNodes:self startingPoint:CGPointMake(CGRectGetMinX(self.frame)+kLedgeSideBufferSpacing, brickBase.position.y+142) withHowManyBlocks:howMany startingIndex:ledgeIndex];
        ledgeIndex = ledgeIndex + howMany;
        
        // ledge, middle middle
        if (CGRectGetMaxX(self.frame) < 500)
            howMany = 31;
        else
            howMany = 36;
        [sceneLedge createNewSetOfLedgeNodes:self startingPoint:CGPointMake(CGRectGetMidX(self.frame)-((howMany * kLedgeBrickSpacing) / 2), brickBase.position.y+152) withHowManyBlocks:howMany startingIndex:ledgeIndex];
        ledgeIndex = ledgeIndex + howMany;
        
        // ledge, middle right
        if (CGRectGetMaxX(self.frame) < 500)
            howMany = 6;
        else
            howMany = 9;
        [sceneLedge createNewSetOfLedgeNodes:self startingPoint:CGPointMake(CGRectGetMaxX(self.frame)-kLedgeSideBufferSpacing-((howMany-1)*kLedgeBrickSpacing), brickBase.position.y+142) withHowManyBlocks:howMany startingIndex:ledgeIndex];
        ledgeIndex = ledgeIndex + howMany;
        
        // ledge, top left
        if (CGRectGetMaxX(self.frame) < 500)
            howMany = 23;
        else
            howMany = 28;
        [sceneLedge createNewSetOfLedgeNodes:self startingPoint:CGPointMake(CGRectGetMinX(self.frame)+kLedgeSideBufferSpacing, brickBase.position.y+224) withHowManyBlocks:howMany startingIndex:ledgeIndex];
        ledgeIndex = ledgeIndex + howMany;
        
        // ledge, top right
        if (CGRectGetMaxX(self.frame) < 500)
            howMany = 23;
        else
            howMany = 28;
        [sceneLedge createNewSetOfLedgeNodes:self startingPoint:CGPointMake(CGRectGetMaxX(self.frame)-kLedgeSideBufferSpacing-((howMany-1)*kLedgeBrickSpacing), brickBase.position.y+224) withHowManyBlocks:howMany startingIndex:ledgeIndex];
        ledgeIndex = ledgeIndex + howMany;

    }
    return self;
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    // contact body name
    NSString *firstBodyName = firstBody.node.name;
    
    // Player / Base
    if ((((firstBody.categoryBitMask & kPlayerCategory) != 0) && ((secondBody.categoryBitMask & kBaseCategory) != 0)))
    {
        // Not interested in this contact event
    }
    
    // Player / sideWalls
    if ((((firstBody.categoryBitMask & kPlayerCategory) != 0) && ((secondBody.categoryBitMask & kWallCategory) != 0))) {
        if ([firstBodyName isEqualToString: @"player1"]) {
            if (_playerSprite.position.x < 100) {
                NSLog(@"player contacted left edge");
                [_playerSprite wrapPlayer:CGPointMake(self.frame.size.width-10, _playerSprite.position.y)];
            } else {
                NSLog(@"player contacted right edge");
                [_playerSprite wrapPlayer:CGPointMake(10, _playerSprite.position.y)];
            }
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SBPlayerStatus status = _playerSprite.playerStatus;
        
        if (!_playerSprite) {
            _playerSprite = [SKBPlayer initNewPlayer:self startingPoint:location];
        } else if (location.y >= (self.frame.size.height / 2 )) {
            // user touched upper half of the screen (zero = bottom of screen)
            if (status != SBPlayerJumpingLeft && status != SBPlayerJumpingRight && status != SBPlayerJumpingUpFacingLeft && status != SBPlayerJumpingUpFacingRight) {
                [_playerSprite jump];
            }
        } else if (location.x <= ( self.frame.size.width / 2 )) {
            // user touched left side of screen
            if (status == SBPlayerRunningRight) {
                [_playerSprite skidRight];
            } else if (status == SBPlayerFacingLeft || status == SBPlayerFacingRight) {
                [_playerSprite runLeft];
            }
        } else {
            // user touched right side of screen
            if (status == SBPlayerRunningLeft) {
                [_playerSprite skidLeft];
            } else if (status == SBPlayerFacingLeft || status == SBPlayerFacingRight) {
                [_playerSprite runRight];
            }
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
