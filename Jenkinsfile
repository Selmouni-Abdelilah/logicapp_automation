pipeline {
    agent any
    tools {
        terraform "terraform"
    }
    stages {
        stage('Checkout') {
            steps {
                script {
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHubcredentials', url: 'https://github.com/Selmouni-Abdelilah/logicapp_automation']])
                }
            }
        }
        stage('Azure login'){
            steps{
                withCredentials([azureServicePrincipal('Azure_credentials')]) {
                    sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
                }
            }
        }
        stage('Create Logic App Infra') {
            steps {
                script {
                    dir('Logicapp_infra') {
                            sh 'terraform init -upgrade'
                            sh "terraform apply --auto-approve "
                            def resourceGroupName = sh (
                                script: 'terraform output -json resourcegrpname',
                                returnStdout: true
                            ).trim()
                            def logicAppName = sh (
                                script: 'terraform output -json logicappname',
                                returnStdout: true
                            ).trim()
                            env.RESOURCE_GROUP_NAME = resourceGroupName
                            env.LOGIC_APP_NAME = logicAppName   
                    }
                }
            }
        }    
    
        stage('Deploy Workflow') {
            steps {
                script { 
                   dir('Logicapp_wf') {
                        sh 'zip -r  workflow.zip ./*'
                        sh "az logicapp deployment source config-zip --name ${LOGIC_APP_NAME} --resource-group ${RESOURCE_GROUP_NAME}  --src workflow.zip"                                   
                    }
                }
            }
        }
    }
}