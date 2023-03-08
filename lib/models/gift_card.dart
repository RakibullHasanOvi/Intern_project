class GiftCard {
  String imgUrl;
  String title;
  String subtitle;

  GiftCard(this.imgUrl, this.subtitle, this.title);

  static List<GiftCard> items() {
    return [
      GiftCard(
        'assets/m_banking_image/Nagad_logo.png',
        'Enter your e-mail address',
        'Amount',
      ),
      GiftCard(
        'assets/m_banking_image/Upai.png',
        'Enter Your e-mail address',
        'Amount',
      ),
    ];
  }
}
