# BK7258 + OV6946 WiFi Video Streaming System

A complete embedded video streaming solution combining the BK7258 WiFi SoC with OV6946 camera sensor, featuring mobile apps for iOS/iPad and Android.

## 🎯 Project Overview

- **Hardware**: BK7258 SoC + OV6946 camera sensor (400x400@30fps)
- **Firmware**: WiFi streaming server with RTSP/HTTP protocols
- **Mobile Apps**: iOS/iPad and Android video streaming clients
- **Target**: Real-time video streaming over WiFi

## 📁 Project Structure

```
BK7258-OV6946-Streaming/
├── firmware/                 # Embedded firmware for BK7258
│   ├── bk7258/
│   │   ├── src/
│   │   │   ├── camera/       # OV6946 driver and interface
│   │   │   ├── streaming/    # RTSP/HTTP streaming servers
│   │   │   ├── wifi/         # WiFi management
│   │   │   └── main.c        # Main application
│   │   ├── include/          # Header files
│   │   ├── libs/             # Third-party libraries
│   │   └── docs/             # Firmware documentation
├── mobile-apps/              # Mobile client applications
│   ├── ios-app/              # iOS/iPad streaming client
│   └── android-app/          # Android streaming client
├── hardware/                 # Hardware design files
│   ├── schematics/           # Circuit schematics
│   └── pcb-layouts/          # PCB layout files
├── documentation/            # Project documentation
├── tests/                    # Testing files and scripts
└── README.md
```

## 🔧 Hardware Specifications

### BK7258 SoC
- **CPU**: ARM Cortex-M33 core
- **WiFi**: 802.11n 2.4GHz
- **Interfaces**: SPI, I2C, UART, ADC, GPIO
- **Power**: 3.3V operation
- **Package**: QFN88 9x9mm

### OV6946 Camera Sensor
- **Resolution**: 400 x 400 pixels (160K pixels)
- **Frame Rate**: Up to 30 fps
- **Interface**: SPI control + Analog video output
- **Power**: 3.3V, 25mW consumption
- **Package**: 950 x 940 µm
- **Technology**: OmniBSI™+ pixel structure

## 🛠️ Development Environment

### Firmware Development
- **SDK**: Beken Armino IDK Framework
- **Toolchain**: GNU ARM toolchain
- **IDE**: VSCode with C/C++ extensions
- **Debugger**: J-Link or compatible ARM debugger

### Mobile Development
- **iOS**: Xcode with Swift/SwiftUI, SGPlayer for RTSP streaming
- **Android**: Android Studio with Kotlin, ExoPlayer with RTSP module

## 📡 Streaming Protocols

- **RTSP/RTP**: Real-time streaming protocol for low latency
- **HTTP/MJPEG**: HTTP-based MJPEG streaming for compatibility
- **WebRTC**: Ultra-low latency streaming (future enhancement)

## 🚀 Getting Started

### Prerequisites
- BK7258 development board
- OV6946 camera sensor
- Development environment setup (see documentation/)

### Quick Start
1. Clone this repository
2. Set up hardware connections (see hardware/schematics/)
3. Build and flash firmware (see firmware/docs/)
4. Install mobile apps and connect to stream

## 📋 Development Roadmap

- [ ] **Week 1-2**: Hardware bring-up and basic camera integration
- [ ] **Week 2-3**: MJPEG compression and HTTP streaming
- [ ] **Week 3-4**: RTSP server implementation
- [ ] **Week 4-5**: Mobile app development and optimization

## 🤝 Contributing

This project is designed as a complete reference implementation for embedded video streaming systems. Contributions welcome!

## 📄 License

[Add your preferred license here]

## 📞 Contact

[Your contact information]