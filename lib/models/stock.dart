class Stock {
  late int code;
  late String? name;
  late int? quantity;
  late String? unit;
  late String? qr;
  late String? type;

  Stock({
    required this.code,
    required this.name,
    required this.quantity,
    required this.qr,
    required this.unit,
    required this.type,
  });

  Stock.fromMap(Map<String ,dynamic> map){
    code = map['code'];
    name = map["name"];
    quantity = map["quantity"];
    unit = map["unit"];
    type = map["type"];
    qr = map["QR"];
  }

}
