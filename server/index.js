const express = require("express");
const mongoose = require("mongoose");
const app = express();

const AuthRouter = require("./routes/auth");
// const { default: mongoose } = require("mongoose");
app.use(express.json());
app.use(AuthRouter);
// app.use()

mongoose
  .connect(
    "mongodb+srv://Abdulbazeet:Ba1za22ta@cluster0.fije88r.mongodb.net/?retryWrites=true&w=majority"
  )
  .then(() => {
    console.log("Connection made with MongoDB");
    app.listen(3000,"0.0.0.0", () => {
      console.log("Connected");
    });
  })
  .catch((e) => {
    console.log(e);
  });
