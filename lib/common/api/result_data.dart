class ResultData<T> {
  T? data;
  bool result;
  int? code;
  Function? next;
  var headers;

  ResultData(this.data, this.result, {this.code, this.headers, this.next});
}
