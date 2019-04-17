import ParseError from "../../util/errors/parse-error"

export default function(event) {
    try {
        const body = JSON.parse(event.body)

        if (!body || !body.name || !body.quantity) {
            throw new Error()
        }

        return { name: body.name, quantity: body.quantity }
    } catch (e) {
        throw new ParseError(`could not parse event: ${event}`)
    }
}
