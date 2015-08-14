//
//  TPLLoginViewController.m
//  CNTaiPingLife
//
//  Created by apple on 13-4-16.
//  Copyright (c) 2013年 CNTaiPing. All rights reserved.
//

#import "TPLoginViewController.h"
#import "TPLAppDelegate.h"
#import "TPMainMenuController.h"
#import "TPIPISUserBO.h"

@interface TPLoginViewController()<
UITextFieldDelegate,
UIWebViewDelegate,
UIScrollViewDelegate
>{
    UIImageView *moveBackView;
    UIImageView *headImageView;     //个人头像的UIImageView
    
    CGRect backRect;                //输入时上移的范围
    UIImageView *middleImage;       //头像图片的效果  用来设置是否隐藏
    UIView *rightView;              //用于弹出解锁界面时 隐藏的部分界面
    NSString *oldInputUserName;
    
    BOOL gestureNeed;
    
    UIScrollView *appLoginScrollView;
    UIPageControl *pageControl;
}
@property (nonatomic,strong) UITextField *nameField;            //名称UITextField
@property (nonatomic,strong) UITextField *passwordField;        //密码UITextField
@property (nonatomic,strong) UIButton *rememberPassword;        //记住密码

@property (nonatomic,strong) UIView *keyMoveView;               //点击手势按钮时弹出的界面
@property (nonatomic,strong) NSString* winkTocken;
@end

@implementation TPLoginViewController
@synthesize rememberPassword;
@synthesize nameField,passwordField;
@synthesize winkTocken;

- (void)initData {
#if  TARGET_IPHONE_SIMULATOR
    self.nameField.text = @"tangjing";
    self.passwordField.text = @"root@123";
#endif
}

- (id)initWithWinkTocken:(NSString*)winktocken {
    self = [super init];
    if (self) {
        self.winkTocken = winktocken;
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)initAppLoadView {
    [self viewLoginInit];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    pageControl.currentPage = scrollView.contentOffset.x/1024;
}

- (void)buttonGotoClick {
    [pageControl removeFromSuperview];
    [appLoginScrollView removeFromSuperview];
    pageControl = nil;
    appLoginScrollView = nil;
    
    [self viewLoginInit];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAppLoadView];
    
}

- (void)viewLoginInit {
    [self.backgroundView removeFromSuperview];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    iv.image = [Image(@"login/loginBackground.png") stretch];
    iv.userInteractionEnabled = YES;
    [self.view addSubview:iv];
    moveBackView = [[UIImageView alloc] initWithFrame:CGRectMake(310, 110, 420, 504)];
    moveBackView.userInteractionEnabled = YES;
    [iv addSubview:moveBackView];
    
    oldInputUserName  = @"";
    gestureNeed = NO;
    
    [self addBackGround];
    [self addBottomButtons];
    
    __block CGRect logoFrame = moveBackView.frame;
    __block UIView* view = moveBackView;
    [self keyboardMonitor:^(CGFloat moveHeight, UIViewControllerKeyboard state){
        if (state == UIViewControllerKeyboardWillShow) {
            CGRect frame = logoFrame;
            CGFloat moveH = 768 - moveHeight;
            if (moveH == 160)
                frame.origin.y -= 140;
            else if (moveH == 106)
                frame.origin.y -= 190;
            else if (moveH == 377)
                frame.origin.y -= 180;
            else if (moveH == 416)
                frame.origin.y -= 140;
            view.frame = frame;
        }
        else if (state == UIViewControllerKeyboardWillHide) {
            view.frame = logoFrame;
        }
    }];
    
    //监听自动更新
    NotificationAddObserver(self, NotificationMsg_UPDATE_VERSION, @selector(responderWillUpdateVersion:));
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//头像按钮进行的操作
- (void)headImageClick {
    [UIView animateWithDuration:.1 animations:^{
        headImageView.alpha = 0.2;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.1 animations:^{
            headImageView.alpha = 1.0;
        }];
    }];
}

#pragma mark - view -
//布局用户名 和 密码
- (void)addBackGround {
    headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(129, 0, 162, 162)];
    headImageView.userInteractionEnabled = YES;
    headImageView.image = Image(@"login/wideCircle.png");
    [moveBackView addSubview:headImageView];
    
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 152, 152)];
    headImage.userInteractionEnabled = YES;
    headImage.image = Image(@"login/normalImage.png");
    [headImageView addSubview:headImage];
    
    //头像的点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageClick)];
    [headImageView addGestureRecognizer:tap];
    
    UIButton* loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundImage:Image(@"login/loginbuttonnormal.png") forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:Image(@"login/loginbuttonnormal2.png") forState:UIControlStateHighlighted];
    loginBtn.frame = CGRectMake(60, moveBackView.height-120, 303, 62);
    [loginBtn addTarget:self action:@selector(onLoginBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [moveBackView addSubview:loginBtn];
    
    UIImageView *nameIV = [[UIImageView alloc] initWithFrame:CGRectMake(60, 180, 303, 50)];
    nameIV.image = Image(@"login/inputback.png");
    nameIV.userInteractionEnabled = YES;
    [moveBackView addSubview:nameIV];
    UIImageView *passwordIV = [[UIImageView alloc] initWithFrame:CGRectMake(60, 260, 303, 50)];
    passwordIV.image = Image(@"login/inputback.png");
    passwordIV.userInteractionEnabled = YES;
    [moveBackView addSubview:passwordIV];
    
    UIImageView *usename = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13, 22, 24)];
    usename.image = Image(@"login/name.png");
    [nameIV addSubview:usename];
    UIImageView *password = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13, 22, 24)];
    password.image = Image(@"login/password.png");
    [passwordIV addSubview:password];
    
    self.nameField = [[UITextField alloc] initWithFrame:
                      CGRectMake(43, 10, 260, 30)];
    self.nameField.placeholder = @"用户名";
    self.nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nameField.backgroundColor = [UIColor clearColor];
    self.nameField.textColor = [UIColor whiteColor];
    self.nameField.font = FontOfSize(FontNormalSize);
    self.nameField.delegate = self;
    self.nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [nameIV addSubview:self.nameField];
    
    self.passwordField = [[UITextField alloc] initWithFrame:
                          CGRectMake(43, 10, 260, 30)];
    self.passwordField.placeholder = @"密码";
    self.passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.passwordField.backgroundColor = [UIColor clearColor];
    self.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordField.secureTextEntry = YES;
    self.passwordField.delegate = self;
    self.passwordField.textColor = [UIColor whiteColor];
    self.passwordField.font = FontOfSize(FontNormalSize);
    [passwordIV addSubview:self.passwordField];
    
}

//布局下面是否记住密码  手势view
- (void)addBottomButtons {
    self.rememberPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rememberPassword.frame = CGRectMake(60, 330, 150, 33);
    [self.rememberPassword setTitle:@"记住密码" forState:UIControlStateNormal];
    [self.rememberPassword setTitleColor:TEXTCOLOR(@"0xffffff") forState:UIControlStateNormal];
    self.rememberPassword.titleLabel.font = FontOfSize(FontNormalSize);
    [self.rememberPassword setImage:Image(@"login/funoselect.png") forState:UIControlStateNormal];
    [self.rememberPassword setImage:Image(@"login/fuselect.png") forState:UIControlStateSelected];
    self.rememberPassword.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 34);
    self.rememberPassword.imageEdgeInsets = UIEdgeInsetsMake(3, 0, 3, 115);
    [moveBackView addSubview:self.rememberPassword];
    
    [rememberPassword addTarget:self action:@selector(remeberPswEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    //dict ====== name password remebername autologin
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"login"];
    if (!dict) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionary] forKey:@"login"];
    }else {
        BOOL remebername = [[dict valueForKey:@"remebername"] boolValue];
        NSString *name = [dict valueForKey:@"name"];
        NSString *password = [dict valueForKey:@"password"];
        self.rememberPassword.selected = remebername;
        if (remebername) {
            self.nameField.text = name;
            self.passwordField.text = password;
        }else {
            self.nameField.text = name;
        }
    }

    [self initData];
    
    oldInputUserName = self.nameField.text;
}

- (void)remeberPswEvent:(UIButton *)button {
    rememberPassword.selected = !rememberPassword.selected;
}

#pragma mark - UITextField -
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.nameField) {
        if ([oldInputUserName isEqualToString:@""]) {
            oldInputUserName = textField.text;
        }else if (![self nameEqual:textField.text]) {
            oldInputUserName = textField.text;
            self.passwordField.text = @"";
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.nameField) {
        self.passwordField.text = @"";
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

#pragma mark - Head Image -
- (NSString *)GetTempPath:(NSString *)fileName
{
    NSString *tempPath = NSTemporaryDirectory();
    return [tempPath stringByAppendingPathComponent:fileName];
}

// 文件是否存在
- (BOOL)isExistsFile:(NSString *)filePath{
    NSFileManager *filemanage = [NSFileManager defaultManager];
    return [filemanage fileExistsAtPath:filePath];
}

// 图取图片文件
- (NSData *)readDateFromFile{
    NSString *name = [NSString stringWithFormat:@"%@", self.nameField.text];
    NSString *fileName = [NSString stringWithFormat:@"%@.png", name];
    NSString *myFilePath = [self GetTempPath:fileName];
    NSData *data = [NSData dataWithContentsOfMappedFile:myFilePath];
    return data;
}

//登陆按钮的操作
- (void) onLoginBtnEvent:(UIButton*)button {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    NSString *userName = [self.nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([@"" isEqualToString:userName] || nil == userName) {
        ShowMessage(@"请输入用户名！", nil);
        return ;
    }
    if ([@"" isEqualToString:password] || nil == passwordField) {
        ShowMessage(@"请输入密码！", nil);
        return ;
    }
    if ([self.nameField.text hasPrefix:@" "] || [self.nameField.text hasSuffix:@" "]) {
        ShowMessage(@"用户名首尾不能输入空格", nil);
        return ;
    }
    if ([self.passwordField.text hasPrefix:@" "] || [self.passwordField.text hasSuffix:@" "]) {
        ShowMessage(@"密码首尾不能输入空格", nil);
        return ;
    }
    
    [TPUserDefaults instance].intservToken = nil;
    if (self.nameField.text && self.passwordField.text) {
        NSString *name = [NSString stringWithFormat:@"%@@astaff", self.nameField.text];
        [TPRemote doAction:1
                      type:@"登陆接口"
             interfaceType:RemoteInterfaceTypeLogin
                requestUrl:URL_login
                  delegate:self
                 parameter:name, self.passwordField.text, nil];
    }
}

- (void) sethistoryNameLogin {
    BOOL rememberPwd = self.rememberPassword.selected;
    NSString *name = self.nameField.text;
    NSString *password = self.passwordField.text;

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"login"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:name forKey:@"name"];
    [dict setObject:password forKey:@"password"];
    [dict setObject:[NSNumber numberWithBool:rememberPwd] forKey:@"remebername"];
    
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"login"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)clearPassword {
    self.passwordField.text = @"";
}

- (void) initAuthDB:(NSArray*)moduleList {
    
    [DB deleteWhereData:@{@"name": [TPUserDefaults instance].userName} Class:[TPDBAuthModulBO class]];
    //游客或者把所有权限全部去除的角色，等效于游客
    if (moduleList.count <= 0) {
        moduleList = [TPDBAuthModulBO visitorAuthModuls];
    }
    [moduleList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TPDBAuthModulBO* bo = (TPDBAuthModulBO*)obj;
        if ([obj isKindOfClass:[NSDictionary class]]) {
            bo = [[TPDBAuthModulBO alloc] initWithDictionary:obj];
            bo.name = [TPUserDefaults instance].userName;
        }
        
        [DB insertToDB:bo];
    }];
}

- (BOOL)nameEqual:(NSString *)str {
    NSString *old = oldInputUserName;
    if (![old hasSuffix:@"@agent"]) {
        old = [NSString stringWithFormat:@"%@@agent",old];
    }
    NSString *new = string(str);
    if (![new hasSuffix:@"@agent"]) {
        new = [NSString stringWithFormat:@"%@@agent",new];
    }
    return [old isEqualToString:new];
}

- (NSString *)userName {
    NSString *text = self.nameField.text;
    return [text lowercaseString];
}

#pragma mark - net -

- (void)remoteResponsSuccess:(int)actionTag withResponsData:(id)responsData {
    if (responsData && actionTag == 1) {
        
        [TPUserDefaults instance].loginUserBO = responsData;
        [TPUserDefaults instance].userName = [self userName];
        [TPUserDefaults instance].password = self.passwordField.text;
        [TPUserDefaults instance].loginTimestamp = [[NSDate date] timeIntervalSince1970];
        
        //将此用户权限插入数据库以备程序内使用
        [self initAuthDB:[TPUserDefaults instance].loginUserBO.moduleList];
    
        [self sethistoryNameLogin];
        
        TPISAgentAgnetBO *isAgent = [[TPISAgentAgnetBO alloc] init];
        isAgent.managerFlag = 6;
        isAgent.organId = [TPUserDefaults instance].loginUserBO.organId;
        isAgent.userId = [[TPUserDefaults instance].loginUserBO.rawStaffId stringValue];
        
        [TPUserDefaults instance].isAgentBO = isAgent;
        if ([TPUserDefaults instance].loginUserBO) {
        }
        
        [self update];
        self.rootViewController = [[TPMainMenuController alloc] initWithMsgKey:@"TPMainMenuController"];
    }
    
    if (actionTag == 1001) {
        if (responsData) {
            NSDictionary *dic = responsData;
            NSString *version_id = dic[@"VERSION_ID"];
            NSString *tempURL = @"mobile/download?sAction=loadFile&versionId=";
            NSString *downloadURL = [NSString stringWithFormat:@"%@%@",SERVERL_URL,tempURL];
            downloadURL = [downloadURL stringByAppendingString:version_id];
            NSURL *url=[[NSURL alloc] initWithString:[downloadURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
            
            UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 10,10)];
            webView.delegate = self;
            webView.hidden=YES;
            [self.view addSubview:webView];
            [webView loadRequest:request];
        }else {
            ShowMessage(@"自动升级接口错误！", nil);
            NSString* urlStr = @"http://emall.life.cntaiping.com/mobile/download?sAction=queryDownloadList";
            NSURL* URL = [NSURL URLWithString:urlStr];
            [[UIApplication sharedApplication] openURL:URL];
       }
        
        [self stopWaitCursor:2];
    }
}

- (void)remoteResponsFailed:(int)actionTag withMessage:(NSString *)message {
    ShowMessage(message, nil);
    if ([message isEqualToString:@"网络连接失败，请检查网络状态！"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"当前无网络,请检查网络状态" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确 定", nil];
        [alert showWithCompletion:^(NSInteger buttonIndex) {
            if (buttonIndex == alert.firstOtherButtonIndex) {
                return;
            }
        }];
        [self stopWaitCursor:2];
        return;
    }
    if (actionTag == 1001) {
        ShowMessage(@"自动升级接口错误！", nil);
        NSString* urlStr = @"http://emall.life.cntaiping.com/mobile/download?sAction=queryDownloadList";
        NSURL* URL = [NSURL URLWithString:urlStr];
        [[UIApplication sharedApplication] openURL:URL];
    }else ShowMessage(message, nil);
    
    
    [self stopWaitCursor:2];
}

- (void)update {
    [TPUserDefaults instance].onlyNote = NO;
    [self stopWaitCursor:2];
}

- (void) startWaitCursor:(int)actionTag {
    TPLAppDelegate *del = [[UIApplication sharedApplication] delegate];
    MBProgressHUD* progressView = [MBProgressHUD showHUDAddedTo:del.window.rootViewController.view animated:YES];
    progressView.labelText = @"加载中....";
    progressView.opaque = .6;
}

- (void) stopWaitCursor:(int)actionTag {
    if (actionTag == 2) {
        TPLAppDelegate *del = [[UIApplication sharedApplication] delegate];
        [MBProgressHUD hideHUDForView:del.window.rootViewController.view animated:NO];
    }
}


//处理自动更新
- (void)responderWillUpdateVersion:(NSNotification*)notification {
    //测试自动更新
    
    if (isIOS7_1) {
        [TPRemote doAction:1001
                      type:@"版本校验"
             interfaceType:RemoteInterfaceTypeUpadte
                requestUrl:URL_login
                  delegate:self
                 parameter:@"12",@"1",@"1",nil];
    }else {
        [TPRemote doAction:1001
                      type:@"版本校验"
             interfaceType:RemoteInterfaceTypeUpadte
                requestUrl:URL_login
                  delegate:self
                 parameter:@"12",@"1",@"0",nil];
    }
}

@end
