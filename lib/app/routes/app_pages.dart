import 'package:get/get.dart';

import '../data/paket.dart';

// views & bindings kamu yang lain
import '../modules/home/views/home_view.dart';
import '../modules/gallery/views/gallery_view.dart';
import '../modules/login/views/login_view.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/profil/bindings/profil_binding.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/paketdetail/bindings/paketdetail_binding.dart';
import '../modules/paketdetail/views/paketdetail_view.dart';
import '../modules/mini_page/bindings/mini_page_binding.dart';
import '../modules/mini_page/views/mini_page_view.dart';
import '../modules/medium_page/bindings/medium_page_binding.dart';
import '../modules/medium_page/views/medium_page_view.dart';
import '../modules/large_page/bindings/large_page_binding.dart';
import '../modules/large_page/views/large_page_view.dart';
import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/admin_gallery/bindings/admin_gallery_binding.dart';
import '../modules/admin_gallery/views/admin_gallery_view.dart';
import '../modules/admin_paket/bindings/admin_paket_binding.dart';
import '../modules/admin_paket/views/admin_paket_view.dart';
import '../modules/edit_paket/bindings/edit_paket_binding.dart';
import '../modules/edit_paket/views/edit_paket_view.dart';
import '../modules/edit_gallery/bindings/edit_gallery_binding.dart';
import '../modules/edit_gallery/views/edit_gallery_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';

// ➕ Tambahan storage demo
import '../modules/storage_demo/bindings/storage_demo_binding.dart';
import '../modules/storage_demo/views/storage_demo_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = <GetPage>[
    GetPage(name: Routes.HOME, page: () => HomeView()),
    GetPage(name: Routes.GALLERY, page: () => GalleryView()),
    GetPage(name: Routes.LOGIN, page: () => LoginView()),
    GetPage(name: Routes.SIGNUP, page: () => SignUpView()),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: Routes.PAKETDETAIL,
      page: () {
        final paket = Get.arguments as Paket;
        return PaketdetailView(paket: paket);
      },
      binding: PaketdetailBinding(),
    ),
    GetPage(
      name: Routes.MINI_PAGE,
      page: () => MiniPageView(),
      binding: MiniPageBinding(),
    ),
    GetPage(
      name: Routes.MEDIUM_PAGE,
      page: () => MediumPageView(),
      binding: MediumPageBinding(),
    ),
    GetPage(
      name: Routes.LARGE_PAGE,
      page: () => LargePageView(),
      binding: LargePageBinding(),
    ),
    GetPage(
      name: Routes.ADMIN,
      page: () => const AdminView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: Routes.ADMIN_GALLERY,
      page: () => AdminGalleryView(),
      binding: AdminGalleryBinding(),
    ),
    GetPage(
      name: Routes.ADMIN_PAKET,
      page: () => AdminPaketView(),
      binding: AdminPaketBinding(),
    ),
    GetPage(
      name: Routes.EDIT_PAKET,
      page: () => EditPaketView(),
      binding: EditPaketBinding(),
    ),
    GetPage(
      name: Routes.EDIT_GALLERY,
      page: () => EditGalleryView(),
      binding: EditGalleryBinding(),
    ),
    GetPage(
      name: Routes.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),

    // ➕ Route baru demo storage
 GetPage(
  name: Routes.STORAGE_DEMO,
  page: () => const StorageDemoView(),
  binding: StorageDemoBinding(),
),
  ];
}
