# Logic App Automation using Terraform and Jenkins Pipeline
[![Azure](https://img.shields.io/badge/Azure-Ready-blue)](https://azure.com)
[![Jenkins](https://img.shields.io/badge/Jenkins-Ready-orange)](https://jenkins.io)
[![Terraform](https://img.shields.io/badge/Terraform-Ready-brightgreen)](https://terraform.io)

## Overview
This repository provides a solution for automating the deployment of a standard Logic App infrastructure on Azure using Terraform within a Jenkins pipeline. By following this guide, you can set up a continuous integration and deployment (CI/CD) pipeline to streamline the provisioning of Logic Apps in your Azure environment.

## Prerequisites
- Azure account with necessary permissions
- Jenkins installed and configured
- Terraform installed and configured
- Git installed
- Azure service principal with contributor access

## Getting Started
1. **Clone the Repository:**
```bash
git clone https://github.com/Selmouni-Abdelilah/logicapp_automation.git
   ```

2. **Configure Azure Credentials:**
- Create Azure service principal
- Add credentials to Jenkins

3. **Create Jenkins Pipeline:**
- Configure pipeline with Jenkinsfile
- Adjust configuration (e.g., repository URL, credentials)

4. **Update Terraform Configuration:**
- Modify `main.tf`, `variables.tf`, `outputs.tf`
- Update variables (e.g., resource group, Logic App name)

5. **Commit Changes:**
- Commit changes and push to remote repository

6. **Run the Pipeline:**
- Trigger pipeline execution
- Jenkins clones repo, authenticates with Azure, and executes Terraform commands

7. **Verify Deployment:**
- Check Azure portal for provisioned Logic App and resources

## Pipeline Structure
1. **Checkout:**
- Clones repository containing Terraform configuration

2. **Azure Login:**
- Authenticates with Azure using service principal credentials

3. **Create Logic App Infra:**
- Executes Terraform commands to initialize, plan, and apply infrastructure changes

4. **Deploy Workflow:**
- Packages Logic App workflow files into zip and deploys to provisioned Logic App in Azure

By following this guide, you can automate the deployment of standard Logic App infrastructure on Azure using Terraform within a Jenkins pipeline, enabling efficient and consistent provisioning of Logic Apps in your Azure environment.
