PORT = 5002
APP_PREFIX = '/athena'
VERSION = 0.4
IMPORT_DATA_TO_SOLR = False


class LocalConfig:
    AZURE_KEY_VAULT = False
    SOLR_URL = 'http://localhost:8983'
    VOCABULARY_DB_NAME = 'vocabulary'
    VOCABULARY_DB_USER = 'vocabulary'
    VOCABULARY_DB_PASSWORD = 'password'
    VOCABULARY_DB_HOST = 'vocabularydb'
    VOCABULARY_DB_PORT = 5432


class DockerConfig:
    AZURE_KEY_VAULT = False
    SOLR_URL = 'http://perseus-solr:8983'
    VOCABULARY_DB_NAME = 'vocabulary'
    VOCABULARY_DB_USER = 'vocabulary'
    VOCABULARY_DB_PASSWORD = 'password'
    VOCABULARY_DB_HOST = 'perseus-vocabularydb'
    VOCABULARY_DB_PORT = 5432


class AzureConfig:
    AZURE_KEY_VAULT = True