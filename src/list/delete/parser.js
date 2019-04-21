import ParseError from "../../util/errors/parse-error"

export default function(event) {
    if (!event.queryStringParameters || typeof event.queryStringParameters.id != "string") {
        throw new ParseError(`can not parse event ${JSON.stringify(event)}`)
    } else {
        return { id: event.queryStringParameters.id }
    }
}
