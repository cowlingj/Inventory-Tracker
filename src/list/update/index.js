import config from "../../../config/aws-config"
import DynamoDB from "aws-sdk/clients/dynamodb"
import parser from "./parser"
import ParseError from "../../util/errors/parse-error"

export const handler = async (event, ctx) => {
    try {
        const parsed = parser(event)

        const client = new DynamoDB.DocumentClient()

        const update =
            "" +
            (parsed.name ? `SET #n = :n` : "") +
            (parsed.quantity ? "SET quantity = :q" : "")

        const names = {
            "#n": parsed.name ? "name" : undefined,
        }

        const values = {
            ":n": parsed.name ? parsed.name : undefined,
            ":q": parsed.quantity ? parsed.quantity : undefined,
        }

        const data = await new Promise((resolve, reject) => {
            client.update(
                {
                    TableName: config.tables.list,
                    Key: { id: parsed.id },
                    UpdateExpression: update,
                    ExpressionAttributeNames: names,
                    ExpressionAttributeValues: values,
                    ConditionExpression: "attribute_exists(id)",
                    ReturnValues: "ALL_NEW",
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
            body: JSON.stringify(data.Attributes),
        }
    } catch (e) {
        if (e instanceof ParseError) {
            return { statusCode: 400, body: e.message }
        }

        return { statusCode: 500, body: e.message }
    }
}
