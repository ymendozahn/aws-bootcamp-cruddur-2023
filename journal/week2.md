# Week 2 — Distributed Tracing

## Required Homework

### Honeycomb Configuration

I really like honeycomb. It seems it's not that difficult to use. I'll be learning more in the near future. Here are the steps for the instrumentation of Honeycomb

1. In order for honeycomb to collect data, we need to install the opentelemetry packages. We added it to the [requirements.txt](https://github.com/ymendozahn/aws-bootcamp-cruddur-2023/blob/3d030dd41700d91f35d6563cb5e468dbcd0f3403/backend-flask/requirements.txt#L4-L8) file under the backend of the app.
2. Login to the Honeycomb portal: [https://ui.honeycomb.io](https://ui.honeycomb.io/login)
3. Create a new environment for dev/test/prod or even bootcamp :wink: 
4. Setup the **environment variables** for Honeycomb. For the honeycomb API Key, you can get it from the environment you just created for the bootcamp.
 
 ![honeycomb-key](images/honeycombkey.png)

Here are the environment variables you   configure on the [docker-compose](https://github.com/ymendozahn/aws-bootcamp-cruddur-2023/blob/3d030dd41700d91f35d6563cb5e468dbcd0f3403/docker-compose.yml#L7-L10) file: 

```dockerfile
HONEYCOMB_API_KEY: "honeycomb-environment-api-key"
OTEL_EXPORTER_OTLP_ENDPOINT: "https://api.honeycomb.io"
OTEL_EXPORTER_OTLP_HEADERS: "x-honeycomb-team=${HONEYCOMB_API_KEY}"  
OTEL_SERVICE_NAME: "backend-flask"
```

5. Now, we can start instrument with honeycomb. We need to add some code for initialize the traces on the [app.py](https://github.com/ymendozahn/aws-bootcamp-cruddur-2023/blob/3d030dd41700d91f35d6563cb5e468dbcd0f3403/backend-flask/app.py#L17-L24) file.  

```python
...

#####  --- HoneyComb traces --- ####
from opentelemetry import trace
from opentelemetry.instrumentation.flask import FlaskInstrumentor
from opentelemetry.instrumentation.requests import RequestsInstrumentor
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.sdk.trace.export import ConsoleSpanExporter, SimpleSpanProcessor

...
```

**NOTE**: there is more code added that you can review on the [app.py](https://github.com/ymendozahn/aws-bootcamp-cruddur-2023/blob/3d030dd41700d91f35d6563cb5e468dbcd0f3403/backend-flask/app.py) file

 ![honeycomb-trace](images/honeycombtrace01.png)

6. Now we can further add more detail info to the span to better understand the trace. Wr can add a hardcode trace within the home page.

On the [home_activities.py](https://github.com/ymendozahn/aws-bootcamp-cruddur-2023/blob/3d030dd41700d91f35d6563cb5e468dbcd0f3403/backend-flask/services/home_activities.py#L8-L11) file we add a span trace to tell what is going on in this part of the app. Here is the code
```python
...
from opentelemetry import trace
...
    with tracer.start_as_current_span("home-activites-test-data"):
      span = trace.get_current_span()
      now = datetime.now(timezone.utc).astimezone()
      span.set_attribute("app.now", now.isoformat())
```

8. Now you can start to look for the trace on the honeycomb portal, and see details of the trace.

 ![honeycomb-trace-detail](images/honeycombtrace02.png)
 
We need to explore more with the span and queries, but basically that's it for now.

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
 
 So, for the cloudwatch logs here are the steps to get it up and running.

1. We include the **watchtower** module into the backend flask [requirements.txt](https://github.com/ymendozahn/aws-bootcamp-cruddur-2023/blob/6427a6d4e6d7b9c5b499c9572074105f238d0135/backend-flask/requirements.txt#L12) file, in order to get install.
2. We import the libraries and configure the logger on the [app.py](https://github.com/ymendozahn/aws-bootcamp-cruddur-2023/blob/6427a6d4e6d7b9c5b499c9572074105f238d0135/backend-flask/app.py#L30-L33) file.
```python
import watchtower
import logging
from time import strftime

...

LOGGER = logging.getLogger(__name__)
LOGGER.setLevel(logging.DEBUG)
console_handler = logging.StreamHandler()
cw_handler = watchtower.CloudWatchLogHandler(log_group='cruddur')
LOGGER.addHandler(console_handler)
LOGGER.addHandler(cw_handler)
LOGGER.info("Starting logging Backend app")
```

3. Now we can log some info on the endpoint. Here is the logging for [home.activities.py](https://github.com/ymendozahn/aws-bootcamp-cruddur-2023/blob/6427a6d4e6d7b9c5b499c9572074105f238d0135/backend-flask/services/home_activities.py#L8) file

```python
logger.info("HomeActivities")
```
4. Also, we have to add some environment variables to the backend part of the [docker-compose](https://github.com/ymendozahn/aws-bootcamp-cruddur-2023/blob/6427a6d4e6d7b9c5b499c9572074105f238d0135/docker-compose.yml#L13-L15) file.

```dockerfile
AWS_DEFAULT_REGION: "${AWS_DEFAULT_REGION}"
AWS_ACCESS_KEY_ID: "${AWS_ACCESS_KEY_ID}"
AWS_SECRET_ACCESS_KEY: "${AWS_SECRET_ACCESS_KEY}"
```
5. Here are my logs registering on the group for the app.

 ![cloudwatch-logs](images/cloudwatchlog01.png)
 
 ![cloudwatch-log-detail](images/cloudwatchlog02.png)
 
 So, that's it. 
 
 ### Rollbar configuration
 
