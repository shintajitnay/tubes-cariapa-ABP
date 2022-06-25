class ProdukModel {
  String id;
  String name;
  String tipe;
  String alamat;
  bool bookmark;
  String harga;
  List<String> image;

  ProdukModel({
    this.id = "",
    this.name = "",
    this.tipe = "",
    this.alamat = "",
    this.bookmark = false,
    this.harga = "0",
    required this.image,
  });
}
