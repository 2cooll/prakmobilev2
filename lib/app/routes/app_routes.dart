part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const HOME = '/';
  static const GALLERY = '/gallery';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const PROFILE = '/profile';
  static const PAKETDETAIL = '/paketdetail';
  static const MINI_PAGE = '/mini_page';
  static const MEDIUM_PAGE = '/medium_page';
  static const LARGE_PAGE = '/large_page';
  static const ADMIN = '/admin';
  static const ADMIN_GALLERY = '/admin_gallery';
  static const ADMIN_PAKET = '/admin_paket';
  static const EDIT_PAKET = '/edit_paket';
  static const EDIT_GALLERY = '/edit_gallery';
  static const EDIT_PROFILE = '/edit_profile';

  // ➕ TAMBAHAN
  static const STORAGE_DEMO = '/storage_demo';
   static const LOCATION = '/location';
}
