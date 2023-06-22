class Question{
  //every question have id
  final String id;
  //every question have title
  final String title;
  //every question have option
  final Map<String,bool> options;

  //create the constructor
  Question({
     required this.id,
     required this.title,
     required this.options,
  });

  @override
  String toString(){
    return 'Question(id:$id,title:$title,options:$options)';
  }
}