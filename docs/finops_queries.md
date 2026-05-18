# FinOps Analysis Queries

## Proyecto

`cloud_finops_platform`

## Objetivo

Documentar consultas iniciales de análisis FinOps utilizando datasets FOCUS
(FinOps Open Cost and Usage Specification) cargados en DuckDB.

Fuente de datos:

- FOCUS Sample Data
- Dataset: `focus_sample_10000.csv`

Base de datos:

- DuckDB
- Tabla principal: `focus_data`

---

## 1. Top Cost Drivers

### Objetivo

Identificar los servicios que generan mayor costo total y detectar los
principales drivers financieros de la plataforma cloud.

Esto permite enfocar estrategias como:

- Rightsizing
- Reserved Instances
- Savings Plans
- Cost Optimization
- Capacity Planning

```sql
SELECT
    ServiceName,
    ProviderName,
    ROUND(SUM(EffectiveCost), 2) AS total_cost
FROM focus_data
GROUP BY ServiceName, ProviderName
ORDER BY total_cost DESC
LIMIT 15;
```

## 2. Chargeback / Showback by Account

### Objetivo

Identificar qué subcuentas y billing accounts generan mayor gasto para
facilitar showback y chargeback interno entre equipos o unidades de negocio.

Esto permite:

- Financial accountability
- Budget ownership
- Internal cost allocation
- Business unit visibility

```sql
SELECT
    SubAccountName,
    BillingAccountName,
    ROUND(SUM(EffectiveCost), 2) AS total_cost
FROM focus_data
GROUP BY SubAccountName, BillingAccountName
ORDER BY total_cost DESC
LIMIT 15;
```

## 3. Commitment Coverage Analysis

### Objetivo

Evaluar cuánto gasto está cubierto por commitment discounts como:

- Reserved Instances
- Savings Plans

y cuánto permanece en consumo On-Demand.

Esto permite:

- Coverage optimization
- Commitment planning
- Savings strategy
- Reserved capacity planning

```sql
SELECT
    CommitmentDiscountType,
    CommitmentDiscountStatus,
    ROUND(SUM(EffectiveCost), 2) AS total_cost
FROM focus_data
GROUP BY
    CommitmentDiscountType,
    CommitmentDiscountStatus
ORDER BY total_cost DESC;
```

## 4. Regional Spend Distribution

### Objetivo

Analizar distribución de gasto por región cloud para detectar:

- Regional concentration
- Governance opportunities
- Disaster Recovery considerations
- Regional pricing optimization
- Data residency alignment

```sql
SELECT
    RegionName,
    ProviderName,
    ROUND(SUM(EffectiveCost), 2) AS total_cost
FROM focus_data
GROUP BY RegionName, ProviderName
ORDER BY total_cost DESC
LIMIT 15;
```

## 5. Monthly Cost Overview

### Objetivo

Visualizar costos mensuales para análisis de:

- Cost growth
- Forecasting
- Budget planning
- Spending anomalies
- Financial trend analysis

```sql
SELECT
    DATE_TRUNC('month', ChargePeriodStart) AS month,
    ROUND(SUM(EffectiveCost), 2) AS total_cost
FROM focus_data
GROUP BY month
ORDER BY month;
```

## Observaciones Iniciales

**Hallazgos relevantes**

- Compute representa el principal driver de costo
- AWS EC2 lidera el gasto total
- Azure VM + Azure SQL muestran fuerte peso financiero
- Baja cobertura de Savings Plans / Reservations
- Alta concentración regional en AWS us-east-1
- Showback claro sobre BillingAccount SunBird
