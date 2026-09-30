-- Admin role permissions setup (idempotent, runs on every startup)
-- Users pre-configured in broadsea-atlasdb: admin/admin, ohdsi/ohdsi

DO $$
DECLARE
    admin_role_id INTEGER;
    perm_id INTEGER;
    perm_value TEXT;
BEGIN
    SELECT id INTO admin_role_id FROM webapi.sec_role WHERE name = 'admin';
    IF admin_role_id IS NULL THEN
        INSERT INTO webapi.sec_role (name) VALUES ('admin') RETURNING id INTO admin_role_id;
    END IF;

    PERFORM setval('webapi.sec_permission_sequence',
        GREATEST((SELECT MAX(id) FROM webapi.sec_permission),
                 (SELECT last_value FROM webapi.sec_permission_sequence)) + 1, false);

    -- Source access
    INSERT INTO webapi.sec_permission (value, description)
    VALUES ('source:*:access', 'Access all data sources') ON CONFLICT (value) DO NOTHING;
    SELECT id INTO perm_id FROM webapi.sec_permission WHERE value = 'source:*:access';
    INSERT INTO webapi.sec_role_permission (role_id, permission_id) VALUES (admin_role_id, perm_id) ON CONFLICT DO NOTHING;

    -- TrexSQL permissions (pathInfo excludes /trexsql prefix)
    INSERT INTO webapi.sec_permission (value, description)
    VALUES ('*:cache:status:get', 'Get cache status') ON CONFLICT (value) DO NOTHING;
    SELECT id INTO perm_id FROM webapi.sec_permission WHERE value = '*:cache:status:get';
    INSERT INTO webapi.sec_role_permission (role_id, permission_id) VALUES (admin_role_id, perm_id) ON CONFLICT DO NOTHING;

    INSERT INTO webapi.sec_permission (value, description)
    VALUES ('*:cache:post', 'Build cache') ON CONFLICT (value) DO NOTHING;
    SELECT id INTO perm_id FROM webapi.sec_permission WHERE value = '*:cache:post';
    INSERT INTO webapi.sec_role_permission (role_id, permission_id) VALUES (admin_role_id, perm_id) ON CONFLICT DO NOTHING;

    INSERT INTO webapi.sec_permission (value, description)
    VALUES ('*:cache:delete', 'Delete cache') ON CONFLICT (value) DO NOTHING;
    SELECT id INTO perm_id FROM webapi.sec_permission WHERE value = '*:cache:delete';
    INSERT INTO webapi.sec_role_permission (role_id, permission_id) VALUES (admin_role_id, perm_id) ON CONFLICT DO NOTHING;

    INSERT INTO webapi.sec_permission (value, description)
    VALUES ('*:cache:count:post', 'Count patients') ON CONFLICT (value) DO NOTHING;
    SELECT id INTO perm_id FROM webapi.sec_permission WHERE value = '*:cache:count:post';
    INSERT INTO webapi.sec_role_permission (role_id, permission_id) VALUES (admin_role_id, perm_id) ON CONFLICT DO NOTHING;

    INSERT INTO webapi.sec_permission (value, description)
    VALUES ('*:cache:job:delete', 'Cancel cache job') ON CONFLICT (value) DO NOTHING;
    SELECT id INTO perm_id FROM webapi.sec_permission WHERE value = '*:cache:job:delete';
    INSERT INTO webapi.sec_role_permission (role_id, permission_id) VALUES (admin_role_id, perm_id) ON CONFLICT DO NOTHING;

    INSERT INTO webapi.sec_permission (value, description)
    VALUES ('cache:jobs:get', 'List cache jobs') ON CONFLICT (value) DO NOTHING;
    SELECT id INTO perm_id FROM webapi.sec_permission WHERE value = 'cache:jobs:get';
    INSERT INTO webapi.sec_role_permission (role_id, permission_id) VALUES (admin_role_id, perm_id) ON CONFLICT DO NOTHING;

    -- Spring Batch job executions listed by JobsPanel.vue. The Atlas3 nav
    -- gates the Jobs side panel icon on this permission; without it, admins
    -- see no Jobs entry next to the Configuration cog.
    INSERT INTO webapi.sec_permission (value, description)
    VALUES ('job:execution:get', 'List Spring Batch job executions') ON CONFLICT (value) DO NOTHING;
    SELECT id INTO perm_id FROM webapi.sec_permission WHERE value = 'job:execution:get';
    INSERT INTO webapi.sec_role_permission (role_id, permission_id) VALUES (admin_role_id, perm_id) ON CONFLICT DO NOTHING;

    -- Role management permissions
    INSERT INTO webapi.sec_permission (value, description)
    VALUES ('role:*:permissions:*:put', 'Add permissions to role') ON CONFLICT (value) DO NOTHING;
    SELECT id INTO perm_id FROM webapi.sec_permission WHERE value = 'role:*:permissions:*:put';
    INSERT INTO webapi.sec_role_permission (role_id, permission_id) VALUES (admin_role_id, perm_id) ON CONFLICT DO NOTHING;

    INSERT INTO webapi.sec_permission (value, description)
    VALUES ('role:*:permissions:*:delete', 'Remove permissions from role') ON CONFLICT (value) DO NOTHING;
    SELECT id INTO perm_id FROM webapi.sec_permission WHERE value = 'role:*:permissions:*:delete';
    INSERT INTO webapi.sec_role_permission (role_id, permission_id) VALUES (admin_role_id, perm_id) ON CONFLICT DO NOTHING;

    INSERT INTO webapi.sec_permission (value, description)
    VALUES ('role:*:put', 'Update role') ON CONFLICT (value) DO NOTHING;
    SELECT id INTO perm_id FROM webapi.sec_permission WHERE value = 'role:*:put';
    INSERT INTO webapi.sec_role_permission (role_id, permission_id) VALUES (admin_role_id, perm_id) ON CONFLICT DO NOTHING;

    INSERT INTO webapi.sec_permission (value, description)
    VALUES ('role:*:delete', 'Delete role') ON CONFLICT (value) DO NOTHING;
    SELECT id INTO perm_id FROM webapi.sec_permission WHERE value = 'role:*:delete';
    INSERT INTO webapi.sec_role_permission (role_id, permission_id) VALUES (admin_role_id, perm_id) ON CONFLICT DO NOTHING;

    INSERT INTO webapi.sec_permission (value, description)
    VALUES ('role:*:users:*:put', 'Add users to role') ON CONFLICT (value) DO NOTHING;
    SELECT id INTO perm_id FROM webapi.sec_permission WHERE value = 'role:*:users:*:put';
    INSERT INTO webapi.sec_role_permission (role_id, permission_id) VALUES (admin_role_id, perm_id) ON CONFLICT DO NOTHING;

    INSERT INTO webapi.sec_permission (value, description)
    VALUES ('role:*:users:*:delete', 'Remove users from role') ON CONFLICT (value) DO NOTHING;
    SELECT id INTO perm_id FROM webapi.sec_permission WHERE value = 'role:*:users:*:delete';
    INSERT INTO webapi.sec_role_permission (role_id, permission_id) VALUES (admin_role_id, perm_id) ON CONFLICT DO NOTHING;

    -- Global read/write/create permissions used by WebAPI's @PreAuthorize
    -- annotations (see e.g. ConceptSetService.java: `isPermitted('read:conceptset')`).
    -- These are global verbs — not URL-shaped Shiro wildcards.
    -- Granting these to the admin role lets admin read/write entities owned
    -- by other users (e.g. the seeded `ohdsi` author).
    FOR perm_value IN SELECT unnest(ARRAY[
        'admin:security',
        'admin:source',
        'admin:tags',
        'create:conceptset',
        'read:conceptset',
        'write:conceptset',
        'create:cohort-definition',
        'read:cohort-definition',
        'write:cohort-definition',
        'create:cohort-characterization',
        'write:cohort-characterization',
        'create:feature-analysis',
        'read:feature-analysis',
        'write:feature-analysis',
        'create:incidence',
        'read:incidence',
        'write:incidence',
        'create:pathway',
        'read:pathway',
        'write:pathway',
        'create:reusable',
        'read:reusable',
        'write:reusable',
        'write:source'
    ]) LOOP
        INSERT INTO webapi.sec_permission (value, description)
        VALUES (perm_value, 'Granted to admin by atlasdb seed')
        ON CONFLICT (value) DO NOTHING;
        SELECT id INTO perm_id FROM webapi.sec_permission WHERE value = perm_value;
        INSERT INTO webapi.sec_role_permission (role_id, permission_id)
        VALUES (admin_role_id, perm_id) ON CONFLICT DO NOTHING;
    END LOOP;

    -- Assign admin user to admin role
    INSERT INTO webapi.sec_user_role (user_id, role_id)
    SELECT u.id, admin_role_id FROM webapi.sec_user u WHERE u.login = 'admin'
    ON CONFLICT DO NOTHING;

    RAISE NOTICE 'Admin permissions setup complete for role_id: %', admin_role_id;
END $$;

-- Verify
SELECT p.value, p.description
FROM webapi.sec_role_permission rp
JOIN webapi.sec_role r ON rp.role_id = r.id
JOIN webapi.sec_permission p ON rp.permission_id = p.id
WHERE r.name = 'admin'
AND p.value IN ('source:*:access', '*:cache:status:get', '*:cache:post', '*:cache:delete',
    '*:cache:count:post', '*:cache:job:delete', 'cache:jobs:get', 'role:*:permissions:*:put',
    'role:*:permissions:*:delete', 'role:*:put', 'role:*:delete', 'role:*:users:*:put', 'role:*:users:*:delete')
ORDER BY p.value;
