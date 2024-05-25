class PaginationRequest {
  final int pageSize;
  final int page;
  final int? id;

  PaginationRequest({this.pageSize = 20, this.page = 1, this.id});
}
