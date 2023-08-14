import ballerina/test;
import ballerina/graphql;

@test:Config {}
function testGetContributions() returns error? {
    // Mock
    githubClient = test:mock(graphql:Client);

    test:prepare(githubClient).when("execute").thenReturn(<record {|anydata...;|}>{
        "data": {
            "user": {
                "contributionsCollection": {
                    "contributionCalendar": {
                        "totalContributions": 1003,
                        "weeks": [
                            {
                                "contributionDays": [
                                    {
                                        "contributionCount": 1,
                                        "date": "2022-08-14T00:00:00.000+00:00",
                                        "color": "#9be9a8",
                                        "weekday": 0,
                                        "contributionLevel": "FIRST_QUARTILE"
                                    },
                                    {
                                        "contributionCount": 9,
                                        "date": "2022-08-15T00:00:00.000+00:00",
                                        "color": "#9be9a8",
                                        "weekday": 1,
                                        "contributionLevel": "FIRST_QUARTILE"
                                    },
                                    {
                                        "contributionCount": 1,
                                        "date": "2022-08-16T00:00:00.000+00:00",
                                        "color": "#9be9a8",
                                        "weekday": 2,
                                        "contributionLevel": "FIRST_QUARTILE"
                                    },
                                    {
                                        "contributionCount": 0,
                                        "date": "2022-08-17T00:00:00.000+00:00",
                                        "color": "#9be9a8",
                                        "weekday": 3,
                                        "contributionLevel": "FIRST_QUARTILE"
                                    },
                                    {
                                        "contributionCount": 0,
                                        "date": "2022-08-18T00:00:00.000+00:00",
                                        "color": "#9be9a8",
                                        "weekday": 4,
                                        "contributionLevel": "FIRST_QUARTILE"
                                    },
                                    {
                                        "contributionCount": 0,
                                        "date": "2022-08-19T00:00:00.000+00:00",
                                        "color": "#9be9a8",
                                        "weekday": 5,
                                        "contributionLevel": "FIRST_QUARTILE"
                                    },
                                    {
                                        "contributionCount": 1,
                                        "date": "2022-08-20T00:00:00.000+00:00",
                                        "color": "#9be9a8",
                                        "weekday": 6,
                                        "contributionLevel": "FIRST_QUARTILE"
                                    }
                                ]
                            }
                        ]
                    }
                }
            }
        }
    });

    final GraphQlClient|error graphqlClient = new;
    if graphqlClient is error {
        test:assertFail("Unexpected: GraphQlClient is error");
    }

    // execute
    final ContributionsResponse|error result = check graphqlClient.getContributions();

    // assert
    test:assertTrue(result is ContributionsResponse);
}
