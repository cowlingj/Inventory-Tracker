import {config, DynamoDB} from "aws-sdk"

export const handler = async (event, ctx) => {
  if (event.queryStringParameters === undefined) {
    return Promise.resolve({
      statusCode: 400
    })
  }

  // const offset = event.queryStringParameters &&
  //                event.queryStringParameters.offset ?
  //                event.queryStringParameters.offset : 0
  const limit = event.queryStringParameters &&
                event.queryStringParameters.limit ?
                event.queryStringParameters.limit : 25 

  config.update({ region: "eu-west-1" })

  const client = new DynamoDB.DocumentClient()

  return await new Promise((resolve, reject) => {
    client.scan({
      TableName: "inventory-list-store-dev",
      ProjectionExpression: "id, #n, quantity",
      ExpressionAttributeNames: { "#n": "name" },
      Limit: limit
    }, (err, data) => {
      if (err) {
        return reject(err)
      } else {
        return resolve(data)
      }
    })
  }).then((data) => {
    return {
      statusCode: 200,
      body: data
    }
  })
}