class SearchModel {
  List<Filters>? filters;
  List<Null>? sorts;
  int? page;
  int? limit;

  SearchModel({this.filters, this.sorts, this.page, this.limit});

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['filters'] != null) {
      filters = <Filters>[];
      json['filters'].forEach((v) {
        filters!.add(Filters.fromJson(v));
      });
    }
    if (json['sorts'] != null) {
      sorts = <Null>[];
      json['sorts'].forEach((v) {});
    }
    page = json['page'];
    limit = json['limit'];
  }
}

class Filters {
  String? key;
  String? operator;
  String? fieldType;
  String? value;

  Filters({this.key, this.operator, this.fieldType, this.value});

  Filters.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    operator = json['operator'];
    fieldType = json['field_type'];
    value = json['value'];
  }
}
