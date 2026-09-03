## Project Description

RaceDay is a web-based event management system designed for South African road running, walking, and cycling events.

The platform allows Organisers to manage events, categories, enrolments, and race results, while Participants can browse events, enter events, select categories, and track their own performance history.# RaceDay/PROG6212-Part1

## User Roles

### Organiser

Organisers can:
- Create, edit, and delete events.
- Manage event categories.
- View participant enrolments.
- Capture finish times and finishing positions.
- View information relating to events they manage.

### Participant

Participants can:
- Register and log in.
- Browse available events.
- Enter an event.
- Select an event category.
- View their own enrolments.
- View their own race results and performance history.

## Repository Structure

```text
RaceDay/
│
├── README.md
│
├── docs/
│   ├── RaceDay_ERD.pdf
│   ├── RaceDay_API_Endpoint_Plan.pdf
│   └── RaceDay_Database.sql
│
└── .github/
    └── workflows/
        └── part1-ci.yml

## Database Setup

The RaceDay database was created for Microsoft SQL Server and can be executed using SQL Server Management Studio (SSMS).

### Requirements

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)

## Entity Relationship Diagram (ERD)

The RaceDay ERD represents the database structure used to support the system.

The database contains six main entities:

- **User** – stores both Organiser and Participant account information.
- **Event** – stores event information created and managed by Organisers.
- **Category** – stores age or distance categories linked to specific Events.
- **Route** – stores route information for Events.
- **Enrolment** – links Participants to Events and the Category they selected.
- **Result** – stores finish times and finishing positions for Participant enrolments.

### Main Relationships

- One Organiser can create many Events.
- One Event can have many Categories.
- One Event can have many Routes.
- One Participant can have many Enrolments.
- One Event can have many Enrolments.
- One Category can be selected by many Enrolments.
- One Enrolment can have zero or one Result.

The ERD also identifies all primary keys, foreign keys, and relationship cardinalities. The SQL database script is designed to match this ERD.

### How to Run the Database Script

1. Open SQL Server Management Studio.
2. Connect to your SQL Server instance.
3. Open the file `docs/RaceDay_Database.sql`.
4. Click **Execute** or press **F5**.
5. Confirm that the script completes without errors.
6. Refresh the **Databases** folder.
7. Expand `RaceDayDB`.
8. Open the **Tables** folder and confirm that the RaceDay tables were created.
9. Run the provided `SELECT` statements to verify the sample data.

## CI/CD

GitHub Actions is used to validate the Part 1 repository structure and confirm that all required submission files are present.

The workflow file is located at:

```text
.github/workflows/part1-ci.yml

## CI/CD Build Screenshot

The screenshot below shows the successful GitHub Actions validation for Part 1.

![Successful GitHub Actions Build](docs/images/ci-green-build.png)
