//
//  TaskTypeViewController.m
//  SberbankAudit
//
//  Created by pnefedov on 23.11.12.
//
//

#import "TaskTypeViewController.h"

@interface TaskTypeViewController ()

@end

@implementation TaskTypeViewController
@synthesize parent;

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
        [self.view setAutoresizesSubviews:NO];
        
//        self.tableView.layer.borderColor = [UIColor blueColor].CGColor;
        self.tableView.layer.borderColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0].CGColor;
        self.tableView.layer.cornerRadius = 5;
        self.tableView.layer.borderWidth = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.taskArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell;
    
    cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [[self.taskArray objectAtIndex:indexPath.row] objectForKey:@"TASK_TYPE_NAME"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * taskTypeID = [NSString stringWithFormat:@"%@",[[self.taskArray objectAtIndex:indexPath.row] objectForKey:@"TASK_TYPE_ID"]];
    NSLog(@"%@",taskTypeID);
    if ([self.parent respondsToSelector:@selector(setSelectedTaskTypeID:)]) {
        [self.parent setSelectedTaskTypeID:taskTypeID];
    }
    
    [self.view setUserInteractionEnabled:NO];
    
    largeLabel = [[UIImageView alloc] initWithFrame:CGRectMake(252-50, 309-20-100, 300, 100)];
    [largeLabel setBackgroundColor:[UIColor lightGrayColor]];
    largeLabel.alpha = 0.8;
    [largeLabel.layer setCornerRadius:5];
    [self.view addSubview:largeLabel];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 240, 60)];
    [label setText:@"Синхронизация данных"];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:UITextAlignmentCenter];
    [largeLabel addSubview:label];
    
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.color = [UIColor blackColor];
    indicator.center = CGPointMake(25, 50);
    [indicator startAnimating];
    [largeLabel addSubview:indicator];

    
    [self.parent performSelector:@selector(createTask)];
    
    [indicator stopAnimating];
    [largeLabel setHidden:YES];
    [self.view setUserInteractionEnabled:YES];

    
    [self.parent performSelector:@selector(cancelAction)];
    [self.parent performSelector:@selector(showAlert)];
//    alert = [[[UIAlertView alloc] initWithTitle:@"Задача успешно создана." message:nil delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil] autorelease];
//    [alert show];
    [self dismissModalViewControllerAnimated:YES];
//    [self.parent performSelector:@selector(cancelAction)];
//    [self.parent dismissModalViewControllerAnimated:YES];

//    [self.parent selectedT];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.taskArray removeAllObjects];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
    //        return YES;
    //    }
    //    return NO;
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (BOOL)shouldAutorotate
{
    return YES;
}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
//}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)dealloc
{
    [largeLabel release];
    [indicator release];
    [label release];
    [super dealloc];
}


@end
