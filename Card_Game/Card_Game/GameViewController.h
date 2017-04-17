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
- (NSInteger) getMoney;
- (void) setMoney: (NSInteger) newValue;

@property (strong, nonatomic) IBOutlet UILabel *potLabel;
- (NSInteger) getPot;
- (void) setPot: (NSInteger) newValue;

@property (strong, nonatomic) IBOutlet UIButton *checkButton;
- (IBAction)checkAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *betButton;
- (IBAction)betAction:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *betAmountInputField;
<<<<<<< HEAD

@property (strong, nonatomic) IBOutlet UIButton *confirmBet;
- (IBAction)confirmBetAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *raiseButton;

@property (strong, nonatomic) IBOutlet UIButton *callButton;
- (IBAction)callAction:(id)sender;
=======
>>>>>>> a6bd3028585b02fb2f858bb0308196a405206ba8

@property (nonatomic) NSInteger lastBet;
@property (nonatomic, retain) IBOutletCollection(UIImageView) NSArray* storyboardCards;
@property (strong, nonatomic) Player * player1;
@property (strong, nonatomic) Player * player2;
@property (nonatomic) NSInteger playerTurn;
@property (nonatomic, strong) Deck *deck;
@property (nonatomic) bool checkBool;

- (void) decideWinner;
- (void) switchPlayer;
- (void) populateHands;
@end
