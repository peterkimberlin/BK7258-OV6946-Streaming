# IDE Setup Guide for BK7258 + OV6946 Project

This guide covers the complete setup of all development environments for the BK7258 + OV6946 WiFi video streaming project.

## 🛠️ **Development Environment Overview**

The project uses three main development environments:
1. **Firmware Development**: VS Code + ARM GCC toolchain
2. **iOS Development**: Xcode with Swift/SwiftUI
3. **Android Development**: Android Studio with Kotlin

---

## 🔧 **Firmware Development Setup**

### **Prerequisites Installed**
- ✅ **Visual Studio Code**: Latest version with C/C++ extensions
- ✅ **ARM GCC Toolchain**: `arm-none-eabi-gcc` version 15.2.0
- ✅ **OpenOCD**: Version 0.12.0 for debugging
- ✅ **Git**: For version control

### **VS Code Extensions** (Auto-recommended via `.vscode/extensions.json`)
```json
- ms-vscode.cpptools              // C/C++ IntelliSense and debugging
- marus25.cortex-debug            // ARM Cortex-M debugging
- dan-c-underwood.arm             // ARM assembly support  
- twxs.cmake                      // CMake language support
- ms-vscode.cmake-tools           // CMake integration
- formulahendry.code-runner       // Quick code execution
- streetsidesoftware.code-spell-checker // Spell checking
- gruntfuggly.todo-tree           // TODO tracking
- ms-vscode.hexeditor            // Hex file editing
- ms-vscode.makefile-tools       // Makefile support
```

### **Build System Configuration**
```bash
# Build firmware
make -C firmware/bk7258 all

# Clean build  
make -C firmware/bk7258 clean

# Flash to device (when hardware available)
make -C firmware/bk7258 flash

# Debug with GDB
make -C firmware/bk7258 debug
```

### **VS Code Tasks** (Configured in `.vscode/tasks.json`)
- **Ctrl+Shift+P → Tasks: Run Task**
  - `Build Firmware` - Compile the firmware
  - `Clean Firmware` - Clean build files  
  - `Flash Firmware` - Flash to BK7258 device
  - `Build iOS App` - Build iOS application
  - `Build Android App` - Build Android application

### **Debug Configuration**
Two debug configurations available:
1. **J-Link Debugger**: Professional debugging with SWO trace
2. **OpenOCD**: Open-source debugging solution

**Launch debugging**: Press `F5` or use VS Code debug panel

### **Debugging Tools Setup**

#### **OpenOCD Configuration**
```bash
# Start OpenOCD server
openocd -f firmware/bk7258/debug/openocd.cfg

# In another terminal, start GDB
arm-none-eabi-gdb -x firmware/bk7258/debug/gdbinit
```

#### **J-Link Setup** (Optional - Professional tool)
1. Install J-Link Software from SEGGER
2. Connect J-Link to BK7258 SWD interface
3. Use Cortex-Debug extension in VS Code

---

## 📱 **iOS Development Setup**

### **Prerequisites**
- ✅ **macOS**: Required for iOS development
- ✅ **Xcode Command Line Tools**: Installed and up to date
- ✅ **Xcode**: Latest version (install from Mac App Store)

### **Project Structure**
```
mobile-apps/ios-app/
├── CameraStreamer/
│   ├── Views/          # SwiftUI views
│   ├── ViewModels/     # MVVM view models  
│   ├── Models/         # Data models
│   ├── Services/       # Network and streaming services
│   ├── Resources/      # Assets and resources
│   └── Info.plist      # iOS app configuration
├── Package.swift       # Swift Package Manager dependencies
└── CameraStreamer.xcodeproj  # Xcode project (to be created)
```

### **Key Dependencies** (Managed via Swift Package Manager)
```swift
// SGPlayer - RTSP streaming support for iOS
.package(url: "https://github.com/libobjc/SGPlayer.git", from: "4.0.0")

// Alamofire - HTTP networking
.package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.0")

// Composable Architecture - State management
.package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.2.0")
```

### **iOS App Features**
- **RTSP/RTP Streaming**: Via SGPlayer library
- **HTTP/MJPEG Streaming**: Fallback for compatibility
- **Network Discovery**: Automatic camera detection
- **SwiftUI Interface**: Modern iOS UI framework
- **Hardware Acceleration**: VideoToolbox integration

### **Build and Run**
```bash
# Build from command line
xcodebuild -project mobile-apps/ios-app/CameraStreamer.xcodeproj -scheme CameraStreamer -configuration Debug build

# Or use VS Code task: "Build iOS App"
```

---

## 🤖 **Android Development Setup**

### **Prerequisites** 
- ✅ **Android Studio**: Version 2025.1.3.7 installed
- ✅ **Java 17**: Required for latest Android development
- ✅ **Android SDK**: API levels 24-34 configured

### **Project Configuration**
```
mobile-apps/android-app/
├── app/
│   ├── src/main/
│   │   ├── java/com/camerastreamer/bk7258/
│   │   │   ├── ui/              # Jetpack Compose UI
│   │   │   ├── viewmodel/       # ViewModels with LiveData
│   │   │   ├── repository/      # Data repositories
│   │   │   ├── service/         # Background services
│   │   │   └── util/            # Utility classes
│   │   ├── res/                 # Android resources
│   │   └── AndroidManifest.xml  # App permissions and components
│   └── build.gradle             # App-level build configuration
├── build.gradle                 # Project-level build configuration
└── gradle.properties           # Gradle configuration
```

### **Key Dependencies**
```kotlin
// ExoPlayer with RTSP support
implementation 'androidx.media3:media3-exoplayer-rtsp:1.8.0'

// Jetpack Compose for modern UI
implementation 'androidx.compose.ui:ui:1.5.4'

// Dependency injection with Hilt
implementation 'com.google.dagger:hilt-android:2.48'

// Network discovery with mDNS
implementation 'org.jmdns:jmdns:3.5.8'

// Coroutines for async operations  
implementation 'org.jetbrains.kotlinx:kotlinx-coroutines-android:1.7.3'
```

### **Android App Features**
- **RTSP Streaming**: Native ExoPlayer RTSP module
- **Jetpack Compose UI**: Modern Android UI toolkit
- **Background Streaming**: Foreground service for continuous playback
- **Network Discovery**: Automatic camera discovery via mDNS/Bonjour
- **Hardware Acceleration**: MediaCodec integration

### **Build and Run**
```bash
# Build from command line
cd mobile-apps/android-app
./gradlew assembleDebug

# Or use VS Code task: "Build Android App"
```

---

## 🔧 **Hardware Interface Setup**

### **Required Hardware** (When Available)
- **BK7258 Development Board**: Official Beken evaluation board
- **OV6946 Camera Sensor**: Evaluation module
- **J-Link Debugger**: Professional ARM debugging (optional)
- **USB-Serial Adapter**: For firmware flashing
- **Logic Analyzer**: For SPI protocol debugging (optional)

### **Connection Diagram**
```
BK7258 Development Board
├── SWD Interface → J-Link Debugger → PC
├── UART → USB-Serial → PC (115200 baud)
├── SPI → OV6946 Camera Sensor
│   ├── SCLK → SPI Clock
│   ├── MOSI → SPI Data Out  
│   ├── MISO → SPI Data In
│   └── CS   → Chip Select
└── ADC_IN → OV6946 Analog Video Output
```

### **Debug Interface Configuration**

#### **SWD (Serial Wire Debug) Pinout**
```
J-Link/Debug Probe    BK7258
==================    ======
VCC (3.3V)       →    VDD
GND              →    GND  
SWDIO            →    SWDIO (PA13)
SWCLK            →    SWCLK (PA14)
RESET            →    NRST
SWO (optional)   →    SWO (PB3)
```

#### **UART Debug Console**
```
USB-Serial Adapter    BK7258
==================    ======
VCC (3.3V)       →    VDD
GND              →    GND
TXD              →    UART_RX (PA9)
RXD              →    UART_TX (PA10)
```

---

## 🚀 **Quick Start Guide**

### **1. Verify Installation**
```bash
# Check all tools are installed
arm-none-eabi-gcc --version    # Should show v15.2.0
openocd --version              # Should show v0.12.0
code --version                 # VS Code version
xcodebuild -version            # Xcode version  
studio --version               # Android Studio version
```

### **2. Open Project in VS Code**
```bash
cd /Users/user/BK7258-OV6946-Streaming
code .
```

### **3. Install Recommended Extensions**
VS Code will prompt to install recommended extensions from `.vscode/extensions.json`

### **4. Build Test (Without Hardware)**
```bash
# Test firmware build system
make -C firmware/bk7258 info

# Test iOS build (requires Xcode)
# Open mobile-apps/ios-app in Xcode

# Test Android build
cd mobile-apps/android-app
./gradlew assembleDebug
```

---

## 🐛 **Troubleshooting**

### **Common Issues**

#### **ARM Toolchain Issues**
```bash
# If arm-none-eabi-gcc not found
brew install arm-none-eabi-gcc

# Check PATH includes Homebrew
echo $PATH | grep -o homebrew
```

#### **VS Code C++ IntelliSense Issues**
1. Open Command Palette (`Cmd+Shift+P`)
2. Run "C/C++: Reset IntelliSense Database"
3. Check `.vscode/settings.json` compiler path

#### **iOS Build Issues**
```bash
# Update Xcode command line tools
xcode-select --install

# Clear derived data
rm -rf ~/Library/Developer/Xcode/DerivedData
```

#### **Android Build Issues**
```bash
# Update Android SDK
# Open Android Studio → SDK Manager → Update

# Clean project
cd mobile-apps/android-app
./gradlew clean
```

### **Debug Connection Issues**
- **Check hardware connections**: Verify SWD wiring
- **Check permissions**: Debug probe may need udev rules on Linux
- **Verify power**: Ensure BK7258 board is properly powered
- **Check clocks**: SWD clock speed may need adjustment

---

## 📚 **Additional Resources**

### **Documentation Links**
- **BK7258 Hardware Manual**: `Downloads/HDK-BK7258_QFN88_9X9_V3.5/`
- **OV6946 Datasheet**: https://www.ovt.com/products/ov6946/
- **ARM Cortex-M33 Reference**: ARM official documentation
- **VS Code C++ Guide**: https://code.visualstudio.com/docs/languages/cpp

### **Development Tools**
- **SEGGER J-Link**: https://www.segger.com/products/debug-probes/j-link/
- **OpenOCD Documentation**: http://openocd.org/doc/
- **Swift Package Manager**: https://swift.org/package-manager/
- **Android Gradle Plugin**: https://developer.android.com/build

---

## ✅ **Setup Complete!**

Your complete development environment is now configured for:
- ✅ **Firmware Development**: VS Code + ARM toolchain + debugging
- ✅ **iOS Development**: Xcode + Swift Package Manager + RTSP support  
- ✅ **Android Development**: Android Studio + Kotlin + ExoPlayer
- ✅ **Debug Tools**: OpenOCD + GDB + hardware interface support
- ✅ **Build System**: Makefiles + Gradle + Xcode integration

**Next Steps:**
1. **Hardware Setup**: Connect BK7258 board and OV6946 sensor
2. **SDK Integration**: Install Beken Armino SDK when available
3. **Code Development**: Start with basic firmware bring-up
4. **Mobile Apps**: Implement streaming clients in parallel

The development environment is ready for the 5-week development timeline!