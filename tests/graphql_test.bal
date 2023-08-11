import ballerina/graphql;
import ballerina/test;

// Test init method
isolated function testInitDataProvider() returns map<[boolean, string, graphql:ClientConfiguration]> {
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
        test:assertFail("Unexpected: GraphQlClient is error");
    }
}

// Test execute Method
isolated function testExecuteDataProvider() returns map<[string]> {
    map<[string]> dataSet = {
        "includedUsernameQuery": [
            string `
            query($userName:String!) {
                user(login: $userName){
                    contributionsCollection {
                        contributionCalendar {
                            totalContributions
                            weeks {
                                contributionDays {
                                    date
                                    contributionCount
                                    color
                                    weekday
                                }
                            }
                        }
                    }
                }
            }`
        ]
    };

    return dataSet;
}

@test:Config {
    dataProvider: testExecuteDataProvider
}
function testExecute(string query) returns error? {
    GraphQlClient|error graphqlClient = new;

    if graphqlClient is error {
        test:assertFail("Unexpected: GraphQlClient is error");
    }

    final graphql:Client mockedClient = test:mock(graphql:Client);
    record {|anydata...;|} res = {"username": "test"};
    test:prepare(mockedClient).when("execute").thenReturn(res);

    graphql:GenericResponseWithErrors|record {|anydata...;|}|json|graphql:ClientError result = check graphqlClient.execute(query = query);
    if result is graphql:GenericResponseWithErrors {
        test:assertFail("Unexpected: executed response is graphql:GenericResponseWithErrors");
    }
    if result is json {
        test:assertFail("Unexpected: executed response is json");
    }
    if result is graphql:ClientError {
        test:assertFail("Unexpected: executed response is graphql:ClientError");
    }
}
