# DuckDB Usage Guide

## Proyecto

`cloud_finops_platform`

## Objetivo

DuckDB se utiliza como motor analítico local para explorar, consultar y validar
datasets **FOCUS (FinOps Open Cost and Usage Specification)** antes de construir
dashboards en Metabase.

Permite trabajar directamente sobre archivos CSV de costos cloud sin necesidad
de levantar una base de datos tradicional como PostgreSQL o MySQL.

Esto acelera el análisis FinOps inicial y simplifica el laboratorio.

---

## ¿Por qué DuckDB?

DuckDB fue elegido por las siguientes razones:

- instalación simple
- sin servidor dedicado
- ideal para análisis sobre CSV y Parquet
- excelente rendimiento analítico
- integración sencilla con Docker y Metabase
- muy útil para laboratorios FinOps y datasets multi-cloud

Para esta fase del proyecto, DuckDB ofrece mayor velocidad de implementación
que PostgreSQL y menor complejidad operativa.

---

## Dataset utilizado

Repositorio fuente:

`FOCUS Sample Data`

Dataset inicial:

```text
focus_sample_10000.csv
```

Ubicación:

```text
data/raw/focus_sample/FOCUS-Sample-Data/FOCUS-1.0/
```

Tabla principal cargada:

```text
focus_data
```

---

## Instalar DuckDB

```bash
curl https://install.duckdb.org | sh
```

## Crear base de datos

Desde la raíz del proyecto:

```bash
mkdir -p warehouse/duckdb
duckdb warehouse/duckdb/finops.duckdb
```

Esto crea la base de datos principal del laboratorio:

```text
warehouse/duckdb/finops.duckdb
```

---

## Cargar CSV en DuckDB

Dentro del shell de DuckDB:

```sql
CREATE TABLE focus_data AS
SELECT *
FROM read_csv_auto(
  'data/raw/focus_sample/FOCUS-Sample-Data/FOCUS-1.0/focus_sample_10000.csv'
);
```

Esto importa el dataset FOCUS y crea la tabla principal para análisis.

---

## Validaciones iniciales

### Validar cantidad de registros

```sql
SELECT COUNT(*) FROM focus_data;
```

Resultado esperado:

```text
10000
```

### Revisar estructura de columnas

```sql
DESCRIBE focus_data;
```

Esto permite identificar:

- tipos de datos
- columnas relevantes
- oportunidades de normalización
- métricas disponibles para análisis FinOps

---

## Consultas iniciales recomendadas

Primeras áreas de análisis:

- Top Cost Drivers
- Chargeback / Showback
- Commitment Coverage
- Regional Spend Distribution
- Monthly Cost Overview

Estas consultas están documentadas en:

```text
docs/finops_analysis_queries.md
```

---

## Próximo paso

Con la base cargada en DuckDB:

```text
FOCUS CSV
   ↓
DuckDB
   ↓
Metabase
   ↓
FinOps Dashboard
```

el siguiente objetivo es construir un dashboard ejecutivo para:

- Cost Optimization
- Showback / Chargeback
- Commitment Analysis
- Regional Governance
- FinOps Portfolio Project
