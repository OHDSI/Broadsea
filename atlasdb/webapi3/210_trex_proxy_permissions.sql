-- Trex proxy permissions setup (idempotent, runs on every startup)
-- Grants access to trex proxy routes (/trexsql/d2e/*) for all authenticated users

DO $$
DECLARE
    public_role_id INTEGER;
    perm_id INTEGER;
BEGIN
    -- Get or create the public role (all authenticated users have this role)
    SELECT id INTO public_role_id FROM webapi.sec_role WHERE name = 'public';
    IF public_role_id IS NULL THEN
        INSERT INTO webapi.sec_role (name, system_role) VALUES ('public', true) RETURNING id INTO public_role_id;
    END IF;

    -- Ensure sequence is up to date
    PERFORM setval('webapi.sec_permission_sequence',
        GREATEST(COALESCE((SELECT MAX(id) FROM webapi.sec_permission), 0),
                 (SELECT last_value FROM webapi.sec_permission_sequence)) + 1, false);

    -- Trex proxy permission - grants access to all /trexsql/d2e/* paths
    INSERT INTO webapi.sec_permission (value, description)
    VALUES ('trexsql:d2e:*', 'Access trex proxy routes under /trexsql/d2e/*')
    ON CONFLICT (value) DO NOTHING;

    SELECT id INTO perm_id FROM webapi.sec_permission WHERE value = 'trexsql:d2e:*';

    INSERT INTO webapi.sec_role_permission (role_id, permission_id)
    VALUES (public_role_id, perm_id)
    ON CONFLICT DO NOTHING;

    RAISE NOTICE 'Trex proxy permissions setup complete for public role_id: %', public_role_id;
END $$;

-- Verify
SELECT r.name as role_name, p.value, p.description
FROM webapi.sec_role_permission rp
JOIN webapi.sec_role r ON rp.role_id = r.id
JOIN webapi.sec_permission p ON rp.permission_id = p.id
WHERE p.value = 'trexsql:d2e:*';
