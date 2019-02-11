# https://bitbucket.org/snakemake/snakemake/issues/794/snakemake-kubernetes-demo-with-minikube
rule HelloWorld :
     singularity :
       "docker://rootproject/root-ubuntu16"
     shell :
       "root -b -q scripts/helloworld.C+"
