var mysql = require("mysql2");

let connection = mysql.createConnection({
  host: "127.0.0.1",
  user: "root",
  password: "root@localhost",
  database: "fmij",
});

connection.connect((err) => {
  if (err) {
    throw err;
  } else {
    console.log("Success");
  }
});

connection.query("SELECT * FROM users;", (err, result) => {
  if (err) throw err;
  console.log(result);
});
