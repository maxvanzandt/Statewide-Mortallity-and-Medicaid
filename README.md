# Statewide Mortality and Medicaid

An analysis of state-level mortality rates as a function of obesity 
prevalence, drug overdose deaths, Medicare/Medicaid enrollment and 
spending, senior population share, political majority, and COVID-19 
restriction policy. Originally completed for a Fall 2023 UVA STAT 
course project.

## Data Sources

- **Total deaths / death rate**: CDC National Center for Health Statistics, via [KFF](https://www.kff.org/other/state-indicator/death-rate-per-100000/)
- **Obesity prevalence**: [CDC Adult Obesity Prevalence Maps](https://www.cdc.gov/obesity/data/prevalence-maps.html#overall) (2022)
- **Medicare enrollment**: [CMS Program Statistics](https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/cms-program-statistics-medicare-total-enrollment) (2021)
- **Medicaid spending**: Urban Institute estimates based on CMS Form 64 data, via [KFF](https://www.kff.org/medicaid/state-indicator/total-medicaid-spending/) (2021)
- **Drug overdose deaths**: KFF analysis of CDC National Center for Health Statistics data ([source](https://www.kff.org/other/state-indicator/drug-overdose-death-rate-per-100000-population/))
- **COVID-19 restrictions**: [Statista infographic](https://cdn.statcdn.com/Infographic/images/normal/21423.jpeg) (2021)
- **Senior population percentage**: U.S. Census Bureau, ACS 2021 (Table DP05)
- **Political majority**: [2020 National Popular Vote Tracker](https://www.cookpolitical.com/2020-national-popular-vote-tracker), Cook Political Report

Additional context sources consulted for the project report: KFF issue briefs on health spending and federal budget policy; Peterson-KFF Health System Tracker on national healthcare spending trends.

## Data Dictionary

| Variable | Column Name | Type | Description |
|---|---|---|---|
| Death Rate | `Death.Rate` | Numeric | Deaths per 100,000 residents by state (response variable) |
| Drug Overdose Death Rate | `Drug.Overdose.Deaths` | Numeric | Overdose deaths per 100,000 residents by state |
| Obesity Prevalence | `Obesity.Prevalence` | Numeric | Self-reported obesity prevalence by state |
| Medicare Enrollment | `Medicare.Enroll` | Numeric | Medicare enrollment as % of resident population |
| Medicaid Spending per Capita | `Medicaid.Spend` | Numeric | Total Medicaid expenditure divided by state population |
| Lifted COVID Restrictions | `Lift.COVID.Restrict` | Categorical | "Yes" = no general mask mandates/stay-at-home orders/interstate quarantines; "No" = restrictions still in place |
| Population Density | `Pop.per.Cap` | Numeric | State population density |
| Senior Population Level | `Senior.Pop` | Categorical | % of population 65+, binned into "Low"/"Medium"/"High" tertiles |
| Senior Population Level (interval form) | `Senior.Pop1` | Factor | Interval form of the tertiles: (11.6,16.6], (16.6,17.9], (17.9,21.7]. Not used in the final model; included to document how `Senior.Pop` was constructed |
| Political Majority | `Political.Majority` | Categorical | "R" or "D", based on 2020 presidential election results by state |

## Reproducing the Analysis

1. Download the source datasets listed above and save them under 
   `data/raw/` using the filenames referenced in `clean_data.R`.
2. Set your R working directory to the repo root.
3. Run `clean_data.R` to merge and clean the data into 
   `data/processed/merged_data.csv`.
4. Knit `analysis.Rmd` to reproduce the analysis and figures.

## Files

- `clean_data.R` - merges and cleans the raw data (see Data Sources above for where to obtain each file)
- `analysis.Rmd` - exploratory analysis, model building, and diagnostics
- `report.pdf` - final written report
- `poster.pdf` - presentation poster

## License

See `LICENSE` (BSD 3-Clause).
