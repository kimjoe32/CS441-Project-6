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

@interface GameViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *potLabel;
@property (strong, nonatomic) IBOutlet UIButton *checkButton;
@property (strong, nonatomic) IBOutlet UIButton *betButton;
@property (nonatomic) float lastBet;
@property (nonatomic, retain) IBOutletCollection(UIImageView) NSArray* cards;
@property (strong, nonatomic) Player * player1;
@property (strong, nonatomic) Player * player2;
@property (nonatomic) NSInteger playerTurn;
-(IBAction)betAction:(id)sender;
-(IBAction)checkAction:(id)sender;

@end
``
