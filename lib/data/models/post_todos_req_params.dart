class PostTodosReqParams {
  List todos = [];

  PostTodosReqParams({required this.todos});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'todos': todos,
    };
  }
}
