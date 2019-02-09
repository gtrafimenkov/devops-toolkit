// SPDX-License-Identifier: MIT
// Copyright (c) 2019 Gennady Trafimenkov

pipeline {
    agent { docker { image 'ubuntu:18.04' } }
    stages {
        stage('build') {
            steps {
                sh './hello.sh'
            }
        }
    }
}
