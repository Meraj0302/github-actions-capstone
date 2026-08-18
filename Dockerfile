# ---- builder stage: has pip, compilers, etc ----
FROM python:3.14-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip setuptools && \
    pip install --no-cache-dir --target=/install -r requirements.txt

COPY . .

# ---- final stage: minimal runtime, no shell/perl/ncurses/etc ----
FROM gcr.io/distroless/python3-debian13

WORKDIR /app

COPY --from=builder /install /usr/lib/python3.14/site-packages
COPY --from=builder /app /app

EXPOSE 80

CMD ["run.py"]