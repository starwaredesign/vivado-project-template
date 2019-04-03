pipeline {
    agent {
        docker { 
            image 'vivado:2018.3'            
        }
    }
    stages {
        stage('Checkout') {
            steps { 
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh '/bin/bash -l scripts/build_fpga.sh'
            }
        }
    }
    post { 
        always {             
            archiveArtifacts artifacts: 'vivado/**/impl_1/*.bit,utilisation.csv'
            plot csvFileName: 'plot-e14c354f-d4b8-4942-9e76-a2423ad3a291.csv', csvSeries: [[displayTableFlag: false,
            exclusionValues: 'utilization.clb.lut.pct,utilization.clb.ff.pct,utilization.dsp.pct,utilization.ram.tile.pct',
            file: 'utilisation.csv', inclusionFlag: 'INCLUDE_BY_STRING', url: '']], group: 'FPGA resource utilisation', style: 'line', title: 'Resource utilisation', useDescr: true, yaxis: '[%]'
            cleanWs()
        }
    }
}
