class Book{

  //Properties
  String title;
  String author;
  double price;

  //Constructor
  Book(this.title,this.author,this.price);

   //Create a method
   double discountedPrice(double discountPercent){
    double discountAmount =price * (discountPercent / 100);
    return price - discountAmount;
   }

   //print their details
   void displayDetails(double newPrice ){
    print("Title:$title");
    print("author:$author");
    print("Orginal Price:${price}");
    print("Discounted Price:$newPrice");
   }


}
void main(){
   //First book object
   Book book1=Book("Math","Nobin",300);
   double newPrice1=book1.discountedPrice(20);
   book1.displayDetails(newPrice1);

   //Second book object
   Book book2=Book("Electric","Rahim",330);
   double newPrice2=book2.discountedPrice(10);
   book2.displayDetails(newPrice2);


}