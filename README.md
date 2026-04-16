# 🏥 Healthcare Analytics Dashboard  
### SQL + Power BI | End-to-End Data Analysis Project

---

##  Project Overview

This project analyzes a **hospital management dataset** to uncover operational inefficiencies, revenue patterns, and patient behavior insights.  
The work covers the full analyst pipeline — from raw SQL queries to a structured Power BI dashboard — with **9 business KPIs** built to simulate real healthcare reporting needs.

> **Goal:** Help hospital management make data-driven decisions around doctor performance, patient retention, billing health, and branch operations.

---

##  Database Structure

The `Health` database consists of **5 core tables:**

| Table | What it holds |
|---|---|
| `patients` | Patient demographics — name, gender, contact info |
| `doctors` | Doctor profiles — specialization, experience, branch |
| `appointments` | Appointment logs — status, dates, doctor-patient links |
| `treatments` | Treatment records — type, cost, date |
| `billing` | Payment details — amount, method, status |

---

##  KPIs Analyzed

| # | KPI | Business Question Answered |
|---|---|---|
| 1 | **Cancellation & No-Show Rate** | Which doctors have the highest drop-off in appointments? |
| 2 | **Unpaid Treatment Tracker** | Which treatments have pending or failed payments? |
| 3 | **Doctor Experience vs Revenue** | Do more experienced doctors generate more revenue? |
| 4 | **Monthly Revenue Trend** | How does hospital income fluctuate month over month? |
| 5 | **Appointments Per Doctor by Branch** | Which branch is under/over-utilizing its doctors? |
| 6 | **Revenue by Specialization** | Which medical specialization is most profitable? |
| 7 | **Customer Lifetime Value (CLV)** | Who are the highest-value patients by total spend? |
| 8 | **Total Revenue Generated** | What is the overall billing revenue? |
| 9 | **Top 5 Treatment Types** | What treatments are most commonly performed? |

---

##  SQL Techniques Used

- **CTEs (Common Table Expressions)** — Used in KPI 1 & 7 for multi-step aggregations before final output
- **Window Functions** — `RANK() OVER` used in CLV analysis to rank patients by revenue
- **Views** — `cancellation_analysis` and `customer_lifetime_value` saved as reusable views
- **Conditional Aggregation** — `SUM(CASE WHEN ...)` to pivot appointment statuses per doctor
- **Multi-table JOINs** — Up to 3-table joins (doctors → appointments → billing/treatments)
- **Type Casting & Rounding** — `CAST AS FLOAT/DECIMAL` + `ROUND()` for clean rate and revenue calculations

---

##  Tech Stack

| Tool | Purpose |
|---|---|
| **SQL Server (T-SQL)** | Data extraction, transformation, KPI logic |
| **Power BI (.pbix)** | Interactive dashboard and visualizations |

---

##  Files in This Repository

```
📦 healthcare-analytics
 ┣ 📄 health_sql.sql       → All KPI queries + views (fully commented)
 ┗ 📊 Health_DB.pbix       → Power BI dashboard connected to the Health DB
```

---

## How to Run This Project

**SQL Setup:**
1. Open **SQL Server Management Studio (SSMS)**
2. Run `CREATE DATABASE Health;` and `USE Health;`
3. Import the five tables (patients, doctors, appointments, treatments, billing)
4. Execute `health_sql.sql` — queries are organized top to bottom by KPI number

**Power BI Setup:**
1. Open `Health_DB.pbix` in **Power BI Desktop**
2. Go to `Transform Data > Data Source Settings`
3. Update the server/database connection to match your local SQL Server instance
4. Refresh — all visuals will auto-populate

---

##  Key Insights (Sample Findings)

- Some doctors show **no-show rates above 20%**, flagging potential scheduling or patient engagement issues
- **Pending/Failed payments** were found across multiple treatment types, indicating billing follow-up gaps
- Doctors with **20+ years experience** don't uniformly generate the highest revenue — specialization matters more
- Monthly revenue shows **clear seasonal dips**, useful for resource planning

---

##  About This Project

Built as part of a self-driven analytics portfolio to demonstrate:
- Ability to translate business questions into SQL logic
- Clean, readable, well-commented query writing
- End-to-end delivery from database to dashboard

---

> Feel free to open an issue or reach out if you'd like to discuss the analysis or methodology.# Healthcare_Analytics_Dashboard
SQL + Power BI | End-to-End Data Analysis Project
