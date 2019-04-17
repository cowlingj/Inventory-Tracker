import "../../../config/aws-config"
import parser from "../update/parser"
import { DynamoDB } from "aws-sdk"
import uuid from "uuid"
import ParseError from "../../util/errors/parse-error"

export const handler = async (event, ctx) => {
    const client = new DynamoDB.DocumentClient()

    try {
        const parsed = parser(event)
        const data = await new Promise((resolve, reject) => {
            client.update(
                {
                    Key: { HashKey: ":id" },
                    AttributeUpdates: {
                        id: {
                            Value: uuid.v1(),
                            Action: "ADD",
                        },
                        name: {
                            Value: parsed.name,
                            Action: "ADD",
                        },
                        quantity: {
                            Value: parsed.quantity,
                            Action: "ADD",
                        },
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
