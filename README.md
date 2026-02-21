# MFlow - Medical Flow Management System

A comprehensive hospital management web application built with Java Servlet/JSP technology. MFlow manages patient visits through the entire healthcare workflow, from registration to diagnosis and pharmacydispensation.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Technology Stack](#technology-stack)
3. [Project Structure](#project-structure)
4. [Features & User Roles](#features--user-roles)
5. [Database Schema](#database-schema)
6. [Configuration](#configuration)
7. [Installation & Setup](#installation--setup)
8. [Building the Project](#building-the-project)
9. [Running the Application](#running-the-application)
10. [API Endpoints & Servlets](#api-endpoints--servlets)
11. [Data Models](#data-models)
12. [Workflow Description](#workflow-description)
13. [Security](#security)
14. [Future Enhancements](#future-enhancements)

---

## Project Overview

**MFlow** (Medical Flow) is a hospital management system that tracks and manages patient visits through various stages of medical care. The system facilitates communication between different hospital departments including Reception, Nursing, Medical Doctors, and Pharmacy.

### Key Capabilities

- **Patient Registration**: Register new patients and create visit records
- **Vitals Recording**: Nurses can record patient vital signs (temperature, blood pressure, weight)
- **Diagnosis Management**: Doctors can add medical notes and prescriptions
- **Pharmacy Dispensation**: Pharmacists can record medication dispensing
- **Archive Management**: View historical records of completed visits
- **Dashboard Analytics**: Admin-level statistics and overview

---

## Technology Stack

| Component | Technology | Version |
|------------|------------|---------|
| **Programming Language** | Java | 21 (Preview) |
| **Web Framework** | Jakarta Servlet | 6.1.0 |
| **View Technology** | JSP (JavaServer Pages) | - |
| **JSTL** | Jakarta Standard Tag Library | 3.0.1 |
| **Database** | PostgreSQL | - |
| **JDBC Driver** | PostgreSQL JDBC | 42.7.7 |
| **Build Tool** | Apache Maven (via IntelliJ) | - |
| **IDE** | IntelliJ IDEA | 2025.3+ |
| **Server** | Smart Tomcat / Apache Tomcat | 10+ (Jakarta EE compatible) |
| **Environment Variables** | dotenv-java | 3.0.0 |

### Prerequisites

- Java Development Kit (JDK) 21 or higher
- IntelliJ IDEA (with Maven and Smart Tomcat plugins)
- PostgreSQL database
- Jakarta EE compatible servlet container (Tomcat 10+) or use Smart Tomcat

### Java Requirements

- Java 21 or higher
- The project uses preview features (`--enable-preview` compiler flag)

---

## Project Structure

```
Mflow/
├── pom.xml                          # Maven configuration
├── .env.example                     # Environment variables template
├── .gitignore                       # Git ignore rules
├── README.md                        # This file
│
├── src/
│   └── main/
│       ├── java/
│       │   ├── controllers/         # Servlet controllers
│       │   │   ├── LoginServlet.java
│       │   │   ├── LogoutServlet.java
│       │   │   ├── DashboardServlet.java
│       │   │   ├── RegisterPatientServlet.java
│       │   │   ├── NurseServlet.java
│       │   │   ├── DoctorServlet.java
│       │   │   ├── PharmacyServlet.java
│       │   │   ├── ArchiveServlet.java
│       │   │   └── VisitDetailsServlet.java
│       │   │
│       │   ├── models/              # Data model classes
│       │   │   ├── Patient.java
│       │   │   ├── Staff.java
│       │   │   ├── Visit.java
│       │   │   ├── VisitDetails.java
│       │   │   ├── Vitals.java
│       │   │   ├── Diagnosis.java
│       │   │   ├── Pharmacy.java
│       │   │   └── ArchiveRecord.java
│       │   │
│       │   ├── daos/                # Data Access Objects
│       │   │   ├── PatientDAO.java
│       │   │   ├── StaffDAO.java
│       │   │   ├── VisitDAO.java
│       │   │   ├── VitalsDAO.java
│       │   │   ├── DiagnosisDAO.java
│       │   │   └── PharmacyDAO.java
│       │   │
│       │   ├── filters/             # Servlet filters
│       │   │   └── AuthenticationFilter.java
│       │   │
│       │   └── utils/               # Utility classes
│       │       └── dbConnection.java
│       │
│       ├── resources/               # Resources folder (empty by default)
│       │
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml          # Web application deployment descriptor
│           │
│           └── views/               # JSP view pages
│               ├── login.jsp
│               ├── dashboard.jsp
│               ├── registerPatient.jsp
│               ├── nurse.jsp
│               ├── doctor.jsp
│               ├── pharmacy.jsp
│               ├── archive.jsp
│               └── viewDetails.jsp
```

---

## Features & User Roles

MFlow supports five distinct user roles, each with specific access rights and responsibilities:

### 1. Receptionist

| Feature | Description |
|---------|-------------|
| **Patient Registration** | Register new patients with full details |
| **Visit Creation** | Automatically create a visit record upon registration |
| **Dashboard** | View patients registered by the logged-in receptionist |

**Access Endpoint**: `/register`

### 2. Nurse

| Feature | Description |
|---------|-------------|
| **Vitals Recording** | Record patient vital signs (temperature, blood pressure, weight) |
| **Patient Queue** | View patients with "REGISTERED" status |
| **Status Update** | Update visit status to "VITALS_RECORDED" |

**Access Endpoint**: `/nurse`

### 3. Doctor

| Feature | Description |
|---------|-------------|
| **Diagnosis Entry** | Add medical notes and prescriptions |
| **Patient Queue** | View patients with "VITALS_RECORDED" status |
| **Status Update** | Update visit status to "DIAGNOSIS_RECORDED" |

**Access Endpoint**: `/doctor`

### 4. Pharmacist

| Feature | Description |
|---------|-------------|
| **Medication Dispensing** | Record medication given to patients |
| **Patient Queue** | View patients with "DIAGNOSIS_RECORDED" status |
| **Status Update** | Update visit status to "COMPLETED" |

**Access Endpoint**: `/pharmacy`

### 5. Admin

| Feature | Description |
|---------|-------------|
| **Dashboard Statistics** | View comprehensive analytics |
| **Archive Access** | View completed visit records |
| **Detailed Records** | View complete history of any visit |

**Access Endpoints**: `/dashboard`, `/archive`

---

## Database Schema

The application uses the following database tables. You must create these tables in your PostgreSQL database before running the application.

### Required Tables

```sql
-- Staff (users) table
CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    username VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL  -- RECEPTIONIST, NURSE, DOCTOR, PHARMACIST, ADMIN
);

-- Patients table
CREATE TABLE patients (
    patient_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    gender VARCHAR(20),
    date_of_birth DATE,
    phone VARCHAR(20)
);

-- Visits table (tracks patient journey)
CREATE TABLE visits (
    visit_id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(patient_id),
    reception_id INTEGER REFERENCES staff(staff_id),
    visit_status VARCHAR(50) NOT NULL,  -- REGISTERED, VITALS_RECORDED, DIAGNOSIS_RECORDED, COMPLETED
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Vitals table (nurse records)
CREATE TABLE vitals (
    vitals_id SERIAL PRIMARY KEY,
    visit_id INTEGER REFERENCES visits(visit_id),
    nurse_id INTEGER REFERENCES staff(staff_id),
    temperature DOUBLE PRECISION,    -- Celsius
    blood_pressure VARCHAR(20),      -- e.g., "120/80"
    weight DOUBLE PRECISION,         -- kg
    recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Diagnosis table (doctor records)
CREATE TABLE diagnosis (
    diagnosis_id SERIAL PRIMARY KEY,
    visit_id INTEGER REFERENCES visits(visit_id),
    doctor_id INTEGER REFERENCES staff(staff_id),
    notes TEXT,
    prescription TEXT,
    diagnosed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Pharmacy table (pharmacist records)
CREATE TABLE pharmacy (
    pharmacy_id SERIAL PRIMARY KEY,
    visit_id INTEGER REFERENCES visits(visit_id),
    pharmacist_id INTEGER REFERENCES staff(staff_id),
    medication TEXT,
    dispensed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Sample Staff Data (for testing)

```sql
-- Insert sample staff members (password is stored as plain text for simplicity)
INSERT INTO staff (full_name, username, password_hash, role) VALUES 
('Admin User', 'admin', 'admin123', 'ADMIN'),
('Receptionist Jane', 'receptionist', 'pass123', 'RECEPTIONIST'),
('Nurse Nancy', 'nurse', 'pass123', 'NURSE'),
('Doctor Dave', 'doctor', 'pass123', 'DOCTOR'),
('Pharmacist Paul', 'pharmacist', 'pass123', 'PHARMACIST');
```

---

## Configuration

### Environment Variables

Create a `.env` file in the project root directory with the following variables:

```env
DB_URL=your_database_url
DB_USER=your_database_username
DB_PASSWORD=your_database_password
```

The `.env.example` file provides a template:

```env
DB_URL=your database url
DB_USER=your database username
DB_PASSWORD=your database password
```

### Database Connection

The database connection is managed by [`src/main/java/utils/dbConnection.java`](src/main/java/utils/dbConnection.java), which:

1. Loads environment variables from the `.env` file using dotenv-java
2. Uses PostgreSQL JDBC driver (version 42.7.7)
3. Provides a static `getConnection()` method for all DAOs

---

## Installation & Setup

### Prerequisites

- Java Development Kit (JDK) 21 or higher
- IntelliJ IDEA (with Maven and Smart Tomcat plugins)
- PostgreSQL database
- Jakarta EE compatible servlet container (Tomcat 10+) or use Smart Tomcat

### Step 1: Open Project in IntelliJ

```
# Open the project folder in IntelliJ IDEA
File → Open → Select D:/Tech/Project/Mflow
```

### Step 2: Configure Database

1. Ensure PostgreSQL is running
2. The `.env` file should already be configured:
   ```env
   DB_URL=jdbc:postgresql://localhost:5432/mflow_db
   DB_USER=postgres
   DB_PASSWORD=your_password
   ```

### Step 3: Create Database Tables

Execute the SQL schema provided in the [Database Schema](#database-schema) section using pgAdmin or psql.

### Step 4: Build the Project

In IntelliJ's Maven tool window:
1. Expand **Lifecycle**
2. Double-click **package**

Or run in terminal:
```bash
mvn clean package
```

This will generate a WAR file at `target/Mflow.war`.

---

## Building the Project

### Using Maven Commands (via IntelliJ IDEA)

The recommended way to build this project is through IntelliJ IDEA's Maven tool window:

1. Open the Maven tool window (View → Tool Windows → Maven)
2. Expand the "Lifecycle" folder
3. Double-click on the desired goal

Alternatively, you can use the following commands in IntelliJ's terminal:

| Command | Description |
|---------|-------------|
| `mvn clean` | Clean the target directory |
| `mvn compile` | Compile the source code |
| `mvn package` | Build the WAR file |
| `mvn clean package` | Clean and build in one command |

### Using Command Line (requires Maven installed)

If you have Maven installed on your system, you can also run:

```bash
mvn clean package
```

> **Note**: If Maven is not installed system-wide, use IntelliJ's built-in Maven as described above.

### Build Output

After running `mvn clean package`, the following artifacts are created:

```
target/
├── Mflow/
│   ├── META-INF/
│   ├── WEB-INF/
│   │   ├── classes/          # Compiled Java classes
│   │   ├── lib/              # Dependencies
│   │   └── web.xml
│   └── views/                # JSP files
└── Mflow.war                 # Deployable WAR file
```

---

## Running the Application

### Option 1: Using IntelliJ IDEA with Smart Tomcat (Recommended)

The project is already configured with Smart Tomcat in `.smarttomcat/`:

1. Open the project in IntelliJ IDEA
2. Look for the Smart Tomcat run configuration in the top-right corner
3. Click the run button (green arrow) to start the server

**Or configure manually:**
- Run → Edit Configurations
- Add Smart Tomcat
- Set the context path to `/Mflow`
- Click Run

### Option 2: Using IntelliJ IDEA with Tomcat

1. Open the project in IntelliJ IDEA
2. Configure a Tomcat server (version 10+):
   - Run → Edit Configurations
   - Add Tomcat Server (Local)
   - Select deployment tab and add artifact: `Mflow:war exploded`
3. Run the server

### Option 2: Using Command Line with Tomcat

```bash
# Copy WAR to Tomcat webapps
copy target\Mflow.war $CATALINA_HOME/webapps/

# Start Tomcat
$CATALINA_HOME/bin/startup.bat
```

### Option 3: Using Command Line with Tomcat

```bash
# Copy WAR to Tomcat webapps
copy target\Mflow.war $CATALINA_HOME/webapps/

# Start Tomcat
$CATALINA_HOME/bin/startup.bat
```

### Access the Application

Once running, access the application at:

```
http://localhost:8080/Mflow
```

The login page will be displayed at `/views/login.jsp`.

---

## API Endpoints & Servlets

| Endpoint | Servlet Class | Method | Description |
|----------|---------------|--------|-------------|
| `/login` | [`LoginServlet.java`](src/main/java/controllers/LoginServlet.java) | GET/POST | User authentication |
| `/logout` | [`LogoutServlet.java`](src/main/java/controllers/LogoutServlet.java) | GET | User logout |
| `/dashboard` | [`DashboardServlet.java`](src/main/java/controllers/DashboardServlet.java) | GET | Main dashboard |
| `/register` | [`RegisterPatientServlet.java`](src/main/java/controllers/RegisterPatientServlet.java) | GET/POST | Patient registration |
| `/nurse` | [`NurseServlet.java`](src/main/java/controllers/NurseServlet.java) | GET/POST | Vitals recording |
| `/doctor` | [`DoctorServlet.java`](src/main/java/controllers/DoctorServlet.java) | GET/POST | Diagnosis entry |
| `/pharmacy` | [`PharmacyServlet.java`](src/main/java/controllers/PharmacyServlet.java) | GET/POST | Medication dispensing |
| `/archive` | [`ArchiveServlet.java`](src/main/java/controllers/ArchiveServlet.java) | GET | View completed visits |
| `/archive/details` | [`VisitDetailsServlet.java`](src/main/java/controllers/VisitDetailsServlet.java) | GET | Visit details |

---

## Data Models

### Core Models

| Class | File | Description |
|-------|------|-------------|
| **Patient** | [`Patient.java`](src/main/java/models/Patient.java) | Patient demographic information |
| **Staff** | [`Staff.java`](src/main/java/models/Staff.java) | User/employee information |
| **Visit** | [`Visit.java`](src/main/java/models/Visit.java) | Visit record linking patient and status |
| **VisitDetails** | [`VisitDetails.java`](src/main/java/models/VisitDetails.java) | Complete visit information (aggregated) |
| **Vitals** | [`Vitals.java`](src/main/java/models/Vitals.java) | Patient vital signs |
| **Diagnosis** | [`Diagnosis.java`](src/main/java/models/Diagnosis.java) | Doctor's medical notes and prescription |
| **Pharmacy** | [`Pharmacy.java`](src/main/java/models/Pharmacy.java) | Dispensed medication record |
| **ArchiveRecord** | [`ArchiveRecord.java`](src/main/java/models/ArchiveRecord.java) | Historical visit summary |

### Model Relationships

```
Patient (1) ──────< Visit (many)
                      │
                      ├─< Vitals (0..1) ──────< Staff (Nurse)
                      ├─< Diagnosis (0..1) ──< Staff (Doctor)
                      └─< Pharmacy (0..1) ────< Staff (Pharmacist)
                      
Staff (Receptionist) ──< Visit (many)
```

---

## Workflow Description

The patient journey through MFlow follows this sequential workflow:

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  RECEPTION   │────>│    NURSE      │────>│    DOCTOR    │────>│   PHARMACY   │
│              │     │              │     │              │     │              │
│ - Register   │     │ - Record     │     │ - Diagnosis  │     │ - Dispense   │
│   patient   │     │   vitals     │     │ - Prescribe  │     │   medication │
│ - Create     │     │ - Update     │     │ - Update     │     │ - Update     │
│   visit      │     │   status     │     │   status     │     │   status     │
└──────────────┘     └──────────────┘     └──────────────┘     └──────────────┘
      │                    │                    │                    │
      ▼                    ▼                    ▼                    ▼
  REGISTERED        VITALS_RECORDED      DIAGNOSIS_RECORDED      COMPLETED
```

### Detailed Workflow

1. **Reception (REGISTERED)**
   - Receptionist registers a new patient
   - System creates a visit record with status "REGISTERED"
   - Visit is queued for nurse

2. **Nursing (VITALS_RECORDED)**
   - Nurse views patients with "REGISTERED" status
   - Records vitals (temperature, blood pressure, weight)
   - Updates visit status to "VITALS_RECORDED"
   - Visit is queued for doctor

3. **Doctor (DIAGNOSIS_RECORDED)**
   - Doctor views patients with "VITALS_RECORDED" status
   - Reviews vitals and adds diagnosis notes
   - Writes prescription
   - Updates visit status to "DIAGNOSIS_RECORDED"
   - Visit is queued for pharmacy

4. **Pharmacy (COMPLETED)**
   - Pharmacist views patients with "DIAGNOSIS_RECORDED" status
   - Reviews prescription
   - Records medication dispensed
   - Updates visit status to "COMPLETED"
   - Visit is archived

5. **Archive (Admin Only)**
   - Admin can view all completed visits
   - Detailed view available for any archived visit

---

## Security

### Authentication

- Session-based authentication using HttpSession
- Login credentials stored in the `staff` table
- Password stored as plain text (note: in production, use hashing)

### Authorization

Role-based access control implemented via [`AuthenticationFilter.java`](src/main/java/filters/AuthenticationFilter.java):

| Role | Accessible Endpoints |
|------|---------------------|
| All roles | `/dashboard`, `/login`, `/logout` |
| RECEPTIONIST | `/register` |
| NURSE | `/nurse` |
| DOCTOR | `/doctor` |
| PHARMACIST | `/pharmacy` |
| ADMIN | `/archive` |

### Filter Configuration

The `AuthenticationFilter` is configured as a web filter using annotations:

```java
@WebFilter("/*")
public class AuthenticationFilter implements Filter { ... }
```

This filter:
- Allows unauthenticated access to login/logout pages and static resources
- Redirects unauthenticated users to login page
- Enforces role-based access control for protected resources
- Returns 403 Forbidden for unauthorized access attempts

---

## Future Enhancements

Potential improvements for future versions:

### Security
- [ ] Implement password hashing (bcrypt or similar)
- [ ] Add HTTPS support
- [ ] Implement CSRF protection
- [ ] Add input validation and sanitization
- [ ] Implement rate limiting

### Features
- [ ] User registration module
- [ ] Password reset functionality
- [ ] Patient search functionality
- [ ] Export reports (PDF/Excel)
- [ ] Email notifications
- [ ] SMS notifications

### Technical
- [ ] Add unit tests
- [ ] Add integration tests
- [ ] Implement caching
- [ ] Add logging framework
- [ ] Docker containerization

---

## Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| **PostgreSQL driver not found** | Ensure PostgreSQL JDBC driver is in classpath |
| **Environment variables not loaded** | Verify `.env` file exists in project root |
| **Database connection refused** | Check PostgreSQL is running and credentials are correct |
| **404 on JSP pages** | Ensure JSP files are in `src/main/webapp/views/` |
| **Role access denied** | Check staff role in database matches expected values |

### Debugging Tips

1. Check Tomcat logs for error messages
2. Verify database connection by testing with a simple query
3. Ensure all dependencies are correctly declared in `pom.xml`
4. Verify Java version compatibility (Java 21)

---

## License

This project is provided as-is for educational and development purposes.

---

## Contact

For questions or contributions, please contact the development team.

---

*Generated: February 2026*
