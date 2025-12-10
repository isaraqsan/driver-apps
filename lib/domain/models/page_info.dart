class PageInfo {
  int? pageSize;
  int? pageNumber;
  int? totalPage;
  int? totalData;
  bool? isLastPage;

  PageInfo({this.pageSize, this.pageNumber, this.totalPage, this.totalData, this.isLastPage});

  PageInfo.fromJson(Map<String, dynamic> json) {
    pageSize = json['page_size'];
    pageNumber = json['page_number'];
    totalPage = json['total_page'];
    totalData = json['total_data'];
    isLastPage = pageNumber == totalPage;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page_size'] = pageSize;
    data['page_number'] = pageNumber;
    data['total_page'] = totalPage;
    data['total_data'] = totalData;
    return data;
  }
}
