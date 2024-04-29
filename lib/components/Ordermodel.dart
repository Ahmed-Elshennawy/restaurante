class OrderModel {
  int? OrderId;
  String? OrderTitle;
  String? OrderDetail;
  String? OrderImage;
  int? OrderUserId;
  int? OrderQuantity;
  int? OrderPrice;
  int? OrderTime;

  OrderModel(
      {this.OrderId,
      this.OrderTitle,
      this.OrderDetail,
      this.OrderImage,
      this.OrderUserId,
      this.OrderQuantity,
      this.OrderPrice,
      this.OrderTime});

  OrderModel.fromJson(Map<String, dynamic> json) {
    OrderId = json['id'];
    OrderTitle = json['order_title'];
    OrderDetail = json['order_detail'];
    OrderImage = json['order_image'];
    OrderUserId = json['order_user_id'];
    OrderQuantity = json['order_quantity'];
    OrderPrice = json['order_price'];
    OrderTime = json['order_time'];
  }
}
