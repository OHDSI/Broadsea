PORT = 5001
APP_PREFIX = '/user'
VERSION = 0.4


class LocalConfig:
    DB_NAME = 'shared'
    DB_USER = 'user'
    DB_PASSWORD = 'password'
    DB_HOST = 'localhost'
    DB_PORT = 5432


class DockerConfig:
    DB_NAME = 'shared'
    DB_USER = 'user'
    DB_PASSWORD = 'password'
    DB_HOST = 'perseus-shareddb'
    DB_PORT = 5432