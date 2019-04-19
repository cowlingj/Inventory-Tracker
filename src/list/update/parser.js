import ParseError from "../../util/errors/parse-error"

export default function(event) {
    try {
        const body = JSON.parse(event.body)

        if (!body || !body.id) {
            throw new Error(`could not parse event: ${JSON.stringify(event)}`)
        }

        return { id: body.id, name: body.name, quantity: body.quantity }
    } catch (e) {
        throw new ParseError(e.message)
    }
}
