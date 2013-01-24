//
//  WaitingViewController.m
//  SberbankAudit
//
//  Created by pnefedov on 06.12.12.
//
//

#import "WaitingViewController.h"

@interface WaitingViewController ()

@end

@implementation WaitingViewController
@synthesize label = _label;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
//        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _label = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 250, 60)];
        [_label setText:@"Идет синхронизация"];
        [_label setBackgroundColor:[UIColor clearColor]];
        [_label setTextAlignment:UITextAlignmentCenter];
        [self.view addSubview:_label];
        
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.center = CGPointMake(50, 50);
        [self.view addSubview:indicator];
        [indicator startAnimating];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [indicator stopAnimating];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"jlkjl;dkfhal;skdhfalksdhfalkdhsflakhdsflsahfah");
}

- (void)dealloc
{
    [_label release];
    [indicator release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}


@end
