# Inventory Tracker Serverless

[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=round-square)](https://github.com/prettier/prettier)
[![built with: terraform](https://img.shields.io/badge/built_with-terraform-blueviolet.svg)](https://www.terraform.io/)
[![built with: aws lambda](https://img.shields.io/badge/built_with-aws-orange.svg)](https://aws.amazon.com/)
[![built with: npm](https://img.shields.io/badge/built_with-npm-red.svg)](https://www.npmjs.com/)

This is an implenentation of the Inventory Tracker API using the serverless
architecture aws lambda.

## Steps to Deploy

1. setup credentials by placing an aws credentials file in
   `deploy/secrets/aws/credentials`.
2. use `npm run buildDeploy` to build and deploy the service to AWS.
3. A side affect of the deployment is creating files for use in
   [Postman](https://www.getpostman.com/), and a set of configuration files in
   `deploy/build/secrets/`, these configuration files contain details like urls
   and api keys for communicating with the service (they should not be
   versioned).

> multiple deployments can exist concurrently by using different
> [terraform workspaces](https://www.terraform.io/docs/state/workspaces.html),

> A single deployment can be removed with `npm run teardown`

## Testing

The live api can be tested using Postman.

> **Api Gateway Dashboard**
>
> Testing using api gateway's own dashboard fails since api methods are given
> access to lambdas on a stage, method, and path basis
> (the test dashboard acts as a seperate stage, therefore it fails this
> authorization).
