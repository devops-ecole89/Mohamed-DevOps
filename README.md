## Workflow DevOps Project Overview
This project automates the creation, deployment, and testing of a basic Flask-based web application. It leverages **containerization with Docker**, a CI/CD pipeline using **GitHub Actions**, and script-driven workflows to streamline the entire development and deployment process.

### Key Functionalities:
1. A simple **Flask application** with routes for web content and running automated tests.
2. Automated testing using **pytest** before merging to specific branches (`develop` to `staging`).
3. Containerization with **Docker** for easy application deployment.
4. CI/CD pipeline implemented using **GitHub Actions** for build, test, and deployment tasks.
5. Version incrementing and automatic container updates with every build.

## Prerequisites
Before setting up the project on your machine, ensure you meet the following requirements:
1. **Python**: Version 3.9+ installed locally.
2. **Docker**: Installed and running on your system.
3. **Git**: Installed for repository cloning and version control.
4. **Requirements**: Install the dependencies listed in `requirements.txt`.

Use the following command to install them:
``` bash
pip install -r requirements.txt
```
For testing and deployment:
- A **GitHub account** to work with repositories and CI/CD pipelines.
- **Docker Hub credentials** with appropriate permissions to allow pushing images.

## Installation Instructions
Follow these steps to clone and install the project on your local machine:
1. Clone the repository:
``` bash
   git clone <repository_url>
   cd <repository_directory>
```
1. Install Python dependencies:
``` bash
   pip install -r requirements.txt
```
1. Build and run the Docker container interactively:
``` bash
   ./build_and_run.sh
```
> On successful execution, the application will be available on **[http://localhost:5000]()**.
> 

## Usage of the Project
### 1. **Application Features**
- **Homepage Route (`/`)**: Displays a web page with a simple message, "Je suis un site web".
- **Test Trigger Route (`/run-tests`)**: Runs the `pytest` automated tests and displays the results directly in the web browser.

### 2. **CI/CD Features**
This project includes GitHub Actions workflows for effective CI/CD:
- **test_develop.yml**: Automatically runs tests upon pushes to the `develop` branch and merges the branch to `staging` if all tests pass.
- **deploy.yml**: On a push to the `main` branch, it builds the Docker container and deploys it to Docker Hub.

### 3. **Build Automation**
The `build_and_run.sh` script performs the following:
- Increments the application version stored in `version.txt`.
- Builds a new Docker container image using the updated version.
- Starts the application using `docker-compose`.

### 4. **Docker Containerization**
The application is containerized with Docker:
- `Dockerfile`: Defines the Python base image and installs the required Python dependencies.
- `docker-compose.yml`: Exposes the application's routes on port 5000 for easy access.

Run the application with:
``` bash
docker-compose up
```
## Running Unit Tests Locally
To run all tests locally, use:
``` bash
pytest
```
The functionality of the `is_sudo.py` module is tested by `test_is_mohamed.py` to ensure correctness.
Sample output:
``` bash
============================= test session starts =============================
collected 3 items

test_is_mohamed.py ... [100%]

============================== 3 passed in 0.01s ==============================
```
## Deployment Workflow
1. **Develop & Test**:
    - Push changes to the `develop` branch.
    - Trigger automated tests using the `test_develop.yml` file.
    - Merges to `staging` if all tests pass.

2. **Build & Deploy** (Production):
    - Push to the `main` branch.
    - `deploy.yml` builds and pushes the Docker image to Docker Hub.

## Contribution Guidelines
1. Create a new branch for your feature or bug fix:
``` bash
   git checkout -b feature/new-feature
```
1. Make changes and ensure all tests pass locally:
``` bash
   pytest
```
1. Push changes to the `develop` branch and allow CI/CD workflows to act accordingly.
2. Merge into `main` only after deployment confirmation from CI workflows.

## Project Structure
``` plaintext
├── build_and_run.sh       # Script to automate builds and startup
├── compose.yml            # Docker Compose configuration
├── deploy.yml             # GitHub Actions workflow for Docker image deployment
├── Dockerfile             # Defines the container build process
├── main.py                # Flask application code
├── requirements.txt       # Python dependencies
├── test_develop.yml       # GitHub Actions workflow to test, merge `develop` to `staging`
├── test_is_mohamed.py     # Unit tests for `is_mohamed` function
├── is_sudo.py             # Contains the `is_mohamed` function
├── version.txt            # Tracks the app version for Docker
```
## Notes for Developers
- When modifying the `main.py` application, ensure compatibility with the `test_is_mohamed.py` test suite.
- Always verify the `build_and_run.sh` script works with the current `Dockerfile` setup.
- Use **secrets** for Docker Hub credentials in `deploy.yml`.

Feel free to open issues, contribute, or reach out for suggestions!
