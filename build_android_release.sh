#!/bin/bash

# NMMC  - Android Release Build Script
# This script automates the Android build process for release deployment

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  NMMC - Android Build Script${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    echo -e "${RED}Error: pubspec.yaml not found!${NC}"
    echo "Please run this script from the project root directory."
    exit 1
fi

# Resolve project root as an absolute path
PROJECT_ROOT="$(cd "$(dirname "$0")" && pwd)"
KEY_PROPS="$PROJECT_ROOT/android/key.properties"

# Setup Java - Force set JAVA_HOME for this session
echo -e "${GREEN}Setting up Java environment...${NC}"

# Always try Android Studio's bundled JDK first (most reliable on macOS)
if [ -d "/Applications/Android Studio.app/Contents/jbr/Contents/Home" ]; then
    export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
    export PATH="$JAVA_HOME/bin:$PATH"
    echo -e "${GREEN}Using Android Studio bundled JDK${NC}"
elif [ -d "/Applications/Android Studio.app/Contents/jre/Contents/Home" ]; then
    export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/Contents/Home"
    export PATH="$JAVA_HOME/bin:$PATH"
    echo -e "${GREEN}Using Android Studio bundled JRE${NC}"
elif [ -d "/opt/homebrew/opt/openjdk@17" ]; then
    export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
    export PATH="$JAVA_HOME/bin:$PATH"
    echo -e "${GREEN}Using Homebrew OpenJDK 17${NC}"
elif [ -d "/usr/local/opt/openjdk@17" ]; then
    export JAVA_HOME="/usr/local/opt/openjdk@17"
    export PATH="$JAVA_HOME/bin:$PATH"
    echo -e "${GREEN}Using Homebrew OpenJDK 17 (Intel)${NC}"
else
    echo -e "${RED}Error: No JDK found!${NC}"
    echo "Please install Java 17 or set JAVA_HOME manually."
    echo ""
    echo "Options:"
    echo "1. Install via Homebrew: brew install openjdk@17"
    echo "2. Download from: https://www.oracle.com/java/technologies/downloads/#java17"
    echo "3. Install Android Studio which includes a bundled JDK"
    exit 1
fi

# Verify Java is working
if ! java -version &>/dev/null; then
    echo -e "${RED}Error: Java is not working properly!${NC}"
    echo "JAVA_HOME is set to: $JAVA_HOME"
    exit 1
fi

echo -e "${GREEN}Java version:${NC}"
java -version 2>&1 | head -1
echo ""

# Check key.properties exists
if [ ! -f "android/key.properties" ]; then
    echo -e "${RED}Error: android/key.properties not found!${NC}"
    echo "Please create key.properties with your keystore credentials"
    exit 1
fi

get_key_prop() {
    local key="$1"
    local value
    value="$(grep -E "^${key}=" "$KEY_PROPS" | head -n 1 | cut -d'=' -f2-)"
    echo "$value"
}

KEYSTORE_ABS="$(get_key_prop storeFile)"
if [ -z "$KEYSTORE_ABS" ]; then
    KEYSTORE_ABS="$PROJECT_ROOT/android/app/keystore.jks"
fi
case "$KEYSTORE_ABS" in
    /*) ;;
    *) KEYSTORE_ABS="$PROJECT_ROOT/$KEYSTORE_ABS" ;;
esac

mkdir -p "$(dirname "$KEYSTORE_ABS")"

# Ensure key.properties storeFile is absolute on this machine
sed -i.bak "s|^storeFile=.*|storeFile=$KEYSTORE_ABS|" "$KEY_PROPS"
rm -f "${KEY_PROPS}.bak"
echo -e "${GREEN}key.properties storeFile updated to: $KEYSTORE_ABS${NC}"

# Generate keystore if missing (non-interactive, uses android/key.properties values)
if [ ! -f "$KEYSTORE_ABS" ]; then
    echo -e "${YELLOW}Keystore not found. Generating release keystore...${NC}"

    KEY_ALIAS="$(get_key_prop keyAlias)"
    STORE_PASS="$(get_key_prop storePassword)"
    KEY_PASS="$(get_key_prop keyPassword)"

    if [ -z "$KEY_ALIAS" ] || [ -z "$STORE_PASS" ] || [ -z "$KEY_PASS" ]; then
        echo -e "${RED}Error: android/key.properties is missing keyAlias/storePassword/keyPassword${NC}"
        exit 1
    fi

    keytool -genkeypair -v \
      -keystore "$KEYSTORE_ABS" \
      -storetype JKS \
      -alias "$KEY_ALIAS" \
      -keyalg RSA \
      -keysize 2048 \
      -validity 9125 \
      -dname "CN=NMMC , OU=Mobile, O=NMMC, L=Dubai, S=Dubai, C=AE" \
      -storepass "$STORE_PASS" \
      -keypass "$KEY_PASS" \
      >/dev/null

    chmod 600 "$KEYSTORE_ABS" 2>/dev/null || true
    echo -e "${GREEN}Keystore generated at:${NC} $KEYSTORE_ABS"
fi

echo -e "${GREEN}Keystore found:${NC} $KEYSTORE_ABS"
echo -e "${GREEN}Key properties found:${NC} $KEY_PROPS"

# Function to display menu
show_menu() {
    echo "Select build environment:"
    echo "1) Development (dev)"
    echo "2) Staging (staging)"
    echo "3) Production (prod)"
    echo "4) Exit"
    echo -n "Enter choice [1-4]: "
}

# Read  choice
show_menu
read choice

ENV=""
case $choice in
    1)
        ENV="dev"
        echo -e "${YELLOW}Building for DEVELOPMENT environment${NC}"
        ;;
    2)
        ENV="staging"
        echo -e "${YELLOW}Building for STAGING environment${NC}"
        ;;
    3)
        ENV="prod"
        echo -e "${YELLOW}Building for PRODUCTION environment${NC}"
        ;;
    4)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo -e "${RED}Invalid choice. Exiting.${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}Step 1: Cleaning previous builds...${NC}"
flutter clean

echo ""
echo -e "${GREEN}Step 2: Getting Flutter dependencies...${NC}"
flutter pub get

echo ""
echo -e "${GREEN}Step 3: Building Android App Bundle (AAB)...${NC}"

# Get version from pubspec.yaml
VERSION=$(grep '^version:' pubspec.yaml | sed 's/version: //' | sed 's/+.*//')
# Build number must be < 2,100,000,000 (Android limit)
# Use Julian day + hour/minute: 1-366 + HHMM
# Example: Day 57 at 15:40 = 0571540 = 571,540 (well under limit)
JULIAN_DAY=$(date +%j)
HOUR_MIN=$(date +%H%M)
BUILD_NUMBER="${JULIAN_DAY}${HOUR_MIN}"

echo -e "${YELLOW}Version: ${VERSION}${NC}"
echo -e "${YELLOW}Build Number: ${BUILD_NUMBER}${NC}"
echo ""

# Build options - Default to AAB for Play Store
echo "Select build method:"
echo "1) Build App Bundle (AAB) - Recommended for Play Store [Default]"
echo "2) Build APK (Universal)"
echo "3) Build APK (Split per ABI)"
echo -n "Enter choice [1-3] (press Enter for AAB): "
read build_choice

# Default to AAB if no input
if [ -z "$build_choice" ]; then
    build_choice=1
    echo -e "${YELLOW}Using default: App Bundle (AAB)${NC}"
fi

case $build_choice in
    1)
        echo -e "${YELLOW}Building App Bundle (AAB) for Play Store...${NC}"
        echo -e "${YELLOW}Target: $ENV environment${NC}"
        echo ""
        
        # Build AAB with Play Store optimizations
        flutter build appbundle \
          --release \
          --dart-define=ENV=$ENV \
          --build-name=$VERSION \
          --build-number=$BUILD_NUMBER \
          --target-platform android-arm,android-arm64,android-x64
        
        BUILD_STATUS=$?
        echo ""
        if [ $BUILD_STATUS -eq 0 ]; then
            AAB_PATH="build/app/outputs/bundle/release/app-release.aab"
            
            echo -e "${GREEN}========================================${NC}"
            echo -e "${GREEN}  Build Successful! ✓${NC}"
            echo -e "${GREEN}========================================${NC}"
            echo ""
            echo -e "${GREEN}AAB Location:${NC} $AAB_PATH"
            
            # Show file size
            if [ -f "$AAB_PATH" ]; then
                AAB_SIZE=$(ls -lh "$AAB_PATH" | awk '{ print $5 }')
                echo -e "${GREEN}File Size:${NC} $AAB_SIZE"
            fi
            
            echo -e "${GREEN}Environment:${NC} $ENV"
            echo -e "${GREEN}Version:${NC} $VERSION"
            echo -e "${GREEN}Build Number:${NC} $BUILD_NUMBER"
            echo ""
            echo -e "${GREEN}Play Store Upload Instructions:${NC}"
            echo "1. Go to: https://play.google.com/console"
            echo "2. Select your app: com.noralmamzar.org"
            echo "3. Go to 'Testing' → 'Internal testing' (or Production)"
            echo "4. Click 'Create new release'"
            echo "5. Upload: $AAB_PATH"
            echo ""
            echo -e "${YELLOW}Or open the folder:${NC}"
            echo "   open build/app/outputs/bundle/release/"
        else
            echo -e "${RED}========================================${NC}"
            echo -e "${RED}  Build Failed! ✗${NC}"
            echo -e "${RED}========================================${NC}"
            echo ""
            echo "Common fixes:"
            echo "1. Run: flutter -v"
            echo "2. Check android/key.properties exists and is valid"
            echo "3. Ensure keystore.jks is in android/app/ directory"
            echo "4. Try: cd android && ./gradlew clean"
            exit 1
        fi
        ;;
    2)
        echo -e "${YELLOW}Building Universal APK...${NC}"
        flutter build apk \
          --release \
          --dart-define=ENV=$ENV \
          --build-name=$VERSION \
          --build-number=$BUILD_NUMBER
        
        echo ""
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}========================================${NC}"
            echo -e "${GREEN}  Build Successful! ✓${NC}"
            echo -e "${GREEN}========================================${NC}"
            echo ""
            echo -e "${GREEN}APK Location:${NC} build/app/outputs/flutter-apk/app-release.apk"
            echo -e "${GREEN}Environment:${NC} $ENV"
            echo -e "${GREEN}Version:${NC} $VERSION"
            echo -e "${GREEN}Build Number:${NC} $BUILD_NUMBER"
            echo ""
            echo "Next steps:"
            echo "1. Install on device: flutter install"
            echo "2. Or use: adb install build/app/outputs/flutter-apk/app-release.apk"
        else
            echo -e "${RED}Build Failed! ✗${NC}"
            exit 1
        fi
        ;;
    3)
        echo -e "${YELLOW}Building Split APKs per ABI...${NC}"
        flutter build apk \
          --release \
          --split-per-abi \
          --dart-define=ENV=$ENV \
          --build-name=$VERSION \
          --build-number=$BUILD_NUMBER
        
        echo ""
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}========================================${NC}"
            echo -e "${GREEN}  Build Successful! ✓${NC}"
            echo -e "${GREEN}========================================${NC}"
            echo ""
            echo -e "${GREEN}APKs Location:${NC} build/app/outputs/flutter-apk/"
            echo -e "${GREEN}Environment:${NC} $ENV"
            echo -e "${GREEN}Version:${NC} $VERSION"
            echo -e "${GREEN}Build Number:${NC} $BUILD_NUMBER"
            echo ""
            echo "Generated APKs:"
            ls -lh build/app/outputs/flutter-apk/*.apk 2>/dev/null || echo "Check build/app/outputs/flutter-apk/ directory"
        else
            echo -e "${RED}Build Failed! ✗${NC}"
            exit 1
        fi
        ;;
    *)
        echo -e "${RED}Invalid choice. Exiting.${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}Build completed successfully!${NC}"
