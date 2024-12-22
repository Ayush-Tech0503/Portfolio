class SellerFAQModel {
  String? status;
  List<Data>? data;

  SellerFAQModel({this.status, this.data});

  SellerFAQModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? faqId;
  String? faqFor;
  String? question;
  String? answer;
  String? isDeleted;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;

  Data(
      {this.faqId,
        this.faqFor,
        this.question,
        this.answer,
        this.isDeleted,
        this.createdDate,
        this.createdBy,
        this.modifiedDate,
        this.modifiedBy});

  Data.fromJson(Map<String, dynamic> json) {
    faqId = json['faq_id'];
    faqFor = json['faq_for'];
    question = json['question'];
    answer = json['answer'];
    isDeleted = json['is_deleted'];
    createdDate = json['created_date'];
    createdBy = json['created_by'];
    modifiedDate = json['modified_date'];
    modifiedBy = json['modified_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['faq_id'] = faqId;
    data['faq_for'] = faqFor;
    data['question'] = question;
    data['answer'] = answer;
    data['is_deleted'] = isDeleted;
    data['created_date'] = createdDate;
    data['created_by'] = createdBy;
    data['modified_date'] = modifiedDate;
    data['modified_by'] = modifiedBy;
    return data;
  }
}
