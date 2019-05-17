import config from "../../../config/aws-config"
import parser from "./parser"
import DynamoDB from "aws-sdk/clients/dynamodb"
import uuid from "uuid"
import ParseError from "../../util/errors/parse-error"

export const handler = async (event, ctx) => {
    const client = new DynamoDB.DocumentClient()

    try {
        const parsed = parser(event)

        const item = {
            id: uuid.v1(),
            name: parsed.name,
            quantity: parsed.quantity,
        }

        await new Promise((resolve, reject) => {

            client.put(
                {
                    TableName: config.tables.list,
                    Item: item,
                    ConditionExpression: "attribute_not_exists(id)",
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
            body: JSON.stringify(item),
        }
    } catch (e) {
        if (e instanceof ParseError) {
            return { statusCode: 400, body: e.message }
        }

        return {
            statusCode: 500,
            body: `err: ${e.message}\nevent: ${JSON.stringify(event, null, 2)}`,
        }
    }
}
