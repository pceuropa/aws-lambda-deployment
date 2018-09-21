# aws-lambda-deployment
CRUD to AWS Lambda by Bash - simple way to deploy your code to lamba.
Zip reguirements package only work with virtualenv (python3)

## preparation
```
chmod 750 deploy-lambda.sh
```

## Create
```
./deploy.sh
Action: [C]reate/[U]pdate/[R]ead/[D]elete? [c/r/u/d] c
Start process creating lambda function...
Zip requirements packages? [y/N] y
Add files to project.zip? [y/N] y
  adding: example.py (deflated 37%)
deploy.zip? [y/N] y
FunctionName:  testDeploy
Handler:  example.handle
```

In file lambda_config.json you have config data

```
cat lambda_config.json
{
    "FunctionName": "testDeploy",
    "FunctionArn": "arn:aws:lambda:eu-west-1:89076900000:function:testDeploy",
    "Runtime": "python3.6",
    "Role": "arn:aws:iam::89076900000:role/role_name",
    "Handler": "example.handler",
    "CodeSize": 3655718,
    "Description": "Description",
    "Timeout": 3,
    "MemorySize": 128,
    "LastModified": "2018-09-21T10:02:07.829+0000",
    "CodeSha256": "-Yy2-EuALNN8fb-qUZPKI51fUobEqBBc7w",
    "Version": "$LATEST",
    "TracingConfig": {
        "Mode": "PassThrough"
    },
    "RevisionId": "11117251-111a-1111-1f1f-11e11a51ca93"
}
```

## Read
```
Action: [C]reate/[U]pdate/[R]ead/[D]elete? [c/r/u/d] r
Function name:  testDeploy
```

## Update - upload only files
```
Action: [C]reate/[U]pdate/[R]ead/[D]elete? [c/r/u/d] u
Start process update lambda function...
Zip requirements packages? [y/N] n
Update lamba function? [y/N] y
updating: example.py (deflated 37%)
    "FunctionName": "testDeploy",
```


## Delete
```bash
Action: [C]reate/[U]pdate/[R]ead/[D]elete? [c/r/u/d] d
Config this project
Function name:  testDeploy
```
