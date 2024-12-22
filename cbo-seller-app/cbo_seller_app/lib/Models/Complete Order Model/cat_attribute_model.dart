class CatAttributesModel {
  String? page;
  List<CatAttributesData>? data;
  String? status;

  CatAttributesModel({this.page, this.data, this.status});

  CatAttributesModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['data'] != null) {
      data = <CatAttributesData>[];
      json['data'].forEach((v) {
        data!.add(CatAttributesData.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class CatAttributesData {
  String? attributeId;
  String? attributeName;
  bool? selectAtt = false;
  String? tableName;
  String? controlName;
  String? isVariant;
  String? controlType;
  String? controlHtml;
  String? controlId;
  List<AttributeData>? attributeData;

  CatAttributesData(
      {this.attributeId,
        this.attributeName,
        this.tableName,
        this.selectAtt,
        this.controlName,
        this.isVariant,
        this.controlType,
        this.controlHtml,
        this.controlId,
        this.attributeData});

  CatAttributesData.fromJson(Map<String, dynamic> json) {
    attributeId = json['attribute_id'];
    attributeName = json['attribute_name'];
    tableName = json['table_name'];
    controlName = json['control_name'];
    isVariant = json['is_variant'];
    controlType = json['control_type'];
    controlHtml = json['control_html'];
    controlId = json['control_id'];
    if (json['attribute_data'] != null) {
      attributeData = <AttributeData>[];
      json['attribute_data'].forEach((v) {
        attributeData!.add(AttributeData.fromJson(v));
      });
    }
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
    if (attributeData != null) {
      data['attribute_data'] =
          attributeData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttributeData {
  dynamic? optionId;
  String? text;
  String? value;
  bool? isSelected;

  AttributeData({this.optionId, this.text, this.value, this.isSelected = false,});

  AttributeData.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    text = json['text'];
    value = json['value'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option_id'] = optionId;
    data['text'] = text;
    data['value'] = value;
    data['isSelected'] = isSelected;
    return data;
  }
}
