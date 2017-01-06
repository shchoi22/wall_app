# Instructions on running the app locally:
## Django app server:
1. `pip install -r requirements.txt`
2. `python manage.py migrate --settings=wall_app.settings.development`
3. `python manage.py runserver --settings=wall_app.settings.development`

## Angularjs & Webpack dev server:
1. `npm install`
2. `webpack-dev-server --content-base public/dist --inline --history-api-fallback`

Then open a browser and go to http://127.0.0.1:8080 to view.
