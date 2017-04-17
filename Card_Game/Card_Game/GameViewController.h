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

@interface GameViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *potLabel;
@property (strong, nonatomic) IBOutlet UIButton *checkButton;
@property (strong, nonatomic) IBOutlet UIButton *betButton;
@property (nonatomic) float lastBet;
@property (strong, nonatomic) IBOutlet UIImageView *card1;
@property (strong, nonatomic) IBOutlet UIImageView *card2;
@property (strong, nonatomic) IBOutlet UIImageView *card3;
@property (strong, nonatomic) IBOutlet UIImageView *card4;
@property (strong, nonatomic) IBOutlet UIImageView *card5;
-(IBAction)betAction:(id)sender;
-(IBAction)checkAction:(id)sender;
@end
