# Test Roles

Summarize the configuration of the tests directory

```bash
project/tests
  - Config.toml : For setting configurable variables
  - README.md : Readme
  - {filename}_{function_name}.bal or {function_name}.bal
```

## File split roles

Create a file for each function or target...

## Naming roles

| No  | Format                                      | Description                                        |
| --- | ------------------------------------------- | -------------------------------------------------- |
| 1   | {filename}\_{function_name(snake_case)}.bal | test target function and file name are different   |
| 2   | {function_name(snake_case)}.bal             | only one function and filename equal function name |
