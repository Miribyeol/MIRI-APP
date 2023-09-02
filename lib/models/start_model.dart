class StartModel {
  String? title;
  String? content;
  String? author;

  StartModel({
    this.title,
    this.content,
    this.author,
  });

  factory StartModel.fromJson(Map<String, dynamic> json) {
    return StartModel(
        title: json['title'], content: json['content'], author: json['author']);
  }
}
