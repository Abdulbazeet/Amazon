const express = require("express");
const AuthRouter = express.Router();
const bycrpt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const User = require("../models/userModels.js");
const auth = require("../middleware/auth.js");
//signUp
AuthRouter.post("/api/signUp", async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "The email has been registered by another user" });
    }
    const newPassword = await bycrpt.hash(password, 8);
    let users = new User({
      email,
      password: newPassword,
      name,
    });
    users = await users.save();
    res.json(users);
  } catch (error) {
    res.status(500).json({ err: error.message });
  }
});
//signIn
AuthRouter.post("/api/signIn", async (req, res) => {
  try {
    const { email, password } = req.body;
    const existingUser = await User.findOne({ email });
    if (!existingUser) {
      return res
        .status(400)
        .json({ msg: "User with this credentials do not exist" });
    }
    const isMatch = await bycrpt.compare(password, existingUser.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "User password is incorrect" });
    }
    const token = jwt.sign({ id: existingUser._id }, "passwordKey");
    res.json({ token, ...existingUser._doc });
  } catch (error) {
    res.status(500).json({ err: error.message });
  }
});
// getTokenVerification
AuthRouter.post("/isTokenValid", async (req, res) => {
  try {
    const token = req.header("userToken");
    if (!token) return res.json(false);
    const verifiedToken = jwt.compare(token, "passwordKey");
    if (!verifiedToken) return res.json(false);
    const user = User.findById(verifiedToken.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (error) {
    res.status(500).json({ err: error.message });
  }
});
AuthRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

module.exports = AuthRouter;
