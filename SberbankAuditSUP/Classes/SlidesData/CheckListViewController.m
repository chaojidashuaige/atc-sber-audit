//
//  CheckListViewController.m
//  SberbankAudit
//
//  Created by pnefedov on 17.12.12.
//
//

#import "CheckListViewController.h"

@interface CheckListViewController ()

@end

@implementation CheckListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super init])
	{
        [self.view setFrame:frame];
        [self.view setBackgroundColor:[UIColor blueColor]];
	}
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
