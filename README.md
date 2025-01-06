# DVD Rental Database Project

This repository contains the project files for the **DVD Rental Database** project, completed as part of the **CIS 556 Database Systems** course at the **University of Michigan – Dearborn** in Fall 2024.

---

## Project Overview

The **DVD Rental Database** project aims to provide hands-on experience in designing, querying, and optimizing databases. This project utilizes the DVD Rental dataset to analyze and optimize query performance using PostgreSQL. 

Key components include:
- Conceptual design and implementation using Entity-Relationship (ER) modeling.
- Database schema creation and data population.
- Writing SQL queries for data analysis.
- Indexing and query performance optimization.

---

## Features and Objectives

1. **Database Design and ER Modeling**  
   - Identified entities, primary/foreign keys, and applied normalization.
   - Designed an ER diagram for the database schema.

2. **SQL Querying**  
   - Performed multi-table joins, data retrieval, and aggregation queries.

3. **Database Transactions**  
   - Implemented ACID transactions to ensure data consistency.

4. **Database Administration**  
   - Conducted data loading, backups, and user permission management.

5. **Performance Optimization**  
   - Utilized indexing and query tuning to improve query execution times.

---

## Dataset Details

The project uses the **DVD Rental Dataset**, which consists of 15 interconnected tables representing a DVD rental store's operations. The dataset includes:
- Actors, films, rentals, payments, inventory, customers, staff, and locations.

The dataset was preprocessed to ensure compatibility with SQL commands. Transformation details are available in the `clean.sql` file.

---

## Files in Repository

| **File Name**                          | **Description**                                                                 |
|---------------------------------------|---------------------------------------------------------------------------------|
| **clean.sql**                         | Data transformation and cleaning script.                                       |
| **ddl_schema.sql**                    | SQL script for creating database schema.                                       |
| **ddl_indexes.sql**                   | SQL script for creating indexes.                                               |
| **dml.sql**                           | SQL script for populating the database.                                        |
| **queries.sql**                       | SQL queries for data analysis and experiments.                                 |
| **DVD_Rental_External_Memory_Algorithms_Report.pdf** | Report on external memory algorithms used for the project.                     |
| **ER_Diagram.pdf**                    | Entity-Relationship diagram of the DVD Rental database.                        |

---

## Query Performance Analysis

Queries were tested under three conditions to evaluate performance:
1. **Without indexes:** Baseline performance.
2. **With basic indexes:** Simple indexes on commonly queried columns.
3. **With advanced indexes:** Compound indexes for optimized performance.

Detailed query plans and benchmarks are included in the project report.

---

## How to Run

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/DVD-Rental-Database.git
   cd DVD-Rental-Database
