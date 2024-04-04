class Incoming{
  late int id;
  late int codeId;
  late int quantity;

  Incoming({
    required this.id,
    required this.codeId,
    required this.quantity
  });

  Incoming.fromMap(Map<String,dynamic> map){
    id = map["id"];
    codeId = map["codeId"];
    quantity = map["quantity"];
  }
}