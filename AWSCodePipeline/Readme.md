**gfgrepo** - Here we have the CodeCommit repository with the python application, unit test case, Dockerfile, requirements.txt, and imagedefination.json(used to mention the container details)

**buildspec.yml** - Here we have the codecommit buildspec file

**s3_bucket_policy** - here we have the policy for the s3 bucket(which would be created by codepipeline) you can use this policy if you get any Permission error
