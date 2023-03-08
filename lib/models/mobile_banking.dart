class MobileBanking {
  String imgUrl;
  double height;
  double width;
  String label;

  MobileBanking(this.imgUrl, this.height, this.width, this.label);

  static List<MobileBanking> generateItem() {
    return [
      MobileBanking(
          "assets/m_banking_image/bKash_logo.png", 200, 200, "bKash Number"),
      MobileBanking(
          "assets/m_banking_image/Nagad_logo.png", 180, 180, "Nagad Number"),
      MobileBanking(
          "assets/m_banking_image/Group 197.png", 180, 180, "Rocket Number"),
      MobileBanking(
          "assets/m_banking_image/Group 199.png", 180, 180, "Upai Number"),
      MobileBanking("assets/m_banking_image/tap.png", 20, 20, "tap Number"),
      MobileBanking(
          "assets/m_banking_image/Group 196.png", 180, 180, "M Cash Number"),
      MobileBanking(
          "assets/m_banking_image/Group-271.png", 180, 180, "SureCash Number"),
    ];
  }
}
