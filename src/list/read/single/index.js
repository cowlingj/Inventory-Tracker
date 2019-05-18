import config from "../../../../config/aws-config"
import DynamoDB from "aws-sdk/clients/dynamodb"
import parser from "./parser"
import ParseError from "../../../util/errors/parse-error"
import NotFoundError from "../../../util/errors/not-found-error"

export const handler = async (event, ctx) => {
    try {
        const parsed = parser(event)

        const client = new DynamoDB.DocumentClient()

        const data = await new Promise((resolve, reject) => {
            client.get(
                {
                    TableName: config.tables.list,
                    Key: { id: parsed.id },
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

        if (!data.Item) {
            throw new NotFoundError(parsed.id)
        }

        return {
            statusCode: 200,
            body: JSON.stringify(data.Item),
        }
    } catch (e) {
        if (e instanceof ParseError) {
            return { statusCode: 400, body: e.message }
        } else if (e instanceof NotFoundError) {
            return { statusCode: 404, body: "" }
        }

        return { statusCode: 500, body: e.message }
    }
}
