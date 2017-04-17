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
@synthesize checkBool;

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
    
    checkBool = false;

    checkBool = false;
    
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
    
    if(checkBool == true){
        checkBool = false;
    }
    [_confirmBet setEnabled:FALSE]; //*****
    [_confirmBet setHidden:TRUE]; //*****
}

- (IBAction)checkAction:(id)sender
{
    //MATT: need logic if both players check at the beginning
    
    if(checkBool == false && playerTurn == 1){ //player 1 checks first
        checkBool = true;
    }
    else if(checkBool == true && playerTurn == 2){ //player 2 checks after player 1 checks
        //resolve game
        [self decideWinner];
        checkBool = false;
    }
    
    [self switchPlayer];
}

- (IBAction)confirmBetAction:(id)sender
{
    //also handles raises
    NSInteger bet = [[_betAmountInputField text] integerValue];
    //check for invalid input
    if (bet > [self getMoney] ||//bet is greater than available money
        bet <= _lastBet           //raise is <= last bet from other player
        //TODO: make sure there's no other forms of invalid input
        )
    {
        NSLog(@"Bad Input : %ld", (long)bet);
    }
    else //valid input given
    {
        NSLog(@"Good Input : %ld", (long)bet);
        [self setPot:bet + [self getPot]];//increase pot size
        
        //subtract bet from players money
        if (playerTurn == 1)
        {
            [player1 subtractMoney:bet label: _moneyLabel];
        }
        else
        {
            [player2 subtractMoney:bet label: _moneyLabel];
        }
        _betAmountInputField.text = @"";//clear text
        [_betAmountInputField setEnabled:FALSE];//hide textfield
        [_betAmountInputField setHidden:TRUE];
        
        [_confirmBet setEnabled:FALSE];
        [_confirmBet setHidden:TRUE];
        
        //enable bet and check buttons
        [_betButton setEnabled:TRUE];
        [_checkButton setEnabled:TRUE];
        
        _lastBet = bet;
        [self switchPlayer];
    }
}


- (IBAction) callAction:(id)sender
{
    if (playerTurn == 1)
    {
        [player1 subtractMoney:_lastBet label: _moneyLabel];
    }
    else
    {
        [player2 subtractMoney:_lastBet label: _moneyLabel];
    }
    
    [self setPot:[self getPot] + _lastBet];
    
    if(checkBool == true){
        checkBool = false;
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
        [player1 addMoney:[self getPot] label: _moneyLabel];
    }
    else if (result == 1)
    {
        [player2 addMoney:[self getPot] label: _moneyLabel];
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
    NSInteger number = [[_moneyLabel text] integerValue];
    return number;
}

- (NSInteger) getPot
{
    //get the value stored at the potLabel
    NSInteger number = [[_moneyLabel text] integerValue];
    return number;
}

- (void) setMoney: (NSInteger) newValue
{
    [_moneyLabel setText:[NSString stringWithFormat:@"$%ld", (long)newValue]];
}

- (void) setPot: (NSInteger) newValue
{
    [_potLabel setText:[NSString stringWithFormat:@"$%ld", (long)newValue]];
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
