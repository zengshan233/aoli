
enum ResearchType{
  comment,
  week,
  research
}



class RearchModel {
  final String title;
  final String description;
  final String date;
  final String pic;
  final String pdfUrl;
  RearchModel({this.title, this.description, this.date, this.pic, this.pdfUrl});
}
