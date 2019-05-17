import ParseError from "../../../util/errors/parse-error"

export default function(event) {
    if (
        !event ||
        !event.queryStringParameters ||
        !event.queryStringParameters.id
    ) {
        throw new ParseError('cannot find query string parameter "id"')
    }

    return { id: event.queryStringParameters.id }
}
