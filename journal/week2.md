# Week 2 — Distributed Tracing

## Required Homework

### Honeycomb configuration

### AWS X-RAY configuration

So, I follow the video instructions and here is a summary of the steps

1. We have to import the libraries and start the recorder for the backend-flask
  Here is the code for reference on [app.py](https://github.com/ymendozahn/aws-bootcamp-cruddur-2023/blob/3d030dd41700d91f35d6563cb5e468dbcd0f3403/backend-flask/app.py#L26-L28) file
2. create a AWS X-Ray group in order to filter the traces we want to review.
 ![xraygroup](images/xraygroup01.png)
3. do some sample trace with the [xray.json](https://github.com/ymendozahn/aws-bootcamp-cruddur-2023/blob/3d030dd41700d91f35d6563cb5e468dbcd0f3403/aws/json/xray.json) file
4. Now we have to do some instrumentation with xray
  Basically for python we import the xray sdk core library. Then we can start the instrumentation using segments.
  
  ```python 
  from aws_xray_sdk.core import xray_recorder
  ```
  Now we can test traces that are logging into AWS X-ray. Here is an example for the cruddur app
  
   ![xraytraces](images/xraytraces01.png)
   
   ![xraytraces](images/xraytraces02.png)
  
  Off course this is just the tip of the iceberg. We have to dig deep in order to understand how use it.
   
 ### AWS Cloudwatch logs configuration
 
 ### Rollbar configuration
 
