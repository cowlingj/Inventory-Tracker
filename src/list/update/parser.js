export default function(event) {

  return new Promise((resolve, reject) => {
    try {
      const body = JSON.parse(event.body)
  
      if (!body || body.id) {
        throw new Error("invalid body provided")
      }
  
      resolve({ id: body.id, name: body.name, quantity: body.quantity })
  
    } catch (e) {
      reject(new ParseError(`could not parse event: ${event}`))
    }
  })
}