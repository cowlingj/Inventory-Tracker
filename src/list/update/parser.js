import ParseError from "../../util/errors/parse-error"

export default function(event) {
            const body = JSON.parse(event.body)

            if (!body || !body.id) {
                throw new ParseError(`could not parse event: ${JSON.stringify(event)}`)
            }

            return { id: body.id, name: body.name, quantity: body.quantity }
        }
