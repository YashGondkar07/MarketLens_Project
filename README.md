# 📊 MarketLens – Campaign Performance & Attribution Analytics

> A marketing analytics solution for analyzing campaign performance, customer conversion, attribution, ROI, CAC, and budget optimization using SQL, Python, MySQL, and Power BI.

---

## 📌 Project Overview

**MarketLens** is a marketing analytics project designed to provide a consolidated view of campaign performance and customer conversion.

The project analyzes campaign spend, revenue, impressions, clicks, leads, qualified leads, customers, customer journeys, and attribution data.

The solution combines:

- Data preparation
- SQL analytics
- Marketing funnel analysis
- Attribution analysis
- ROI and ROAS analysis
- Customer acquisition cost analysis
- Budget utilization
- Campaign optimization
- Interactive Power BI dashboards

---

## 🎯 Project Objectives

The main objectives of MarketLens are:

- Analyze marketing campaign performance
- Measure campaign ROI and ROAS
- Calculate Customer Acquisition Cost (CAC)
- Analyze the marketing conversion funnel
- Compare first-touch, last-touch, and weighted attribution
- Identify campaign performance differences
- Analyze customer conversion by channel, device, audience, and region
- Evaluate budget utilization
- Identify campaigns requiring budget optimization
- Build an interactive Power BI dashboard

---

# 🏗️ Project Architecture

```text
                 ┌──────────────────────┐
                 │      Raw Data        │
                 │                      │
                 │ Campaign Performance │
                 │ Leads & Customers    │
                 │ Marketing Events     │
                 │ Customer Journeys    │
                 └──────────┬───────────┘
                            │
                            ▼
                 ┌──────────────────────┐
                 │   Data Preparation   │
                 │                      │
                 │ Python / Pandas      │
                 │ Cleaning & Transform │
                 └──────────┬───────────┘
                            │
                            ▼
                 ┌──────────────────────┐
                 │      MySQL           │
                 │                      │
                 │ Data Mart / SQL      │
                 │ Analytics            │
                 └──────────┬───────────┘
                            │
                            ▼
                 ┌──────────────────────┐
                 │      Power BI        │
                 │                      │
                 │ KPI & Visualizations │
                 │ Attribution          │
                 │ Funnel Analysis      │
                 │ Budget Optimization  │
                 └──────────┬───────────┘
                            │
                            ▼
                 ┌──────────────────────┐
                 │   Business Insights  │
                 │                      │
                 │ Campaign Actions     │
                 │ Budget Decisions     │
                 │ Performance Reports  │
                 └──────────────────────┘
