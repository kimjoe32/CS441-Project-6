//
//  Card.h
//  Card_Game
//
//  Created by Matt Perl on 4/16/17.
//  Copyright © 2017 Matt Perl & Joe Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic, strong) IBOutlet UIImage *cardImg;
@property (nonatomic, strong) NSString *cardString;

@end
