/* 
** PACKAGES NODE MODULES
*/
import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import path from "path";
import csrf from "csurf";
import helmet from "helmet";
import compression from "compression";
import morgan from "morgan";
import fs from "fs";

// load env file
dotenv.config({ path: ".env" });

const app = express();

// csrf protection => protect api
const csrfProtection = csrf();

// logger api
const accessLogStream = fs.createWriteStream(
  path.join(__dirname, "log/access.log"),
  { flags: "a" }
);

// Setup Response Headers
app.use(express.json());

// Protect header
app.use(helmet());

// cors => allow all origin to access api
app.use(cors({ origin: true }));

// compress response body data
app.use(compression());

// log api
app.use(morgan("combined", { stream: accessLogStream }));

// delare csrf protection in headers
app.use(csrfProtection);
app.use((req, res, next) => {
  res.locals.csrfToken = req.csrfToken();
  next();
});

// load routes
routes(app);

app.listen("3000", () => {
  console.info(`Server running 🤖🚀 at localhost:3000`);
});
