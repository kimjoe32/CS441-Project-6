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
@synthesize playerTurn;
- (void)viewDidLoad {
    [super viewDidLoad];
    playerTurn = 1;
    // Load the SKScene from 'GameScene.sks'
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    //Deck *deck = [[Deck alloc] init];
    
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
    
}


-(IBAction)betAction:(id)sender
{
    
    playerTurn = (playerTurn == 1)? 2 : 1;
}

-(IBAction)checkAction:(id)sender
{
    
    playerTurn = (playerTurn == 1)? 2 : 1;
}

-(void) switchPlayer
{
    playerTurn = (playerTurn == 1)? 2 : 1;
    //TODO: change cards
    //TODO: change pot and change
}

- (float) getMoney
{
    //get the value stored at the moneyLabel
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSNumber *number = [nf numberFromString:[_moneyLabel text]];
    float f = [number floatValue];
    return f;
}

- (float) getPot
{
    //get the value stored at the potLabel
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSNumber *number = [nf numberFromString:[_potLabel text]];
    float f = [number floatValue];
    return f;
}

- (void) setMoney: (float) newValue
{
    [_moneyLabel setText:[NSString stringWithFormat:@"$%.02f", newValue]];
}

- (void) setPot: (float) newValue
{
    [_potLabel setText:[NSString stringWithFormat:@"$%.02f", newValue]];
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
