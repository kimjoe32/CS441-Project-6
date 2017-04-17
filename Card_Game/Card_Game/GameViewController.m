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
@synthesize deck;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.betAmountInputField setDelegate:self];
    
    // Load the SKScene from 'GameScene.sks'
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    deck = [[Deck alloc] init];

    //create players and give them cards
    player1 = [[Player alloc] init];
    player2 = [[Player alloc] init];
    [self populateHands];
    for(Card* c in player1.hand.cardObjsInHand)
    {
        NSLog(@"%@", c.cardString);
    }
    NSLog(@"*************");
    for(Card* c in player2.hand.cardObjsInHand)
    {
        NSLog(@"%@", c.cardString);
    }
    
    //player 1 goes first, but switchPlayer will set it to player and show player1's cards
    playerTurn = 2;
    [self switchPlayer];
    
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
        [_moneyLabel setText:[NSString stringWithFormat:@"%ld", (long)[player1 money]]];
    }
    else
    {
        [player2 setStoryboardCardsToThisPlayerCards:storyboardCards];
        [_moneyLabel setText:[NSString stringWithFormat:@"%ld", (long)[player2 money]]];
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
    [_moneyLabel setText:[NSString stringWithFormat:@"%ld", (long)[player1 money]]];
    _lastBet = 0;
    
    //MATT: add new cards to their hands
    
    [deck clearDeck];
    [deck remakeDeck];
    [deck shuffleDeck];
    
    //Needs testing
    [self populateHands];
}

- (void) populateHands
{
    NSMutableArray *player1Hand = [[NSMutableArray alloc] init];
    NSMutableArray *player2Hand = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < 10; ++i){
        NSInteger upperBound = [[deck cardArr] count]-1;
        int ind = arc4random_uniform((u_int32_t)upperBound);
        
        if((i % 2) == 0){ //player 1
            [player1Hand addObject:[deck removeCardFromDeck:ind]];
        }
        else{
            [player2Hand addObject:[deck removeCardFromDeck:ind]];
        }
    }
    
    [[player1 hand] addCardObjects:[player1Hand objectAtIndex:0]
                             card2:[player1Hand objectAtIndex:1]
                             card3:[player1Hand objectAtIndex:2]
                             card4:[player1Hand objectAtIndex:3]
                             card5:[player1Hand objectAtIndex:4]];
    
    [[player2 hand] addCardObjects:[player2Hand objectAtIndex:0]
                             card2:[player2Hand objectAtIndex:1]
                             card3:[player2Hand objectAtIndex:2]
                             card4:[player2Hand objectAtIndex:3]
                             card5:[player2Hand objectAtIndex:4]];
}

- (NSInteger) getMoney
{
    //get the value stored at the moneyLabel
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSNumber *number = [nf numberFromString:[_moneyLabel text]];
    NSInteger f = [number integerValue];
    return f;
}

- (NSInteger) getPot
{
    //get the value stored at the potLabel
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSNumber *number = [nf numberFromString:[_potLabel text]];
    NSInteger f = [number integerValue];
    return f;
}

- (void) setMoney: (NSInteger) newValue
{
    [_moneyLabel setText:[NSString stringWithFormat:@"$%ld", (long)newValue]];
}

- (void) setPot: (NSInteger) newValue
{
    [_potLabel setText:[NSString stringWithFormat:@"$%ld", (long)newValue]];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger bet = [[textField text] integerValue];
    NSLog(@"starting");
    //check for invalid input
    if (bet > [self getMoney] ||//bet is greater than available money
        bet <= _lastBet           //bet is <= last bet from other player
        //TODO: make sure there's no other forms of invalid input
        )
    {
        NSLog(@"Bad Input");
        return NO;
    }
    else //valid input given
    {
        NSLog(@"Good Input");
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
