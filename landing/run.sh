#!/bin/bash
echo "source $(poetry env info --path)/bin/activate" >> /root/.bashrc
source $(poetry env info --path)/bin/activate

# python manage.py migrate
python manage.py runserver 0.0.0.0:8000