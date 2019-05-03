
pipeline {
  agent {
    kubernetes {
        label 'bsu-s1-deployment-qa'
        cloud 'kubernetes'
        defaultContainer 'jnlp'
        yaml """
apiVersion: v1
kind: Pod
metadata:
    namespace: jenkins
    labels:
        name: jnlp
spec:
  nodeSelector:
    kubernetes.io/hostname: 'cnpvgl56588417'
  containers:
  - name: jnlp
    image: registry.gcsc.sap.corp/sports/sports-system-setup:v122_23_without_hana_jnlp
    imagePullPolicy: Always
    env:
    - name: JENKINS_URL
      value: 'http://jenkins-master.jenkins.svc.cluster.local:8080'
    - name: USER
      value: '${USER}'
    - name: PASSWORD
      value: '${PASSWORD}'
    - name: HOST
      value: '${HOST}'
    - name: PORT
      value: '${PORT}'
    - name: VERSION
      value: '${VERSION}'
    - name: DAEMON_MODE
      value: '${DAEMON_MODE}'
    - name: STOP_JOBS
      value: '${STOP_JOBS}'
    - name: HANA_TEST_TOOLS_VERSION
      value: '${HANA_TEST_TOOLS_VERSION}'
    - name: IMPORT_OPTION
      value: '${IMPORT_OPTION}'
    - name: SKIP_INSTALLATION
      value: '${SKIP_INSTALLATION}'
    - name: SKIP_SETUP
      value: '${SKIP_SETUP}'
    - name: DEBUG_MODE
      value: '${DEBUG_MODE}'
    - name: BATCH_MODE
      value: '${BATCH_MODE}'
    - name: REPO
      value: '${REPO}'
    - name: ADDITIONAL_DUS
      value: '${ADDITIONAL_DUS}'
    - name: SYSTEM_SETTINGS
      value: '${SYSTEM_SETTINGS}'
"""
    }
  }
stages {
    stage ('deploy') { 
        steps {
        	sh '/tools/setup_system'

        }
    }
  }
}