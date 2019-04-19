import "../../../config/aws-config"
import parser from "./parser"
import DynamoDB from "aws-sdk/clients/dynamodb"
import uuid from "uuid"
import ParseError from "../../util/errors/parse-error"

export const handler = async (event, ctx) => {
    const client = new DynamoDB.DocumentClient()
    let updates = undefined

    try {
        const parsed = parser(event)
        updates = {
            name: {
                Value: parsed.name,
                Action: "PUT",
            },
            quantity: {
                Value: parsed.quantity,
                Action: "PUT",
            },
        }
        const data = await new Promise((resolve, reject) => {
            const id = uuid.v1()

            client.update(
                {
                    TableName: "inventory-list-store-dev",
                    Key: { id },
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

        return {
            statusCode: 500,
            body: `err: ${e.message} parsed: ${JSON.stringify(event, null, 2)}`,
        }
    }
}
