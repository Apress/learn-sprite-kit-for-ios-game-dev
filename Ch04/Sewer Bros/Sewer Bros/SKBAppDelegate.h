//
//  SKBAppDelegate.h
//  Sewer Bros
//
//  Created by admin on 8/26/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

// Global project constants
static const uint32_t kPlayerCategory =            0x1 << 0;
static const uint32_t kBaseCategory =              0x1 << 1;
static const uint32_t kWallCategory =              0x1 << 2;
static const uint32_t kLedgeCategory =             0x1 << 3;



@interface SKBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
