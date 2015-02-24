//
//  ViewController.m
//  Alcolator
//
//  Created by Larry Lynn on 12/2/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "ViewController.h"

//@interface ViewController ()

@interface ViewController () <UITextFieldDelegate>


//@property (weak, nonatomic) IBOutlet UITextField *beerPercentTextField;

//@property (weak, nonatomic) IBOutlet UISlider *beerCountSlider;

//@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

//@property (weak, nonatomic) IBOutlet UILabel *beerCountLabel;

//@property (weak, nonatomic) UITextField *beerPercentTextField;

//@property (weak, nonatomic) UISlider *beerCountSlider;

//@property (weak, nonatomic) UILabel *resultLabel;

@property (weak, nonatomic) UILabel *beerCountLabel;

@property (weak, nonatomic) UIButton *calculateButton;

@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;


@end

@implementation ViewController

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.title = NSLocalizedString(@"Wine", @"wine");
        
        [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -18)];
    }
    return self;

}

- (void)viewDidLoad {
    
    //  self.title = NSLocalizedString(@"Wine", @"Wine");
    
    self.view.backgroundColor = [UIColor colorWithRed:0.741 green:0.925 blue:0.714 alpha:1]; /*bdecb6*/
    
    

    //calls the superclass' implementation
    [super viewDidLoad];
    
    // Set our primary view's background color to lightGrayColor
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // Tells the textfield that 'self', this instance of 'ViewController' should be treated as the text field's delegate
    self.beerPercentTextField.delegate = self;
    self.beerPercentTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    // Sets the placeholder text
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percentage placeholder text");
    
    // Tells 'self.beerCountSlider' that when its value changes, it should call '[self -sliderValueDidChange:]'
    // This is equivalent to connecting the IBAction in the previous checkpoint
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    // Set the minimum and maximum numbers of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    // Tells 'self.caculateButton' that when a finger is lifted from the button while still inside its bounds, to call [selfButtonPushed]
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Set the title of the button
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    
    //  Tells the tap gesture recognizer to call '[self -tapGestureDidFire:]' when it detects a tap.
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    // Gets rid of the maximum number of lines on the label
    self.resultLabel.numberOfLines = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// - (IBAction)textFieldDidChange:(UITextField *)sender {
- (void)textFieldDidChange:(UITextField *)sender {
//   Make sure the text is a number
    
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        // the user typed 0, or something that's not a number, so clear the field
        sender.text = nil;
    }
}

//- (IBAction)sliderValueDidChange:(UISlider *)sender {
- (void)sliderValueDidChange:(UISlider *)sender {

     NSLog(@"Slider value changed to %f", sender.value);
    [self.beerCountLabel setText:@(sender.value).stringValue];
    [self.beerPercentTextField resignFirstResponder];
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int) sender.value]];

    [self buttonPressed:nil];
    
    self.title = [NSString stringWithFormat:@"Wine (%d glasses)" , (int) sender.value];
}

//- (IBAction)buttonPressed:(UIButton *)sender {
- (void)buttonPressed:(UIButton *)sender {

    
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



//- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    
    [self.beerPercentTextField resignFirstResponder];
    
}

- (void)loadView {
    // Allocate and initialize the all-encompassing view
    self.view = [[UIView alloc] init];
    
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    //add each view and the gesture recognizer as the view's subviews
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    // Assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
    
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 44;
    
    self.beerPercentTextField.frame = CGRectMake(padding, padding + 50, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight * 4);
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
    
}
                    



@end
