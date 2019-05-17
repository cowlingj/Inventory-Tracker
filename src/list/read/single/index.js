import config from "../../../../config/aws-config"
import DynamoDB from "aws-sdk/clients/dynamodb"
import parser from "../all/parser"

export const handler = async (event, ctx) => {
    const parsed = parser(event)

    const client = new DynamoDB.DocumentClient()

    try {
        const data = await new Promise((resolve, reject) => {
            client.get(
                {
                    TableName: config.tables.list,
                    Key: parsed.id,
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
            body: JSON.stringify(data.Item),
        }
    } catch (e) {
        if (e instanceof ParseError) {
            return { statusCode: 400, body: e.message }
        }

        return { statusCode: 500, body: e.message }
    }
}
