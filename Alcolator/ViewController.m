//
//  ViewController.m
//  Alcolator
//
//  Created by Larry Lynn on 12/2/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *beerPercentTextField;

@property (weak, nonatomic) IBOutlet UISlider *beerCountSlider;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDidChange:(UITextField *)sender {
//  Make sure the text is a number
    
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        // the user typed 0, or something that's not a number, so clear the field
        sender.text = nil;
    }
}

- (IBAction)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    
}

- (IBAction)buttonPressed:(UIButton *)sender {
    
    [self.beerPercentTextField resignFirstResponder];
    
    // first calculate how much alcohol is in all those beers..
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  //assume they are 12 ounce beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue]  / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    //now calculate the equivalent amount of wine
    
    float ouncesInOneWineGlass = 5;  // wine glasses are typically 5 oz.
    float alcoholPercentageOfWine = 0.13;  // 13% is average content of alcohol in wine
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
            beerText = NSLocalizedString(@"beers", @"plural of beer");
    
}
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    }  else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    // generate the result text, and display it on the label
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
}



- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    
    [self.beerPercentTextField resignFirstResponder];
    
}


@end
