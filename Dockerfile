# Python runtime as a parent image
FROM python:3.11

# set the working dir for my application
WORKDIR /my_fastapi_application/app1

# copy all from the current dir to the container
COPY . .

# Install dependencies
RUN pip install -r requirements.txt

# Run at port 8002
EXPOSE 8002

# Command to run the FastAPI app
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8002", "--reload"]