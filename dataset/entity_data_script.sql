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

