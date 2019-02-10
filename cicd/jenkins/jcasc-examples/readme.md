# Jenkins Configuration as Code Examples

## Add multibranch project

```yaml
jobs:
  - script: >
      multibranchPipelineJob('configuration-as-code') {
          branchSources {
              git {
                  id = 'configuration-as-code'
                  remote('https://github.com/gtrafimenkov/example-cicd-simple-bash.git')
              }
          }
      }
```
