//
//  SKBViewController.m
//  Sewer Bros
//
//  Created by admin on 8/26/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "SKBViewController.h"
#import "SKBSplashScene.h"

@implementation SKBViewController

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
    if (!skView.scene) {
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        // Create and configure the scene.
        SKScene * scene = [SKBSplashScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene]; }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
