import ParseError from "../../util/errors/parse-error"

export default function(event) {
    try {
        const body = JSON.parse(event.body)

        if (!body || typeof body.name != "string" || typeof body.quantity != "number") {
            console.log(`validation failed for: ${JSON.stringify(body)}`)
            throw new Error()
        }

        return { name: body.name, quantity: body.quantity }
    } catch (e) {
        throw new ParseError(`could not parse event: ${JSON.stringify(event)}`)
    }
}
