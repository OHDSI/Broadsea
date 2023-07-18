PORT = 5003
APP_PREFIX = '/perseus-usagi'
VERSION = 0.4
IMPORT_DATA_TO_SOLR = False


class LocalConfig:
    AZURE_KEY_VAULT = False
    SOLR_URL = 'http://localhost:8983'

    USAGI_DB_NAME = 'shared'
    USAGI_DB_USER = 'usagi'
    USAGI_DB_PASSWORD = 'password'
    USAGI_DB_HOST = 'localhost'
    USAGI_DB_PORT = 5432

    VOCABULARY_DB_NAME = 'vocabulary'
    VOCABULARY_DB_USER = 'vocabulary'
    VOCABULARY_DB_PASSWORD = 'password'
    VOCABULARY_DB_HOST = 'localhost'
    VOCABULARY_DB_PORT = 5431


class DockerConfig:
    AZURE_KEY_VAULT = False
    SOLR_URL = 'http://perseus-solr:8983'

    USAGI_DB_NAME = 'shared'
    USAGI_DB_USER = 'usagi'
    USAGI_DB_PASSWORD = 'password'
    USAGI_DB_HOST = 'perseus-shareddb'
    USAGI_DB_PORT = 5432

    VOCABULARY_DB_NAME = 'vocabulary'
    VOCABULARY_DB_USER = 'vocabulary'
    VOCABULARY_DB_PASSWORD = 'password'
    VOCABULARY_DB_HOST = 'perseus-vocabularydb'
    VOCABULARY_DB_PORT = 5432


class AzureConfig:
    AZURE_KEY_VAULT = True
