# StudentPulse — Student Life Analytics & Business Intelligence Platform

## Overview

StudentPulse is an end-to-end Business Intelligence project designed to analyze student engagement, event participation, registration behavior, and satisfaction.

The platform transforms raw student and event data into actionable insights through Python-based data generation, PostgreSQL analysis, SQL views, and interactive Power BI dashboards.

**Note:** This project uses a synthetically generated dataset for educational and portfolio demonstration purposes. It does not contain real student or company data.

## Business Objectives

- Analyze student participation across universities and academic years.
- Identify the most popular event categories and individual events.
- Monitor event attendance and capacity utilization.
- Understand registration channel performance.
- Evaluate student satisfaction.
- Support data-driven decisions through interactive dashboards.

## Dataset

The dataset was generated using Python with a fixed random seed for reproducibility.

| Dataset | Description |
|---|---|
| Students | 1,000 synthetic student records |
| Events | 36 synthetic events |
| Registrations | Several thousand registration records |

Main attributes include:

- University and field of study
- Academic year
- Event category and capacity
- Registration date and channel
- Attendance status
- Satisfaction score

## Technology Stack

- **Python:** Synthetic data generation and data preparation
- **Pandas / NumPy:** Data manipulation
- **PostgreSQL:** Relational database management
- **SQL:** Data analysis, aggregation, and analytical views
- **Power BI:** Interactive dashboards and data visualization
- **DAX:** Measures and business KPIs
- **Git / GitHub:** Version control and project documentation

## Database Design

The database contains three main relational tables:

- `students`
- `events`
- `registrations`

The registrations table connects students and events through foreign keys.

Analytical SQL views were created to support dashboard reporting, including:

- Overall KPIs
- Category performance
- Event performance
- Registration channel performance
- Monthly registration trends

## Power BI Dashboard

The report is organized into three pages:

### 1. Executive Overview

- Total students
- Total events
- Total registrations
- Attendance rate
- Average satisfaction
- Registrations by event category
- Monthly registration trends
- Satisfaction by category
- Registrations by channel

### 2. Event Performance

- Attendance rate by event category
- Registrations by event
- Capacity utilization by event

### 3. Student Insights

- Students by university
- Students by field of study
- Registrations by academic year
- Interactive university and academic-year filters

## Key Business Questions

The analysis aims to answer questions such as:

1. Which event categories attract the most registrations?
2. Which events have the highest participation?
3. What proportion of registrations result in attendance?
4. Which events use their available capacity most effectively?
5. Which registration channels are most frequently used?
6. How does student engagement vary across universities and academic years?

## Project Structure

```text
StudentPulse/
├── data/
│   ├── raw/
│   └── processed/
├── scripts/
│   └── generate_data.py
├── sql/
├── notebooks/
├── dashboard/
│   └── StudentPulse.pbix
├── reports/
├── requirements.txt
└── README.md
```

## Reproducing the Project

1. Clone the repository.
2. Install the Python dependencies:

```bash
pip install -r requirements.txt
```

3. Generate the synthetic datasets:

```bash
python scripts/generate_data.py
```

4. Create a PostgreSQL database named `studentpulse`.
5. Create the relational tables and import the generated CSV files.
6. Execute the SQL scripts to create the analytical views.
7. Open `dashboard/StudentPulse.pbix` in Power BI Desktop.
8. Configure the PostgreSQL connection to your local database.

## Learning Outcomes

This project demonstrates practical experience in:

- Building a relational database.
- Writing SQL queries for business analysis.
- Creating analytical KPIs and measures.
- Developing interactive Power BI dashboards.
- Connecting data sources and managing table relationships.
- Translating data into business-oriented insights.

---

**StudentPulse — Turning student activity data into actionable insights.**
