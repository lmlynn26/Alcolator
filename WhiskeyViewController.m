//
//  WhiskeyViewController.m
//  Alcolator
//
//  Created by Larry Lynn on 12/16/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "WhiskeyViewController.h"

@interface WhiskeyViewController ()

@end

@implementation WhiskeyViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Whiskey", nil);
        
    }
    
    return self;
    
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    //  self.title = NSLocalizedString(@"Whiskey", @"Whiskey");
    
    self.view.backgroundColor = [UIColor colorWithRed:0.992 green:0.992 blue:0.588 alpha:1];  /*fdfd96*/
    
    
}

- (void)buttonPressed:(UIButton *)sender;
{
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;   //assume 12 oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWhiskeyGlass = 1;  //a one ounce shot
    float alcoholPercentageOfWhiskey = 0.4;  //40% alcohol is average for Whiskey
    
    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass;
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    }   else {
            beerText = NSLocalizedString(@"beers", @"plural of beer");
        }
    NSString *whiskeyText;
    
    if (numberOfWhiskeyGlassesForEquivalentAlcoholAmount == 1)  {
        whiskeyText = NSLocalizedString(@"shot", @"singular shot");
    
    }  else {
        whiskeyText = NSLocalizedString(@"shots", @"plural of shots");
    }
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of Whiskey.", nil), numberOfBeers, beerText, numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
                                                                        
    self.resultLabel.text = resultText;
    
}

- (void)sliderValueDidChange:(UISlider *)sender {
    
    [super sliderValueDidChange:sender];
    
    self.title = [NSString stringWithFormat:@"Whiskey (%d glasses)" , (int) sender.value];
    
    
}


@end
