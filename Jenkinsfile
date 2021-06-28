/* groovylint-disable NestedBlockDepth, VariableTypeRequired */
pipeline {
    agent any
    environment {
         TF_HOME = tool('terraform')
        TF_INPUT = "0"
        TF_IN_AUTOMATION = true
        TF_LOG = "WARN"
        AWS_ACCESS_KEY_ID = credentials('aws-access-key')
        AWS_SECRET_KEY_ID = credentials('aws-secret-key')
    }

    stages {
        stage('git-checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']],
                 doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs:  
                 [[url: 'https://github.com/yaw4testing/terraform-cicd.git']]])
            }
        }
        stage('config-init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('config-validate') {
            steps {
                sh 'terraform validate'
            }
        }
        stage('confgig-plan') {
            steps {
                sh 'terraform plan -out="DevOpsPlan"'
            }
        }
        stage('config-apply') {
            steps {
                script {
                    /* groovylint-disable-next-line NoDef */
                    def apply = false
                    /* groovylint-disable-next-line SpaceAfterClosingBrace */
                    try {
                        sh 'terraform apply "DevOpsPlan"'
                        input message: 'confirm apply', ok: 'apply config'
                        apply = true 
                    }catch (err) {
                        apply = false
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
    }
}
