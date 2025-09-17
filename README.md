# Auto Setup iOS App

Ứng dụng iOS mô phỏng luồng cài đặt tự động cho iPhone với các bước:

1. **Cài đặt → Cài đặt chung → Ngôn ngữ và vùng → Vùng → Nhật Bản**
2. **Sau khi khởi động máy, trigger app một lần nữa**
3. **Trở lại cài đặt chung → Ngày và giờ → Tắt đặt tự động múi giờ → Múi giờ: Tokyo**
4. **Trở lại Cài đặt chung → Trở lại cài đặt → Quyền riêng tư → Dịch vụ định vị → Tắt dịch vụ định vị**

## Tính năng

- ✅ Mô phỏng giao diện Settings của iOS
- ✅ Luồng cài đặt tự động với notifications
- ✅ Quản lý trạng thái setup qua UserDefaults
- ✅ Hỗ trợ Location Services và Timezone settings
- ✅ UI/UX giống iOS Settings app

## Cấu trúc dự án

```
AutoSetupApp/
├── AppDelegate.swift                    # App lifecycle management
├── SceneDelegate.swift                  # Scene management
├── AutoSetupManager.swift              # Auto setup logic & notifications
├── MainSettingsViewController.swift     # Main settings screen
├── GeneralSettingsViewController.swift  # General settings
├── LanguageRegionViewController.swift   # Language & Region settings
├── RegionSelectionViewController.swift  # Region selection
├── DateTimeViewController.swift         # Date & Time settings
├── PrivacyViewController.swift          # Privacy settings
├── LocationServicesViewController.swift # Location Services settings
├── Main.storyboard                     # Main storyboard
├── LaunchScreen.storyboard             # Launch screen
├── Info.plist                          # App configuration
└── Assets.xcassets/                    # App icons and assets
```

## Hướng dẫn Build IPA

### Yêu cầu

- **macOS** với Xcode 15.0+
- **Apple Developer Account** ($99/năm)
- **iOS Device** để test (không cần jailbreak)

### Bước 1: Mở dự án

1. Mở file `AutoSetupApp.xcodeproj` trong Xcode
2. Chọn target device (iPhone/iPad)

### Bước 2: Cấu hình Signing

1. Chọn project → Target "AutoSetupApp"
2. Vào tab "Signing & Capabilities"
3. Chọn Team của bạn (Apple Developer Account)
4. Bundle Identifier: `com.autosetup.AutoSetupApp` (hoặc thay đổi theo team của bạn)

### Bước 3: Build và Archive

1. Chọn **Product → Archive**
2. Chờ quá trình build hoàn tất
3. Trong Organizer, chọn **Distribute App**
4. Chọn **Development** (để test trên device)
5. Chọn **Export** và chọn thư mục lưu

### Bước 4: Install trên Device

#### Cách 1: Xcode (Khuyến nghị)
1. Kết nối iPhone/iPad qua USB
2. Chọn device trong Xcode
3. Nhấn **Run** (▶️) để build và install

#### Cách 2: IPA File
1. Sử dụng **Apple Configurator 2** hoặc **3uTools**
2. Drag & drop file IPA vào device
3. Trust developer certificate trong Settings → General → VPN & Device Management

### Bước 5: Test App

1. Mở app trên device
2. Cho phép notifications khi được hỏi
3. Follow luồng cài đặt:
   - Settings → General → Language & Region → Region → Japan
   - Restart app
   - General → Date & Time → Tắt auto timezone → Chọn Tokyo
   - Privacy → Location Services → Tắt location services

## Luồng hoạt động

### Lần đầu mở app:
1. App request notification permission
2. Hiển thị notification hướng dẫn setup
3. User navigate: Settings → General → Language & Region → Region → Japan

### Sau khi chọn Japan:
1. App lưu region selection
2. Hiển thị thông báo "App restart required"
3. User restart app

### Lần thứ 2 mở app:
1. App detect đã set region
2. Hiển thị notification tiếp tục setup
3. User navigate: General → Date & Time → Privacy → Location Services

### Hoàn thành:
1. App mark setup complete
2. Hiển thị thông báo hoàn thành

## Troubleshooting

### Lỗi Signing
- Đảm bảo Apple Developer Account còn hạn
- Check Bundle Identifier không trùng với app khác
- Refresh certificates trong Xcode

### App không install được
- Check device đã trust developer certificate
- Đảm bảo iOS version >= 15.0
- Thử restart device

### Notifications không hiện
- Check Settings → Notifications → Auto Setup
- Đảm bảo app có permission notifications

## Customization

### Thay đổi Bundle ID
```swift
// Trong project settings
PRODUCT_BUNDLE_IDENTIFIER = com.yourcompany.AutoSetupApp
```

### Thay đổi App Name
```swift
// Trong Info.plist
CFBundleDisplayName = "Your App Name"
```

### Thêm regions khác
```swift
// Trong RegionSelectionViewController.swift
private let regions = [
    Region(name: "Your Country", code: "XX", flag: "🇺🇸"),
    // ...
]
```

## Lưu ý quan trọng

⚠️ **App này chỉ mô phỏng giao diện Settings, không thực sự thay đổi system settings của iOS**

⚠️ **Để thay đổi thực sự system settings, cần sử dụng Configuration Profiles hoặc MDM**

⚠️ **App này chỉ dành cho mục đích demo và testing**

## Support

Nếu gặp vấn đề, hãy check:
1. Xcode version compatibility
2. iOS deployment target
3. Code signing configuration
4. Device compatibility

---

**Happy Coding! 🚀**
