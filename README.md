# Credit Advisory System

## Overview

The Credit Advisory System manages credit applications facilitated by bank advisors. This README provides a description of the schema used in the system, outlining the key entities, their attributes, and the relationships between them.

## Entities

### 1. Advisor

An advisor is a bank employee with a specific role: associate, partner, or senior. Each advisor is assigned a list of credit applications to review.

- **Attributes:**
    - Role (associate, partner, senior)

### 2. Applicant

An applicant is an individual who applies for credit. The system captures detailed information about each applicant.

- **Attributes:**
    - First Name
    - Last Name
    - Social Security Number
    - Address:
        - City
        - Street
        - Number
        - ZIP Code
        - Apartment
    - Phone Numbers:
        - Home
        - Work
        - Mobile

### 3. Application

An application represents the document submitted by an applicant for credit. Multiple applications can be associated with the same applicant. Applications have various statuses and key timestamps.

- **Attributes:**
    - Amount of Money (USD)
    - Status (new, assigned, on_hold, approved, canceled, declined)
    - Timestamps:
        - Creation Time
        - Assignment Time
    - References:
        - Applicant (linked to the applicant)
        - Advisor (linked if assigned)

## Relationships

- An advisor is associated with multiple applications.
- An application is linked to a specific applicant.
- If assigned, an application is connected to an advisor.

## User Management

The system involves two types of users: advisors and applicants. User authentication and authorization are handled through AWS Cognito.

- **Attributes:**
    - Email
    - Cognito Username
