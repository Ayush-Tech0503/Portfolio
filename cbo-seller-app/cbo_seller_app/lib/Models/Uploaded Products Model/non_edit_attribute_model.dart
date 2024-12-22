class NonEditAttributeModel {
  String? status;
  List<AttData>? data;

  NonEditAttributeModel({this.status, this.data});

  NonEditAttributeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AttData>[];
      json['data'].forEach((v) {
        data!.add(AttData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttData {
  String? attributeId;
  String? attributeName;
  String? tableName;
  String? controlName;
  String? isVariant;
  String? controlType;
  String? controlHtml;
  String? controlId;
  String? attributeValue;

  AttData(
      {this.attributeId,
        this.attributeName,
        this.tableName,
        this.controlName,
        this.isVariant,
        this.controlType,
        this.controlHtml,
        this.controlId,
        this.attributeValue});

  AttData.fromJson(Map<String, dynamic> json) {
    attributeId = json['attribute_id'];
    attributeName = json['attribute_name'];
    tableName = json['table_name'];
    controlName = json['control_name'];
    isVariant = json['is_variant'];
    controlType = json['control_type'];
    controlHtml = json['control_html'];
    controlId = json['control_id'];
    attributeValue = json['attribute_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attribute_id'] = attributeId;
    data['attribute_name'] = attributeName;
    data['table_name'] = tableName;
    data['control_name'] = controlName;
    data['is_variant'] = isVariant;
    data['control_type'] = controlType;
    data['control_html'] = controlHtml;
    data['control_id'] = controlId;
    data['attribute_value'] = attributeValue;
    return data;
  }
}
