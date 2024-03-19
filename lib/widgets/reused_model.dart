class OnboardContent {
  String image;
  String title;
  OnboardContent({required this.image, required this.title});
}

List<OnboardContent> contents = [
  OnboardContent(
    image: 'images/screen1.png',
    title: 'Select from Our Best Menu.',
  ),
  OnboardContent(
    image: 'images/screen2.png',
    title: 'Easy and Online Payment',
  ),
  OnboardContent(
    image: 'images/screen3.png',
    title: 'Quick Delivery.',
  ),
];
