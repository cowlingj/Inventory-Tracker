import "../../../config/aws-config"
import {DynamoDB} from "aws-sdk"
import parser from "./parser";

export const handler = async (event, ctx) => {
  if (event.queryStringParameters === undefined) {
    return Promise.resolve({
      statusCode: 400
    })
  }

  const parsed = parser(event)

  const client = new DynamoDB.DocumentClient()

  try {
  const data = await new Promise((resolve, reject) => {
    client.scan({
      TableName: "inventory-list-store-dev",
      ProjectionExpression: "id, #n, quantity",
      ExpressionAttributeNames: { "#n": "name" },
      Limit: parsed.limit
    }, (err, data) => {
      if (err) {
        return reject(err)
      } else {
        return resolve(data)
      }
    })
  })
  
  return {
    statusCode: 200,
    body: data
  }
  } catch (e) {

    if (e instanceof ParseError) {
      return { statusCode: 400, body: e.message }
    }

    return { statusCode: 500, body: e }
  }
}