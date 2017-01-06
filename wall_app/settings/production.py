import environ

from wall_app.settings.base import *

env = environ.Env()
environ.Env.read_env()

SECRET_KEY = env('SECRET_KEY', default="secret_key")

DEBUG = False

# If using a different db for production like postgres
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': env('DB_NAME', default='wall_app'),
        'USER': env('DB_USER', default='wall_app_user'),
        'PASSWORD': env('DB_PASSWORD', default='wall_app_password'),
        'HOST': env('DB_NAME', default='wall_app_host'),
        'PORT': '5432',
    }
}