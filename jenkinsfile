pipeline{
    agent any

    environment{
        TF_HOME = tool('terraform')
        TF_INPUT = "0"
        TF_IN_AUTOMATION = true
        TF_LOG = "WARN"
        AWS_ACCESS_KEY_ID = credentials('aws-access-key')
        AWS_SECRET_KEY_ID = credentials('aws-secret-key')
     }
    stages{
        stage('git-checout'){
            steps{
                sh "checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[]]])"
            }
        }
        stage('config-init')
            steps{
                sh 'terrafrom --version'
                sh 'terrafrom init'
            }
        }
        stage('config-validation'){
            steps{
                sh 'terraform validate'

            }
        }
        stage('config-plan'){
            steps{
                sh 'terraform plan -out=DevopsPlan'
            }
        }
        stage('config-apply'){
            steps{
                script{
                    def apply = false
                    try{
                        input message: 'confirm apply', ok: 'Apply config'
                        apply = true
                    }catch(err){
                        apply = false
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
    }
    
}