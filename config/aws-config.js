import { config } from "aws-sdk"

config.update({ region: "eu-west-1" })

export default {
  tables: {
    list: process.env["LIST_TABLE_NAME"],
    report: null
  }
}
