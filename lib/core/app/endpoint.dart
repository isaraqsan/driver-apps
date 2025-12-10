class Endpoint {
  //* Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String profile = '/app/resource';
  static const String verify = '/auth/verify';
  static const String approval = '/auth/approval';

  //* Program
  static const String program = '/program';

  //* Promotion Outlet
  static const String promotionOutlet = '/outlet';
  static const String promotionOutletFilled = '/outlet/filled';
  static const String promotionOutletNotFilled = '/outlet/not-filled';
  static const String promotionOutletTransaction = '/transaction';

  //* Area
  static const String areaProvince = '/area/province';
  static const String areaRegency = '/area/regency';
  static const String areaSubArea = '/area/sub-area';
  static const String areaSubDistrict = '/area/subdistrict';
  static const String areaVillage = '/area/village';

  //* Global
  static const String globalBrand = '/global/brand';
  static const String globalDisplayType = '/global/display-type';
  static const String globalChannel = '/global/channel';
  static const String globalSubChannel = '/global/sub-channel';

  // * OSM
  static const String baseUrlOsmLocation =
      'https://nominatim.openstreetmap.org';

  // * Articles
  static const String articles = '/forum/article';
  static const String articlesTrending = '/fe/trending-article';
  static const String likeArticle = '/forum/like';

  // * Profile
  static const String updateProfile = '/app/resource';
  static const String listApproval = '/app/resource/list-approval';

  // * Announcment
  static const String announcement = '/fe/announcement';

  // * Jabatan
  static const String jenjang = '/master/jenjang/all-data';
  static const String jabatan = '/master/jabatan/all-data';
  static const String jabatanByJenjang = '/master/jabatan-by-jenjang';

  // * Notification
  static const String notification = '/notif';

  // * Comment
  static const String comment = '/fe/comment';
  static const String commentCreate = '/forum/comment';

  // * Member Card
  static const String memberCard = '/fe/resource/generate-card';
}
