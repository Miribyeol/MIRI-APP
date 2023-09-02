class MainViewModel {
  int challengerStep;
  List<Emotion> emotions;
  List<Post> posts;

  MainViewModel({
    required this.challengerStep,
    required this.emotions,
    required this.posts,
  });
}

class Emotion {
  String emotion;
  int count;

  Emotion({
    required this.emotion,
    required this.count,
  });
}

class Post {
  String title;
  String content;
  String author;

  Post({
    required this.title,
    required this.content,
    required this.author,
  });
}
