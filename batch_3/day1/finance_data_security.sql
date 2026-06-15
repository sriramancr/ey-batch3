# Data Security table and contents

use finance;

CREATE TABLE data_security (
    event_id VARCHAR(20) PRIMARY KEY, event_timestamp DATETIME,     user_id VARCHAR(50),  department VARCHAR(100),
    user_role VARCHAR(100), access_type VARCHAR(100), resource_name VARCHAR(255), storage_layer VARCHAR(100),
    transmission_layer VARCHAR(100), device_type VARCHAR(100), geo_region VARCHAR(100), data_sensitivity_level INT,
    records_accessed INT, bytes_transferred_mb DECIMAL(12,2), session_duration_min DECIMAL(10,2),
    failed_logins_24h INT, prior_alerts_30d INT, unusual_ip_flag TINYINT, unmanaged_device_flag TINYINT,
    encryption_in_transit_flag TINYINT,  encryption_at_rest_flag TINYINT, privilege_level INT,
    off_hours_access_flag TINYINT, cross_region_access_flag TINYINT, concurrent_sessions INT,
    velocity_access_count_1h INT, genai_anomaly_score DECIMAL(10,4), auth_confidence_score DECIMAL(10,4),
    dlp_policy_hits INT, risk_score DECIMAL(10,4),    step_up_auth_required TINYINT, authentication_result VARCHAR(50),
    anomaly_flag TINYINT, unauthorized_access_flag TINYINT, breach_scenario_label VARCHAR(100)
);

select * from data_security;

CREATE TABLE agent_memory (
            id INT AUTO_INCREMENT PRIMARY KEY,
            event_id VARCHAR(50),
            original_label VARCHAR(100),
            agent_decision VARCHAR(100),
            assigned_owner VARCHAR(100),
            reasoning TEXT,
            analyst_feedback VARCHAR(100),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );

select * from agent_memory;






