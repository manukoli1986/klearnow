#!/usr/bin/env python3

#This line ask the application to import Flask module from flask package. Flask used to create instances of web application.
from flask import Flask, request, jsonify
import requests, random, json

#This line create an instance of your web application. __name__ is a special variable in python, it will equal to “__main__” if the module(python file) being executed as the main program.
app = Flask(__name__)


#This line define the routes. For example if we set route to “/” like above, the code will be executed if we access <IP-address>:8080/. You could set the route to “/hello” and our “hello world” will be shown if we access <IP-address>:8080/hello.
@app.route('/')
#This line define function that will be executed if we access route.
def hello():
    return "Kindly add uri /hello"


@app.route('/hello')
def hello_page():
    return """<h1>Hello world!</h1>"""


#This line mean that your flask app will being run if we run from app.py. Notice also that we are setting the debug parameter to true. That will print out possible Python errors on the web page helping us trace the errors.
if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=80)

