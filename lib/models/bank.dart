class Bank {
  String imgUrl;
  String label;

  Bank(this.imgUrl, this.label);

  static List<Bank> samples() {
    return [
      Bank("assets/bank_image/dbbl-new.png", "Datch bangla Bank Ltd."),
      Bank("assets/bank_image/city-bank-logo.png", "City Bank Ltd."),
      Bank("assets/bank_image/islami_bank.png", "Islami Bank bangladesh Ltd."),
      Bank("assets/bank_image/ucb_logo.png", "UCB Bank Ltd."),
      Bank("assets/bank_image/EBL-Logo.png", "Eastern Bank Ltd."),
      Bank("assets/bank_image/brack_logo.png", "Brack Bank Ltd."),
      Bank("assets/bank_image/one_bank_logo.png", "One Bank Ltd."),
      Bank("assets/bank_image/mutual_trust_logo.png", "MTB Bank Ltd."),
      Bank("assets/bank_image/exim-bank.png", "EXIM Bank Ltd."),
      Bank("assets/bank_image/prime_bank.png", "Prime Bank Ltd."),
      Bank("assets/bank_image/rebranding-img-new.png", "AB Bank Ltd."),
      Bank("assets/bank_image/asia_bank_logo.png", "Asia Bank Ltd."),
    ];
  }
}
