//
//  PropertiesViewController.m
//  SberbankAudit
//
//  Created by pnefedov on 29.11.12.
//
//

#import "PropertiesViewController.h"
#import "SberbankAuditAppDelegate.h"

@interface PropertiesViewController ()

@end

@implementation PropertiesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SberbankAuditAppDelegate * app = [SberbankAuditAppDelegate instance];
    
    UILabel * nameLabel = [[UILabel alloc] init];
    [nameLabel setText:@"НАСТРОЙКИ ПОДКЛЮЧЕНИЯ К SUP-СЕРВЕРУ"];
    [nameLabel setTextAlignment:UITextAlignmentCenter];
    [nameLabel setFont:[UIFont systemFontOfSize:20]];
    [nameLabel setFrame:CGRectMake(39, 30, 600, 30)];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:nameLabel];
    [nameLabel release];
    
    serverAdressLabel = [[UILabel alloc] init];
    [serverAdressLabel setText:@"HOST/IP адрес сервера:"];
    [serverAdressLabel setTextAlignment:UITextAlignmentLeft];
    [serverAdressLabel setFont:[UIFont systemFontOfSize:16]];
    [serverAdressLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:serverAdressLabel];

    
    serverAdressValue = [[UILabel alloc] init];
    [serverAdressValue setText:app.serverName];
    [serverAdressValue setTextAlignment:UITextAlignmentLeft];
    [serverAdressValue setFont:[UIFont systemFontOfSize:16]];
    [serverAdressValue setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:serverAdressValue];

    versionLabel = [[UILabel alloc] init];
    [versionLabel setText:@"Версия приложения:"];
    [versionLabel setTextAlignment:UITextAlignmentLeft];
    [versionLabel setFont:[UIFont systemFontOfSize:16]];
    [versionLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:versionLabel];
    
    NSString * fileName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

    versionValue = [[UILabel alloc] init];
    [versionValue setText:fileName];
    [versionValue setTextAlignment:UITextAlignmentLeft];
    [versionValue setFont:[UIFont systemFontOfSize:16]];
    [versionValue setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:versionValue];
    
    idLabel = [[UILabel alloc] init];
    [idLabel setText:@"ID-номер устройста"];
    [idLabel setTextAlignment:UITextAlignmentLeft];
    [idLabel setFont:[UIFont systemFontOfSize:16]];
    [idLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:idLabel];
    
    
    idValue = [[UILabel alloc] init];
    [idValue setText:app.idName];
    [idValue setTextAlignment:UITextAlignmentLeft];
    [idValue setFont:[UIFont systemFontOfSize:16]];
    [idValue setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:idValue];
    

    IPLabel = [[UILabel alloc] init];
    [IPLabel setText:@"IP-адрес устройста"];
    [IPLabel setTextAlignment:UITextAlignmentLeft];
    [IPLabel setFont:[UIFont systemFontOfSize:16]];
    [IPLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:IPLabel];
    
    
    IPValue = [[UILabel alloc] init];
    [IPValue setText:app.IPAdress];
    [IPValue setTextAlignment:UITextAlignmentLeft];
    [IPValue setFont:[UIFont systemFontOfSize:16]];
    [IPValue setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:IPValue];


    connectionIDLabel = [[UILabel alloc] init];
    [connectionIDLabel setText:@"ConnectionID устройста"];
    [connectionIDLabel setTextAlignment:UITextAlignmentLeft];
    [connectionIDLabel setFont:[UIFont systemFontOfSize:16]];
    [connectionIDLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:connectionIDLabel];
    
    
    connectionIDValue = [[UILabel alloc] init];
    [connectionIDValue setText:app.connectionID];
    [connectionIDValue setTextAlignment:UITextAlignmentLeft];
    [connectionIDValue setFont:[UIFont systemFontOfSize:16]];
    [connectionIDValue setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:connectionIDValue];

    
    aCancelButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
    [aCancelButton setTitle:@"Выйти" forState:UIControlStateNormal];
    [aCancelButton addTarget:self action:@selector(aCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aCancelButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [serverAdressLabel setFrame:CGRectMake(25, 100, 200, 30)];
    [serverAdressValue setFrame:CGRectMake(280, 100, 370, 30)];
    [versionLabel setFrame:CGRectMake(serverAdressLabel.frame.origin.x, serverAdressLabel.frame.origin.y + serverAdressLabel.frame.size.height + 20, 200, 30)];
    [versionValue setFrame:CGRectMake(serverAdressValue.frame.origin.x, serverAdressValue.frame.origin.y + serverAdressValue.frame.size.height + 20, 370, 30)];
    [idLabel setFrame:CGRectMake(serverAdressLabel.frame.origin.x, versionLabel.frame.origin.y + versionLabel.frame.size.height + 20, 200, 30)];
    [idValue setFrame:CGRectMake(serverAdressValue.frame.origin.x, versionValue.frame.origin.y + versionValue.frame.size.height + 20, 370, 30)];
    [IPLabel setFrame:CGRectMake(serverAdressLabel.frame.origin.x, idLabel.frame.origin.y + idLabel.frame.size.height + 20, 200, 30)];
    [IPValue setFrame:CGRectMake(serverAdressValue.frame.origin.x, idValue.frame.origin.y + idValue.frame.size.height + 20, 370, 30)];
    [connectionIDLabel setFrame:CGRectMake(serverAdressLabel.frame.origin.x, IPLabel.frame.origin.y + IPLabel.frame.size.height + 20, 200, 30)];
    [connectionIDValue setFrame:CGRectMake(serverAdressValue.frame.origin.x, IPValue.frame.origin.y + IPValue.frame.size.height + 20, 370, 30)];
    [aCancelButton setFrame:CGRectMake(279, 439, 120, 35)];
}

- (void)aCancelAction
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc
{
    [aCancelButton release];
    [versionLabel release];
    [versionValue release];
    [serverAdressLabel release];
    [serverAdressValue release];
    [idLabel release];
    [idValue release];
    [IPLabel release];
    [IPValue release];
    [connectionIDLabel release];
    [connectionIDValue release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

@end
