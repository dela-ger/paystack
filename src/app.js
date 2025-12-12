import express from "express";
import { cfg } from "./config/env.js";

const app = express();

app.get('/health', (req, res) => res.json({ ok: true, env: cfg.env }));

export default app;