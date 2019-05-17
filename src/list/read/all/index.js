import config from "../../../../config/aws-config"
import DynamoDB from "aws-sdk/clients/dynamodb"
import parser from "./parser"
import ParseError from "../../../util/errors/parse-error"

export const handler = async (event, ctx) => {
    const parsed = parser(event)

    const client = new DynamoDB.DocumentClient()

    try {
        const data = await new Promise((resolve, reject) => {
            client.scan(
                {
                    TableName: config.tables.list,
                    ProjectionExpression: "id, #n, quantity",
                    ExpressionAttributeNames: { "#n": "name" },
                    Limit: parsed.limit,
                },
                (err, data) => {
                    if (err) {
                        return reject(err)
                    } else {
                        return resolve(data)
                    }
                }
            )
        })

        return {
            statusCode: 200,
            body: JSON.stringify({
                items: data.Items,
                next: data.LastEvaluatedKey,
            }),
        }
    } catch (e) {
        if (e instanceof ParseError) {
            return { statusCode: 400, body: e.message }
        }

        return { statusCode: 500, body: e.message }
    }
}
