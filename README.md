![Static Badge](https://img.shields.io/badge/Ballerina-2201.7.1-1ab3ab)
![Static Badge](https://img.shields.io/badge/package-zerohack/github-1ab3ab)
<br/>
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/zero-hack-org/module-zerohack-github)
![GitHub repo size](https://img.shields.io/github/repo-size/zero-hack-org/module-zerohack-github)
<br/>
[![codecov](https://codecov.io/gh/zero-hack-org/module-zerohack-github/branch/main/graph/badge.svg?token=263B3XC36E)](https://codecov.io/gh/zero-hack-org/module-zerohack-github)
<br/>
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
<br/>
![Twitter Follow](https://img.shields.io/twitter/follow/y_morimoto_dev?style=social)

## module-zerohack-github

This package is used to get specific data from GitHub.

### Usage

#### 1. configurable variables settings

`githubGraphqlEndpoint`: Default [GitHub GraphQL](https://api.github.com/graphql)<br/>
`githubUsername` or ENV:`ZEROHACK_GITHUB_USERNAME`: GitHub username <br/>
`githubPersonalAccessToken` or ENV:`ZEROHACK_GITHUB_PERSONAL_ACCESS_TOKEN`: GitHub personal access token <br/>

#### 2. code sample

```ballerina
import ballerina/io;
import zerohack/github;


function main() {
    final github:GraphQlClient githubClient = new;
    final ContributionsResponse result = check graphqlClient.getContributions();
    io:println(result);
}
```

### Useful links

- Discuss code changes of the Ballerina project via [yuya-morimoto@zero-hack.jp](yuya-morimoto@zero-hack.jp).
- Published ballerina central ([Ballerina Central](https://central.ballerina.io/zerohack/github))

### License

This project is licensed under the Apache-2.0 License, see the [LICENSE](./LICENSE) file for details
