const mongoose = require("mongoose");
const userSchemer = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  password: {
    type: String,
    required: true,
    validate: {
      validator: (val) => {
        return val.length > 6;
      },

      message: "Password should be of upto 6 characters",
    },
  },
  email: {
    required: true,
    trim: true,
    type: String,
    validate: {
      validator: (val) => {
        const reg =
          /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:.[a-zA-Z0-9-]+)*$/;
        return val.match(reg);
      },
      message: "Email supplied is invalid",
    },
  },
  typeOfUser: {
    type: String,
    default: "user",
  },
  address: {
    type: String,
    default: "",
  },
});
const User = mongoose.model("User", userSchemer);
module.exports = User;
