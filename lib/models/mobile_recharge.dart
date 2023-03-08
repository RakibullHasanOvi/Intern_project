class MobileRecharge {
  String imgUrl;
  String label;
  String sceondlabel;

  MobileRecharge(this.imgUrl, this.label, this.sceondlabel);

  static List<MobileRecharge> items() {
    return [
      MobileRecharge(
        "assets/m_recharge_image/gp.png",
        "Mobile Number",
        "Amount",
      ),
      MobileRecharge(
        "assets/m_recharge_image/airtel.png",
        "Mobile Number",
        "Amount",
      ),
      MobileRecharge(
        "assets/m_recharge_image/banglalink.png",
        "Mobile Number",
        "Amount",
      ),
      MobileRecharge(
        "assets/m_recharge_image/robi.png",
        "Mobile Number",
        "Amount",
      ),
      MobileRecharge(
        "assets/m_recharge_image/TeleTalk-Logo.png",
        "Mobile Number",
        "Amount",
      )
    ];
  }
}
