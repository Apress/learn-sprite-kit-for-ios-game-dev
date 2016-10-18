//
//  SKBSpriteTextures.m
//  Sewer Bros
//
//  Created by admin on 10/15/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "SKBSpriteTextures.h"

@implementation SKBSpriteTextures

- (void)createAnimationTextures
{
    // animation arrays
    
    
    // Player
    
    //   right, running
    SKTexture *f1 = [SKTexture textureWithImageNamed:kPlayerRunRight1FileName];
    SKTexture *f2 = [SKTexture textureWithImageNamed:kPlayerRunRight2FileName];
    SKTexture *f3 = [SKTexture textureWithImageNamed:kPlayerRunRight3FileName];
    SKTexture *f4 = [SKTexture textureWithImageNamed:kPlayerRunRight4FileName];
    _playerRunRightTextures = @[f1,f2,f3,f4];
    
    //   right, skidding
    f1 = [SKTexture textureWithImageNamed:kPlayerSkidRightFileName];
    _playerSkiddingRightTextures = @[f1];
    _playerRunRightTextures = @[f1,f2,f3,f4];
    
    //   right, jumping
    f1 = [SKTexture textureWithImageNamed:kPlayerJumpRightFileName];
    _playerJumpRightTextures = @[f1];
    
    //   right, still
    f1 = [SKTexture textureWithImageNamed:kPlayerStillRightFileName];
    _playerStillFacingRightTextures = @[f1];
    
    //   left, running
    f1 = [SKTexture textureWithImageNamed:kPlayerRunLeft1FileName];
    f2 = [SKTexture textureWithImageNamed:kPlayerRunLeft2FileName];
    f3 = [SKTexture textureWithImageNamed:kPlayerRunLeft3FileName];
    f4 = [SKTexture textureWithImageNamed:kPlayerRunLeft4FileName];
    _playerRunLeftTextures = @[f1,f2,f3,f4];
    
    //   left, skidding
    f1 = [SKTexture textureWithImageNamed:kPlayerSkidLeftFileName];
    _playerSkiddingLeftTextures = @[f1];
    
    //   left, jumping
    f1 = [SKTexture textureWithImageNamed:kPlayerJumpLeftFileName];
    _playerJumpLeftTextures = @[f1];
    
    //   left, still
    f1 = [SKTexture textureWithImageNamed:kPlayerStillLeftFileName];
    _playerStillFacingLeftTextures = @[f1];
    
    
    // Ratz
    
    //  right, running
    f1 = [SKTexture textureWithImageNamed:kRatzRunRight1FileName];
    f2 = [SKTexture textureWithImageNamed:kRatzRunRight2FileName];
    f3 = [SKTexture textureWithImageNamed:kRatzRunRight3FileName];
    f4 = [SKTexture textureWithImageNamed:kRatzRunRight4FileName];
    SKTexture *f5 = [SKTexture textureWithImageNamed:kRatzRunRight5FileName];
    _ratzRunRightTextures = @[f1,f2,f3,f4,f5];
    
    //  left, running
    f1 = [SKTexture textureWithImageNamed:kRatzRunLeft1FileName];
    f2 = [SKTexture textureWithImageNamed:kRatzRunLeft2FileName];
    f3 = [SKTexture textureWithImageNamed:kRatzRunLeft3FileName];
    f4 = [SKTexture textureWithImageNamed:kRatzRunLeft4FileName];
    f5 = [SKTexture textureWithImageNamed:kRatzRunLeft5FileName];
    _ratzRunLeftTextures = @[f1,f2,f3,f4,f5];
    
    // knocked out, facing left
    f1 = [SKTexture textureWithImageNamed:kRatzKOfacingLeft1FileName];
    f2 = [SKTexture textureWithImageNamed:kRatzKOfacingLeft2FileName];
    f3 = [SKTexture textureWithImageNamed:kRatzKOfacingLeft3FileName];
    f4 = [SKTexture textureWithImageNamed:kRatzKOfacingLeft4FileName];
    f5 = [SKTexture textureWithImageNamed:kRatzKOfacingLeft5FileName];
    _ratzKOfacingLeftTextures = @[f1,f2,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f3,f2,f3,f2,f3,f2,f1];
    
    // knocked out, facing right
    f1 = [SKTexture textureWithImageNamed:kRatzKOfacingRight1FileName];
    f2 = [SKTexture textureWithImageNamed:kRatzKOfacingRight2FileName];
    f3 = [SKTexture textureWithImageNamed:kRatzKOfacingRight3FileName];
    f4 = [SKTexture textureWithImageNamed:kRatzKOfacingRight4FileName];
    f5 = [SKTexture textureWithImageNamed:kRatzKOfacingRight5FileName];
    _ratzKOfacingRightTextures = @[f1,f2,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f5,f3,f2,f3,f2,f3,f2,f1];
    
    //  Coins
    f1 = [SKTexture textureWithImageNamed:kCoin1FileName];
    f2 = [SKTexture textureWithImageNamed:kCoin2FileName];
    f3 = [SKTexture textureWithImageNamed:kCoin3FileName];
    _coinTextures = @[f1,f2,f3,f2];
}

@end
