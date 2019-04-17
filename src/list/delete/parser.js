import ParseError from "../../util/errors/parse-error"

export default function(event) {
    if (!event.queryStringParameters || !event.queryStringParameters.id) {
        throw new ParseError(`can not parse event ${event}`)
    } else {
        return { id: event.queryStringParameters.id }
    }
}
