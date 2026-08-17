
# GitHub Actions Capstone 🚀

A complete **CI/CD pipeline project using GitHub Actions, Python Flask, Pytest, Docker, and Docker Hub**.

This project demonstrates how application code can automatically go through:

**Code → Pull Request → Test → Build → Docker Image → Docker Hub → Deployment → Health Check**

---

## 📌 Project Overview

This repository contains a simple Flask web application and a production-style GitHub Actions CI/CD pipeline.

The main purpose of this project is to demonstrate practical DevOps concepts including:

- Git & GitHub
- GitHub Actions
- CI/CD
- Pull Request automation
- Reusable workflows
- Python testing with Pytest
- Docker image creation
- Docker Hub authentication
- Docker image publishing
- Production deployment workflow
- Scheduled Docker health checks
- GitHub Actions environments
- Workflow outputs
- Secrets and repository variables

---

## 🏗️ Architecture

```text
                    Developer
                        |
                        | git push
                        v
                +----------------+
                |    GitHub      |
                |   Repository   |
                +-------+--------+
                        |
              +---------+---------+
              |                   |
              v                   v
       Pull Request          Push to main
              |                   |
              v                   v
       PR Pipeline         Main CI/CD Pipeline
              |                   |
              v                   v
       Build & Test         Build & Test
                                  |
                                  v
                           Docker Build
                                  |
                                  v
                           Docker Hub
                                  |
                                  v
                           Production
                                  |
                                  v
                         Health Check
```

---

# 📁 Project Structure

```text
github-actions-capstone/
│
├── .github/
│   └── workflows/
│       ├── health-check.yml
│       ├── main-pipeline.yml
│       ├── pr-pipeline.yml
│       ├── reusable-build-test.yml
│       └── reusable-docker.yml
│
├── templates/
│   └── index.html
│
├── app.py
├── run.py
├── test_app.py
├── requirements.txt
├── Dockerfile
└── README.md
```

The repository currently contains five GitHub Actions workflow files under `.github/workflows`.

---

# 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Python 3.14 | Application runtime |
| Flask 3.1.1 | Web framework |
| Pytest | Automated testing |
| Docker | Containerization |
| Docker Hub | Container image registry |
| GitHub Actions | CI/CD automation |
| GitHub | Source code management |
| Bash | CI/CD scripting |
| AWS EC2 | Intended deployment environment |

The application dependencies currently include Flask 3.1.1, Werkzeug 3.1.3, and Pytest.

---

# 🌐 Application

The project contains a simple Flask application.

## Home Page

```text
GET /
```

The `/` route renders the HTML application from:

```text
templates/index.html
```

## Health Endpoint

```text
GET /health
```

Response:

```text
Server is up and running
```

The application defines both routes in `app.py`.

---

# 🔌 Ports Used

## Application Port

| Component | Port |
|---|---:|
| Flask Application | `80` |
| Docker Container | `80` |
| Host → Container | `80:80` |
| Health Check | `http://0.0.0.0:80/health` |

The Dockerfile exposes port `80`, and `run.py` starts Flask on `0.0.0.0:80`.

### Docker Port Mapping

The health-check workflow starts the container using:

```bash
docker run -d \
  --name capstone-health-check \
  -p 80:80 \
  <docker-image>:latest
```

Therefore:

```text
Host Port 80
     |
     v
Container Port 80
     |
     v
Flask Application
```



---

# ⚙️ Prerequisites

Install the following before running the project locally:

- Git
- Python 3.12+
- pip
- Docker
- GitHub account
- Docker Hub account

---

# 🚀 Run the Application Locally

## Step 1 — Clone Repository

```bash
git clone https://github.com/Meraj0302/github-actions-capstone.git
```

```bash
cd github-actions-capstone
```

---

## Step 2 — Create Virtual Environment

Linux/macOS:

```bash
python3 -m venv venv
```

Windows:

```bash
python -m venv venv
```

---

## Step 3 — Activate Virtual Environment

Linux/macOS:

```bash
source venv/bin/activate
```

Windows:

```powershell
venv\Scripts\activate
```

---

## Step 4 — Install Dependencies

```bash
pip install -r requirements.txt
```

---

## Step 5 — Start Flask Application

```bash
python run.py
```

The application starts on:

```text
http://localhost:80
```

Open the following in your browser:

```text
http://localhost:80
```

Health endpoint:

```text
http://localhost:80/health
```

Expected response:

```text
Server is up and running
```

---

# 🧪 Run Tests

This project uses **Pytest**.

Run:

```bash
pytest -v
```

The current test suite validates:

1. Home page returns HTTP `200`
2. Health endpoint returns HTTP `200`
3. Health endpoint returns the expected response

These tests are implemented in `test_app.py`.

Expected result:

```text
2 passed
```

---

# 🐳 Docker

## Build Docker Image

```bash
docker build -t github-actions-capstone .
```

The Dockerfile uses:

```text
python:3.14-slim
```

and exposes port `80`.

---

## Run Docker Container

```bash
docker run -d \
  --name github-actions-capstone \
  -p 80:80 \
  github-actions-capstone
```

Check running containers:

```bash
docker ps
```

Open:

```text
http://localhost:80
```

Health check:

```text
http://localhost:80/health
```

---

## Stop Container

```bash
docker stop github-actions-capstone
```

Remove container:

```bash
docker rm github-actions-capstone
```

---

# 🔄 CI/CD Pipeline

This project uses multiple GitHub Actions workflows.

```text
.github/workflows/
│
├── pr-pipeline.yml
├── main-pipeline.yml
├── reusable-build-test.yml
├── reusable-docker.yml
└── health-check.yml
```

---

# 1️⃣ Pull Request Pipeline

File:

```text
.github/workflows/pr-pipeline.yml
```

Triggered when a Pull Request is:

```text
opened
synchronize
```

against:

```text
main
```

The workflow performs:

```text
Pull Request
     |
     v
Checkout Code
     |
     v
Setup Python
     |
     v
Install Dependencies
     |
     v
Run Pytest
     |
     v
PR Check Summary
```

The PR workflow calls the reusable build/test workflow with Python `3.12` and tests enabled.

---

# 2️⃣ Main CI/CD Pipeline

File:

```text
.github/workflows/main-pipeline.yml
```

Triggered when code is pushed to:

```text
main
```

Pipeline:

```text
Push to main
     |
     v
Build & Test
     |
     v
Docker Build
     |
     v
Docker Hub
     |
     v
Production Deployment
```

The Docker job waits for the build/test job to complete successfully.

---

# 3️⃣ Reusable Build & Test Workflow

File:

```text
.github/workflows/reusable-build-test.yml
```

This workflow uses:

```yaml
workflow_call
```

It can therefore be called from other workflows.

Steps:

```text
Checkout Code
     ↓
Setup Python
     ↓
Install Dependencies
     ↓
Run Pytest
     ↓
Return Test Result
```

The workflow accepts:

```text
python_version
run_tests
```

and exposes a `test_result` output.

---

# 4️⃣ Reusable Docker Workflow

File:

```text
.github/workflows/reusable-docker.yml
```

This workflow is responsible for:

- Docker Hub login
- Docker Buildx setup
- Docker tag preparation
- Docker image build
- Docker image push
- Returning the image URL

Pipeline:

```text
Checkout
   |
   v
Docker Hub Login
   |
   v
Docker Buildx
   |
   v
Prepare Tags
   |
   v
Build Docker Image
   |
   v
Push to Docker Hub
```

The main pipeline passes the image name and tags to this reusable workflow.

---

# 5️⃣ Scheduled Health Check

File:

```text
.github/workflows/health-check.yml
```

The health-check workflow runs:

```text
Every 12 hours
```

using:

```yaml
cron: "0 */12 * * *"
```

It can also be started manually using:

```text
workflow_dispatch
```



### Health Check Flow

```text
Docker Hub
    |
    v
Pull latest image
    |
    v
Start Docker container
    |
    v
Wait 5 seconds
    |
    v
GET /health
    |
    +------> PASSED
    |
    +------> FAILED
    |
    v
Generate GitHub Actions Summary
    |
    v
Remove Container
```

The workflow checks:

```bash
curl --fail --silent --show-error \
http://0.0.0.0:80/health
```



---

# 🔐 GitHub Secrets & Variables

The CI/CD pipeline requires Docker Hub credentials.

## Repository Variable

Create:

```text
DOCKERHUB_USERNAME
```

Store your Docker Hub username as a GitHub **Repository Variable**.

---

## Repository Secret

Create:

```text
DOCKER_TOKEN
```

Store your Docker Hub access token as a GitHub **Repository Secret**.

---

## GitHub Configuration

Go to:

```text
Repository
    ↓
Settings
    ↓
Secrets and variables
    ↓
Actions
```

Configure:

```text
Variables
└── DOCKERHUB_USERNAME

Secrets
└── DOCKER_TOKEN
```

The workflows use the Docker username variable and Docker token secret when publishing the image.

> Never commit Docker Hub passwords, access tokens, AWS credentials, or other secrets into the repository.

---

# 🐳 Docker Hub Image

The main pipeline publishes the image using:

```text
<DOCKERHUB_USERNAME>/github-actions-capstone
```

The current pipeline creates two tags:

```text
latest
sha-<commit-sha>
```

For example:

```text
username/github-actions-capstone:latest
username/github-actions-capstone:sha-abc123
```



---

# 🔁 Complete CI/CD Flow

The complete workflow is:

```text
                    Developer
                        |
                        v
                  Git Push / PR
                        |
              +---------+---------+
              |                   |
              v                   v
         Pull Request          main branch
              |                   |
              v                   v
        PR Pipeline         Main CI/CD Pipeline
              |                   |
              +--------+----------+
                       |
                       v
                Build & Test
                       |
                       v
                    Pytest
                       |
                 Tests Pass?
                  /       \
                NO         YES
                |           |
                X           v
                       Docker Build
                            |
                            v
                       Docker Hub
                            |
                            v
                       Production
                            |
                            v
                     Health Check
                            |
                            v
                     /health = 200
```

---

# ☁️ AWS Deployment

The application is designed to be deployed to an AWS EC2 environment.

Recommended architecture:

```text
                    Internet
                       |
                       v
                 AWS EC2 Instance
                       |
                       v
                  Docker Engine
                       |
                       v
             Flask Container :80
                       |
                       v
                 Flask Application
```

For AWS EC2, allow inbound TCP traffic on port `80` in the EC2 Security Group if the application needs to be publicly accessible.

---

# 📋 Useful Commands

## Git

```bash
git status
git add .
git commit -m "update application"
git push origin main
```

## Python

```bash
python --version
pip --version
pip install -r requirements.txt
```

## Testing

```bash
pytest
pytest -v
```

## Docker

```bash
docker build -t github-actions-capstone .
docker images
docker ps
docker run -d -p 80:80 github-actions-capstone
docker logs github-actions-capstone
docker stop github-actions-capstone
docker rm github-actions-capstone
```

---

# 🔍 Troubleshooting

## Port 80 Already in Use

Check which process is using port 80:

```bash
sudo lsof -i :80
```

or:

```bash
sudo ss -lntp | grep :80
```

Stop the conflicting service or use another host port.

For example:

```bash
docker run -d -p 8080:80 github-actions-capstone
```

Then access:

```text
http://localhost:8080
```

The application inside the container still listens on port `80`.

---

## Docker Container Not Starting

Check:

```bash
docker ps -a
```

Then:

```bash
docker logs github-actions-capstone
```

---

## Tests Failing

Run:

```bash
pytest -v
```

Make sure dependencies are installed:

```bash
pip install -r requirements.txt
```

---

## Docker Hub Authentication Failure

Check:

```text
DOCKERHUB_USERNAME
DOCKER_TOKEN
```

Make sure:

- Username is correct
- Docker token is valid
- Token has appropriate permissions
- Repository/image name is correct

---

# 🎯 What This Project Demonstrates

This capstone demonstrates practical knowledge of:

### Git

- Repository management
- Branches
- Pull Requests
- Commits

### GitHub Actions

- Workflows
- Events
- Jobs
- Steps
- `workflow_call`
- Reusable workflows
- Workflow inputs
- Workflow outputs
- Secrets
- Variables
- Environments
- Scheduled workflows
- Manual workflow execution

### CI/CD

- Continuous Integration
- Automated testing
- Continuous Delivery
- Docker image publishing
- Deployment workflow
- Health monitoring

### Docker

- Dockerfile
- Docker image
- Docker container
- Port mapping
- Docker Hub
- Docker Buildx

### Testing

- Pytest
- Flask test client
- HTTP status validation
- Endpoint testing

---

# 📊 Pipeline Summary

| Stage | Tool | Purpose |
|---|---|---|
| Source Code | GitHub | Store code |
| Pull Request | GitHub Actions | Validate changes |
| Build | GitHub Actions | Prepare application |
| Test | Pytest | Validate application |
| Containerize | Docker | Create image |
| Registry | Docker Hub | Store image |
| Deployment | GitHub Actions | Deploy image |
| Monitoring | Health Check | Verify application |

---

# 📸 Recommended Screenshots

For project documentation, capture screenshots of:

1. GitHub repository
2. Pull Request workflow
3. Successful Pytest execution
4. Main CI/CD pipeline
5. Docker image on Docker Hub
6. Production deployment job
7. Scheduled health check
8. Successful `/health` response
9. Running Docker container

---

# 👨‍💻 Author

**Meraj**

GitHub:

https://github.com/Meraj0302

Project:

https://github.com/Meraj0302/github-actions-capstone

---

# ⭐ Project Goal

The goal of this project is to demonstrate a complete **GitHub Actions CI/CD implementation** where application changes are automatically tested, containerized, published to Docker Hub, deployed, and periodically health-checked.

```text
Code
 ↓
Pull Request
 ↓
Automated Tests
 ↓
Docker Build
 ↓
Docker Hub
 ↓
Deployment
 ↓
Health Check
```

**Built as part of DevOps Zero to Hero learning journey. 🚀**