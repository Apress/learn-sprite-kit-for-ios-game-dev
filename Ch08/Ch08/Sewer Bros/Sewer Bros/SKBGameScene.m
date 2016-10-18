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
        
        // add backdrop image to screen
        [self addChild:backdrop];
        
        // add surfaces to screen
        [self createSceneContents];
        
        // compose cast of characters from propertyList
        [self loadCastOfCharacters];
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
    
    // Grates
    SKSpriteNode *grate = [SKSpriteNode spriteNodeWithImageNamed:@"Grate.png"];
    grate.name = @"grate1";
    grate.position = CGPointMake(30, CGRectGetMaxY(self.frame)-25);
    [self addChild:grate];
    
    grate = [SKSpriteNode spriteNodeWithImageNamed:@"Grate.png"];
    grate.name = @"grate2";
    grate.position = CGPointMake(CGRectGetMaxX(self.frame)-30, CGRectGetMaxY(self.frame)-25);
    [self addChild:grate];
    
    // Pipes
    SKSpriteNode *pipe = [SKSpriteNode spriteNodeWithImageNamed:@"PipeLwrLeft.png"];
    pipe.name = @"pipeLeft";
    pipe.position = CGPointMake(9, 25);
    pipe.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pipe.size];
    pipe.physicsBody.categoryBitMask = kPipeCategory;
    pipe.physicsBody.dynamic = NO;
    [self addChild:pipe];
    
    pipe = [SKSpriteNode spriteNodeWithImageNamed:@"PipeLwrRight.png"];
    pipe.name = @"pipeRight";
    pipe.position = CGPointMake(CGRectGetMaxX(self.frame)-9, 25);
    pipe.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pipe.size];
    pipe.physicsBody.categoryBitMask = kPipeCategory;
    pipe.physicsBody.dynamic = NO;
    [self addChild:pipe];
    
    // Scoring
    SKBScores *sceneScores = [[SKBScores alloc] init];
    [sceneScores createScoreNode:self];
    _scoreDisplay = sceneScores;
    _playerScore = 0;
    [_scoreDisplay updateScore:self newScore:_playerScore];
    
    // Player
    _playerSprite = [SKBPlayer initNewPlayer:self startingPoint:CGPointMake(40, 25)];
    [_playerSprite spawnedInScene:self];
}



#pragma mark



- (void)loadCastOfCharacters
{
    // load cast from plist file, just Level One
    NSString *path = [[NSBundle mainBundle] pathForResource:kCastOfCharactersFileName ofType:@"plist"];
    NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    if (plistDictionary) {
        NSDictionary *levelDictionary = [plistDictionary valueForKey:@"Level"];
        if (levelDictionary) {
            NSArray *levelOneArray = [levelDictionary valueForKey:@"One"];
            if (levelOneArray) {
                NSDictionary *enemyDictionary = nil;
                NSMutableArray *newTypeArray = [NSMutableArray arrayWithCapacity:[levelOneArray count]];
                NSMutableArray *newDelayArray = [NSMutableArray arrayWithCapacity:[levelOneArray count]];
                NSMutableArray *newStartArray = [NSMutableArray arrayWithCapacity:[levelOneArray count]];
                NSNumber *rawType, *rawDelay, *rawStartXindex;
                int enemyType, spawnDelay, startXindex = 0;
                
                for (int index=0; index<[levelOneArray count]; index++) {
                    enemyDictionary = [levelOneArray objectAtIndex:index];
                    
                    // NSNumbers from dictionary
                    rawType = [enemyDictionary valueForKey:@"Type"];
                    rawDelay = [enemyDictionary valueForKey:@"Delay"];
                    rawStartXindex = [enemyDictionary valueForKey:@"StartXindex"];
                    
                    // local integer values
                    enemyType = [rawType intValue];
                    spawnDelay = [rawDelay intValue];
                    startXindex = [rawStartXindex intValue];
                    
                    // long term storage
                    [newTypeArray addObject:rawType];
                    [newDelayArray addObject:rawDelay];
                    [newStartArray addObject:rawStartXindex];
                    
                    //NSLog(@"%d, %d, %d, %d", index, enemyType, spawnDelay, startXindex);
                }
                // store data locally
                _cast_TypeArray = [NSArray arrayWithArray:newTypeArray];
                _cast_DelayArray = [NSArray arrayWithArray:newDelayArray];
                _cast_StartXindexArray = [NSArray arrayWithArray:newStartArray];
            } else {
                NSLog(@"No levelOneArray");
            }
        } else {
            NSLog(@"No levelDictionary");
        }
    } else {
        NSLog(@"No plist loaded from '%@'", kCastOfCharactersFileName);
    }
}



#pragma mark Contact / Collision / Touches



- (void)checkForEnemyHits:(NSString *)struckLedgeName
{
    // Coins
    for (int index=0; index <= _spawnedEnemyCount; index++) {
        [self enumerateChildNodesWithName:[NSString stringWithFormat:@"coin%d", index] usingBlock:^(SKNode *node, BOOL *stop) {
            *stop = YES;
            SKBCoin *theCoin = (SKBCoin *)node;
            
            // struckLedge check
            if ([theCoin.lastKnownContactedLedge isEqualToString:struckLedgeName]) {
                NSLog(@"Player hit %@ where %@ is known to be", struckLedgeName, theCoin.name);
                [theCoin coinCollected:self];
            }
        }];
    }
    
    // Ratz
    for (int index=0; index <= _spawnedEnemyCount; index++) {
        [self enumerateChildNodesWithName:[NSString stringWithFormat:@"ratz%d", index] usingBlock:^(SKNode *node, BOOL *stop) {
            *stop = YES;
            SKBRatz *theRatz = (SKBRatz *)node;
            
            // struckLedge check
            if ([theRatz.lastKnownContactedLedge isEqualToString:struckLedgeName]) {
                NSLog(@"Player hit %@ where %@ is known to be", struckLedgeName, theRatz.name);
                [theRatz ratzKnockedOut:self];
            }
        }];
    }
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
            if (_playerSprite.playerStatus != SBPlayerFalling) {
                if (_playerSprite.position.x < 100) {
                    //NSLog(@"player contacted left edge");
                    [_playerSprite wrapPlayer:CGPointMake(self.frame.size.width-10, _playerSprite.position.y)];
                } else {
                    //NSLog(@"player contacted right edge");
                    [_playerSprite wrapPlayer:CGPointMake(10, _playerSprite.position.y)];
                }
            } else {
                // contacted bottom wall (has been killed and has fallen)
                [_playerSprite playerHitWater:self];
            }
        }
    }
    
    // Player / Ledges
    if ((((firstBody.categoryBitMask & kPlayerCategory) != 0) && ((secondBody.categoryBitMask & kLedgeCategory) != 0))) {
        if (_playerSprite.playerStatus == SBPlayerJumpingLeft || _playerSprite.playerStatus == SBPlayerJumpingRight ||
            _playerSprite.playerStatus == SBPlayerJumpingUpFacingLeft || _playerSprite.playerStatus == SBPlayerJumpingUpFacingRight) {
            {
                SKSpriteNode *theStruckLedge = (SKSpriteNode *)secondBody.node;
                [self checkForEnemyHits:theStruckLedge.name];
            }
        }
    }

    // Player / Coins
    if ((((firstBody.categoryBitMask & kPlayerCategory) != 0) && ((secondBody.categoryBitMask & kCoinCategory) != 0))) {
        SKBCoin *theCoin = (SKBCoin *)secondBody.node;
        [theCoin coinCollected:self];
        
        // Score some bonus points
        _playerScore = _playerScore + kCoinPointValue;
        [_scoreDisplay updateScore:self newScore:_playerScore];
    }
    
    // Player / Ratz
    if ((((firstBody.categoryBitMask & kPlayerCategory) != 0) && ((secondBody.categoryBitMask & kRatzCategory) != 0))) {
        SKBRatz *theRatz = (SKBRatz *)secondBody.node;
        if (_playerSprite.playerStatus != SBPlayerFalling) {
            if (theRatz.ratzStatus == SBRatzKOfacingLeft || theRatz.ratzStatus == SBRatzKOfacingRight) {
                // ratz unconscious so kick 'em off the ledge
                [theRatz ratzCollected:self];
                
                // Score some points
                _playerScore = _playerScore + kRatzPointValue;
                [_scoreDisplay updateScore:self newScore:_playerScore];
            } else if (theRatz.ratzStatus == SBRatzRunningLeft || theRatz.ratzStatus == SBRatzRunningRight) {
                // oops, player dies
                [_playerSprite playerKilled:self];
            }
        }
    }
    
    // Ratz / BaseBricks
    if ((((firstBody.categoryBitMask & kBaseCategory) != 0) && ((secondBody.categoryBitMask & kRatzCategory) != 0))) {
        SKBRatz *theRatz = (SKBRatz *)secondBody.node;
        theRatz.lastKnownContactedLedge = @"";
        //NSLog(@"x- %f, y- %f", theRatz.position.x, theRatz.position.y);
    }
    
    // Ratz / ledges
    if ((((firstBody.categoryBitMask & kLedgeCategory) != 0) && ((secondBody.categoryBitMask & kRatzCategory) != 0))) {
        SKBRatz *theRatz = (SKBRatz *)secondBody.node;
        SKNode *theLedge = firstBody.node;
        //NSLog(@"%@ contacting %@", theRatz.name, theLedge.name);
        theRatz.lastKnownContactedLedge = theLedge.name;
    }
    
    // Ratz / sideWalls
    if ((((firstBody.categoryBitMask & kWallCategory) != 0) && ((secondBody.categoryBitMask & kRatzCategory) != 0))) {
        SKBRatz *theRatz = (SKBRatz *)secondBody.node;
        if (theRatz.ratzStatus != SBRatzKicked) {
            if (theRatz.position.x < 100) {
                [theRatz wrapRatz:CGPointMake(self.frame.size.width-13, theRatz.position.y)];
            } else {
                [theRatz wrapRatz:CGPointMake(13, theRatz.position.y)];
            }
        } else {
            // contacted bottom wall (has been kicked off and has fallen)
            [theRatz ratzHitWater:self];
        }
    }
    
    // Ratz / Pipes
    if ((((firstBody.categoryBitMask & kPipeCategory) != 0) && ((secondBody.categoryBitMask & kRatzCategory) != 0))) {
        SKBRatz *theRatz = (SKBRatz *)secondBody.node;
        if (theRatz.position.x < 100) {
            [theRatz ratzHitLeftPipe:self];
        } else {
            [theRatz ratzHitRightPipe:self];
        }
    }
    
    // Ratz / Ratz
    if ((((firstBody.categoryBitMask & kRatzCategory) != 0) && ((secondBody.categoryBitMask & kRatzCategory) != 0))) {
        SKBRatz *theFirstRatz = (SKBRatz *)firstBody.node;
        SKBRatz *theSecondRatz = (SKBRatz *)secondBody.node;
        
        //NSLog(@"%@ & %@ have collided...", theFirstRatz.name, theSecondRatz.name);
        
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
    
    // Coin / ledges
    if ((((firstBody.categoryBitMask & kLedgeCategory) != 0) && ((secondBody.categoryBitMask & kCoinCategory) != 0))) {
        SKBCoin *theCoin = (SKBCoin *)secondBody.node;
        SKNode *theLedge = firstBody.node;
        //NSLog(@"%@ contacting %@", theCoin.name, theLedge.name);
        theCoin.lastKnownContactedLedge = theLedge.name;
    }
    
    // Coin / sideWalls
    if ((((firstBody.categoryBitMask & kWallCategory) != 0) && ((secondBody.categoryBitMask & kCoinCategory) != 0))) {
        SKBCoin *theCoin = (SKBCoin *)secondBody.node;
        if (theCoin.position.x < 100) {
            [theCoin wrapCoin:CGPointMake(self.frame.size.width-8, theCoin.position.y)];
        } else {
            [theCoin wrapCoin:CGPointMake(8, theCoin.position.y)];
        }
    }
    
    // Coin / Pipes
    if ((((firstBody.categoryBitMask & kPipeCategory) != 0) && ((secondBody.categoryBitMask & kCoinCategory) != 0))) {
        SKBCoin *theCoin = (SKBCoin *)secondBody.node;
        [theCoin coinHitPipe];
    }
    
    // Coin / Coin
    if ((((firstBody.categoryBitMask & kCoinCategory) != 0) && ((secondBody.categoryBitMask & kCoinCategory) != 0))) {
        SKBCoin *theFirstCoin = (SKBCoin *)firstBody.node;
        SKBCoin *theSecondCoin = (SKBCoin *)secondBody.node;
        
        //NSLog(@"%@ & %@ have collided...", theFirstCoin.name, theSecondCoin.name);
        
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
        
        //NSLog(@"%@ & %@ have collided...", theCoin.name, theRatz.name);
        
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
        
        if (location.y >= (self.frame.size.height / 2 )) {
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
    
    if (!_enemyIsSpawningFlag && _spawnedEnemyCount < [_cast_TypeArray count]) {
        _enemyIsSpawningFlag = YES;
        int castIndex = _spawnedEnemyCount;

        int leftSideX = CGRectGetMinX(self.frame)+kEnemySpawnEdgeBufferX;
        int rightSideX = CGRectGetMaxX(self.frame)-kEnemySpawnEdgeBufferX;
        int topSideY = CGRectGetMaxY(self.frame)-kEnemySpawnEdgeBufferY;
        
        // from castOfCharacters file, the sprite Type
        NSNumber *theNumber = [_cast_TypeArray objectAtIndex:castIndex];
        int castType = [theNumber intValue];
        
        // from castOfCharacters file, the sprite Delay
        theNumber = [_cast_DelayArray objectAtIndex:castIndex];
        int castDelay = [theNumber intValue];
        
        // from castOfCharacters file, the sprite startXindex
        int startX = 0;
        // determine which side
        theNumber = [_cast_StartXindexArray objectAtIndex:castIndex];
        if ([theNumber intValue] == 0)
            startX = leftSideX;
        else
            startX = rightSideX;
        int startY = topSideY;
        
        // begin delay & when completed spawn new enemy
        SKAction *spacing = [SKAction waitForDuration:castDelay];
        [self runAction:spacing completion:^{
            // Create & spawn the new Enemy
            _enemyIsSpawningFlag = NO;
            _spawnedEnemyCount = _spawnedEnemyCount + 1;
            
            if (castType == SKBEnemyTypeCoin) {
                SKBCoin *newCoin = [SKBCoin initNewCoin:self startingPoint:CGPointMake(startX, startY) coinIndex:castIndex];
                [newCoin spawnedInScene:self];
            } else if (castType == SKBEnemyTypeRatz) {
                SKBRatz *newEnemy = [SKBRatz initNewRatz:self startingPoint:CGPointMake(startX, startY) ratzIndex:castIndex];
                [newEnemy spawnedInScene:self];
            }
        }];
    }
    
    // check for stuck enemies every 20 frames
    _frameCounter = _frameCounter + 1;
    if (_frameCounter >= 20) {
        _frameCounter = 0;
        
        for (int index=1; index <= _spawnedEnemyCount; index++) {
            // Coins
            [self enumerateChildNodesWithName:[NSString stringWithFormat:@"coin%d", index] usingBlock:^(SKNode *node, BOOL *stop) {
                *stop = YES;
                SKBCoin *theCoin = (SKBCoin *)node;
                int currentX = theCoin.position.x;
                int currentY = theCoin.position.y;
                if (currentX == theCoin.lastKnownXposition && currentY == theCoin.lastKnownYposition) {
                    //NSLog(@"%@ appears to be stuck...", theCoin.name);
                    if (theCoin.coinStatus == SBCoinRunningRight) {
                        [theCoin removeAllActions];
                        [theCoin runLeft];
                    } else if (theCoin.coinStatus == SBCoinRunningLeft) {
                        [theCoin removeAllActions];
                        [theCoin runRight];
                    }
                }
                theCoin.lastKnownXposition = currentX;
                theCoin.lastKnownYposition = currentY;
            }];
            
            // Ratz
            [self enumerateChildNodesWithName:[NSString stringWithFormat:@"ratz%d", index] usingBlock:^(SKNode *node, BOOL *stop) {
                *stop = YES;
                SKBRatz *theRatz = (SKBRatz *)node;
                int currentX = theRatz.position.x;
                int currentY = theRatz.position.y;
                if (currentX == theRatz.lastKnownXposition && currentY == theRatz.lastKnownYposition) {
                    //NSLog(@"%@ appears to be stuck...", theRatz.name);
                    if (theRatz.ratzStatus == SBRatzRunningRight) {
                        [theRatz turnLeft];
                    } else if (theRatz.ratzStatus == SBRatzRunningLeft) {
                        [theRatz turnRight];
                    }
                }
                theRatz.lastKnownXposition = currentX;
                theRatz.lastKnownYposition = currentY;
            }];
        }
    }
}

@end
