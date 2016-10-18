//
//  SKBLedge.m
//  Sewer Bros
//
//  Created by admin on 10/28/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "SKBLedge.h"

@implementation SKBLedge

- (void)createNewSetOfLedgeNodes:(SKScene *)whichScene startingPoint:(CGPoint)leftSide withHowManyBlocks:(int)blockCount startingIndex:(int)indexStart
{
    // ledge nodes
    SKTexture *ledgeBrickTexture = [SKTexture textureWithImageNamed:kLedgeBrickFileName];
    
    NSMutableArray *nodeArray = [[NSMutableArray alloc] initWithCapacity:blockCount-1];
    CGPoint where = leftSide;
    
    // nodes, equally spaced
    for (int index=0; index < blockCount; index++) {
        SKSpriteNode *theNode = [SKSpriteNode spriteNodeWithTexture:ledgeBrickTexture];
        theNode.name = [NSString stringWithFormat:@"ledgeBrick%d", indexStart+index];
        //NSLog(@"%@ created", theNode.name);
        theNode.position = where;
        theNode.anchorPoint = CGPointMake(0.5,0.5);
        where.x += kLedgeBrickSpacing;
        
        // physicsBody
        theNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:theNode.size];
        theNode.physicsBody.categoryBitMask = kLedgeCategory;
        theNode.physicsBody.affectedByGravity = NO;
        theNode.physicsBody.linearDamping = 1.0;
        theNode.physicsBody.angularDamping = 1.0;
        
        // designate left & right edge pieces
        if (index == 0) {
            // first node stays solidly in place; anchor point
            theNode.physicsBody.dynamic = NO;
        } else if (index == (blockCount-1)) {
            // last node stays solidly in place; anchor point
            theNode.physicsBody.dynamic = NO;
        } else {
            // all the other nodes inbetween the edge pieces
            theNode.physicsBody.dynamic = YES;
        }

        [nodeArray insertObject:theNode atIndex:index];
        [whichScene addChild:theNode];
    }
    
    // joints between nodes
    for (int index=0; index <= (blockCount-2); index++) {
        SKSpriteNode *nodeA = [nodeArray objectAtIndex:index];
        SKSpriteNode *nodeB = [nodeArray objectAtIndex:index+1];
        SKPhysicsJointPin *theJoint = [SKPhysicsJointPin jointWithBodyA:nodeA.physicsBody bodyB:nodeB.physicsBody anchor:CGPointMake(nodeB.position.x, nodeB.position.y)];
        theJoint.frictionTorque = 1.0;
        theJoint.shouldEnableLimits = YES;
        theJoint.lowerAngleLimit = 0.0000;
        theJoint.upperAngleLimit = 0.0000;
        [whichScene.physicsWorld addJoint:theJoint];
    }
}

@end
