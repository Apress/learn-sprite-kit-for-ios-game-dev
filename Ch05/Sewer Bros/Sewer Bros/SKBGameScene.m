//
//  SKBGameScene.m
//  Sewer Bros
//
//  Created by admin on 8/27/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "SKBGameScene.h"

@implementation SKBGameScene



#pragma mark Initialization



-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor blackColor];
        
        CGRect edgeRect = CGRectMake(0.0, 0.0, 568.0, 420.0);
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:edgeRect];
        self.physicsBody.categoryBitMask = kWallCategory;
        self.physicsWorld.contactDelegate = self;
        
        // initialize and create our sprite textures
        _spriteTextures = [[SKBSpriteTextures alloc] init];
        [_spriteTextures createAnimationTextures];
        
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
        
        [self createSceneContents];
    }
    return self;
}



#pragma mark Scene creation



- (void)createSceneContents
{
    // Initialize Enemies & Schedule
    _spawnedEnemyCount = 0;
    _enemyIsSpawningFlag = NO;
    
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



#pragma mark Contact / Collision / Touches



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
    
    // Ratz / sideWalls
    if ((((firstBody.categoryBitMask & kWallCategory) != 0) && ((secondBody.categoryBitMask & kRatzCategory) != 0))) {
        SKBRatz *theRatz = (SKBRatz *)secondBody.node;
        if (theRatz.position.x < 100) {
            [theRatz wrapRatz:CGPointMake(self.frame.size.width-11, theRatz.position.y)];
        } else {
            [theRatz wrapRatz:CGPointMake(11, theRatz.position.y)];
        }
    }
    
    // Ratz / Ratz
    if ((((firstBody.categoryBitMask & kRatzCategory) != 0) && ((secondBody.categoryBitMask & kRatzCategory) != 0))) {
        SKBRatz *theFirstRatz = (SKBRatz *)firstBody.node;
        SKBRatz *theSecondRatz = (SKBRatz *)secondBody.node;
        
        NSLog(@"%@ & %@ have collided...", theFirstRatz.name, theSecondRatz.name);
        
        // cause first Ratz to turn and change directions
        if (theFirstRatz.ratzStatus == SBRatzRunningLeft) {
            [theFirstRatz turnRight];
        } else if (theFirstRatz.ratzStatus == SBRatzRunningRight) {
            [theFirstRatz turnLeft];
        }
        // cause second Ratz to turn and change directions
        if (theSecondRatz.ratzStatus == SBRatzRunningLeft) {
            [theSecondRatz turnRight];
        } else if (theSecondRatz.ratzStatus == SBRatzRunningRight) {
            [theSecondRatz turnLeft];
        }
    }
    
    // Coin / sideWalls
    if ((((firstBody.categoryBitMask & kWallCategory) != 0) && ((secondBody.categoryBitMask & kCoinCategory) != 0))) {
        SKBCoin *theCoin = (SKBCoin *)secondBody.node;
        if (theCoin.position.x < 100) {
            [theCoin wrapCoin:CGPointMake(self.frame.size.width-6, theCoin.position.y)];
        } else {
            [theCoin wrapCoin:CGPointMake(6, theCoin.position.y)];
        }
    }
    
    // Coin / Coin
    if ((((firstBody.categoryBitMask & kCoinCategory) != 0) && ((secondBody.categoryBitMask & kCoinCategory) != 0))) {
        SKBCoin *theFirstCoin = (SKBCoin *)firstBody.node;
        SKBCoin *theSecondCoin = (SKBCoin *)secondBody.node;
        
        NSLog(@"%@ & %@ have collided...", theFirstCoin.name, theSecondCoin.name);
        
        // cause first Coin to turn and change directions
        if (theFirstCoin.coinStatus == SBCoinRunningLeft) {
            [theFirstCoin turnRight];
        } else if (theFirstCoin.coinStatus == SBCoinRunningRight) {
            [theFirstCoin turnLeft];
        }
        // cause second Coin to turn and change directions
        if (theSecondCoin.coinStatus == SBCoinRunningLeft) {
            [theSecondCoin turnRight];
        } else if (theSecondCoin.coinStatus == SBCoinRunningRight) {
            [theSecondCoin turnLeft];
        }
    }
    
    // Coin / Ratz
    if ((((firstBody.categoryBitMask & kCoinCategory) != 0) && ((secondBody.categoryBitMask & kRatzCategory) != 0))) {
        SKBCoin *theCoin = (SKBCoin *)firstBody.node;
        SKBRatz *theRatz = (SKBRatz *)secondBody.node;
        
        NSLog(@"%@ & %@ have collided...", theCoin.name, theRatz.name);
        
        // cause Coin to turn and change directions
        if (theCoin.coinStatus == SBCoinRunningLeft) {
            [theCoin turnRight];
        } else if (theCoin.coinStatus == SBCoinRunningRight) {
            [theCoin turnLeft];
        }
        // cause Ratz to turn and change directions
        if (theRatz.ratzStatus == SBRatzRunningLeft) {
            [theRatz turnRight];
        } else if (theRatz.ratzStatus == SBRatzRunningRight) {
            [theRatz turnLeft];
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
            [_playerSprite spawnedInScene:self];
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



#pragma mark Animation update



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    if (!_enemyIsSpawningFlag && _spawnedEnemyCount < 25) {
        _enemyIsSpawningFlag = YES;
        int castIndex = _spawnedEnemyCount;

        int scheduledDelay = 2;
        int leftSideX = CGRectGetMinX(self.frame)+kEnemySpawnEdgeBufferX;
        int rightSideX = CGRectGetMaxX(self.frame)-kEnemySpawnEdgeBufferX;
        int topSideY = CGRectGetMaxY(self.frame)-kEnemySpawnEdgeBufferY;
        
        int startX = 0;
        // alternate sides for every other spawn
        if (castIndex % 2 == 0)
            startX = leftSideX;
        else
            startX = rightSideX;
        int startY = topSideY;
        
        // begin delay & when completed spawn new enemy
        SKAction *spacing = [SKAction waitForDuration:scheduledDelay];
        [self runAction:spacing completion:^{
            // Create & spawn the new Enemy
            _enemyIsSpawningFlag = NO;
            _spawnedEnemyCount = _spawnedEnemyCount + 1;
            
            if (castIndex % 5 == 0) {
                SKBCoin *newCoin = [SKBCoin initNewCoin:self startingPoint:CGPointMake(startX, startY) coinIndex:castIndex];
                [newCoin spawnedInScene:self];
            } else {
                SKBRatz *newEnemy = [SKBRatz initNewRatz:self startingPoint:CGPointMake(startX, startY) ratzIndex:castIndex];
                [newEnemy spawnedInScene:self];
            }
        }];
    }
}

@end
