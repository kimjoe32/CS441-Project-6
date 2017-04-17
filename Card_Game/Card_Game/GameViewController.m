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
@synthesize player1;
@synthesize player2;
@synthesize storyboardCards;
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


- (IBAction)betAction:(id)sender
{
    //can't press these buttons while inputting bet amount
    [_betButton setEnabled:FALSE];
    [_checkButton setEnabled:FALSE];
    [_betAmountInputField setHidden:FALSE];
    [_betAmountInputField setEnabled:TRUE];
    
    [self switchPlayer];
}

- (IBAction)checkAction:(id)sender
{
    //MATT: need logic if both players check at the beginning
    if (playerTurn == 1)
    {
        [player1 subtractMoney:_lastBet];
    }
    else
    {
        [player2 subtractMoney:_lastBet];
    }
    
    [self setPot:[self getPot] + _lastBet];
    
    if (_lastBet > 0) //if checked after other player bets, decide winner
    {
        [self decideWinner];
    }
    [self switchPlayer];
}

-(void) switchPlayer
{
    //change the money and cards displayed to next player
    playerTurn = (playerTurn == 1)? 2 : 1;
    if (playerTurn == 1)
    {
        [player1 setStoryboardCardsToThisPlayerCards:storyboardCards];
        [_moneyLabel setText:[NSString stringWithFormat:@"%.02f", [player1 money]]];
    }
    else
    {
        [player2 setStoryboardCardsToThisPlayerCards:storyboardCards];
        [_moneyLabel setText:[NSString stringWithFormat:@"%.02f", [player2 money]]];
    }
}

-(void) decideWinner
{
    NSInteger result = [player1 compareHandAgainst:player2]; // -1 = tie, 0 = player1 wins, 1 = player2 wins
    if (result == 0)
    {
        [player1 addMoney:[self getPot]];
    }
    else if (result == 1)
    {
        [player2 addMoney:[self getPot]];
    }
    
    [self setPot:0];
    [player1 clearHand];
    [player2 clearHand];
    
    //player1 starts
    playerTurn = 1;
    [player1 setStoryboardCardsToThisPlayerCards:storyboardCards];
    [_moneyLabel setText:[NSString stringWithFormat:@"%.02f", [player1 money]]];
    _lastBet = 0;
    //MATT: add new cards to their hands
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    float bet = [[textField text] floatValue]; // TODO:check to see if this will work with "2" and "2.0"
    
    //check for invalid input
    if (bet > [self getMoney] ||//bet is greater than available money
        bet <= _lastBet           //bet is <= last bet from other player
        //TODO: make sure there's no other forms of invalid input
        )
    {
        return NO;
    }
    else //valid input given
    {
        [self setPot:bet + [self getPot]];//increase pot size
        
        //subtract bet from players money
        if (playerTurn == 1)
        {
            [player1 subtractMoney:bet];
        }
        else
        {
            [player2 subtractMoney:bet];
        }
        textField.text = @"";//clear text
        [textField setEnabled:FALSE];//hide textfield
        [textField setHidden:TRUE];
        
        //enable bet and check buttons
        [_betButton setEnabled:TRUE];
        [_checkButton setEnabled:TRUE];
        
        _lastBet = bet;
        return YES;
    }
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
