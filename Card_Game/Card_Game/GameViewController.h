//
//  GameViewController.h
//  Card_Game
//
//  Created by Matt Perl on 4/5/17.
//  Copyright © 2017 Matt Perl & Joe Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>
#import "Hand.h"
#import "Deck.h"
#import "Card.h"
#import "Player.h"

@interface GameViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
- (float) getMoney;
- (void) setMoney: (float) newValue;

@property (strong, nonatomic) IBOutlet UILabel *potLabel;
- (float) getPot;
- (void) setPot: (float) newValue;

@property (strong, nonatomic) IBOutlet UIButton *checkButton;
-(IBAction)checkAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *betButton;
-(IBAction)betAction:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *betAmountInputField;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@property (nonatomic) float lastBet;
@property (nonatomic, retain) IBOutletCollection(UIImageView) NSArray* storyboardCards;
@property (strong, nonatomic) Player * player1;
@property (strong, nonatomic) Player * player2;
@property (nonatomic) NSInteger playerTurn;
@property (nonatomic, strong) Deck *deck;

-(void) decideWinner;
-(void) switchPlayer;

@end
