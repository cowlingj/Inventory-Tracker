import config from "../../../config/aws-config"
import DynamoDB from "aws-sdk/clients/dynamodb"
import parser from "./parser"

export const handler = async (event, ctx) => {
    try {
        const parsed = parser(event)

        const client = new DynamoDB.DocumentClient()

        const updates = {
            name: parsed.name
                ? { Value: parsed.name, Action: "PUT" }
                : undefined,
            quantity: parsed.quantity
                ? { Value: parsed.quantity, Action: "PUT" }
                : undefined,
        }

        const data = await new Promise((resolve, reject) => {
            client.update(
                {
                    TableName: config.tables.list,
                    Key: { id: parsed.id },
                    AttributeUpdates: updates,
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
            body: JSON.stringify(data),
        }
    } catch (e) {
        if (e instanceof ParseError) {
            return { statusCode: 400, body: e.message }
        }

        return { statusCode: 500, body: e.message }
    }
}
