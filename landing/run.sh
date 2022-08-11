#!/bin/bash
echo "source $(poetry env info --path)/bin/activate" >> /root/.bashrc
source $(poetry env info --path)/bin/activate

python manage.py migrate
python manage.py findstatic .
python manage.py collectstatic --noinput
if [ $1 == prod ]; then
    poetry add gunicorn
    gunicorn landing.wsgi:application --bind 0.0.0.0:8000
else
    python manage.py runserver 0.0.0.0:8000
fi
