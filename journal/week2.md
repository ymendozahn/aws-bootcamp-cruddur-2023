# Week 2 — Distributed Tracing

## Required Homework

### AWS X-RAY configuration

So, I follow the video instructions and here is a summary of the steps

1. We have to import the libraries and start the recorder for the backend-flask
  Here is the code for reference on [app.py]() file
2. create a AWS X-Ray group in order to filter the traces we want to review.
 ![xrayGroup.png](images/)
3. do some sample trace with the [xray.json]() file
4. Now we have to do some instrumentation with xray
