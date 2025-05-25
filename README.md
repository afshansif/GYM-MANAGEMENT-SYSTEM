#  Gym Management System - PostgreSQL Database

![Database ER Diagram](/documentation/ERD.png)

A complete database solution for fitness centers to automate member management, trainer scheduling, and financial reporting.

##  Features

| Module               | Key Capabilities                                                                 |
|----------------------|---------------------------------------------------------------------------------|
| **Member Portal**    | Registration, profile management, attendance tracking                          |
| **Trainer System**   | Schedule management, specialization tracking, session booking                  |
| **Subscription**     | Recurring payments, expiration alerts, membership tiers                        |
| **Operations**       | Daily reporting (revenue/attendance), workout/diet plan management             |

##  Tech Stack

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15+-blue)
![Git](https://img.shields.io/badge/Git-F05032?logo=git&logoColor=white)
![pgAdmin](https://img.shields.io/badge/pgAdmin-4.30-red)

##  Getting Started

### Prerequisites
- PostgreSQL 15+
- Git
- Basic SQL knowledge

### Installation

```bash
# Clone repository
git clone https://github.com/afshansif/GYM-MANAGEMENT-SYSTEM.git
cd GYM-MANAGEMENT-SYSTEM

# Setup database
createdb gym_management
psql gym_management < database_scripts/schema.sql
psql gym_management < database_scripts/views.sql
psql gym_management < database_scripts/stored_procedures.sql
