class Images {
  String id;
  String image;

  Images(this.id, this.image);

  static List<Images> getImages(){
    return <Images>[
      Images("Other", 'assets/pc.png'),
      Images("Google", 'assets/search.png'),
      Images("Gmail", 'assets/gmail.png'),
      Images("Twitter", 'assets/twitter.png'),
      Images("FaceBook", 'assets/facebook.png'),
      Images("GitHub", 'assets/github-logo.png'),
      Images("Private", 'assets/padlock.png'),
      Images("Instagram", 'assets/instagram.png'),
      Images("Credit Card", 'assets/credit.png')
    ];
  }
}
