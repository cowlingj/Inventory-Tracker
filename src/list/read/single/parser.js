import ParseError from "../../../util/errors/parse-error"

export default function(event) {
    if (
        !event ||
        !event.pathParameters ||
        !event.pathParameters.id
    ) {
        throw new ParseError('cannot find path parameter "id"')
    }

    return { id: event.pathParameters.id }
}
