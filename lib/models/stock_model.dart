class StockModel {
  int? id;
  String? name;
  String? tag;
  String? color;
  List<Criteria>? criteria;

  StockModel({this.id, this.name, this.tag, this.color, this.criteria});

  StockModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tag = json['tag'];
    color = json['color'];
    if (json['criteria'] != null) {
      criteria = <Criteria>[];
      json['criteria'].forEach((v) {
        criteria!.add(Criteria.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tag'] = tag;
    data['color'] = color;
    if (criteria != null) {
      data['criteria'] = criteria!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Criteria {
  String? type;
  String? text;
  Map<String,dynamic>? rawData;

  Criteria({this.type, this.text,this.rawData});

  Criteria.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    text = json['text'];
    if(type == "variable")
      {
        rawData = json["variable"];
      }
    else
      {
        rawData = {};
      }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['text'] = text;
    return data;
  }
}
