import ballerina/graphql;
import ballerina/test;

function testInitDataProvider() returns map<[boolean, string, graphql:ClientConfiguration]> {
    map<[boolean, string, graphql:ClientConfiguration]> dataSet = {
        "noneArgs": [false, "", {}]
    };

    return dataSet;
}

@test:Config {
    dataProvider: testInitDataProvider
}
function testInit(boolean isIncludeEndpoint, string serviceUrl, graphql:ClientConfiguration configuration) {
    final GraphQlClient|error testClient;
    if isIncludeEndpoint {
        testClient = new (serviceUrl, configuration);
    } else {
        testClient = new ();
    }

    if testClient is error {
        test:assertFail("GraphQlClient is error");
    }
}
