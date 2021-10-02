# Description

This is a playground with terraform, where i create several AWS resources. The goal is to figure out how to automate those processes and avoid the regular GUI approach.

### Usage:

_An installed terraform is required._

U will need ur own configuration file with the required credentials. In order to get the credentials u need to sign up for an AWS account. A demo file is supplyed, so that it can be cloned.

Once the account is created and credentials are setup, u can go and run:

- to see the affecting changes:
terraform plan

- to apply the changes:
terraform apply

- to undo all the terraform actions:
terraform plan -destroy -out destroy.plan
