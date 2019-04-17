import "../../../config/aws-config"
import { DynamoDB } from "aws-sdk"
import parser from "./parser"

export const handler = async (event, ctx) => {
    try {
        const parsed = parser(event)

        const client = new DynamoDB.DocumentClient()

        const updates = {
            id: {
                Value: parsed.id,
                Action: "ADD",
            },
            name: parsed.name
                ? { Value: parsed.name, Action: "ADD" }
                : undefined,
            quantity: parsed.quantity
                ? { Value: parsed.quantity, Action: "ADD" }
                : undefined,
        }

        return await new Promise((resolve, reject) => {
            client.update(
                {
                    Key: { HashKey: ":id" },
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
        }).then(data => {
            return {
                statusCode: 200,
                body: data,
            }
        })
    } catch (e) {
        if (e instanceof ParseError) {
            return { statusCode: 400, body: e.message }
        }

        return { statusCode: 500, body: e }
    }
}
