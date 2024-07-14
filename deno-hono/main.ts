import { Hono } from "@hono/hono";

const app = new Hono();

app.get("/", (ctx) => ctx.text("Hello!"));

Deno.serve(app.fetch);
