import dotenv from "dotenv";
import path from "path";
import { fileURLToPath } from "url";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");

dotenv.config({ path: path.join(root, ".env") });

const appEnv = (process.env.APP_ENV || "local").trim().toLowerCase();
const envFile = appEnv === "production" ? ".env.production" : ".env.local";

dotenv.config({ path: path.join(root, envFile), override: true });

console.log(`Entorno activo: ${appEnv === "production" ? "production" : "local"} (${envFile})`);
