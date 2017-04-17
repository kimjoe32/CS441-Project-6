//
//  GameViewController.m
//  Card_Game
//
//  Created by Matt Perl on 4/5/17.
//  Copyright © 2017 Matt Perl & Joe Kim. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the SKScene from 'GameScene.sks'
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    
    Deck *deck = [[Deck alloc] init];
    
    /*
    NSLog(@"count: %lu\n", (unsigned long)[[deck cardArr] count]);
    
    [deck shuffleDeck];
    
    for(int i = 0; i < [[deck cardArr] count]; ++i){
        Card *c = [[deck cardArr] objectAtIndex:i];
        NSString *cardName = [c cardString];
        
        NSLog(@"%@\n", cardName);
    }
    */
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    Hand * h1 = [[Hand alloc] init];
    [h1 addCards:@"8C" card2:@"TS" card3:@"KC" card4:@"9H" card5:@"4S"];
    Hand * h2 = [[Hand alloc] init];
    [h2 addCards:@"7D" card2:@"2S" card3:@"5D" card4:@"3S" card5:@"AC"];
    
    NSInteger winner = [h1 checkWinnerAgainst:h2];
    NSLog(@"%ld", (long)winner);
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
