#!/bin/bash

/myproject/myprojectenv/bin/gunicorn --bind unix:/myproject/myproject.sock wsgi:app &
nginx -g 'daemon off;'
