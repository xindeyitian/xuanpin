//
//  OrderShouHouListModel.h
//  SmallB
//
//  Created by zhang on 2022/7/11.
//

#import "THBaseModel.h"

@interface OrderShouHouListModel : THBaseModel

@property (nonatomic , strong)NSMutableArray *records;

@end

@interface OrderShouHouListRecordsModel : THBaseModel

@property (nonatomic , strong)NSString *moneyAgent;//单个商品）佣金
@property (nonatomic , strong)NSString *moneyBackValue;//退款金额
@property (nonatomic , strong)NSString *skuImgUrl;
@property (nonatomic , strong)NSString *payTime;//付款时间
@property (nonatomic , strong)NSString *goodsName;//商品名称
@property (nonatomic , strong)NSString *skuId;//
@property (nonatomic , strong)NSString *applyType;//退款类型 1：仅退款 2：退货退款
@property (nonatomic , strong)NSString *imgUrlList;
@property (nonatomic , strong)NSString *skuName;
@property (nonatomic , strong)NSString *applyReason;//申请原因
@property (nonatomic , strong)NSString *dealSign;//处理状态（1 等待商家同意、2等待揽件、3等待退款、4待商家确认收货、9退货完成、-1退货失败、-2客户取消、-3商家取消）
@property (nonatomic , strong)NSString *priceSale;//（单个商品）销售价
@property (nonatomic , strong)NSString *goodsId;//商品id
@property (nonatomic , strong)NSString *postTime;//发货时间
@property (nonatomic , strong)NSString *dealDesc;//受理描述
@property (nonatomic , strong)NSString *quantity;//申请退货数量
@property (nonatomic , strong)NSString *quantityTotal;//购买商品总数量
@property (nonatomic , strong)NSString *expressNo;//快递编号
@property (nonatomic , strong)NSString *orderNo;//订单编号
@property (nonatomic , strong)NSString *moneyBackSign;//退款状态（0无需退款、1 待退款、9 已退款、 -1无法退款）
@property (nonatomic , strong)NSString *dealTime;//受理时间
@property (nonatomic , strong)NSString *moneyBackTime;//退款时间
@property (nonatomic , strong)NSString *expressComp;//快递公司
@property (nonatomic , strong)NSString *orderItemId;//订单项id
@property (nonatomic , strong)NSString *orderTime;//下单时间
@property (nonatomic , strong)NSString *applyId;//退款申请单号
@property (nonatomic , strong)NSString *orderId;//订单id

@end
