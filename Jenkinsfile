pipeline {
    agent any 
    stages {
        stage('Build') { 
            steps {
                git url: 'https://github.com/asim0196/Ealastic_loadBalancer_project.git' ,branch: 'main'
            }
        }
        stage('Test') { 
            steps {
                echo "hello world vinu" 
            }
        }
        stage('Deploy') { 
            steps {
                echo "hello world asim" 
            }
        }
    }
}
