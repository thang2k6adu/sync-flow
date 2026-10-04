# Mock Data

Dev giao diện mà không cần backend/Firebase.

## Bật/tắt

Trong `.env`:

```env
USE_MOCK_DATA=true   # mock
USE_MOCK_DATA=false  # backend + Firebase thật
```

Đổi giá trị xong phải **restart hẳn app** (không phải hot reload) vì `.env` chỉ được load lúc khởi động.

## Cách hoạt động

Switch nằm ở tầng gọi API, `ApiService` (`get/post/put/patch/delete`). Khi `ApiConstants.useMockData` bật,
`ApiService` không gọi Dio mà chuyển `(method, path, data, query)` sang `MockApiRouter`. Router trả về JSON
giống hệt response backend (`{ error, code, message, data, traceId }`), nên datasource, repository, usecase,
UI giữ nguyên và `ApiResponse.fromJson` chạy bình thường.

Login còn đi qua Firebase trước khi gọi `/auth/firebase/login`, nên `FirebaseAuthService` cũng có switch
tương tự (trả idToken giả từ `AuthMock`, không khởi tạo Firebase trong `main.dart`).

## Files

```
lib/data/mocks/
├── mock_api_router.dart     # method + path -> handler; route chưa có mock sẽ throw
├── mock_api_response.dart   # mockSuccess(), mockPaginated()
├── auth_mock.dart           # /auth/* + giả lập FirebaseAuthService
├── user_mock.dart           # /users/*
└── task_mock.dart           # /tasks (CRUD, phân trang, search, filter status)
```

## Hành vi

- Mỗi request có delay 400ms để thấy loading state.
- Login/Register chấp nhận mọi email + password. `error@test.com` luôn lỗi (đăng nhập: sai thông tin,
  đăng ký: email đã tồn tại) để test màn hình lỗi.
- Google Sign-In thành công ngay, user là `google.user@example.com`.
- User và task giữ trong bộ nhớ: update profile, create/update/delete task có hiệu lực tới khi restart app.
- Gọi route chưa có mock sẽ ném `Mock chưa có route: METHOD /path`.

## Thêm mock cho API mới

1. Tạo `xxx_mock.dart` trả `mockSuccess(data: {...})` (hoặc `mockPaginated`) đúng format backend.
2. Đăng ký route trong `mock_api_router.dart`.
3. Muốn test lỗi thì `throw Exception('message')`, giống `ApiService` thật khi backend trả lỗi.
