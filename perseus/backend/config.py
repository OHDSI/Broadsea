PORT = 5004
APP_PREFIX = '/backend'
VERSION = 0.4


class LocalConfig:
    AZURE_KEY_VAULT = False
    APP_LOGIC_DB_NAME = 'shared'
    APP_LOGIC_DB_USER = 'perseus'
    APP_LOGIC_DB_PASSWORD = 'password'
    APP_LOGIC_DB_HOST = 'localhost'
    APP_LOGIC_DB_PORT = 5432

    USER_SCHEMAS_DB_NAME = 'source'
    USER_SCHEMAS_DB_USER = 'source'
    USER_SCHEMAS_DB_PASSWORD = 'password'
    USER_SCHEMAS_DB_HOST = 'localhost'
    USER_SCHEMAS_DB_PORT = 5432

    FILE_MANAGER_API_URL = 'http://localhost:10500/files-manager'


class DockerConfig:
    AZURE_KEY_VAULT = False
    APP_LOGIC_DB_NAME = 'shared'
    APP_LOGIC_DB_USER = 'perseus'
    APP_LOGIC_DB_PASSWORD = 'password'
    APP_LOGIC_DB_HOST = 'perseus-shareddb'
    APP_LOGIC_DB_PORT = 5432

    USER_SCHEMAS_DB_NAME = 'source'
    USER_SCHEMAS_DB_USER = 'source'
    USER_SCHEMAS_DB_PASSWORD = 'password'
    USER_SCHEMAS_DB_HOST = 'perseus-shareddb'
    USER_SCHEMAS_DB_PORT = 5432

    FILE_MANAGER_API_URL = 'http://perseus-files-manager:10500/files-manager'


class AzureConfig:
    AZURE_KEY_VAULT = True
