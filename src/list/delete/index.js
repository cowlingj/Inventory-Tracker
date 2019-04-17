import "../../../config/aws-config"
import { DynamoDB } from "aws-sdk"
import parser from "./parser"

export const handler = async (event, ctx) => {
    const client = new DynamoDB.DocumentClient()

    try {
        const parsed = parser(event)

        const data = await new Promise((resolve, reject) => {
            client.delete(
                {
                    TableName: "inventory-list-store-dev",
                    Key: {
                        // HashKey: id?
                        id: parsed.id,
                    },
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
            body: data,
        }
    } catch (e) {
        if (e instanceof ParseError) {
            return { statusCode: 400, body: e.message }
        }

        return { statusCode: 500, body: e }
    }
}