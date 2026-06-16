# Create the database and the table
create database ey;

use ey;

CREATE TABLE IF NOT EXISTS entity_memory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    entity_id VARCHAR(50),
    entity_name VARCHAR(100),
    memory_key VARCHAR(100),
    memory_value TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from entity_memory;

# ----------- Implementation # 2
CREATE TABLE data_security (
  event_id varchar(20) PRIMARY KEY,
  event_timestamp datetime DEFAULT NULL,
  user_id varchar(50) DEFAULT NULL,
  department varchar(100) DEFAULT NULL,
  user_role varchar(100) DEFAULT NULL,
  access_type varchar(100) DEFAULT NULL,
  resource_name varchar(255) DEFAULT NULL,
  storage_layer varchar(100) DEFAULT NULL,
  transmission_layer varchar(100) DEFAULT NULL,
  device_type varchar(100) DEFAULT NULL,
  geo_region varchar(100) DEFAULT NULL,
  data_sensitivity_level int DEFAULT NULL,
  records_accessed int DEFAULT NULL,
  bytes_transferred_mb decimal(12,2) DEFAULT NULL,
  session_duration_min decimal(10,2) DEFAULT NULL,
  failed_logins_24h int DEFAULT NULL,
  prior_alerts_30d int DEFAULT NULL,
  unusual_ip_flag tinyint DEFAULT NULL,
  unmanaged_device_flag tinyint DEFAULT NULL,
  encryption_in_transit_flag tinyint DEFAULT NULL,
  encryption_at_rest_flag tinyint DEFAULT NULL,
  privilege_level int DEFAULT NULL,
  off_hours_access_flag tinyint DEFAULT NULL,
  cross_region_access_flag tinyint DEFAULT NULL,
  concurrent_sessions int DEFAULT NULL,
  velocity_access_count_1h int DEFAULT NULL,
  genai_anomaly_score decimal(10,4) DEFAULT NULL,
  auth_confidence_score decimal(10,4) DEFAULT NULL,
  dlp_policy_hits int DEFAULT NULL,
  risk_score decimal(10,4) DEFAULT NULL,
  step_up_auth_required tinyint DEFAULT NULL,
  authentication_result varchar(50) DEFAULT NULL,
  anomaly_flag tinyint DEFAULT NULL,
  unauthorized_access_flag tinyint DEFAULT NULL,
  breach_scenario_label varchar(100) DEFAULT NULL
 );
 select * from data_security;
 
 drop table portfolio_data;
 select * from portfolio_data;
 
 CREATE TABLE portfolio_data (
    row_id                      INTEGER PRIMARY KEY,
    date                        varchar(10),
    portfolio_id                VARCHAR(20) NOT NULL,
    ticker                      VARCHAR(10) NOT NULL,
    sector                      VARCHAR(50),
    asset_class                 VARCHAR(50),
    investment_style            VARCHAR(50),
    benchmark                   VARCHAR(50),
    currency                    CHAR(3),
    market_regime               VARCHAR(20),
    goal_type                   VARCHAR(50),
    risk_tolerance              VARCHAR(20),
    investment_horizon_yr       INTEGER,
    target_annual_return_pct    DECIMAL(6,2),
    goal_progress_pct           DECIMAL(6,2),
    price_close                 DECIMAL(12,4),
    avg_cost_basis              DECIMAL(12,4),
    shares_held                 INTEGER,
    position_value              DECIMAL(15,4),
    unrealized_pnl              DECIMAL(15,4),
    unrealized_pnl_pct          DECIMAL(8,4),
    portfolio_value             DECIMAL(18,4),
    allocation_pct              DECIMAL(8,4),
    target_allocation_pct       DECIMAL(8,4),
    allocation_drift_pct        DECIMAL(8,4),
    cash_pct                    DECIMAL(8,4),
    pe_ratio                    DECIMAL(8,2),
    pb_ratio                    DECIMAL(8,2),
    dividend_yield_pct          DECIMAL(6,2),
    revenue_growth_pct          DECIMAL(8,2),
    eps_growth_pct              DECIMAL(8,2),
    debt_to_equity              DECIMAL(8,2),
    free_cash_flow_B            DECIMAL(10,2),
    esg_total_score             DECIMAL(6,2),
    rsi_14                      DECIMAL(6,2),
    macd                        DECIMAL(10,4),
    macd_signal                 DECIMAL(10,4),
    sma_50                      DECIMAL(12,4),
    sma_200                     DECIMAL(12,4),
    momentum_3m_pct             DECIMAL(8,2),
    beta                        DECIMAL(6,2),
    alpha_pct                   DECIMAL(8,2),
    sharpe_ratio                DECIMAL(8,4),
    volatility_30d_pct          DECIMAL(8,4),
    max_drawdown_pct            DECIMAL(8,4),
    return_1y_pct               DECIMAL(8,4),
    benchmark_return_1y_pct     DECIMAL(8,4),
    excess_return_pct           DECIMAL(8,4),
    slippage_pct                DECIMAL(8,4),
    stop_loss_price             DECIMAL(12,4),
    analyst_rating              VARCHAR(20),
    news_sentiment_score        DECIMAL(6,4),
    earnings_surprise_pct       DECIMAL(8,2),
    next_earnings_days          INTEGER,
    short_interest_pct          DECIMAL(6,2),
    institutional_ownership_pct DECIMAL(6,2),
    recommendation              VARCHAR(20),
    recommendation_confidence   DECIMAL(4,2),
    recommendation_score        INTEGER,
    recommendation_reasoning    TEXT,
    goal_risk_mismatch_flag     varchar(10)
);

drop table customers;

CREATE TABLE customers (
    customer_id                 VARCHAR(20)     PRIMARY KEY,
    first_name                  VARCHAR(50)     NOT NULL,
    last_name                   VARCHAR(50)     NOT NULL,
    age                         SMALLINT,
    date_of_birth               varchar(10),
    gender                      VARCHAR(20),
    marital_status              VARCHAR(20),
    dependents                  SMALLINT,
    city                        VARCHAR(100),
    country                     VARCHAR(100),
    preferred_currency          CHAR(3),
    education_level             VARCHAR(20),
    occupation                  VARCHAR(100),
    kyc_status                  VARCHAR(20),
    onboarding_date             varchar(10),
    account_type                VARCHAR(50),
    annual_income               DECIMAL(15,2),
    net_worth                   DECIMAL(18,2),
    investable_assets           DECIMAL(18,2),
    current_portfolio_value     DECIMAL(18,2),
    monthly_contribution        DECIMAL(12,2),
    emergency_fund_months       SMALLINT,
    existing_debt               DECIMAL(15,2),
    debt_to_income_ratio        DECIMAL(6,2),
    tax_bracket                 VARCHAR(10),
    tax_loss_harvesting         varchar(10),
    goal_type                   VARCHAR(50),
    risk_tolerance              VARCHAR(20),
    investment_horizon_yr       SMALLINT,
    target_annual_return_pct    DECIMAL(6,2),
    investment_style            VARCHAR(50),
    preferred_benchmark         VARCHAR(50),
    experience_level            VARCHAR(20),
    liquidity_need              VARCHAR(20),
    rebalance_frequency         VARCHAR(20),
    loss_aversion_score_1_10    SMALLINT,
    max_drawdown_tolerance_pct  DECIMAL(6,2),
    uses_stop_loss              varchar(10),
    past_investing_experience   VARCHAR(100),
    reaction_to_market_crash    VARCHAR(50),
    esg_preference              VARCHAR(30),
    preferred_sectors           TEXT,
    excluded_sectors            TEXT,
    international_exposure      VARCHAR(10),
    alternative_assets          VARCHAR(10),
    crypto_exposure             VARCHAR(10),
    dividend_preference         VARCHAR(50),
    suitability_score           SMALLINT,
    suitability_label           VARCHAR(20),
    goal_risk_aligned           varchar(10)
);

select * from customers;


# --------------------------------
# match portfolio with customer needs

select distinct goal_type from customers;
select distinct risk_tolerance from customers;
select distinct target_annual_return_pct from customers;
select distinct esg_preference from customers;
select distinct excluded_sectors from customers;


# goal_type = "Aggressive Growth"
# risk_tolerance = "Aggressive"
# target_annual_return_pct = 9.4
# esg_preference = "Strong Preference"
# excluded_sectors (Adult Entertainment, Gambling)

select * from portfolio_data where sector not in ('arts', 'gambling', 'utilities');






