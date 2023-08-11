final string GET_CONTRIBUTIONS = string `
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
    }
`;
