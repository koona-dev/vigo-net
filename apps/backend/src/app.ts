/*
 ** PACKAGES NODE MODULES
 */
import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import path from "path";
import helmet from "helmet";
import compression from "compression";
import morgan from "morgan";
import fs from "fs";

import routes from "./routes/routes";

// load env file
dotenv.config({ path: ".env" });

const app = express();

// logger api
const accessLogStream = fs.createWriteStream(
  path.join(__dirname, "access.log"),
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

routes(app);

app.listen("8080", () => {
  console.info(`Server running 🤖🚀 at localhost:3000`);
});
