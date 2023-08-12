import ballerina/graphql;
import ballerina/os;

configurable string githubGraphqlEndpoint = GITHUB_GRAPHQL_ENDPOINT;
configurable string githubUsername = os:getEnv(GITHUB_USERNAME);
configurable string githubPersonalAccessToken = os:getEnv(GITHUB_PERSONAL_ACCESS_TOKEN);

graphql:Client githubClient = check new (githubGraphqlEndpoint);

// Github graphql client
public class GraphQlClient {
    # Query execute used free query
    # Auto setting variables(username) and headers(token)
    #
    # + query - Query
    # + variables - Query parameter
    # + operationName - Operation name
    # + headers - Request headers
    # + return - Response
    public function execute(
            string query,
            map<anydata>? variables = (),
            string? operationName = (),
            map<string|string[]>? headers = ()
    ) returns graphql:GenericResponseWithErrors|record {|anydata...;|}|json|graphql:ClientError {

        // gen variables
        map<anydata> clonedVariables;
        if variables is () {
            clonedVariables = {[REQUEST_VARIABLE_USERNAME_KEY] : githubUsername};
        } else {
            clonedVariables = variables.clone();
            clonedVariables[REQUEST_VARIABLE_USERNAME_KEY] = githubUsername;
        }

        // gen headers
        map<string|string[]> clonedHeaders;
        if headers is () {
            clonedHeaders = {[REQUEST_HEADER_AUTHORIZATION_KEY] : string `bearer ${githubPersonalAccessToken}`};
        } else {
            clonedHeaders = headers.clone();
            clonedHeaders[REQUEST_HEADER_AUTHORIZATION_KEY] = string `bearer ${githubPersonalAccessToken}`;
        }

        record {|anydata...;|}|graphql:ClientError result = githubClient->execute(query, clonedVariables, operationName, clonedHeaders);

        return result;
    };

}
