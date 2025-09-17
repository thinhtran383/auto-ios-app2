#!/bin/bash

# Auto Setup App - Build Script for Jailbreak Devices
# This script builds an IPA that can be installed on jailbroken devices

echo "🚀 Building Auto Setup App for Jailbreak Testing..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "${RED}❌ This script must be run on macOS with Xcode installed${NC}"
    exit 1
fi

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    echo -e "${RED}❌ Xcode is not installed or not in PATH${NC}"
    exit 1
fi

# Project configuration
PROJECT_NAME="AutoSetupApp"
SCHEME_NAME="AutoSetupApp"
CONFIGURATION="Release"
BUILD_DIR="build"
ARCHIVE_PATH="$BUILD_DIR/AutoSetupApp.xcarchive"
IPA_PATH="$BUILD_DIR/AutoSetupApp.ipa"

# Clean previous builds
echo -e "${YELLOW}🧹 Cleaning previous builds...${NC}"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# Build for jailbreak (no code signing required)
echo -e "${YELLOW}🔨 Building for jailbreak device...${NC}"
xcodebuild clean \
    -project "$PROJECT_NAME.xcodeproj" \
    -scheme "$SCHEME_NAME" \
    -configuration "$CONFIGURATION"

xcodebuild archive \
    -project "$PROJECT_NAME.xcodeproj" \
    -scheme "$SCHEME_NAME" \
    -configuration "$CONFIGURATION" \
    -archivePath "$ARCHIVE_PATH" \
    CODE_SIGN_IDENTITY="" \
    CODE_SIGNING_REQUIRED=NO \
    CODE_SIGNING_ALLOWED=NO

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Archive failed${NC}"
    exit 1
fi

# Export IPA
echo -e "${YELLOW}📦 Exporting IPA...${NC}"
xcodebuild -exportArchive \
    -archivePath "$ARCHIVE_PATH" \
    -exportPath "$BUILD_DIR" \
    -exportOptionsPlist exportOptions.plist

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Export failed${NC}"
    exit 1
fi

# Check if IPA was created
if [ -f "$IPA_PATH" ]; then
    echo -e "${GREEN}✅ IPA created successfully: $IPA_PATH${NC}"
    echo -e "${GREEN}📱 File size: $(du -h "$IPA_PATH" | cut -f1)${NC}"
    echo ""
    echo -e "${YELLOW}📋 Next steps:${NC}"
    echo "1. Transfer $IPA_PATH to your jailbroken device"
    echo "2. Install using Filza, Sileo, or Cydia"
    echo "3. Test the app functionality"
    echo "4. If working correctly, send source code to Mac user for proper IPA build"
else
    echo -e "${RED}❌ IPA creation failed${NC}"
    exit 1
fi
