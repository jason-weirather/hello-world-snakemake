{
    "cwlVersion": "v1.0",
    "$graph": [
        {
            "class": "CommandLineTool",
            "id": "#snakemake-job",
            "label": "Snakemake job executor",
            "hints": [
                {
                    "dockerPull": "quay.io/snakemake/snakemake:v5.4.0",
                    "class": "DockerRequirement"
                }
            ],
            "baseCommand": "snakemake",
            "requirements": {
                "ResourceRequirement": {
                    "coresMin": "$(inputs.cores)"
                }
            },
            "arguments": [
                "--force",
                "--keep-target-files",
                "--keep-remote",
                "--force-use-threads",
                "--wrapper-prefix",
                "https://bitbucket.org/snakemake/snakemake-wrappers/raw/",
                "--notemp",
                "--quiet",
                "--use-conda",
                "--no-hooks",
                "--nolock",
                "--mode",
                "1"
            ],
            "inputs": {
                "snakefile": {
                    "type": "File",
                    "default": {
                        "class": "File",
                        "location": "Snakefile"
                    },
                    "inputBinding": {
                        "prefix": "--snakefile"
                    }
                },
                "sources": {
                    "type": "File[]",
                    "default": [
                        {
                            "class": "File",
                            "location": "README.md"
                        },
                        {
                            "class": "File",
                            "location": "Snakefile"
                        },
                        {
                            "class": "File",
                            "location": "config.yaml"
                        },
                        {
                            "class": "File",
                            "location": "rules/foo.smk"
                        }
                    ]
                },
                "cores": {
                    "type": "int",
                    "default": 1,
                    "inputBinding": {
                        "prefix": "--cores"
                    }
                },
                "rules": {
                    "type": "string[]?",
                    "inputBinding": {
                        "prefix": "--allowed-rules"
                    }
                },
                "input_files": {
                    "type": "File[]",
                    "default": []
                },
                "target_files": {
                    "type": "string[]?",
                    "inputBinding": {
                        "position": 0
                    }
                }
            },
            "outputs": {
                "output_files": {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputBinding": {
                        "glob": "$(inputs.target_files)"
                    }
                }
            }
        },
        {
            "class": "Workflow",
            "requirements": {
                "InlineJavascriptRequirement": {},
                "MultipleInputFeatureRequirement": {}
            },
            "steps": [
                {
                    "run": "#snakemake-job",
                    "requirements": {
                        "InitialWorkDirRequirement": {
                            "listing": [
                                {
                                    "writable": true,
                                    "entry": "$({'class': 'Directory', 'basename': 'results', 'listing': [{'class': 'File', 'basename': 'output.foo', 'location': inputs.input_files[0].location}]})"
                                }
                            ]
                        }
                    },
                    "in": {
                        "cores": {
                            "default": 1
                        },
                        "target_files": {
                            "default": []
                        },
                        "rules": {
                            "default": [
                                "all"
                            ]
                        },
                        "input_files": {
                            "source": [
                                "#main/job-1/output_files"
                            ],
                            "linkMerge": "merge_flattened"
                        }
                    },
                    "out": [
                        "output_files"
                    ],
                    "id": "#main/job-0"
                },
                {
                    "run": "#snakemake-job",
                    "requirements": {
                        "InitialWorkDirRequirement": {
                            "listing": [
                                {
                                    "writable": true,
                                    "entry": "$({'class': 'Directory', 'basename': 'data', 'listing': [{'class': 'Directory', 'basename': 'run', 'listing': [{'class': 'File', 'basename': 'sample-A-normal_1.fq.gz', 'location': inputs.input_files[0].location}]}]})"
                                }
                            ]
                        }
                    },
                    "in": {
                        "cores": {
                            "default": 1
                        },
                        "target_files": {
                            "default": [
                                "results/output.foo"
                            ]
                        },
                        "rules": {
                            "default": [
                                "foo"
                            ]
                        },
                        "input_files": {
                            "source": [
                                "#main/input/job-1"
                            ],
                            "linkMerge": "merge_flattened"
                        }
                    },
                    "out": [
                        "output_files"
                    ],
                    "id": "#main/job-1"
                }
            ],
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "default": [
                        {
                            "class": "File",
                            "location": "data/run/sample-A-normal_1.fq.gz"
                        }
                    ],
                    "id": "#main/input/job-1"
                }
            ],
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputSource": "#main/job-0/output_files",
                    "id": "#main/output/job-0"
                }
            ],
            "id": "#main"
        }
    ]
}