import pandas as pd
import yaml

from snakemake.utils import validate, min_version

# set minimum snakemake version to the version its developed on
min_version("5.3.1")

# load config and mastersheet

configfile: "config.yaml"
#validate(config,schema="schemas/config.schema.yaml")

# target rules

rule all:
    input:
        "results/output.foo"

# Modules

include: "rules/foo.smk"
