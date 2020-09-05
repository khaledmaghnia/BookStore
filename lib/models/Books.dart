class Books{

  final String bookId;
  final String bookTitle;
  final String uploaderName;
  final String uploaderId;
  final int rating;
  final int categoryId;
  final String bookPDF;
  final String bookCover;
  final String bookDescription;

  Books(this.bookId, this.bookTitle, this.uploaderName, this.uploaderId,
      this.rating, this.categoryId,this.bookPDF, this.bookCover,this.bookDescription);

  Map<String, Object> toJson(){
    return {
      "bookId":bookId,
      "bookTitle":bookTitle,
      "uploaderName":uploaderName,
      "uploaderId":uploaderId,
      "rating":rating,
      "categoryId":categoryId,
      "bookPDF":bookPDF,
      "bookCover":bookCover,
      "bookDescription":bookDescription
    };
  }
}