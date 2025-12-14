# Waffir - Anti-Food Waste Mobile Application

## Overview
Waffir (وفّر - meaning "save" in Arabic) is a mobile application designed to combat food waste in Algeria by connecting consumers with businesses selling unsold food items at reduced prices. The app addresses a critical issue: according to national studies, 54% of waste in Algeria comes from food, with an estimated $50 million worth of food ending up in landfills annually.

## Key Objectives
- **Reduce Food Waste**: Give unsold products a second chance by enabling businesses to sell surplus inventory at discounted prices
- **Environmental Impact**: Combat climate change by reducing greenhouse gas emissions from food waste
- **Social Benefit**: Help feed those in need while making affordable food accessible
- **Economic Value**: Generate additional revenue for sellers while offering consumers budget-friendly meals

## Core Features

### For Customers
- Email and Google authentication with account verification
- Browse products by category (Bakery, Pastries, Prepared Meals, etc.)
- Interactive map showing nearby participating businesses
- Shopping cart and order management
- Favorites list for quick access to preferred items
- Order history and profile management

### For Vendors
- Product management dashboard (add, edit, remove items)
- Order tracking and fulfillment interface
- Business profile customization
- Real-time inventory updates

### Administrative
- Firebase backend for comprehensive app management
- User authentication and data storage
- Real-time database synchronization

## Technical Architecture

**Platform**: Android (targeting 91.38% market share in Algeria)

**Technology Stack**:
- **Frontend**: Flutter & Dart for cross-platform development
- **Backend**: Firebase (Authentication, Firestore Database, Cloud Storage)
- **Development Tools**: Android Studio, Visual Studio Code
- **Version Control**: GitHub
- **Design Tools**: Figma, Canva, Lucidchart

**Architecture**: Client-server model with Flutter client communicating with Firebase backend

## Development Methodology
The project followed a Waterfall methodology with sequential phases:
1. Requirements gathering and ideation
2. System design and architecture planning
3. Implementation and development
4. Testing and quality assurance

Project management was conducted using Trello for task tracking and GitHub for code collaboration.

## Design Philosophy
- **Colors**: Green (#0B622E) representing nature and sustainability, paired with warm yellow (#F2AE1C) for energy and creativity
- **Typography**: Simple, readable fonts ensuring intuitive user experience
- **Logo**: Shopping basket with "W" symbolizing both shopping and the app name

## UML Diagrams

### Use Case Diagrams
The application defines two primary actors:
- **Client**: End users who browse and purchase products
- **Vendor**: Businesses selling unsold food items

Key use cases include:
- Authentication and account creation
- Product discovery and search
- Location-based vendor finding
- Cart and order management
- Favorites management
- Profile customization
- Product and order management (vendors)

### Class Diagram
Main classes:
- `UserDetail`: Base user information
- `Seller`: Vendor-specific data
- `Buyer`: Customer-specific data
- `Product`: Product information
- `Order`: Transaction relationship between buyers and sellers

## Project Structure
```
waffir/
├── lib/
│   ├── models/          # Data models
│   ├── screens/         # UI screens
│   ├── services/        # Firebase services
│   ├── widgets/         # Reusable components
│   └── main.dart        # App entry point
├── assets/              # Images, fonts, etc.
├── android/             # Android-specific files
└── pubspec.yaml         # Dependencies
```

## Future Enhancements
- iOS platform expansion
- Automated product expiration management
- Vendor rating and review system
- Push notifications for real-time updates
- Online payment integration
- Expanded vendor categories (grocers, markets)
- Enhanced database management with automated cleanup
- Improved user interface based on feedback


## Academic Context
**Institution**: Djillali Liabes University, Sidi Bel Abbes  
**Department**: Computer Science  
**Program**: 2nd Year State Engineer in Computer Science  
**Academic Year**: 2023-2024  
**Project Type**: Interdisciplinary Group Project  



*Note: This was a collaborative project with contributions across frontend development, backend infrastructure, UI/UX design, system architecture, testing, and documentation.*
