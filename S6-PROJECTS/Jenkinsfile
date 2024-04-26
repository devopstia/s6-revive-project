pipeline {
    agent any
    triggers {
         githubPush()
    }
    environment {
        AWS_Cred = 'AWS_Cred'
    }
    options {
        buildDiscarder(logRotator(numToKeepStr: '7'))
        //skipDefaultCheckout(true)
        disableConcurrentBuilds()
        timeout (time: 60, unit: 'MINUTES')
        timestamps() 
    }
    stages {
        stage('Setup parameters') {
            steps {
                script {
                    properties([
                        parameters([
                          string(name: 'WARNTIME',
                            defaultValue: '0',
                            description: '''Warning time (in minutes) before starting upgrade'''),
                          string(
                            defaultValue: 'develop',
                            name: 'Please_leave_this_section_as_it_is',
                            trim: true
                            ),
                        ])
                    ])
                }
            }
        }
        stage('warning') {
            steps {
                   script {
                       notifyUpgrade(currentBuild.currentResult, "WARNING")
                       sleep(time:env.WARNTIME, unit:"MINUTES")
                }
            }
        }


        stage('Login') {
            environment {
               DOCKERHUB_CREDENTIALS=credentials('Dockerhub-jenkins')
               }
        	steps {
        		sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
        	   }
        }   
        stage('unit-test ui') {
            agent {
             docker {
               image 'devopseasylearning/maven-revive:v1.0.0'
               args '-u root:root'
            }    
        } 
            steps {
                sh '''
            cd REVIVE/src/ui
            mvn test -DskipTests=true
                '''
            }       
        }
        stage('unit-test catalog') {
            agent {
             docker {
               image 'devopseasylearning/golang02-revive:v1.0.0'
               args '-u 0:0'
            }    
        }
        steps {
                sh '''
            cd REVIVE/src/catalog 
            go test -buildscv=false
                '''
            }        
        }
        stage('unit-test cart') {
            agent {
             docker {
               image 'devopseasylearning/maven-revive:v1.0.0'
               args '-u root:root'
            }    
        }
        steps {
                sh '''
            cd REVIVE/src/cart
            mvn test -DskipTests=true
                '''
            }       
        }
        stage('unit-test orders') {
            agent {
             docker {
               image 'devopseasylearning/maven-revive:v1.0.0'
               args '-u root:root'
            }    
        }
        steps {
                sh '''
            cd REVIVE/src/orders
            mvn test -DskipTests=true
                '''
            }
        
        }
        stage('unit-test checkout') {
                agent {
                docker {
                   image 'devopseasylearning/nodejs01-revive:v1.0.0'
                   args '-u root:root'
                }    
            }
            steps {
                sh '''
                  cd REVIVE/src/checkout 
                  npm install
                    '''
                }            
        }
        stage('SonarQube analysis') {
                agent {
                    docker {
                      image 'devopseasylearning/sonar-scanner-revive:v1.0.0'
                    }
                   }
                   environment {
            CI = 'true'
            scannerHome='/opt/sonar-scanner'
        }
                steps{
                    withSonarQubeEnv('sonar') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        stage("Quality Gate") {
                steps {
                  timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
                  }
                }
              }      
        stage('Build ui') {
                steps {
                    sh '''
                    cd $WORKSPACE/REVIVE/src/ui
                    docker build -t 637423375996.dkr.ecr.us-east-1.amazonaws.com/ui:${BUILD_NUMBER} .
                    '''
                }
          }
          stage('Build catalog') {
              steps {
                  sh '''
                    cd $WORKSPACE/REVIVE/src/catalog
                    docker build -t 637423375996.dkr.ecr.us-east-1.amazonaws.com/catalog:${BUILD_NUMBER} .
                    docker build -t 637423375996.dkr.ecr.us-east-1.amazonaws.com/catalog-db:${BUILD_NUMBER} -f Dockerfile-db .
                  '''
              }
          }
        stage('Build cart') {
            steps {
                sh '''
                  cd $WORKSPACE/REVIVE/src/cart
                  docker build -t 637423375996.dkr.ecr.us-east-1.amazonaws.com/carts:${BUILD_NUMBER} .
                  docker build -t 637423375996.dkr.ecr.us-east-1.amazonaws.com/carts-db:${BUILD_NUMBER} -f Dockerfile-dynamodb .
                '''
            }
        }
        stage('Build orders') {
            steps {
                sh '''
                  cd $WORKSPACE/REVIVE/src/orders
                  docker build -t 637423375996.dkr.ecr.us-east-1.amazonaws.com/orders:${BUILD_NUMBER} .
                  docker build -t 637423375996.dkr.ecr.us-east-1.amazonaws.com/orders-db:${BUILD_NUMBER} -f Dockerfile-db .                 
                '''
            }
        }
        stage('Build checkout') {
            steps {
                sh '''
                cd $WORKSPACE/REVIVE/src/checkout
                docker build -t 637423375996.dkr.ecr.us-east-1.amazonaws.com/checkout:${BUILD_NUMBER} .
                docker build -t 637423375996.dkr.ecr.us-east-1.amazonaws.com/checkout-db:${BUILD_NUMBER} -f Dockerfile-db .
                '''
            }
        }
        stage('Build assets') {
            steps {
                sh '''
                  cd $WORKSPACE/REVIVE/src/assets
                  docker build -t 637423375996.dkr.ecr.us-east-1.amazonaws.com/asset:${BUILD_NUMBER} .
                  docker build -t 637423375996.dkr.ecr.us-east-1.amazonaws.com/asset-db:${BUILD_NUMBER} -f Dockerfile-rabbitmq .
                '''
            }
         }    
        stage('Configure AWS CLI') {          
            steps {
             script {
              withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                credentialsId: env.AWS_Cred,
                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                     ]])                      {   
                   sh 'aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}'
                   sh 'aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}'
                   sh 'aws configure set default.region "us-east-1"'
                   sh 'aws configure set default.output json'
             }
         }
         }
        }
        stage('Login ECR') {
           when{ 
         expression {
           env.GIT_BRANCH == 'origin/develop' }
           }
          steps {
            script {
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 637423375996.dkr.ecr.us-east-1.amazonaws.com'
            }
         }
        }
        stage('Push ui') {
           when{ 
         expression {
           env.GIT_BRANCH == 'origin/develop' }
           }
           steps {
               sh '''
               docker push 637423375996.dkr.ecr.us-east-1.amazonaws.com/ui:${BUILD_NUMBER}       
               '''
           }
        }
        stage('Push catalog') {
           when{ 
         expression {
           env.GIT_BRANCH == 'origin/develop' }
           }
           steps {
               sh '''
           docker push 637423375996.dkr.ecr.us-east-1.amazonaws.com/catalog:${BUILD_NUMBER}
           docker push 637423375996.dkr.ecr.us-east-1.amazonaws.com/catalog-db:${BUILD_NUMBER}
               '''
           }
        }
        stage('Push cart') {
           when{ 
         expression {
           env.GIT_BRANCH == 'origin/develop' }
           }
           steps {
               sh '''
           docker push 637423375996.dkr.ecr.us-east-1.amazonaws.com/carts:${BUILD_NUMBER}
           docker push 637423375996.dkr.ecr.us-east-1.amazonaws.com/carts-db:${BUILD_NUMBER}
               '''
           }
        }
        stage('Push orders') {
           when{ 
         expression {
           env.GIT_BRANCH == 'origin/develop' }
           }
           steps {
               sh '''
           docker push 637423375996.dkr.ecr.us-east-1.amazonaws.com/orders:${BUILD_NUMBER}
           docker push 637423375996.dkr.ecr.us-east-1.amazonaws.com/orders-db:${BUILD_NUMBER}
           
               '''
           }
        }
        stage('Push checkout') {
           when{ 
         expression {
           env.GIT_BRANCH == 'origin/develop' }
           }
           steps {
               sh '''
           docker push 637423375996.dkr.ecr.us-east-1.amazonaws.com/checkout:${BUILD_NUMBER}
           docker push 637423375996.dkr.ecr.us-east-1.amazonaws.com/checkout-db:${BUILD_NUMBER}
               '''
           }
        }
        stage('Push assets') {
           when{ 
           expression {
             env.GIT_BRANCH == 'origin/develop' }
           }
           steps {
                sh '''
            docker push 637423375996.dkr.ecr.us-east-1.amazonaws.com/asset:${BUILD_NUMBER}
            docker push 637423375996.dkr.ecr.us-east-1.amazonaws.com/asset-db:${BUILD_NUMBER}
                '''
            }
        }

        stage('helm-charts') {
            when {
                expression {
                    env.GIT_BRANCH == 'origin/develop'
                }
            }
            steps {
                script {
                    withCredentials([
                        sshUserPrivateKey(credentialsId: 'github-key', keyFileVariable: 'SSH_KEY')
                    ]) {
                        sh '''
rm -rf s6-revive-chart-repo || true 

git clone git@github.com:DEL-ORG/s6-revive-chart-repo.git   
cd s6-revive-chart-repo/helm-chart/
cat <<EOF > dev-values.yaml
repository:
  tag: ${BUILD_NUMBER}
  assets:
   image: 637423375996.dkr.ecr.us-east-1.amazonaws.com/asset

  carts:
   image: 637423375996.dkr.ecr.us-east-1.amazonaws.com/carts

  cart_dynamodb:
   image: 637423375996.dkr.ecr.us-east-1.amazonaws.com/carts-db
 
  catalog:
   image: 637423375996.dkr.ecr.us-east-1.amazonaws.com/catalog

 
  catalog_mysql:
   image: 637423375996.dkr.ecr.us-east-1.amazonaws.com/catalog-db

  checkout:
   image: 637423375996.dkr.ecr.us-east-1.amazonaws.com/checkout

  checkout_redis:
   image: 637423375996.dkr.ecr.us-east-1.amazonaws.com/checkout-db

  orders:
   image: 637423375996.dkr.ecr.us-east-1.amazonaws.com/orders

  orders_mysql:
   image: 637423375996.dkr.ecr.us-east-1.amazonaws.com/orders-db

  orders_rabbitmq:
   image: 637423375996.dkr.ecr.us-east-1.amazonaws.com/asset-db

  ui:
   image: 637423375996.dkr.ecr.us-east-1.amazonaws.com/ui
EOF
  git config --global user.email "info@devopseasylearning.com"
  git config --global user.name "devopseasylearning"
  git add -A
  git commit -m "Update image in values.yaml"
  git push origin HEAD:develop                   
                          '''
                    }
                }
            }
        }








    }

    post {
        always {
            script {
                notifyUpgrade(currentBuild.currentResult, "POST")
            }
        }    
    }
}

def notifyUpgrade(String buildResult, String whereAt) {
    if (Please_leave_this_section_as_it_is == 'origin/develop') {
        channel = 's6-revive-development-alerts'
    } else {
        channel = 's6-revive-development-alerts'
    }
    if (buildResult == "SUCCESS") {
        switch(whereAt) {
            case 'WARNING':
                slackSend(channel: channel,
                        color: "#439FE0",
                        message: "revive-app: Upgrade starting in ${env.WARNTIME} minutes @ ${env.BUILD_URL}  Application REVIVEAPP")
                break
            case 'STARTING':
                slackSend(channel: channel,
                        color: "good",
                        message: "revive-app: Starting upgrade @ ${env.BUILD_URL} Application REVIVEAPP")
                break
            default:
                slackSend(channel: channel,
                        color: "good",
                        message: "revive-app: Upgrade completed successfully @ ${env.BUILD_URL}  Application REVIVEAPP")
                break
        }
    } else {
        slackSend(channel: channel,
                color: "danger",
                message: "revive-app: Upgrade was not successful. Please investigate it immediately.  @ ${env.BUILD_URL}  Application REVIVEAPP")
    }
}
