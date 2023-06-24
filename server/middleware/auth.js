const jwt = require("jsonwebtoken");
const auth = async (req, res, next) => {
  try {
    const token = req.header("userToken");
    if (!token)
      return res.status(401).json({ msg: "No token found, access denied" });
    const verified = jwt.compare(token, "passwordKey");
    if (!verified)
      return res
        .status(401)
        .json({ msg: "User validation failed, no access token" });
    req.user = verified.id;
      req.token = token;
      next();
  } catch (error) {
    res.status(500).json({ err: error.message });
  }
};

module.exports = auth;
