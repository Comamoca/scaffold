import { Hono } from "https://deno.land/x/hono@v4.3.11/mod.ts";

const app = new Hono();

app.get("/", (ctx) => ctx.text("Hello!"));

Deno.serve(app.fetch);
