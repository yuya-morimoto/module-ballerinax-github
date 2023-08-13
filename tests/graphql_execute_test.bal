import ballerina/graphql;
import ballerina/test;

# Test data for execute function
#
# + isOnlyRequireArgs - only require arguments flug
# + query - arg query
# + variables - arg variables
# + operationName - arg operationName
# + headers - arg headers
# + executeMockedResponse - response of mocked execute function
# + expected - expected value
type TestExecuteData record {|
    boolean isOnlyRequireArgs;
    string query;
    map<anydata>? variables;
    string? operationName;
    map<string|string[]>? headers;
    graphql:GenericResponseWithErrors|record {|anydata...;|}|json|graphql:ClientError executeMockedResponse;
    graphql:GenericResponseWithErrors|record {|anydata...;|}|json|graphql:ClientError expected;

|};

# Test data provider for execute function
# + return - test data
isolated function testExecuteDataProvider() returns map<[TestExecuteData]> {
    map<[TestExecuteData]> dataSet = {
        "onlyQueryArgs": [
            {
                isOnlyRequireArgs: true,
                query: string `
                    query($userName:String!) {
                        user(login: $userName){
                            name
                        }
                    }`,
                variables: (),
                operationName: (),
                headers: (),
                executeMockedResponse: <record {|anydata...;|}>{"data": {"user": {"name": "test-user"}}},
                expected: <record {|anydata...;|}>{"data": {"user": {"name": "test-user"}}}
            }
        ],
        "allArgs": [
            {
                isOnlyRequireArgs: false,
                query: string `
                    query($userName:String!) {
                        user(login: $userName){
                            name
                        }
                    }`,
                variables: {username: "setting-user"},
                operationName: "setting",
                headers: {"Authorization": "bearer test1234567890"},
                executeMockedResponse: <record {|anydata...;|}>{"data": {"user": {"name": "setting-user"}}},
                expected: <record {|anydata...;|}>{"data": {"user": {"name": "setting-user"}}}
            }
        ],
        "jsonResponse": [
            {
                isOnlyRequireArgs: false,
                query: string `
                    query($userName:String!) {
                        user(login: $userName){
                            name
                        }
                    }`,
                variables: {username: "setting-user"},
                operationName: "setting",
                headers: {"Authorization": "bearer test1234567890"},
                executeMockedResponse: <json>{"data": {"user": {"name": "setting-user"}}},
                expected: <json>{"data": {"user": {"name": "setting-user"}}}
            }
        ],
        "genericResponseWithErrorsResponse": [
            {
                isOnlyRequireArgs: false,
                query: string `
                    query($userName:String!) {
                        user(login: $userName){
                            name
                        }
                    }`,
                variables: {username: "setting-user"},
                operationName: "setting",
                headers: {"Authorization": "bearer test1234567890"},
                executeMockedResponse: <graphql:GenericResponseWithErrors>{extensions: (), data: (), errors: ()},
                expected: <graphql:GenericResponseWithErrors>{extensions: (), data: (), errors: ()}
            }
        ]
    };

    return dataSet;
}

# Test for execute function
#
# + testData - test data
# + return - error?
@test:Config {
    dataProvider: testExecuteDataProvider
}
function testExecute(TestExecuteData testData) returns error? {

    // Mock
    githubClient = test:mock(graphql:Client);

    // Prepare
    final GraphQlClient|error graphqlClient = new;
    if graphqlClient is error {
        test:assertFail("Unexpected: GraphQlClient is error");
    }

    test:prepare(githubClient).when("execute").thenReturn(testData.executeMockedResponse);

    // execute
    final graphql:GenericResponseWithErrors|record {|anydata...;|}|json|graphql:ClientError result;
    if testData.isOnlyRequireArgs {
        result = check graphqlClient.execute(testData.query);
    } else {
        result = check graphqlClient.execute(testData.query, testData.variables, testData.operationName, testData.headers);
    }

    // assert
    final graphql:GenericResponseWithErrors|record {|anydata...;|}|json|graphql:ClientError expected = testData.expected;
    if expected is error {
        test:assertFail("Unexpected: error graphql:ClientError");
    } else {
        test:assertEquals(result, expected, "Assert executed result");
    }
}
