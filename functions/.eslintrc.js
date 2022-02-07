module.exports = {
  parser: "babel-eslint",
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: [
    "eslint:recommended",
    "google",
  ],
  rules: {
    quotes: ["error", "double"],
    "no-unused-vars": 0,
    "keyword-spacing": 0,
    "space-before-blocks": 0,
    "quotes": 0,
    "eol-last": 0,
    "quote-props": 0,
    "no-dupe-keys": 0,
    "max-len": 0,
  },
};
