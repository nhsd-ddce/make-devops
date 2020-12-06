# TODO

- Refactoring
  - Make sure the `infrastructure` directory is custom and move away test files from it
  - Run `kubectl` from container
- Infrastructure
  - [Limit container resources](https://docs.docker.com/config/containers/resource_constraints/)
  - [Decouple data](https://www.terraform.io/docs/modules/composition.html)
  - More k8s example [network policies](https://www.stackrox.com/post/2019/04/setting-up-kubernetes-network-policies-a-detailed-guide/)
- Security
  - Replace the development SSL certificate by a secure one loaded by the CI/CD pipeline
  - Perform security analysis using [prowler](https://github.com/toniblyx/prowler)
- Development
  - Provide `tdd` and `dev` targets for Python to support development workflow
  - Implement `VERBOSE` flag to show/hide verbose script execution
  - Issue with the JS file formatting, see [Jsx indentation conflict vscode and eslint](https://stackoverflow.com/questions/48674208/jsx-indentation-conflict-vscode-and-eslint)
- Documentation
  - List features by module
  - Configuration of a CI/CD system, i.e. set mandatory variables
  - Docker library image usage
- Containers
  - Refactor the execution logic for the `postgres` Docker image
  - Should the `_replace_variables()` and `am_i_root()` functions be moved to `libinit.sh` script? E.g. https://github.com/bitnami/bitnami-docker-nginx/tree/master/1.18/debian-10/prebuildfs/opt/bitnami/scripts
  - Create reverse proxy configuration for `nginx`
  - Add `redis` for local Amazon ElastiCache
  - Add `dynamodb` for local Amazon DynamoDB
- Others
  - Move iTerm2 config file into the repository