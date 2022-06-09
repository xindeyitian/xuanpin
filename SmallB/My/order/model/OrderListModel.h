//
//  OrderListModel.h
//  SmallB
//
//  Created by zhang on 2022/5/14.
//

#import "THBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderListModel : THBaseModel

@property (nonatomic , strong)NSMutableArray *records;

@end

@interface OrderListRecordsModel : THBaseModel

@property (nonatomic , strong)NSString *deliveryPhoneNum;//deliveryPhoneNum
@property (nonatomic , strong)NSString *deliveryRealName;//deliveryRealName
@property (nonatomic , strong)NSMutableArray *orderGoodsListVos;
@property (nonatomic , strong)NSString *orderId;//订单编号
@property (nonatomic , strong)NSString *orderNo;//订单号
/**
 订单状态（0上门定制、1待支付默认，2待发货、3待收货，9完成，-1客户取消、-2管理员取消、-3待退货、-4已部分退货、-5已全部退货）
 */
@property (nonatomic , strong)NSString *orderState;//
@property (nonatomic , strong)NSString *orderTime;//下单时间
@property (nonatomic , strong)NSString *totalMoneyAgent;//总佣金

@end

@interface OrderListProductModel : THBaseModel

@property (nonatomic , strong)NSString *expressInfo;//快递描述信息
@property (nonatomic , strong)NSString *expressTime;//快递时间
@property (nonatomic , strong)NSString *goodsId;//商品编号
@property (nonatomic , strong)NSString *goodsName;//商品名称
@property (nonatomic , strong)NSString *moneyAgent;//佣金
@property (nonatomic , strong)NSString *priceSale;//销售价
@property (nonatomic , strong)NSString *quantityTotal;//购买数量
@property (nonatomic , strong)NSString *skuImgUrl;//商品图片
@property (nonatomic , strong)NSString *skuName;//商品规格

@end

@interface OrderDetailModel : THBaseModel

@property (nonatomic , strong)NSString *orderTime;
@property (nonatomic , strong)NSString *deliveryPhoneNum;
@property (nonatomic , strong)NSString *payTime;
@property (nonatomic , strong)NSString *deliveryDate;
@property (nonatomic , strong)NSString *orderNo;
@property (nonatomic , strong)NSString *cancelTime;
@property (nonatomic , strong)NSString *totalMoneySale;
@property (nonatomic , strong)NSString *deliveryAddress;
@property (nonatomic , strong)NSString *orderState;
@property (nonatomic , strong)NSString *recvRime;
@property (nonatomic , strong)NSString *expressFee;
@property (nonatomic , strong)NSString *deliveryRealName;
@property (nonatomic , strong)NSString *totalMoneyPayed;
@property (nonatomic , strong)NSMutableArray *orderGoodsListVo;

@end

NS_ASSUME_NONNULL_END
