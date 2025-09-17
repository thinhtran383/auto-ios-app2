# Hướng dẫn đẩy repo lên Git

## 🚀 Cách 1: Sử dụng GitHub Desktop (Khuyến nghị cho Windows)

### Bước 1: Cài đặt GitHub Desktop
1. Tải về: https://desktop.github.com/
2. Cài đặt và đăng nhập GitHub account

### Bước 2: Tạo repository
1. Mở **GitHub Desktop**
2. **File** → **New Repository**
3. Điền thông tin:
   ```
   Name: auto-ios-app2
   Description: Auto Setup iOS App - iPhone Settings Automation
   Local path: G:\auto-ios-app2
   Initialize with README: ❌ (không tick vì đã có file)
   ```

### Bước 3: Add files và commit
1. GitHub Desktop sẽ hiện tất cả files
2. Add commit message: "Initial commit: Auto Setup iOS App"
3. Click **Commit to main**

### Bước 4: Publish to GitHub
1. Click **Publish repository**
2. Chọn **Public** hoặc **Private**
3. Click **Publish Repository**

## 🚀 Cách 2: Sử dụng Git Command Line

### Bước 1: Cài đặt Git
1. Tải về: https://git-scm.com/download/win
2. Cài đặt với default settings

### Bước 2: Mở Command Prompt/PowerShell
```cmd
cd G:\auto-ios-app2
```

### Bước 3: Khởi tạo Git repository
```bash
git init
git add .
git commit -m "Initial commit: Auto Setup iOS App"
```

### Bước 4: Tạo repository trên GitHub
1. Vào https://github.com
2. Click **New repository**
3. Điền thông tin:
   ```
   Repository name: auto-ios-app2
   Description: Auto Setup iOS App - iPhone Settings Automation
   Public/Private: Chọn theo ý muốn
   ```

### Bước 5: Connect và push
```bash
git remote add origin https://github.com/[YOUR_USERNAME]/auto-ios-app2.git
git branch -M main
git push -u origin main
```

## 🚀 Cách 3: Sử dụng Visual Studio Code

### Bước 1: Mở project trong VS Code
```bash
code G:\auto-ios-app2
```

### Bước 2: Sử dụng Source Control
1. Click **Source Control** icon (Ctrl+Shift+G)
2. Click **Initialize Repository**
3. Add commit message
4. Click **Commit**

### Bước 3: Publish to GitHub
1. Click **Publish to GitHub**
2. Chọn **Public** hoặc **Private**
3. Click **Publish**

## 📋 Repository Information

### Tên repository đề xuất:
```
auto-ios-app2
```

### Description:
```
Auto Setup iOS App - iPhone Settings Automation

A complete iOS app that simulates iPhone settings automation flow:
1. Settings → General → Language & Region → Region → Japan
2. App restart simulation
3. General → Date & Time → Auto timezone off → Tokyo timezone
4. Privacy → Location Services → Turn off location services

Features:
- Complete iOS Settings UI simulation
- Auto setup flow with notifications
- Jailbreak build support
- Production build ready
- Comprehensive documentation
```

### Tags:
```
ios, swift, xcode, settings, automation, jailbreak, ipa, mobile
```

## 📁 Files sẽ được upload:

```
auto-ios-app2/
├── AutoSetupApp.xcodeproj/
│   └── project.pbxproj
├── AutoSetupApp/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   ├── AutoSetupManager.swift
│   ├── MainSettingsViewController.swift
│   ├── GeneralSettingsViewController.swift
│   ├── LanguageRegionViewController.swift
│   ├── RegionSelectionViewController.swift
│   ├── DateTimeViewController.swift
│   ├── PrivacyViewController.swift
│   ├── LocationServicesViewController.swift
│   ├── Main.storyboard
│   ├── LaunchScreen.storyboard
│   ├── Info.plist
│   └── Assets.xcassets/
├── README.md
├── JAILBREAK-TESTING.md
├── MAC-USER-INSTRUCTIONS.md
├── GIT-SETUP.md
├── build-jailbreak.sh
├── exportOptions.plist
└── .gitignore
```

## 🔒 Repository Settings

### Public vs Private:
- **Public**: Ai cũng có thể xem và clone
- **Private**: Chỉ bạn và collaborators có thể xem

### Khuyến nghị: **Public** (vì đây là demo project)

## 📝 Commit Messages

### Initial commit:
```
Initial commit: Auto Setup iOS App

- Complete iOS Settings UI simulation
- Auto setup flow with notifications
- Jailbreak build support
- Production build ready
- Comprehensive documentation
```

### Future commits:
```
Add new feature: [Feature name]
Fix bug: [Bug description]
Update documentation: [What was updated]
```

## 🚀 Sau khi upload

### Share repository:
```
https://github.com/[YOUR_USERNAME]/auto-ios-app2
```

### Clone instructions cho Mac user:
```bash
git clone https://github.com/[YOUR_USERNAME]/auto-ios-app2.git
cd auto-ios-app2
open AutoSetupApp.xcodeproj
```

## ⚠️ Lưu ý

1. **Không upload** file `.ipa` (quá lớn)
2. **Không upload** `build/` folder
3. **Không upload** `DerivedData/` folder
4. **Đảm bảo** `.gitignore` đã được tạo

---

**Happy Coding! 🚀**
