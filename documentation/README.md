# 🏋️ Gym Management System - PostgreSQL Database Project

## 📋 Project Overview
A comprehensive database solution for fitness centers to manage:
- Member registrations and profiles
- Trainer schedules and specializations
- Subscription plans and payments
- Workout/diet plans
- Attendance tracking
- Automated notifications and reporting

## 🌟 Key Features
| Feature               | Description                                                                 |
|-----------------------|-----------------------------------------------------------------------------|
| Member Management     | Track member details, registration dates, and assigned trainers            |
| Subscription System   | Handle recurring payments with expiration tracking                         |
| Attendance Tracking   | Log check-ins with timestamps and method (Mobile/RFID)                     |
| Trainer Scheduling    | Manage trainer availability and session bookings                           |
| Reporting             | Generate daily reports on revenue, attendance, and membership stats        |

## 🛠 Tech Stack
- **Database**: PostgreSQL 15+
- **Version Control**: Git/GitHub
- **Tools**: pgAdmin, psql

## 🚀 Quick Start

### Prerequisites
- PostgreSQL installed
- Git installed

### Installation
```bash
# Clone repository
git clone https://github.com/afshansif/GYM-MANAGEMENT-SYSTEM.git
cd GYM-MANAGEMENT-SYSTEM

# Create database
createdb gym_management

# Initialize schema
psql gym_management < database_scripts/schema.sql
psql gym_management < database_scripts/views.sql
psql gym_management < database_scripts/stored_procedures.sql

# Load sample data (optional)
psql gym_management < database_scripts/sample_data.sql