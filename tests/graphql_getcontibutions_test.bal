import ballerina/test;
import ballerina/graphql;

type Test record {|
    anydata...;
|};

type TestRecord record {|
    int one;
    int two;
|};

@test:Config {}
function testSample() returns error? {
    final Test testData
= {
        "one": 1,
        "two": 2
    };

    final TestRecord testRecord = check testData.cloneWithType();

    test:assertEquals(testRecord, testData);

}

@test:Config {}
function testGetContributions() returns error? {
    // Mock
    githubClient = test:mock(graphql:Client);

    final GraphQlClient|error graphqlClient = new;
    if graphqlClient is error {
        test:assertFail("Unexpected: GraphQlClient is error");
    }

    test:prepare(githubClient).when("execute").thenReturn(
        <record {|anydata...;|}>{
        "data": {
            "user": {
                "contributionsCollection": {
                    "contributionCalendar": {
                        "totalContributions": 945,
                        "weeks": [
                            {
                                "contributionDays": [
                                    {
                                        "date": "2022-08-14T00:00:00.000+00:00",
                                        "contributionCount": 1,
                                        "color": "#9be9a8",
                                        "weekday": 0
                                    },
                                    {
                                        "date": "2022-08-15T00:00:00.000+00:00",
                                        "contributionCount": 9,
                                        "color": "#40c463",
                                        "weekday": 1
                                    },
                                    {
                                        "date": "2022-08-16T00:00:00.000+00:00",
                                        "contributionCount": 1,
                                        "color": "#9be9a8",
                                        "weekday": 2
                                    },
                                    {
                                        "date": "2022-08-17T00:00:00.000+00:00",
                                        "contributionCount": 0,
                                        "color": "#ebedf0",
                                        "weekday": 3
                                    },
                                    {
                                        "date": "2022-08-18T00:00:00.000+00:00",
                                        "contributionCount": 0,
                                        "color": "#ebedf0",
                                        "weekday": 4
                                    },
                                    {
                                        "date": "2022-08-19T00:00:00.000+00:00",
                                        "contributionCount": 0,
                                        "color": "#ebedf0",
                                        "weekday": 5
                                    },
                                    {
                                        "date": "2022-08-20T00:00:00.000+00:00",
                                        "contributionCount": 1,
                                        "color": "#9be9a8",
                                        "weekday": 6
                                    }
                                ]
                            }
                        ]
                    }
                }
            }
        }
    });

    // execute
    final ContributionsResponse|error result = check graphqlClient.getContributions();

    // assert
    test:assertTrue(result is ContributionsResponse);
}
