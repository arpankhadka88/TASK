pipeline {
    agent any

    parameters {
        string(
            name: 'REFERENCE_TAG',
            defaultValue: 'v1.0.0',
            description: 'Git tag to compare against HEAD'
        )
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Fetch Tags') {
            steps {
                sh 'git fetch --all --tags'
            }
        }

        stage('Validate Tag') {
            steps {
                sh '''
                    echo "Reference tag: ${REFERENCE_TAG}"
                    echo "Current commit: $(git rev-parse --short HEAD)"

                    if ! git rev-parse "${REFERENCE_TAG}" >/dev/null 2>&1; then
                      echo "❌ Tag '${REFERENCE_TAG}' does not exist"
                      exit 1
                    fi
                '''
            }
        }

        stage('Generate Diff Reports') {
            steps {
                sh '''
                    echo "📌 Commits after tag ${REFERENCE_TAG}:" | tee commits.txt
                    git log "${REFERENCE_TAG}"..HEAD --oneline | tee -a commits.txt

                    echo "📁 Files changed after tag ${REFERENCE_TAG}:" | tee changed-files.txt
                    git diff --name-only "${REFERENCE_TAG}"..HEAD | tee -a changed-files.txt

                    echo "🧩 Detailed changes:" | tee detailed-diff.txt
                    git diff "${REFERENCE_TAG}"..HEAD | tee -a detailed-diff.txt
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '*.txt', fingerprint: true
        }
        failure {
            echo '❌ Pipeline failed'
        }
        success {
            echo '✅ Diff reports generated successfully'
        }
    }
}
