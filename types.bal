public type ContributionsResponse record {|
    ContributionsDataResponse data;
|};

public type ContributionsDataResponse record {|
    ContributionsUserResponse user;
|};

public type ContributionsUserResponse record {|
    ContributionsCollection contributionsCollection;
|};

public type ContributionsCollection record {|
    ContributionCalendar contributionCalendar;

|};

public type ContributionCalendar record {|
    int totalContributions;
    Weeks[] weeks;
|};

public type Weeks record {|
    ContributionDays[] contributionDays;
|};

public type ContributionDays record {|
    string date;
    int contributionCount;
    string color;
    int weekday;
|};
