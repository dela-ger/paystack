import app from "./app";
import { cfg } from "./confiq/env.js";

app.listen(cfg.port, () => {
    console.log(`Server listening on port ${cfg.port} in ${cfg.env}`);
}) 