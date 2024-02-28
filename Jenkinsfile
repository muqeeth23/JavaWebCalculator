pipeline {
    agent any

    stages {
        stage('clone') {
            steps {
                echo "this is checkout stage"
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/muqeeth23/JavaWebCalculator.git']]])
            }
        }
         stage('scan-qa') {
            steps {
                withSonarQubeEnv(installationName: 'sonarQ'){
                    sh './mvnw clean org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar'
                }
            }
        }
         stage('build') {
            steps {
                echo "this is the build stage"
                sh 'mvn package'
            }
        }
         stage('release') {
            steps {
                echo "this is release stage"
                nexusArtifactUploader artifacts: [[artifactId: 'WebAppCal', classifier: '', file: 'target/WebAppCal-0.0.2.war', type: 'war']], credentialsId: 'nexus', groupId: 'com.web.cal', nexusUrl: '3.110.67.107:8081/nexus/', nexusVersion: 'nexus2', protocol: 'http', repository: 'releases', version: '0.0.2'
            }
        }
    }
}
