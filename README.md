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


.github/workflows/part1-ci.yml

## CI/CD Build Screenshot

The screenshot below shows the successful GitHub Actions validation for Part 1.

![Successful GitHub Actions Build](docs/images/ci-green-build.png)

## API Endpoint Plan

The API Endpoint Plan defines the RESTful operations that will be implemented in Part 2 of the RaceDay system.

The plan covers the following functional areas:

- Authentication
- User Profile
- Events
- Categories
- Event Enrolments
- Results

Each endpoint includes:

- HTTP Method
- Route
- Description
- Role Required
- Request Body
- Expected Response

### Role-Based Access

RaceDay uses role-based access to separate Organiser and Participant functionality.

- **Public endpoints** allow users to register, log in, and browse available events.
- **Authenticated endpoints** allow logged-in users to view or update their profiles.
- **Organiser endpoints** allow Organisers to create, update, and delete events, manage categories, view event enrolments, and capture results.
- **Participant endpoints** allow Participants to enrol in events and view their own enrolments and race results.

The endpoint plan is intended to act as the specification for the RESTful API that will be developed in Part 2.
Video Demonstration

The Part 1 video demonstration explains:

The RaceDay system

Repository structure

ERD entities and relationships

Primary and foreign keys

Cardinality

API Endpoint Plan

Role-based endpoint access

SQL database structure

Constraints and relationships

Live execution of the SQL script in SSMS

Sample database records

Successful GitHub Actions build

YouTube Link: https://youtu.be/74FynxRkq80

- Fix spelling and grammar mistakes in README.md
- Make headings consistent
- Check that all filenames in README match the actual repository files
- Confirm RaceDay_ERD.pdf is referenced correctly
- Confirm RaceDay_API_Endpoint_Plan.pdf is referenced correctly
- Confirm RaceDay_Database.sql is referenced correctly
- Make sure the CI/CD screenshot path works
- Make sure the video section is included
- Check that Organiser and Participant descriptions are clear
- Check that the database setup instructions are complete

## Author

Student Name: Kevin Thendo Rasilingwane

Student Number: ST10495040

Module: PROG6212 - Programming 2B

Assessment: Portfolio of Evidence - Part 1

