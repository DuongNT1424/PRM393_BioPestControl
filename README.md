# BioPestControl — Mobile App for an Agricultural Supply Store

A Flutter app for a store that sells biological pesticides, fertilizers and crop supplements. Customers browse products, order and pay online, chat with staff, check chemical safety information and find nearby stores. Admin and Staff manage the catalog, stock, orders and customers from the same app.

Final project for **PRM393 (Mobile Programming)**, FPT University, May – Jul 2026. Team of 5. The original team repository is private; this is my copy.

## Features

**Customer**

- **Account.** Register and log in with email/password or Google Sign-In (Firebase Auth); reset a forgotten password by email; edit profile and change password.
- **Shopping.** Browse products by category, view product details, manage the cart and apply discount codes.
- **Checkout and payment.** Place orders and pay through **payOS** (payment links signed with HMAC-SHA256); track order history and order details.
- **Chat with staff.** Real-time messaging backed by Cloud Firestore listeners, with chat search and message deletion.
- **Chemical safety.** Look up, search and filter safety information for agricultural chemicals.
- **Store map.** View stores on an OpenStreetMap map, search a location (Nominatim), see nearby stores and get a driving route (OSRM).
- **News, notifications and feedback.** Read news posts, receive notifications and send product feedback.

**Admin and Staff**

- **Dashboard.** Sales statistics with charts (`fl_chart`).
- **Catalog and stock.** Manage products, categories, discounts and warehouse stock.
- **Orders.** Review and update customer orders.
- **People.** Manage customers and staff accounts.
- **Content.** Publish news, send notifications, and create, edit or delete chemical safety records (Admin).

## Architecture

The app follows **Clean Architecture** with one folder per feature, each split into three layers:

```
lib/
├── app/            App widget and theme
├── core/           DI container (get_it), local database, errors, base use case
├── features/       19 features: auth, product, cart, order, payment, chat, map, chemical…
│   └── <feature>/
│       ├── data/           Data sources (Firebase, SQLite, HTTP), models, repository implementations
│       ├── domain/         Entities, repository interfaces, use cases
│       └── presentation/   BLoC, pages, widgets
└── shared/         Shared widgets
```

- **State management:** BLoC (`flutter_bloc`) with `equatable`.
- **Dependency injection:** `get_it`.
- **Error handling:** use cases return `Either<Failure, T>` (`dartz`).
- **Data:** Cloud Firestore for users, orders, chat, notifications, feedback and chemicals; SQLite (`sqflite`) for the product catalog, categories, discounts, warehouse and statistics, seeded on first launch.

## Tech stack

| Area | Technology |
|---|---|
| Framework | Flutter, Dart |
| State and DI | flutter_bloc, equatable, get_it, dartz |
| Backend services | Firebase Auth, Cloud Firestore, Google Sign-In |
| Local storage | sqflite |
| Payments | payOS |
| Maps | flutter_map, OpenStreetMap, Nominatim, OSRM, geolocator |
| UI | flutter_screenutil, google_fonts, flutter_svg, fl_chart |

## Getting started

**Requirements:** Flutter SDK (Dart 3), Android Studio or VS Code, an Android emulator or device.

```bash
git clone https://github.com/DuongNT1424/PRM393_BioPestControl.git
cd PRM393_BioPestControl
git checkout dev
flutter pub get
flutter run
```

- **Firebase.** The app reads `android/app/google-services.json`. To use your own Firebase project, enable Email/Password and Google sign-in in Firebase Auth, create a Firestore database, and replace that file (or run `flutterfire configure`).
- **payOS.** Fill in `clientId`, `apiKey` and `checksumKey` in `lib/features/order/data/datasources/payos_service.dart` with keys from your payOS merchant account. Payment does not work without them.

The latest code is on the **`dev`** branch.

## Team

| Member (GitHub) | Area |
|---|---|
| BienHuynh-code — Huynh Le Cong Bien | Project owner. Authentication, products, cart, orders and payOS, discounts, notifications, feedback, statistics |
| [DuongNT1424](https://github.com/DuongNT1424) — Nguyen Thai Duong | Chemical safety management, real-time chat, store map and directions |
| Tlaphu | News |
| BmrgRocker | Product |
| Baonguyen | Feedback |

### My contributions — DuongNT1424

- **Chemical safety:** list, search and filter for every role; create, edit and delete for Admin; detail and form pages; data in Firestore.
- **Real-time chat:** chat list and conversation pages; send, search and delete messages; live updates through Firestore `snapshots()`.
- **Store map:** OpenStreetMap view with `flutter_map`, location search with Nominatim, nearby stores, and driving directions with OSRM.
- Each feature is built in all three Clean Architecture layers: data source, repository, use cases, BLoC and UI.
- Resolved merge conflicts when integrating these features into `dev`.

<details>
<summary>Tiếng Việt</summary>

**BioPestControl** là ứng dụng Flutter cho cửa hàng vật tư nông nghiệp (thuốc trừ sâu sinh học, phân bón). Khách hàng xem sản phẩm, đặt hàng, thanh toán qua payOS, chat với nhân viên, tra cứu an toàn hóa chất và tìm cửa hàng gần nhất. Admin và Staff quản lý sản phẩm, kho, đơn hàng, khách hàng, tin tức và thông báo. Đồ án môn PRM393, Đại học FPT, nhóm 5 người (05 – 07/2026).

**Phần mình phụ trách (DuongNT1424):** quản lý an toàn hóa chất (xem, tìm kiếm, lọc; Admin thêm, sửa, xóa), chat thời gian thực bằng Firestore, bản đồ cửa hàng (tìm địa điểm, cửa hàng gần đây, chỉ đường). Mỗi tính năng làm đủ 3 tầng Clean Architecture với BLoC.

</details>
