class OrderModel {
  int? orderId;
  String? orderTitle;
  String? orderDetail;
  String? orderImage;
  int? orderUserId;
  int? orderQuantity;
  int? orderPrice;
  int? orderTime;

  OrderModel(
      {this.orderId,
      this.orderTitle,
      this.orderDetail,
      this.orderImage,
      this.orderUserId,
      this.orderQuantity,
      this.orderPrice,
      this.orderTime});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['id'];
    orderTitle = json['order_title'];
    orderDetail = json['order_detail'];
    orderImage = json['order_image'];
    orderUserId = json['order_user_id'];
    orderQuantity = json['order_quantity'];
    orderPrice = json['order_price'];
    orderTime = json['order_time'];
  }
}
