//
//  AllUrl.h
//  YPReusableController
//
//  Created by zhiai on 16/2/26.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#ifndef AllUrl_h
#define AllUrl_h
#define knewApi @"http://www.nyxdt.com/apiv/arctype.php" //top的标题;其实我已经写死了...
#define knewListApi @"http://www.nyxdt.com/apiv/list.php"//列表
#define knewPhotoApi @"http://www.nyxdt.com/apiv/images.php"//相册
#define knewDetailApi @"http://www.nyxdt.com/apiv/view.php"//详细
#define kUMappKey @"56d4f773e0f55a790b001aad" //友盟(UMSocial) APPkey
#define checkUserLogin(token) ( (token) == NULL || [(token) isEqualToString:@""] ? NO:YES)
#define kLoginUrl @"http://apiv.beloved999.com/newapi/" //登陆
#define KNewOutApi @"http://www.nyxdt.com/member/apiv_index_do.php"//退出

#define kNewRegiestApi @"http://www.nyxdt.com/member/apiv_reg_new.php"//注册
#endif /* AllUrl_h */
