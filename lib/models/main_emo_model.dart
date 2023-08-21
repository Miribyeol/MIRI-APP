class MainViewModel {
  final int challengerStep;
  final List<Emotion> emotions;
  final List<Post> posts;

  MainViewModel({
    required this.challengerStep,
    required this.emotions,
    required this.posts,
  });
}

class Emotion {
  final String emotion;
  final int count;

  Emotion({
    required this.emotion,
    required this.count,
  });
}

class Post {
  final String title;
  final String content;
  final String author;

  Post({
    required this.title,
    required this.content,
    required this.author,
  });
}