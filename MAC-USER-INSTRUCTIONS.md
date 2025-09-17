# Hướng dẫn cho Mac User

Hướng dẫn chi tiết cho người dùng Mac để build IPA hợp pháp cho iPhone bình thường.

## 📋 Yêu cầu

- **macOS** với Xcode 15.0+
- **Apple Developer Account** ($99/năm)
- **iPhone/iPad** (không cần jailbreak)
- **USB cable** để kết nối device

## 🚀 Bước 1: Chuẩn bị

### 1.1 Cài đặt Xcode
```bash
# Từ App Store hoặc Apple Developer
# Xcode 15.0+ required
```

### 1.2 Cấu hình Apple Developer Account
1. Mở **Xcode** → **Preferences** → **Accounts**
2. Thêm Apple ID của bạn
3. Download certificates và provisioning profiles

## 📁 Bước 2: Mở Project

### 2.1 Mở Xcode Project
```bash
# Double-click file này
AutoSetupApp.xcodeproj
```

### 2.2 Cấu hình Project Settings
1. Chọn project **AutoSetupApp** (root level)
2. Chọn target **AutoSetupApp**
3. Vào tab **Signing & Capabilities**

### 2.3 Cấu hình Code Signing
```
Team: [Your Apple Developer Team]
Bundle Identifier: com.yourcompany.AutoSetupApp
Signing Certificate: Apple Development
Provisioning Profile: Automatic
```

## 🔧 Bước 3: Build và Archive

### 3.1 Chọn Device
1. Chọn **iPhone** hoặc **iPad** từ device list
2. Đảm bảo device đã kết nối qua USB

### 3.2 Build Project
1. **Product** → **Clean Build Folder** (⌘+Shift+K)
2. **Product** → **Build** (⌘+B)
3. Kiểm tra không có errors

### 3.3 Archive
1. **Product** → **Archive**
2. Chờ quá trình build hoàn tất
3. **Organizer** sẽ mở tự động

## 📦 Bước 4: Export IPA

### 4.1 Trong Organizer
1. Chọn archive vừa tạo
2. Click **Distribute App**

### 4.2 Chọn Distribution Method
```
Development: Để test trên device cụ thể
Ad Hoc: Để test trên nhiều device
App Store: Để upload lên App Store
Enterprise: Cho enterprise distribution
```

**Chọn "Development" cho testing**

### 4.3 Export Options
```
✅ Rebuild from Bitcode: No
✅ Strip Swift symbols: Yes
✅ Upload symbols: Yes
```

### 4.4 Chọn thư mục lưu
- Chọn thư mục để lưu IPA file
- File sẽ có tên: `AutoSetupApp.ipa`

## 📱 Bước 5: Install trên Device

### 5.1 Kết nối Device
1. Kết nối iPhone/iPad qua USB
2. Trust computer trên device
3. Mở **Xcode** → **Window** → **Devices and Simulators**

### 5.2 Install qua Xcode (Khuyến nghị)
1. Chọn device trong **Devices and Simulators**
2. Drag & drop IPA file vào **Installed Apps**
3. Hoặc click **+** và chọn IPA file

### 5.3 Install qua iTunes/Finder
1. Mở **Finder** (macOS Catalina+)
2. Chọn device
3. Drag & drop IPA vào **Files** section

### 5.4 Trust Developer Certificate
1. Trên device: **Settings** → **General** → **VPN & Device Management**
2. Tìm developer certificate của bạn
3. Tap **Trust** → **Trust**

## 🧪 Bước 6: Testing

### 6.1 Launch App
1. Mở app trên device
2. Cho phép notifications
3. Test luồng cài đặt

### 6.2 Test Checklist
- [ ] App launch successfully
- [ ] Main Settings screen
- [ ] Navigation between screens
- [ ] Region selection (Japan)
- [ ] Date/Time settings
- [ ] Location Services toggle
- [ ] Notifications working
- [ ] Auto setup flow complete

## 🐛 Troubleshooting

### Build Errors:
```bash
# Clean build folder
⌘+Shift+K

# Reset derived data
rm -rf ~/Library/Developer/Xcode/DerivedData
```

### Signing Errors:
1. Check Apple Developer Account status
2. Refresh certificates: **Xcode** → **Preferences** → **Accounts** → **Download Manual Profiles**
3. Check Bundle Identifier không trùng

### Install Errors:
1. Check device UDID trong provisioning profile
2. Check iOS version compatibility
3. Restart device và computer

### App Crash:
1. Check device logs trong **Xcode** → **Window** → **Devices and Simulators**
2. Check iOS version >= 15.0
3. Check available storage space

## 📊 Test Results

Ghi lại kết quả test:

```
Test Date: ___________
Device: iPhone ___ (iOS ___)
Build: Development/Ad Hoc

✅ Working Features:
- [ ] App launch
- [ ] UI navigation
- [ ] Region selection
- [ ] Date/Time settings
- [ ] Location services
- [ ] Notifications
- [ ] Auto setup flow

❌ Issues:
- [ ] Issue 1: Description
- [ ] Issue 2: Description

📝 Performance:
- Launch time: ___ seconds
- Memory usage: ___ MB
- Battery impact: Low/Medium/High
```

## 🚀 Production Build

Nếu test thành công, có thể build cho production:

### Ad Hoc Distribution:
1. Thêm device UDIDs vào provisioning profile
2. Build với **Ad Hoc** distribution
3. Distribute cho testers

### App Store:
1. Build với **App Store** distribution
2. Upload qua **Xcode** → **Organizer** → **Distribute App**
3. Submit for review

## 📞 Support

Nếu gặp vấn đề:
1. Check **Xcode** console logs
2. Check device logs
3. Verify Apple Developer Account status
4. Check iOS version compatibility

---

**Happy Building! 🚀**
