class OnboardContent {
  String image;
  String title;
  String description;
  OnboardContent(
      {required this.image, required this.title, required this.description});
}

List<OnboardContent> contents = [
  OnboardContent(
      image: 'images/screen1.png',
      title: 'Select from Our Best Menu',
      description:
          'Pick your food from our menu\n           More than 35 items'),
  OnboardContent(
      image: 'images/screen2.png',
      title: 'Easy and Online Payment',
      description:
          'You can pay cash on delivery and\n        Card payment is available'),
  OnboardContent(
      image: 'images/screen3.png',
      title: 'Quick Delivery at Your Doorstep',
      description: 'Deliver your food at your Doorstep'),
];
