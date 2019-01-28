rule foo:
    input:
        "data/run/sample-A-normal_1.fq.gz"
    output:
        "results/output.foo"
    log:
        "logs/foo/sample.log"
    shell:
        "ls -lht {input} > {output}"
