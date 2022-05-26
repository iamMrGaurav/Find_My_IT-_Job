var mysql = require("mysql2");
var dotenv = require("dotenv");
dotenv.config();

var connection = mysql.createConnection({
  host: "127.0.0.1",
  user: "root",
  password: "",
  database: "fmij",
  charset: "utf8mb4",
});

// var connection = mysql.createConnection({
//   host: "localhost",
//   user: "teisapce_gaurav",
//   password: "l=Iqo^HHr5oZ",
//   database: "teisapce_fmij",
//   charset: "utf8mb4",
// });
module.exports = connection;
