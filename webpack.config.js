const path = require("path")
const FileManagerPlugin = require("filemanager-webpack-plugin")

module.exports = {
    entry: {
        "get-list": "./src/list/read/all/index.js",
        "get-list-item": "./src/list/read/single/index.js",
        "post-list": "./src/list/create/index.js",
        "put-list": "./src/list/update/index.js",
        "delete-list": "./src/list/delete/index.js",
        "get-report": "./src/report/read/index.js",
    },
    output: {
        libraryTarget: "commonjs",
        path: path.resolve(__dirname, "dist"),
        filename: "[name].js",
    },
    target: "node",
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: {
                    loader: "babel-loader",
                },
            },
        ],
    },
    plugins: [
        new FileManagerPlugin({
            onStart: {
                delete: ["dist/*", "deploy/build/*"],
            },
            onEnd: {
                archive: [
                    {
                        source: "dist/get-list.js",
                        destination: "deploy/build/get-list.zip",
                    },
                    {
                        source: "dist/get-list-item.js",
                        destination: "deploy/build/get-list-item.zip",
                    },
                    {
                        source: "dist/post-list.js",
                        destination: "deploy/build/post-list.zip",
                    },
                    {
                        source: "dist/put-list.js",
                        destination: "deploy/build/put-list.zip",
                    },
                    {
                        source: "dist/delete-list.js",
                        destination: "deploy/build/delete-list.zip",
                    },
                    {
                        source: "dist/get-report.js",
                        destination: "deploy/build/get-report.zip",
                    },
                ],
            },
        }),
    ],
}
