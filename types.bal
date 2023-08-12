type ContributionsDataResponse record {|
    ContributionsUserResponse user;
|};

type ContributionsUserResponse record {|
    ContributionsCollection contributionsCollection;
|};

type ContributionsCollection record {|
    ContributionCalendar contributionCalendar;

|};

type ContributionCalendar record {|
    int totalContributions;
    Weeks[] weeks;
|};

type Weeks record {|
    ContributionDays contributionDays;
|};

type ContributionDays record {|
    string date;
    int contributionCount;
    string color;
    int weekday;
|};
