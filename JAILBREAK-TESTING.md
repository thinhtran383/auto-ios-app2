# Jailbreak Testing Guide

Hướng dẫn build và test Auto Setup App trên máy jailbreak trước khi gửi source cho Mac user.

## 🎯 Mục đích

Test app trên máy jailbreak để:
- Kiểm tra UI/UX hoạt động đúng
- Test luồng auto setup
- Verify notifications
- Đảm bảo không có crash
- Sau đó gửi source cho Mac user build IPA hợp pháp

## 📋 Yêu cầu

### Cho Jailbreak Testing:
- **macOS** với Xcode (để build)
- **Jailbroken iPhone/iPad** (iOS 15.0+)
- **Filza** hoặc **Sileo** để install IPA

### Cho Production Build:
- **Mac** với Xcode
- **Apple Developer Account** ($99/năm)
- **iPhone/iPad bình thường** (không jailbreak)

## 🚀 Build cho Jailbreak

### Bước 1: Chạy build script

```bash
# Make script executable
chmod +x build-jailbreak.sh

# Run build script
./build-jailbreak.sh
```

### Bước 2: Kiểm tra output

Script sẽ tạo:
```
build/
├── AutoSetupApp.xcarchive
└── AutoSetupApp.ipa
```

### Bước 3: Transfer IPA to device

#### Cách 1: AirDrop (Khuyến nghị)
1. AirDrop file `build/AutoSetupApp.ipa` từ Mac sang iPhone
2. Mở file trên iPhone
3. Install bằng Filza

#### Cách 2: USB Transfer
1. Copy IPA vào iPhone qua iTunes/Finder
2. Mở Filza → On My iPhone
3. Tap vào IPA file → Install

#### Cách 3: SSH/SCP
```bash
# Copy via SSH (if SSH enabled on jailbreak)
scp build/AutoSetupApp.ipa root@[DEVICE_IP]:/var/mobile/Documents/
```

## 📱 Install trên Jailbreak Device

### Sử dụng Filza:
1. Mở **Filza**
2. Navigate đến thư mục chứa IPA
3. Tap vào `AutoSetupApp.ipa`
4. Chọn **Install**
5. Chờ install hoàn tất

### Sử dụng Sileo:
1. Mở **Sileo**
2. Tap **Sources** → **+** → Add IPA file
3. Install từ source

### Sử dụng Cydia:
1. Copy IPA vào `/var/mobile/Documents/`
2. Mở **Terminal** trên device
3. Chạy: `dpkg -i AutoSetupApp.ipa`

## 🧪 Testing Checklist

### ✅ UI Testing:
- [ ] App launch successfully
- [ ] Main Settings screen hiển thị đúng
- [ ] Navigation giữa các màn hình smooth
- [ ] TableView cells hiển thị đúng
- [ ] Icons và text đúng

### ✅ Functionality Testing:
- [ ] Settings → General → Language & Region → Region → Japan
- [ ] Region selection hoạt động
- [ ] App restart simulation
- [ ] General → Date & Time → Toggle auto timezone
- [ ] Timezone selection (Tokyo)
- [ ] Privacy → Location Services → Toggle location
- [ ] Notifications hiển thị đúng

### ✅ Auto Setup Flow:
- [ ] First launch: Notification hướng dẫn setup
- [ ] After region selection: Restart notification
- [ ] Second launch: Continue setup notification
- [ ] Setup completion: Success message

### ✅ Edge Cases:
- [ ] App không crash khi force close
- [ ] Memory usage ổn định
- [ ] Battery usage bình thường
- [ ] Không có memory leaks

## 🐛 Troubleshooting

### App không install được:
```bash
# Check device compatibility
dpkg --print-architecture

# Force install
dpkg -i --force-all AutoSetupApp.ipa
```

### App crash khi mở:
1. Check iOS version compatibility (>= 15.0)
2. Check available storage space
3. Restart device
4. Reinstall app

### Notifications không hiện:
1. Check notification permissions
2. Settings → Notifications → Auto Setup
3. Restart app

## 📊 Test Results

Sau khi test, ghi lại kết quả:

```
Test Date: ___________
Device: iPhone ___ (iOS ___)
Jailbreak: _________

✅ Working Features:
- [ ] Main UI
- [ ] Navigation
- [ ] Region selection
- [ ] Date/Time settings
- [ ] Location services
- [ ] Notifications
- [ ] Auto setup flow

❌ Issues Found:
- [ ] Issue 1: Description
- [ ] Issue 2: Description

📝 Notes:
- Performance: Good/Fair/Poor
- UI/UX: Good/Fair/Poor
- Stability: Good/Fair/Poor
```

## 📤 Gửi Source cho Mac User

Sau khi test thành công, gửi source code cho Mac user:

### Files cần gửi:
```
AutoSetupApp/
├── AutoSetupApp.xcodeproj/
├── AutoSetupApp/
├── README.md
├── .gitignore
└── JAILBREAK-TESTING.md (optional)
```

### Instructions cho Mac User:
1. Mở `AutoSetupApp.xcodeproj` trong Xcode
2. Cấu hình Apple Developer Account
3. Build và Archive
4. Export IPA với proper code signing
5. Install trên iPhone bình thường

## ⚠️ Lưu ý quan trọng

- **Jailbreak build**: Không cần code signing, có thể install trên jailbreak device
- **Production build**: Cần Apple Developer Account và proper code signing
- **App chỉ mô phỏng Settings UI**, không thực sự thay đổi system settings
- **Test kỹ trước khi gửi source** để tránh lãng phí thời gian Mac user

---

**Happy Testing! 🧪**
