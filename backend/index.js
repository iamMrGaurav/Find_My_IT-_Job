const cors = require("cors");
const express = require("express");
const dotenv = require("dotenv");
dotenv.config();
const app = express();
const http = require("http");
const httpServer = http.createServer(app);
var io = require("socket.io")(httpServer, {
  cors: { origin: "*" },
});
app.use(cors());
const login = require("./routes/login.js");
const admin = require("./routes/admin.js");
const forgot_pass = require("./routes/forgot_pass.js");
const { json, urlencoded } = require("express");
const register = require("./routes/register.js");
const verification = require("./routes/verification.js");
const googlelogin = require("./routes/googlelogin.js");
const setupProfile = require("./routes/setup_profile.js");
const company = require("./routes/company.js");
const seeker = require("./routes/seeker.js");

const multer = require("multer");
const { compareSync } = require("bcrypt");
app.use("/images", express.static("images"));
app.use("/cv", express.static("cv"));

var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "./images");
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + file.originalname);
  },
});

const upload = multer({ storage: storage });

app.use(json());

// app.use(cors());

app.use(
  urlencoded({
    extended: true,
  })
);

app.use("/forgot_pass", forgot_pass);
app.use("/login", login);
app.use("/admin_home", admin);
app.use("/register", register);
app.use("/verification", verification);
app.use("/googlelogin", googlelogin);
app.use("/company", company);
app.use("/stats", upload.single("file_field"), setupProfile);
app.use("/seeker", seeker);

var users = {};

io.on("connection", (socket) => {
  socket.on("login", (user) => {
    user = JSON.parse(user);
    users[socket.id.toString()] = user.userName;
    console.log(`${user.userName} Logged In ${socket.id}`);
  });

  socket.on("sendMessage", (data) => {
    data = JSON.parse(data);

    let receiver = data.receiverName;
    let companyId = data.companyId;
    let seekerId = data.seekerId;
    let message = data.message;
    let sender = data.sender;

    if (receiver && message && companyId && seekerId && message && sender) {
      let receiverId = Object.keys(users).find(
        (key) => users[key] === receiver
      );

      let isReceiverActive = false;
      if (receiverId) isReceiverActive = true;

      if (isReceiverActive) {
        let messageResponse = {
          receiverName: receiver,
          companyId: companyId,
          seekerId: seekerId,
          message: message,
          sender: sender,
        };
        io.to(receiverId).emit("receive-message", messageResponse);
      }
    }
  });
  socket.on("disconnect", () => {
    console.log(`${users[socket.id]} Disconnected`);
    delete users[socket.id];
  });
});

httpServer.listen(process.env.PORT || 4000);
