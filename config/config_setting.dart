abstract class AppSetting {
  static const int timeloading = 300;
  static const int timeanimation = 400;
  static const int timehideloading = 500;

  static const double sizetextsmall = 11;
  static const double sizetextnormal = 14;
  static const double sizeletterspacing = 0.5;
  static const double sizeheight = 1.4;

  static const String dbname = "inidb10.db";
  static const int dbversion = 1;

  static const String tableuser = "userprofile";
  static const String tablehotel = "hotel";

  static const String query_create_table_user = """
        CREATE TABLE userprofile(
          id TEXT PRIMARY KEY, 
          name TEXT, 
          username TEXT,
          password TEXT
        )
      """;

  static const String query_create_table_hotel = """
        CREATE TABLE hotel(
          id TEXT PRIMARY KEY, 
          name TEXT, 
          tipe TEXT,
          alamat TEXT,
          bookmark TEXT,
          harga TEXT,
          image TEXT
        )
      """;

  static const String query_delete_table_user =
      "DROP TABLE IF EXISTS userprofile";
  static const String query_delete_table_hotel = "DROP TABLE IF EXISTS hotel";

  static const List<String> listhotel = [
    """
      INSERT INTO hotel VALUES(
        '1',
        'Merlynn Park Hotel',
        'Hotel',
        'Gambir, Jakarta Pusat',
        '0',
        '740.000',
        '
        https://origin.pegipegi.com/jalan/images/pict3M/Y4/Y994224/Y994224145.jpg,
        https://pix10.agoda.net/hotelImages/182137/-1/e8ec413da9213fce9ab4c2b03e22dd41.jpg,
        https://pix10.agoda.net/hotelImages/182137/-1/4eb4d9e47a5299efbd03de1673f03858.jpg
        '
      )
    """,
    """
      INSERT INTO hotel VALUES(
        '2',
        'Silve Oak Ciwidey',
        'Villa',
        'Ciwidey, Bandung',
        '0',
        '614.000',
        '
        https://s-light.tiket.photos/t/01E25EBZS3W0FY9GTG6C42E1SE/t_htl-dskt/tix-hotel/images-web/2020/11/01/4e99fafa-11b3-41f0-af33-91f2f480fc36-1604181120379-b050cafc9f3aa7bcb3a6ec4eca928ce3.jpg,
        https://www.silveroakciwidey.com/wp-content/uploads/2020/01/room_superior2_livingroom.jpg,
        https://www.silveroakciwidey.com/wp-content/uploads/2020/01/room_deluxe_livingroom.jpg
        '
      )
    """,
    """
      INSERT INTO hotel VALUES(
        '3',
        'eL Royale',
        'Hotel',
        'Sumur Bandung, Bandung',
        '0',
        '670.000',
        '
        https://s-light.tiket.photos/t/01E25EBZS3W0FY9GTG6C42E1SE/t_htl-dskt/tix-hotel/images-web/2020/10/31/0855d18c-bcc0-436f-a21a-79a0019c2a7f-1604160228970-29db73f5fb7f3b656bf3fca660ed760d.jpg,
        http://bandung.el-hotels.com/sites/default/files/Condotel-Studio-2.jpg,
        https://whatsnewindonesia.com/bandung/wp-content/uploads/sites/3/2019/02/el-royale-bandung.jpg
        '
      )
    """,
    """
      INSERT INTO hotel VALUES(
        '4',
        'Asyana Kemayoran Jakarta',
        'Hotel',
        'Kemayoran, Jakarta Pusat',
        '0',
        '512.500',
        '
        https://pix10.agoda.net/hotelImages/21935861/-1/bbb707baf978ea5ef4b53f5f7f95e11d.png,
        https://ik.imagekit.io/tvlk/apr-asset/Ixf4aptF5N2Qdfmh4fGGYhTN274kJXuNMkUAzpL5HuD9jzSxIGG5kZNhhHY-p7nw/hotel/asset/67805081-95a2607ad6deb873b9174d6ce8870bc0.png,
        https://www.kayak.co.id/rimg/himg/91/b6/9e/expediav2-56259-6780ab-129738.jpg
        '
      )
    """,
    """
      INSERT INTO hotel VALUES(
        '5',
        'Taman Wisata Mangrove',
        'Villa',
        'Penjaringan, Jakarta Utara',
        '0',
        '250.000',
        '
        https://asset.kompas.com/crops/22YAo4nAhkcQ8dPlqGxm9_uyjY0=/0x0:1999x1333/750x500/data/photo/2022/02/05/61fe7edddd4ee.jpg,
        https://cdn-image.hipwee.com/wp-content/uploads/2019/07/hipwee-mangrove4-750x422.jpg,
        https://pix10.agoda.net/hotelImages/811/8110330/8110330_19082711060080037573.jpg
        '
      )
    """,
  ];
}
