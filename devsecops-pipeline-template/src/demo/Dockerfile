FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN python -c "print('hello from container')" >/dev/null
CMD ["python","-c","print('hi')"]