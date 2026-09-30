-- DB-auth user table for WebAPI 3.0 AtlasRegularSecurity
-- Schema matches org.ohdsi.webapi.security.authc.db.DatabaseUserDetailsService
-- Default passwords: admin / admin, ohdsi / ohdsi (inherited from broadsea-atlasdb)

CREATE TABLE IF NOT EXISTS webapi.auth_user (
    login VARCHAR(255) PRIMARY KEY,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    middle_name VARCHAR(100),
    last_name VARCHAR(100),
    enabled BOOLEAN NOT NULL DEFAULT TRUE,
    failed_attempts INT NOT NULL DEFAULT 0,
    locked_until TIMESTAMP
);

INSERT INTO webapi.auth_user (login, password_hash, first_name, last_name, enabled)
VALUES
    ('admin', '{bcrypt}$2a$10$opEKwT32fEvoPfSbzE1Rx.p8QsCG0KryiA7VEguLP/V0M62aho6mC', 'admin', 'admin', TRUE),
    ('ohdsi', '{bcrypt}$2a$04$Fg8TEiD2u/xnDzaUQFyiP.uoDu4Do/tsYkTUCWNV0zTCW3HgnbJjO', 'ohdsi', 'ohdsi', TRUE)
ON CONFLICT (login) DO NOTHING;
