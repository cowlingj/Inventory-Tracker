export default function(event) {
    const offset =
        event.queryStringParameters && event.queryStringParameters.offset
            ? event.queryStringParameters.offset
            : 0
    const limit =
        event.queryStringParameters && event.queryStringParameters.limit
            ? event.queryStringParameters.limit
            : 25

    return { limit, offset }
}
