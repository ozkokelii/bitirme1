class Hatalar {
  static String goster(String hataKodu) {
    switch (hataKodu) {
      case "email-already-in-use":
        return "Bu mail adresi zaten kullanımda";
      case "user-not-found":
        return "Bu kullanici sistemde bulunmamakta";
      default:
        return "Bir hata oluştu";
    }
  }
}
